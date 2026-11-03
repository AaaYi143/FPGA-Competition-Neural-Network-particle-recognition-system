#!/usr/bin/env python3
"""32-channel offline acquisition analysis. Requires Python 3 and NumPy.

CSV schema: frame_id,timestamp_ticks,ch0,...,ch31 (header required).
Calibration JSON: {"dark": [32 numbers], "gain": [32 positive numbers]}.
Corrected signal = max(raw - dark, 0) * gain. Ticks are retained as integers;
no frame-rate claim is made without a known clock frequency.

A kernel is an externally calibrated, headerless CSV with one row per scatter
channel (ascending channel number, excluding center_channel) and one column per
diameter bin. Its columns MUST describe corrected signal per unit particle
volume fraction, in the same optical configuration/units as these measurements.
The headerless bins CSV contains strictly increasing positive diameter centers,
in micrometers. No Mie kernel or trained model is supplied here.

With a kernel, solve min(x>=0) ||Kx-y||^2 + lambda*||x||^2. Normalize x by its
sum to report volume fractions. D10/D50/D90 use the weighted empirical quantile:
the first diameter center whose cumulative volume fraction reaches 10/50/90%.
These discrete quantiles have bin-limited resolution; no interpolation within
bins is assumed. Valid particle sizing still requires experimental validation.
"""

from __future__ import annotations

import argparse
import csv
import json
import math
from pathlib import Path
import numpy as np

CHANNELS = 32
HEADER = ["frame_id", "timestamp_ticks"] + [f"ch{i}" for i in range(CHANNELS)]


def _array(values, shape, name):
    try:
        value = np.asarray(values, dtype=float)
    except (ValueError, TypeError) as exc:
        raise ValueError(f"{name} must contain numeric values") from exc
    if value.shape != shape or not np.all(np.isfinite(value)):
        raise ValueError(f"{name} must have shape {shape} and finite values")
    return value


def load_calibration(path):
    with open(path, encoding="utf-8-sig") as stream:
        data = json.load(stream)
    if not isinstance(data, dict) or "dark" not in data or "gain" not in data:
        raise ValueError("calibration JSON requires dark and gain arrays")
    dark = _array(data["dark"], (CHANNELS,), "dark")
    gain = _array(data["gain"], (CHANNELS,), "gain")
    if np.any(dark < 0) or np.any(gain <= 0):
        raise ValueError("dark must be nonnegative and gain strictly positive")
    return dark, gain


def read_frames(path):
    ids, ticks, frames = [], [], []
    with open(path, newline="", encoding="utf-8-sig") as stream:
        reader = csv.reader(stream)
        if next(reader, None) != HEADER:
            raise ValueError("CSV header must be frame_id,timestamp_ticks,ch0,...,ch31")
        for line, row in enumerate(reader, 2):
            if len(row) != len(HEADER):
                raise ValueError(f"CSV line {line}: expected 34 fields")
            try:
                frame_id, tick = int(row[0]), int(row[1])
                values = _array(row[2:], (CHANNELS,), f"CSV line {line}")
            except (ValueError, TypeError) as exc:
                raise ValueError(f"CSV line {line}: invalid frame: {exc}") from exc
            if frame_id < 0 or tick < 0 or np.any(values < 0):
                raise ValueError(f"CSV line {line}: values must be nonnegative")
            ids.append(frame_id)
            ticks.append(tick)
            frames.append(values)
    if not frames:
        raise ValueError("CSV contains no frames")
    return ids, ticks, np.asarray(frames)


def correct_frames(raw, dark, gain):
    raw = np.asarray(raw, dtype=float)
    if raw.ndim != 2 or raw.shape[0] == 0 or raw.shape[1] != CHANNELS:
        raise ValueError("raw frames must be a nonempty N x 32 array")
    if not np.all(np.isfinite(raw)) or np.any(raw < 0):
        raise ValueError("raw frames must be finite and nonnegative")
    dark = _array(dark, (CHANNELS,), "dark")
    gain = _array(gain, (CHANNELS,), "gain")
    if np.any(dark < 0) or np.any(gain <= 0):
        raise ValueError("dark must be nonnegative and gain strictly positive")
    result = np.maximum(raw - dark, 0) * gain
    if not np.all(np.isfinite(result)):
        raise ValueError("calibration overflowed: check raw values and gains")
    return result


def scatter_channels(center_channel=0):
    if center_channel is not None and center_channel not in range(CHANNELS):
        raise ValueError("center_channel must be 0..31 or None")
    return [i for i in range(CHANNELS) if i != center_channel]


def validate_kernel(kernel, bins, rows):
    kernel, bins = np.asarray(kernel, dtype=float), np.asarray(bins, dtype=float)
    if bins.ndim != 1 or bins.size == 0 or not np.all(np.isfinite(bins)):
        raise ValueError("diameter bins must be a nonempty finite 1-D array")
    if np.any(bins <= 0) or np.any(np.diff(bins) <= 0):
        raise ValueError("diameter bins must be positive and strictly increasing")
    if kernel.shape != (rows, bins.size) or not np.all(np.isfinite(kernel)):
        raise ValueError(f"kernel must have shape ({rows}, {bins.size}) and finite values")
    if np.any(kernel < 0) or np.any(np.max(kernel, axis=0) == 0):
        raise ValueError("kernel must be nonnegative with no all-zero columns")
    return kernel, bins


def nnls_ridge(kernel, signal, regularization=0.0):
    """NumPy active-set NNLS, with an optional augmented ridge penalty.

    Solves linear least-squares subproblems without squaring the condition number.
    Raises on nonconvergence rather than reporting an unverified distribution.
    """
    matrix, target = np.asarray(kernel, float), np.asarray(signal, float)
    if matrix.ndim != 2 or target.shape != (matrix.shape[0],) or matrix.shape[1] == 0:
        raise ValueError("NNLS matrix/target shape mismatch")
    if not np.all(np.isfinite(matrix)) or not np.all(np.isfinite(target)):
        raise ValueError("NNLS inputs must be finite")
    if not math.isfinite(regularization) or regularization < 0:
        raise ValueError("regularization must be finite and nonnegative")
    n = matrix.shape[1]
    if regularization:
        matrix = np.vstack([matrix, math.sqrt(regularization) * np.eye(n)])
        target = np.concatenate([target, np.zeros(n)])
    # Joint scaling preserves the objective minimizer and avoids tiny signal
    # units being mistaken for a zero solution by an absolute tolerance.
    scale = max(float(np.max(np.abs(matrix))), float(np.max(np.abs(target))))
    if scale == 0:
        return np.zeros(n)
    matrix, target = matrix / scale, target / scale
    tol = 100 * np.finfo(float).eps * max(matrix.shape) * np.linalg.norm(matrix, 1) * max(np.linalg.norm(target), np.finfo(float).tiny)
    x = np.zeros(n)
    passive = np.zeros(n, dtype=bool)
    steps = 0
    max_steps = max(100, 30 * n * n)
    gradient = matrix.T @ (target - matrix @ x)
    while np.any((~passive) & (gradient > tol)):
        passive[np.argmax(np.where(~passive, gradient, -np.inf))] = True
        while True:
            steps += 1
            if steps > max_steps:
                raise ValueError("NNLS did not converge; check kernel conditioning")
            z = np.zeros(n)
            z[passive] = np.linalg.lstsq(matrix[:, passive], target, rcond=None)[0]
            if np.all(z[passive] > 0):
                x = z
                break
            bad = passive & (z <= 0)
            denominators = x[bad] - z[bad]
            ratios = np.divide(x[bad], denominators, out=np.zeros_like(denominators), where=denominators > 0)
            alpha = float(np.min(ratios))
            x += alpha * (z - x)
            # Remove the limiting coefficients, using a relative x tolerance.
            boundary = passive & (x <= np.finfo(float).eps * max(float(np.max(x)), np.finfo(float).tiny) * 10)
            passive[boundary] = False
            x[boundary] = 0
        gradient = matrix.T @ (target - matrix @ x)
    if not np.all(np.isfinite(x)):
        raise ValueError("NNLS returned nonfinite coefficients")
    return np.maximum(x, 0)


def volume_quantiles(bins, fractions):
    bins, fractions = np.asarray(bins, float), np.asarray(fractions, float)
    if bins.ndim != 1 or bins.size == 0 or fractions.shape != bins.shape:
        raise ValueError("bins and fractions must be nonempty equal-size vectors")
    if not np.all(np.isfinite(bins)) or np.any(bins <= 0) or np.any(np.diff(bins) <= 0):
        raise ValueError("bins must be finite, positive and strictly increasing")
    if not np.all(np.isfinite(fractions)) or np.any(fractions < 0):
        raise ValueError("volume fractions must be finite and nonnegative")
    total = float(np.sum(fractions))
    if total == 0:
        return {"D10_um": None, "D50_um": None, "D90_um": None}
    cdf = np.cumsum(fractions / total)
    return {f"D{int(q * 100)}_um": float(bins[min(int(np.searchsorted(cdf, q, side="left")), bins.size - 1)]) for q in (0.1, 0.5, 0.9)}


def analyze(raw, dark, gain, center_channel=0, kernel=None, bins=None, regularization=0.0, adc_max_code=None):
    corrected = correct_frames(raw, dark, gain)
    raw = np.asarray(raw, dtype=float)
    dark = np.asarray(dark, dtype=float)
    channels = scatter_channels(center_channel)
    if adc_max_code is not None and (isinstance(adc_max_code, bool) or not isinstance(adc_max_code, (int, np.integer)) or adc_max_code <= 0):
        raise ValueError("adc_max_code must be a positive integer, or None when unknown")
    if (kernel is None) != (bins is None):
        raise ValueError("kernel and bins must be supplied together")
    if not math.isfinite(regularization) or regularization < 0:
        raise ValueError("regularization must be finite and nonnegative")
    if kernel is not None:
        kernel, bins = validate_kernel(kernel, bins, len(channels))
    results = []
    for raw_row, row in zip(raw, corrected):
        signal = row[channels]
        zero = not bool(np.any(signal))
        saturated = None if adc_max_code is None else np.flatnonzero(raw_row >= adc_max_code).tolist()
        saturated_scatter = None if saturated is None else [i for i in saturated if i in channels]
        below_dark = np.flatnonzero(raw_row < dark).tolist()
        item = {"scatter_sum": float(np.sum(signal)), "scatter_peak": float(np.max(signal)), "center_signal": None if center_channel is None else float(row[center_channel]), "saturated_channels": saturated, "saturated_scatter_channels": saturated_scatter, "center_saturated": None if center_channel is None or saturated is None else center_channel in saturated, "below_dark_channels": below_dark, "quality_flags": ["zero_scatter"] if zero else []}
        if saturated_scatter:
            item["quality_flags"].append("scatter_at_or_above_adc_max_code")
        if center_channel is not None and saturated is not None and center_channel in saturated:
            item["quality_flags"].append("center_at_or_above_adc_max_code")
        if adc_max_code is not None and np.any(raw_row > adc_max_code):
            item["quality_flags"].append("raw_exceeds_adc_max_code")
        if kernel is not None:
            coefficients = nnls_ridge(kernel, signal, regularization)
            total = float(np.sum(coefficients))
            fractions = coefficients / total if total > 0 else np.zeros_like(coefficients)
            residual = float(np.linalg.norm(kernel @ coefficients - signal))
            item.update({"volume_coefficients": coefficients.tolist(), "volume_fractions": fractions.tolist(), "residual_l2": residual, "relative_residual_l2": None if zero else residual / float(np.linalg.norm(signal))})
            item.update(volume_quantiles(bins, fractions))
            if total == 0:
                item["quality_flags"].append("no_resolved_distribution")
        results.append(item)
    return corrected, results


def write_frames(path, ids, ticks, values):
    with open(path, "w", newline="", encoding="utf-8") as stream:
        writer = csv.writer(stream)
        writer.writerow(HEADER)
        for frame_id, tick, row in zip(ids, ticks, values):
            writer.writerow([frame_id, tick] + [format(float(v), ".12g") for v in row])


def make_demo(directory, count=20):
    """Synthetic intensity profiles only; deliberately supplies no optical kernel."""
    directory = Path(directory)
    directory.mkdir(parents=True, exist_ok=True)
    dark = np.full(CHANNELS, 100.0)
    gain = np.ones(CHANNELS)
    frames = []
    for i in range(count):
        shape = np.exp(-np.arange(CHANNELS) / (4 + i / max(count, 1)))
        frames.append(dark + np.round((1000 + 100 * np.sin(i)) * shape))
    write_frames(directory / "SYNTHETIC_demo_frames.csv", list(range(count)), [i * 5000 for i in range(count)], frames)
    (directory / "SYNTHETIC_demo_calibration.json").write_text(json.dumps({"synthetic_demo_only": True, "dark": dark.tolist(), "gain": gain.tolist()}, indent=2), encoding="utf-8")
    return directory / "SYNTHETIC_demo_frames.csv", directory / "SYNTHETIC_demo_calibration.json"


def _center(value):
    if value.lower() == "none":
        return None
    try:
        result = int(value)
        scatter_channels(result)
    except ValueError as exc:
        raise argparse.ArgumentTypeError(str(exc)) from exc
    return result


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--input", type=Path, help="raw CSV with exactly 32 channels")
    parser.add_argument("--calibration", type=Path, help="JSON with 32-element dark and gain arrays")
    parser.add_argument("--output-dir", type=Path, default=Path("output/analysis"))
    parser.add_argument("--center-channel", type=_center, default=0, help="exclude center channel 0..31 (default 0); use none for 32 scatter rings")
    parser.add_argument("--kernel", type=Path, help="externally calibrated headerless scatter-channel x diameter-bin CSV")
    parser.add_argument("--bins", type=Path, help="headerless row/column of diameter centers in micrometers")
    parser.add_argument("--kernel-basis", choices=["volume_fraction"], help="required acknowledgment of kernel column basis for sizing")
    parser.add_argument("--regularization", type=float, default=0.0, help="nonnegative lambda in ||Kx-y||^2 + lambda ||x||^2; validate experimentally")
    parser.add_argument("--adc-max-code", type=int, help="known unsigned ADC maximum code for saturation flags; omitted means unknown (no assumed 16-bit ADC). Averaged CSV cannot reveal saturation of individual constituent samples")
    parser.add_argument("--demo", action="store_true", help="generate SYNTHETIC intensity-only demo and analyze; produces no particle diameters")
    args = parser.parse_args(argv)
    if args.demo and any(v is not None for v in (args.input, args.calibration, args.kernel, args.bins, args.kernel_basis)):
        parser.error("--demo cannot be mixed with measurement inputs or optical kernels")
    if not args.demo and (args.input is None or args.calibration is None):
        parser.error("provide --input and --calibration, or --demo")
    if (args.kernel is None) != (args.bins is None):
        parser.error("--kernel and --bins must be supplied together")
    if args.kernel is not None and args.kernel_basis != "volume_fraction":
        parser.error("sizing requires --kernel-basis volume_fraction; never use a number-fraction kernel here")
    if args.kernel is None and (args.kernel_basis is not None or args.regularization != 0):
        parser.error("kernel basis and regularization require an optical kernel")
    try:
        args.output_dir.mkdir(parents=True, exist_ok=True)
        if args.demo:
            args.input, args.calibration = make_demo(args.output_dir)
        ids, ticks, raw = read_frames(args.input)
        dark, gain = load_calibration(args.calibration)
        kernel = np.loadtxt(args.kernel, delimiter=",", ndmin=2) if args.kernel is not None else None
        bins = np.loadtxt(args.bins, delimiter=",", ndmin=1).reshape(-1) if args.bins is not None else None
        corrected, results = analyze(raw, dark, gain, args.center_channel, kernel, bins, args.regularization, args.adc_max_code)
        for frame_id, tick, item in zip(ids, ticks, results):
            item.update(frame_id=frame_id, timestamp_ticks=tick)
        prefix = "SYNTHETIC_demo_" if args.demo else ""
        output_csv = args.output_dir / f"{prefix}corrected.csv"
        output_json = args.output_dir / f"{prefix}summary.json"
        # Prevent accidental replacement of the raw measurement or calibration.
        inputs = [p.resolve() for p in (args.input, args.calibration, args.kernel, args.bins) if p is not None]
        if output_csv.resolve() in inputs or output_json.resolve() in inputs:
            raise ValueError("output path overlaps an input file; select another --output-dir")
        summary = {"synthetic_demo_only": args.demo, "frame_count": len(ids), "center_channel": args.center_channel, "scatter_channels": scatter_channels(args.center_channel), "adc_max_code": args.adc_max_code, "saturation_check_performed": args.adc_max_code is not None, "timestamp_unit": "FPGA clock ticks; clock frequency unspecified", "sizing_performed": kernel is not None, "kernel_basis": args.kernel_basis, "regularization_lambda": args.regularization, "diameter_bins_um": None if bins is None else bins.tolist(), "quantile_definition": "volume-weighted empirical quantile at diameter centers, no within-bin interpolation" if kernel is not None else None, "notes": ["SYNTHETIC DEMO: no measured data, physical optical model, or trained model." if args.demo else "Calibrate and validate against reference samples before interpreting particle sizes.", "No optical kernel: intensity analysis only; particle diameters are unavailable." if kernel is None else "Small residual does not establish uniqueness or physical accuracy; lambda depends on kernel scaling.", "Saturation flags inspect CSV sample codes only; when frames contain averages, retain FPGA per-sample saturation metadata separately."], "frames": results}
        serialized = json.dumps(summary, indent=2, ensure_ascii=False, allow_nan=False)
        write_frames(output_csv, ids, ticks, corrected)
        output_json.write_text(serialized + "\n", encoding="utf-8")
    except (ValueError, OSError, np.linalg.LinAlgError) as exc:
        parser.error(str(exc))
    print(f"{'SYNTHETIC DEMO: ' if args.demo else ''}{len(ids)} frames analyzed")
    print(output_csv.resolve())
    print(output_json.resolve())
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

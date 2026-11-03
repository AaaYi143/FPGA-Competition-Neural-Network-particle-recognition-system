"""Engineering budget for 32 sequential channels, not a measured performance result."""
import argparse
import json
import math


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--target-fps', type=float, default=10000)
    parser.add_argument('--adc-sps', type=float, required=True,
                        help='effective rate including conversion/readout for this adapter')
    parser.add_argument('--settle-us', type=float, required=True)
    parser.add_argument('--break-us', type=float, default=0.2)
    parser.add_argument('--address-us', type=float, default=0.04)
    parser.add_argument('--control-us', type=float, default=0.1,
                        help='estimated extra FSM/handshake cost per channel; replace with actual')
    parser.add_argument('--average', type=int, default=1)
    parser.add_argument('--discard', type=int, default=1)
    parser.add_argument('--bytes-per-sample', type=int, default=2)
    parser.add_argument('--header-bytes', type=int, default=24,
                        help='proposed application metadata incl CRC, excludes network framing')
    args = parser.parse_args()
    for key, value in vars(args).items():
        if not math.isfinite(value) or value < 0:
            parser.error(f'{key} must be finite and nonnegative')
    if args.adc_sps == 0 or args.target_fps == 0 or args.average < 1 or args.bytes_per_sample < 1:
        parser.error('rates, average and bytes-per-sample must be positive')
    if args.average & (args.average - 1):
        parser.error('average must be a power of two for this RTL')
    slot = args.break_us + args.address_us + args.settle_us + args.control_us
    slot += (args.average + args.discard) * 1e6 / args.adc_sps
    frame_bytes = args.header_bytes + 32 * args.bytes_per_sample
    print(json.dumps({
        'status': 'ASSUMPTION_BASED_BUDGET_NOT_MEASUREMENT',
        'inputs': vars(args),
        'target_slot_us': 1e6 / (32 * args.target_fps),
        'estimated_slot_us': slot,
        'estimated_fps_before_frame_transfer_stalls': 1e6 / (32 * slot),
        'estimated_first_to_last_channel_skew_us': 31 * slot,
        'target_adc_conversion_sps_min_excluding_settling': 32 * args.target_fps * (args.average + args.discard),
        'frame_application_bytes': frame_bytes,
        'target_application_bytes_per_second': frame_bytes * args.target_fps,
        'target_uart_8N1_baud_min': 10 * frame_bytes * args.target_fps,
        'target_has_positive_budget_margin': slot < 1e6 / (32 * args.target_fps),
    }, indent=2))


if __name__ == '__main__':
    main()

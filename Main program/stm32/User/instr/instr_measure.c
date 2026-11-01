/**
 * @file    instr_measure.c
 * @brief   Trigger + measurements. All integer; ADC ref = 3300 mV / 4096.
 */
#include "./instr/instr_measure.h"

uint16_t InstrTrig_Rising(const uint16_t *buf, uint16_t n, uint16_t level)
{
    uint16_t i;
    for (i = 1; i < n; i++) {
        if (buf[i - 1] < level && buf[i] >= level) return i;
    }
    return n;
}

uint16_t InstrMeas_Min(const uint16_t *buf, uint16_t n)
{
    uint16_t m = 0xFFFFu, i;
    for (i = 0; i < n; i++) if (buf[i] < m) m = buf[i];
    return m;
}

uint16_t InstrMeas_Max(const uint16_t *buf, uint16_t n)
{
    uint16_t m = 0, i;
    for (i = 0; i < n; i++) if (buf[i] > m) m = buf[i];
    return m;
}

uint16_t InstrMeas_VppMv(const uint16_t *buf, uint16_t n)
{
    uint32_t span = (uint32_t)(InstrMeas_Max(buf, n) - InstrMeas_Min(buf, n));
    return (uint16_t)(span * 3300u / 4096u);
}

uint32_t InstrMeas_FreqHz(const uint16_t *buf, uint16_t n, uint32_t fs_hz)
{
    uint16_t lo = InstrMeas_Min(buf, n);
    uint16_t hi = InstrMeas_Max(buf, n);
    uint16_t mid = (uint16_t)(((uint32_t)lo + hi) / 2u);
    uint16_t crossings = 0, i;
    for (i = 1; i < n; i++) {
        if (buf[i - 1] < mid && buf[i] >= mid) crossings++;
    }
    return (uint32_t)crossings * fs_hz / n;
}

uint16_t InstrMeas_DutyPermille(const uint16_t *buf, uint16_t n, uint16_t mid)
{
    uint16_t hi_cnt = 0, i;
    for (i = 0; i < n; i++) if (buf[i] >= mid) hi_cnt++;
    return (uint16_t)((uint32_t)hi_cnt * 1000u / n);
}

uint16_t InstrMeas_MeanMv(const uint16_t *buf, uint16_t n)
{
    uint32_t sum = 0;
    uint16_t i;
    for (i = 0; i < n; i++) sum += buf[i];
    return (uint16_t)(sum / n * 3300u / 4096u);
}

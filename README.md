# Mukah GHG Data Investigation

## Background

During EddyPro processing of the Mukah Eddy Covariance dataset, abnormal behavior was observed in the high-frequency greenhouse gas data from Instrument AIU-1552 (LI-7500A).

The objective of this investigation is to identify:

- when the problem started;
- whether the issue originates from EddyPro settings or raw data;
- whether the abnormality is temporary or persistent.

---

## Investigation Timeline

### Normal Files

| Timestamp |
|------------|
| 2021-09-28 00:00 |
| 2021-09-28 06:00 |
| 2021-09-28 07:30 |
| 2021-09-28 08:00 |

Characteristics:

- Diagnostic Value = 254–255
- Valid CO2 measurements
- Valid H2O measurements
- Normal signal strength
- Valid wind data

---

### Abnormal Files

| Timestamp |
|------------|
| 2021-09-28 09:13:58 |
| 2021-09-28 09:30 |
| 2021-09-28 12:00 |
| 2021-09-29 00:00 |
| 2021-09-29 12:00 |
| 2021-12-01 12:00 |

Characteristics:

- Diagnostic Value = 16
- CO2 = 0
- H2O = 0
- CO2 Signal Strength = 0
- Dew Point = -inf
- Fixed abnormal wind values

---

## Preliminary Conclusion

The AIU-1552 instrument appears to have failed between:

2021-09-28 08:00

and

2021-09-28 09:13:58

The abnormal condition persisted for at least two months.

The issue is therefore likely related to:

- LI-7500A instrument failure;
- SmartFlux acquisition failure;
- data acquisition system malfunction.

The issue is unlikely to be caused by:

- EddyPro configuration;
- metadata mismatch;
- processing settings.

---

## Next Steps

1. Check maintenance records around 2021-09-28.
2. Check LI-7500A diagnostics.
3. Verify SmartFlux operation logs.
4. Determine whether valid backup data exist.
5. Exclude affected periods from flux calculations if necessary.
# Mukah GHG Data Investigation

## Project Background

This repository documents the investigation of abnormal high-frequency greenhouse gas data from the Mukah Eddy Covariance site.

## Instrument

AIU-1552

LI-7500A Open Path CO2/H2O Analyzer

## Main Finding

Normal data:

- 2021-09-28 00:00
- 2021-09-28 06:00
- 2021-09-28 07:30
- 2021-09-28 08:00

Abnormal data:

- 2021-09-28 09:13:58
- 2021-09-28 09:30
- 2021-09-28 12:00
- 2021-09-29 00:00
- 2021-09-29 12:00
- 2021-12-01 12:00

## Preliminary Conclusion

The failure occurred between:

2021-09-28 08:00

and

2021-09-28 09:13:58

The issue persisted for at least two months.

## Author

Jiaoying
PhD Candidate

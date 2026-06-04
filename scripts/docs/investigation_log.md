# 建立 investigation_log.md

内容直接复制：

````markdown
# Mukah AIU-1552 Investigation Log

## Investigation Timeline

### Step 1

Observed EddyPro error:

```text
At least one wind component appears to be corrupted.
````

Initial hypothesis:

* EddyPro configuration issue
* Sampling frequency mismatch
* Corrupted raw data

Result:

Further investigation required.

---

### Step 2

Verified merged CSV outputs.

Observation:

Large sections contained:

```text
CO2 = 0
H2O = 0
Signal Strength = 0
```

Hypothesis:

Raw GHG files may already be corrupted before EddyPro processing.

---

### Step 3

Downloaded raw GHG files from S3.

Example:

```bash
aws s3 cp s3://ec-mukahead-ghg/2021-09-28T060000_AIU-1552.ghg .
```

Extracted and inspected manually.

---

### Step 4

Checked 2021-09-28 06:00.

Result:

Normal.

Indicators:

* Diagnostic Value = 255
* CO2 valid
* H2O valid
* Signal Strength valid

Status:

Instrument operational.

---

### Step 5

Checked 2021-09-28 07:30.

Result:

Normal.

Status:

Instrument operational.

---

### Step 6

Checked 2021-09-28 08:00.

Result:

Normal.

Status:

Instrument operational.

---

### Step 7

Searched available files around 09:00.

S3 listing revealed:

```text
2021-09-28T080000_AIU-1552.ghg
2021-09-28T091358_AIU-1552.ghg
2021-09-28T093000_AIU-1552.ghg
```

No file existed at:

```text
2021-09-28T090000_AIU-1552.ghg
```

---

### Step 8

Checked 2021-09-28 09:13:58.

Result:

Abnormal.

Indicators:

* Diagnostic Value = 16
* CO2 = 0
* H2O = 0
* Signal Strength = 0
* Dew Point = -inf

Status:

Instrument failure confirmed.

---

### Step 9

Checked 2021-09-28 09:30.

Result:

Abnormal.

Status:

Failure persisted.

---

### Step 10

Checked:

```text
2021-09-29 12:00
2021-12-01 12:00
```

Result:

Still abnormal.

Status:

Long-term failure.

---

## Current Conclusion

Failure occurred between:

```text
2021-09-28 08:00
and
2021-09-28 09:13:58
```

The issue originated before EddyPro processing.

The evidence indicates a malfunction of:

* LI-7500A
  or
* SmartFlux acquisition system
  or
* data acquisition chain.


#!/bin/bash

set -e

BUCKET="s3://ec-mukahead-ghg"
START_MONTH="${1:-2022-02}"
END_MONTH="${2:-2022-12}"

WORKDIR="$HOME/data"
OUTBASE="$HOME/ghg_monthly_view"

mkdir -p "$WORKDIR" "$OUTBASE"

month="$START_MONTH"

while [[ "$month" < "$END_MONTH" || "$month" == "$END_MONTH" ]]; do
  echo
  echo "=================================================="
  echo "MONTH: $month"
  echo "=================================================="

  mapfile -t FILES < <(
    aws s3 ls "$BUCKET/${month}-" \
    | awk '{print $4}' \
    | grep "_AIU-1552\.ghg$" \
    | sort
  )

  COUNT=${#FILES[@]}
  echo "Found $COUNT files"

  if [ "$COUNT" -eq 0 ]; then
    month=$(date -d "$month-01 +1 month" +%Y-%m)
    continue
  fi

  SAMPLE_INDEXES=(0 $((COUNT / 2)) $((COUNT - 1)))

  for IDX in "${SAMPLE_INDEXES[@]}"; do
    GHG_FILE="${FILES[$IDX]}"
    FILE_ID="${GHG_FILE%.ghg}"

    OUTDIR="$OUTBASE/$month/$FILE_ID"
    mkdir -p "$OUTDIR"

    cd "$WORKDIR"

    echo
    echo "--------------------------------------------------"
    echo "FILE: $FILE_ID"
    echo "--------------------------------------------------"

    aws s3 cp "$BUCKET/$GHG_FILE" . --only-show-errors
    unzip -o "$GHG_FILE" -d "$OUTDIR" >/dev/null

    DATA_FILE=$(find "$OUTDIR" -name "*.data" | head -n 1)

    if [ -z "$DATA_FILE" ]; then
      echo "No .data file found after unzip"
      continue
    fi

    echo "DATA FILE:"
    echo "$DATA_FILE"
    echo

    echo "HEADER + FIRST DATA LINES:"
    grep -n -A 15 "^DATAH" "$DATA_FILE" | head -80

    echo
    echo "ERROR KEYWORDS:"
    grep -n -m 10 -E "DATA|inf| 16 | 0 " "$DATA_FILE" | head -20

    echo
    echo "Press Enter to continue to next file..."
    read
  done

  month=$(date -d "$month-01 +1 month" +%Y-%m)
done

#!/bin/bash

# Check selected GHG files around the suspected failure period.

set -e

BUCKET="s3://ec-mukahead-ghg"
WORKDIR="$HOME/data"
OUTBASE="$HOME/ghg_qc_checks"

mkdir -p "$WORKDIR"
mkdir -p "$OUTBASE"

FILES=(
  "2021-09-28T080000_AIU-1552"
  "2021-09-28T091358_AIU-1552"
  "2021-09-28T093000_AIU-1552"
  "2021-09-29T000000_AIU-1552"
  "2021-12-01T120000_AIU-1552"
)

cd "$WORKDIR"

for FILE_ID in "${FILES[@]}"; do
  echo "======================================"
  echo "Checking: $FILE_ID"
  echo "======================================"

  OUTDIR="$OUTBASE/$FILE_ID"
  mkdir -p "$OUTDIR"

  aws s3 cp "$BUCKET/${FILE_ID}.ghg" .
  unzip -o "${FILE_ID}.ghg" -d "$OUTDIR" >/dev/null

  echo "Preview:"
  head -12 "$OUTDIR"/*.data
  echo
done

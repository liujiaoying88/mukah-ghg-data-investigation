#!/bin/bash

# Inspect one GHG file from S3
# Usage:
# bash scripts/01_inspect_ghg_file.sh 2021-09-28T080000_AIU-1552

set -e

BUCKET="s3://ec-mukahead-ghg"
FILE_ID="$1"

if [ -z "$FILE_ID" ]; then
  echo "Usage: bash scripts/01_inspect_ghg_file.sh 2021-09-28T080000_AIU-1552"
  exit 1
fi

WORKDIR="$HOME/data"
OUTDIR="$HOME/check_${FILE_ID}"

mkdir -p "$WORKDIR"
mkdir -p "$OUTDIR"

cd "$WORKDIR"

aws s3 cp "$BUCKET/${FILE_ID}.ghg" .

unzip -o "${FILE_ID}.ghg" -d "$OUTDIR"

echo "===== Extracted data preview ====="
head -20 "$OUTDIR"/*.data

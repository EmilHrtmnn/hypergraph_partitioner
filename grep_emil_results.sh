#!/bin/bash
if [[ -z "$1" ]]; then
  echo "Usage: $0 <prefix>"
  exit 1
fi

PREFIX="$1"
CURRENT_DIR="$(basename "$PWD")"
TAR_NAME="${CURRENT_DIR}_execution_csvs.tar"

find . -maxdepth 1 -type d -name "${PREFIX}*" \
  -exec find {} -type f -name "*_execution.csv" \; \
  | tar -cvf "$TAR_NAME" -T -

#!/usr/bin/env sh

if [ -z "$1" ]; then
  echo "Usage: $0 <experiment_dir>"
  exit 1
fi

experiment_dir="$1"
if [ ! -d "$experiment_dir" ]; then
  echo "Error: directory does not exist: $experiment_dir"
  exit 1
fi

experiment_dir="$(cd "$experiment_dir" && pwd)"
parent_dir="$(dirname "$experiment_dir")"
experiment_name="$(basename "$experiment_dir")"

echo "Experiment dir : $experiment_dir"
echo "Output tar     : $parent_dir/${experiment_name}_results.tar"

cd "$experiment_dir" || exit 1

generated_files=""

for header_file in *.header.csv; do
  [ -f "$header_file" ] || continue

  algorithm_name="${header_file%.header.csv}"
  result_dir="${algorithm_name}_results"
  result_file="${algorithm_name}.csv"

  echo "Processing algorithm: $algorithm_name"

  if [ ! -d "$result_dir" ]; then
    echo "  Warning: missing result directory $result_dir, skipping"
    continue
  fi

  rm -f "$result_file"
  cat "$header_file" >> "$result_file"
  cat "$result_dir"/*.result >> "$result_file"
  generated_files="$generated_files $result_file"
done


if [ -n "$generated_files" ]; then
  tar -cvf "$parent_dir/${experiment_name}_results.tar" $generated_files
  echo "Tar created successfully."
else
  echo "No result files generated, no tar created."
fi


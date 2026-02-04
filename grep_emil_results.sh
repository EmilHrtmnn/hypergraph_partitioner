PREFIX="$1"
CURRENT_DIR="$(basename "$PWD")"
TAR_NAME="${CURRENT_DIR}.tar"

find . -maxdepth 1 -type d -name "${PREFIX}*" \
  -exec find {} -type f -name "*_execution.csv" \; \
  | tar -cvf "$TAR_NAME" \
        --transform='s|.*/||' \
        -T -

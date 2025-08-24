#!/usr/bin/env bash

if [ $# -eq 0 ]; then
  echo "Usage: $0 <dir1> <dir2> ..."
  exit 1
fi

for d in "$@"; do
  FILE="$d/global.auto.tfvars"
  if [ ! -f "$FILE" ]; then
    mkdir -p "$d"
    cat <<EOF > "$FILE"
yc_token="${YC_TOKEN}"
billing_account_id="${BILLING_ACCOUNT_ID}"
cloud_name="${CLOUD_NAME}"
EOF
    echo "File $FILE created."
  else
    echo "File $FILE already exists."
  fi
done

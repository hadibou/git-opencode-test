#!/usr/bin/env bash
set -e

echo "=== Running Markdown Test Validation ==="

# 1. Check if docs folder exists
if [ ! -d "docs" ]; then
  echo "FAIL: 'docs/' directory does not exist."
  exit 1
fi

# 2. Verify all Markdown files are non-empty
for file in docs/*.md; do
  if [ -f "$file" ]; then
    if [ ! -s "$file" ]; then
      echo "FAIL: File $file is empty."
      exit 1
    fi
    echo "PASS: $file is valid and non-empty."
  fi
done

# 3. Basic syntax check (ensure headers exist)
for file in docs/*.md; do
  if ! grep -q "^# " "$file"; then
    echo "FAIL: $file missing top-level H1 header ('# ')."
    exit 1
  fi
done

echo "=== All Markdown Tests Passed Successfully ==="
exit 0
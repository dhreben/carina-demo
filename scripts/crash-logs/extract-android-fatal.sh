#!/usr/bin/env bash
# Print the first FATAL EXCEPTION / AndroidRuntime block from a logcat file.
# Usage: ./extract-android-fatal.sh path/to/android-crash-....log

set -euo pipefail

LOG_FILE="${1:-}"
if [[ -z "${LOG_FILE}" || ! -f "${LOG_FILE}" ]]; then
  echo "usage: $0 <android-crash.log>" >&2
  exit 1
fi

# Prefer FATAL EXCEPTION log lines; fall back to AndroidRuntime lines with context.
if grep -qE "(^|[^[:alnum:]_])FATAL EXCEPTION" "${LOG_FILE}"; then
  # Print from first FATAL EXCEPTION through end of stack (up to 80 lines).
  awk '
    /FATAL EXCEPTION/ { capture=1 }
    capture {
      print
      lines++
      if (lines > 1 && /^[[:space:]]*$/) { blank++ } else { blank=0 }
      if (lines >= 80 || blank >= 2) exit
      if (/Process .* has died/) exit
    }
  ' "${LOG_FILE}"
  exit 0
fi

if grep -q "AndroidRuntime" "${LOG_FILE}"; then
  grep -n -E "AndroidRuntime|FATAL EXCEPTION" "${LOG_FILE}" | head -60
  exit 0
fi

echo "No FATAL EXCEPTION or AndroidRuntime found in: ${LOG_FILE}" >&2
exit 2

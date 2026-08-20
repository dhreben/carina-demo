#!/usr/bin/env bash
# Capture a full Android bugreport ZIP for escalation.
# Usage: ./capture-android-bugreport.sh

set -euo pipefail

OUT_DIR="${CRASH_LOG_DIR:-${HOME}/Desktop}"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
OUT_FILE="${OUT_DIR}/bugreport-${TIMESTAMP}.zip"

if ! command -v adb >/dev/null 2>&1; then
  echo "error: adb not found. Install Android Platform Tools or Android Studio." >&2
  exit 1
fi

mkdir -p "${OUT_DIR}"

DEVICES="$(adb devices | awk 'NR>1 && $2=="device" {print $1}')"
if [[ -z "${DEVICES}" ]]; then
  echo "error: no authorized Android device." >&2
  adb devices -l >&2 || true
  exit 1
fi

echo "==> Collecting bugreport (this may take several minutes)..."
echo "    Output: ${OUT_FILE}"
adb bugreport "${OUT_FILE}"
echo "==> Done: ${OUT_FILE}"
ls -lh "${OUT_FILE}"

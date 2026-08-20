#!/usr/bin/env bash
# Capture Android crash logs via adb logcat for a bug report.
# Usage: ./capture-android-crash.sh [package.name]
# Optional: CRASH_LOG_DIR=~/Desktop PACKAGE=com.company.app ./capture-android-crash.sh

set -euo pipefail

PACKAGE="${1:-${PACKAGE:-}}"
OUT_DIR="${CRASH_LOG_DIR:-${HOME}/Desktop}"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
OUT_FILE="${OUT_DIR}/android-crash-${TIMESTAMP}.log"

if ! command -v adb >/dev/null 2>&1; then
  echo "error: adb not found. Install Android Platform Tools or Android Studio." >&2
  echo "  See docs/mobile-crash-logs/checklists/01-setup.md" >&2
  exit 1
fi

mkdir -p "${OUT_DIR}"

echo "==> Checking adb devices..."
DEVICES="$(adb devices | awk 'NR>1 && $2=="device" {print $1}')"
if [[ -z "${DEVICES}" ]]; then
  echo "error: no authorized Android device. Enable USB debugging and accept the prompt." >&2
  adb devices -l >&2 || true
  exit 1
fi
adb devices -l
echo

echo "==> Clearing logcat buffer..."
adb logcat -c

echo "==> Recording to: ${OUT_FILE}"
echo "    1. Open the app on the phone and wait for the crash."
if [[ -n "${PACKAGE}" ]]; then
  echo "    2. Filtering hints will use package: ${PACKAGE}"
fi
echo "    3. Press Ctrl+C after the crash to stop recording."
echo

cleanup() {
  echo
  echo "==> Saved: ${OUT_FILE}"
  if [[ -f "${OUT_FILE}" ]]; then
    BYTES="$(wc -c < "${OUT_FILE}" | tr -d ' ')"
    echo "    Size: ${BYTES} bytes"
    if grep -qE "FATAL EXCEPTION|AndroidRuntime" "${OUT_FILE}" 2>/dev/null; then
      echo "    Found FATAL EXCEPTION / AndroidRuntime — good for the bug report."
      echo "    Extract excerpt:"
      echo "      ./scripts/crash-logs/extract-android-fatal.sh \"${OUT_FILE}\""
    else
      echo "    Warning: no FATAL EXCEPTION / AndroidRuntime found."
      echo "    Try again, or run a full bugreport:"
      echo "      ./scripts/crash-logs/capture-android-bugreport.sh"
    fi
    if [[ -n "${PACKAGE}" ]]; then
      echo
      echo "==> App version (if installed):"
      adb shell dumpsys package "${PACKAGE}" 2>/dev/null | grep -E "versionName|versionCode" | head -5 || true
    fi
  fi
}
trap cleanup EXIT

# Record everything with threadtime; filter later. Using unbuffered-ish line output.
adb logcat -v threadtime | tee "${OUT_FILE}"

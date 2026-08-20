#!/usr/bin/env bash
# Print a reminder checklist for iOS crash capture (Console / Xcode / Analytics).
# No USB automation for iOS crash export on macOS without Xcode UI.
# Usage: ./ios-capture-checklist.sh [bundle.id]

set -euo pipefail

BUNDLE_ID="${1:-${BUNDLE_ID:-com.company.app}}"

cat <<EOF
iOS crash capture checklist
Bundle ID filter: ${BUNDLE_ID}

Method 1 — Console.app (live)
  [ ] Connect iPhone via USB; Trust This Computer
  [ ] Open Console → select iPhone in sidebar
  [ ] Search: ${BUNDLE_ID}
  [ ] Clear view → launch app → wait for crash
  [ ] Look for: assertion failure, Terminated, EXC_BAD_ACCESS, SIGABRT, dyld, crash
  [ ] Save selection to ~/Desktop/ios-console-\$(date +%Y%m%d-%H%M%S).txt

Method 2 — Xcode Devices (preferred .ips)
  [ ] Xcode → Window → Devices and Simulators → select iPhone
  [ ] Open Console and/or View Device Logs / Crash reports
  [ ] Reproduce crash
  [ ] Export newest .ips / .crash for ${BUNDLE_ID} to Desktop

Method 3 — On-device Analytics
  [ ] Settings → Privacy & Security → Analytics & Improvements → Analytics Data
  [ ] Find ${BUNDLE_ID}-YYYY-MM-DD-....ips → AirDrop / Files to Mac

Also record for the bug report
  [ ] Model + iOS version (Settings → General → About)
  [ ] App version / build
  [ ] Exact local crash time

See: docs/mobile-crash-logs/03-ios.md
Template: docs/mobile-crash-logs/templates/bug-report.md
EOF

# Checklist: Mac and device setup

Complete this once on a new corporate Mac before collecting crash logs.

## Mac software

- [ ] Install **Xcode** from the App Store (needed for iPhone Device Logs / crash reports)
- [ ] Open Xcode once and accept the license / install additional components
- [ ] Install Android tooling — pick one:
  - [ ] **Android Studio** (includes Platform Tools + Logcat UI), or
  - [ ] [Android Platform Tools](https://developer.android.com/tools/releases/platform-tools) only, or
  - [ ] Homebrew: `brew install android-platform-tools`
- [ ] Confirm `adb` is on `PATH`:
  ```bash
  adb version
  ```
- [ ] (Optional) Install Homebrew if not present: https://brew.sh

## Android phone

- [ ] Settings → About phone → tap **Build number** 7 times → Developer mode enabled
- [ ] Settings → Developer options → enable **USB debugging**
- [ ] (Optional) Enable **Wireless debugging** for Wi‑Fi capture
- [ ] Connect USB → allow **USB debugging** prompt on the phone
- [ ] Verify:
  ```bash
  adb devices
  ```
  Device should appear as `device` (not `unauthorized`)

## iPhone

- [ ] Settings → Privacy & Security → **Developer Mode** (iOS 16+) → On → reboot when prompted
- [ ] Connect USB to Mac → tap **Trust This Computer**
- [ ] Unlock iPhone and keep it unlocked while trusting
- [ ] Confirm device appears in:
  - Console.app (left sidebar), and/or
  - Xcode → Window → Devices and Simulators

## Info to collect for every bug report

Record these before or right after capture (not only the log files):

- [ ] Device model
- [ ] OS version
- [ ] App version + build number
- [ ] Exact local time of the crash (for matching system crash reports)
- [ ] Install source (TestFlight / App Store / internal APK / Firebase)
- [ ] Steps: fresh install → open → closes immediately
- [ ] Optional: screen recording or screenshot

## Package / bundle identifiers

Fill in from the team before filtering logs:

| Platform | Identifier | Value |
|----------|------------|-------|
| Android | Application ID (`package`) | `com.company.app` |
| iOS | Bundle ID | `com.company.app` |

Replace placeholders in the Android script and iOS Console search with the real IDs.

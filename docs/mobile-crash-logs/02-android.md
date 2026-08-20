# Android: capture crash logs

Use this when the Android app opens and immediately returns to the home screen.

Prerequisite: [setup checklist](checklists/01-setup.md) complete; USB debugging authorized.

## Primary method: `adb logcat`

### Automated (recommended)

From the repo root:

```bash
./scripts/crash-logs/capture-android-crash.sh com.company.app
```

Replace `com.company.app` with the real application ID.

The script:

1. Checks `adb devices`
2. Clears the log buffer (`adb logcat -c`)
3. Starts recording with `-v threadtime`
4. Prints instructions to launch the app and crash it
5. On Ctrl+C, saves the log under `~/Desktop/` (or `$CRASH_LOG_DIR`)
6. Prints a hint for `FATAL EXCEPTION` / `AndroidRuntime`

### Manual commands

```bash
adb devices
adb logcat -c
adb logcat -v threadtime > ~/Desktop/android-crash-$(date +%Y%m%d-%H%M%S).log
```

1. On the phone, open the app and wait for the crash.
2. Stop recording with `Ctrl+C`.
3. In the file, search for `FATAL EXCEPTION`, `AndroidRuntime`, or `Process: <package.name>`.

### Filter by package (after a crash, or live)

If the process is already dead, `pidof` is empty — use a package filter:

```bash
adb logcat -c
adb logcat -v threadtime | grep -E "AndroidRuntime|FATAL|com.company.app"
```

If you can start the app long enough to get a PID:

```bash
adb logcat -c
adb logcat --pid="$(adb shell pidof -s com.company.app)" -v threadtime > crash.log
```

## Alternative: Android Studio Logcat

1. View → Tool Windows → Logcat
2. Select the device and app process
3. Set level to **Error**
4. Reproduce the crash
5. Right-click → Copy / Export selected lines

## Full system report (when the crash is quiet or OS context is needed)

```bash
./scripts/crash-logs/capture-android-bugreport.sh
# or:
adb bugreport ~/Desktop/bugreport.zip
```

Takes several minutes. Includes logcat, dumpsys, and ANR data — useful when escalating to a platform team.

## What to attach to the bug report

- `.log` file with the fragment from `FATAL EXCEPTION` through the end of the stack trace (include ~20–50 surrounding lines)
- Device info: `adb devices -l`
- App version:
  ```bash
  adb shell dumpsys package com.company.app | grep -E "versionName|versionCode"
  ```

## Helper: extract stack excerpt

```bash
./scripts/crash-logs/extract-android-fatal.sh ~/Desktop/android-crash-YYYYMMDD-HHMMSS.log
```

Prints the first `FATAL EXCEPTION` / `AndroidRuntime` block for pasting into the ticket body.

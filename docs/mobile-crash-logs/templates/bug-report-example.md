# Filled example — cold-start crash (Android + iOS)

Example of a completed bug report using [bug-report.md](bug-report.md). Replace with real data when filing.

---

## Summary

App crashes immediately on launch (cold start). Opens briefly, then returns to the home screen.

## Environment

- Device: Pixel 8 / iPhone 15
- OS: Android 14 / iOS 17.5
- App version: 1.2.3 (build 456)
- Install source: Firebase App Distribution (Android) / TestFlight (iOS)
- Package / Bundle ID: `com.company.app`

## Steps to Reproduce

1. Fresh install of the build above
2. Tap the app icon
3. App opens briefly, then closes to the home screen

## Expected

App opens to the main screen and stays running.

## Actual

Immediate crash on launch on both platforms.

## Time of crash (local)

2026-07-11 11:42:03 MSK (Android), 2026-07-11 11:45:18 MSK (iOS)

## Stack excerpt (Android)

```
E AndroidRuntime: FATAL EXCEPTION: main
E AndroidRuntime: Process: com.company.app, PID: 5678
E AndroidRuntime: java.lang.RuntimeException: Unable to create application com.company.app.App: java.lang.IllegalStateException: missing config
E AndroidRuntime: 	at android.app.ActivityThread.handleBindApplication(ActivityThread.java:1)
E AndroidRuntime: Caused by: java.lang.IllegalStateException: missing config
E AndroidRuntime: 	at com.company.app.App.onCreate(App.java:42)
```

## Attachments

- [x] Android: `android-crash-20260711-114203.log`
- [ ] Android bugreport.zip (not needed if FATAL stack is clear)
- [x] iOS: `com.company.app-2026-07-11-114518.ips`
- [ ] Optional: screen recording

## Additional notes

Reproduced on clean devices after corporate wipe. Same build ID on both platforms. Captured with `scripts/crash-logs/capture-android-crash.sh` and Xcode Device Logs.

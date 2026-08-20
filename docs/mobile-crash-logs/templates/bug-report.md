# Bug report template — cold-start crash

Copy into Jira / GitHub / Linear. Attach log files listed under Attachments.

---

## Summary

App crashes immediately on launch (cold start). Opens briefly, then returns to the home screen.

## Environment

- Device: <!-- e.g. Pixel 8 / iPhone 15 -->
- OS: <!-- e.g. Android 14 / iOS 17.5 -->
- App version: <!-- e.g. 1.2.3 (build 456) -->
- Install source: <!-- TestFlight / App Store / internal APK / Firebase App Distribution -->
- Package / Bundle ID: <!-- com.company.app -->

## Steps to Reproduce

1. Fresh install of the build above
2. Tap the app icon
3. App opens briefly, then closes to the home screen

## Expected

App opens to the main screen and stays running.

## Actual

Immediate crash on launch (process terminates / returns to home screen).

## Time of crash (local)

<!-- e.g. 2026-07-11 11:42:03 MSK — must match log timestamps -->

## Stack excerpt (optional but preferred)

```
<!-- Paste FATAL EXCEPTION block (Android) or key Console / .ips lines (iOS) -->
```

## Attachments

- [ ] Android: `android-crash-YYYYMMDD-HHMMSS.log` (full logcat capture)
- [ ] Android (if needed): `bugreport.zip`
- [ ] iOS: `com.company.app-YYYY-MM-DD-....ips` or Console export `.txt`
- [ ] Optional: screen recording

## Additional notes

<!-- Network / VPN / MDM / first launch after wipe / etc. -->

---

## Reporter checklist

- [ ] Environment fields filled
- [ ] Exact crash time recorded
- [ ] Logs captured **after** `logcat -c` / Console clear, then reproduce
- [ ] Minimal stack excerpt in the ticket body
- [ ] Full log files attached (not only screenshots)
- [ ] Reproduced on both platforms if both fail (separate attachments labeled Android / iOS)

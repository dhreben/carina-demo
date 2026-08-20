# iPhone: capture crash logs

Use this when the iOS app opens and immediately returns to the home screen.

Prerequisite: [setup checklist](checklists/01-setup.md) complete; iPhone trusted on the Mac; Developer Mode on (iOS 16+).

## Method 1: Console.app (fast, no Xcode project)

Best for a live stream while you reproduce the crash.

1. Connect the iPhone over USB.
2. Open **Console** (Spotlight → `Console`).
3. In the left sidebar, select the **iPhone** (not the Mac).
4. Search for the app name or bundle id (e.g. `com.company.app`).
5. Clear the view, then launch the app on the phone.
6. Look for: `assertion failure`, `Terminated`, `EXC_BAD_ACCESS`, `SIGABRT`, `dyld`, `crash`.
7. Select relevant lines → File → Save, or paste into a text file on the Desktop.

Save as something like `ios-console-YYYYMMDD-HHMMSS.txt`.

## Method 2: Xcode → Devices and Simulators (preferred for crash reports)

Best for official `.ips` / `.crash` files to attach to the ticket.

1. Xcode → Window → **Devices and Simulators**
2. Select the iPhone
3. Use **Open Console** for a live log, and/or open **View Device Logs** / Crash reports
4. Reproduce the crash on the device
5. In Device Logs / Crash Reports, find the newest entry for the app by name and timestamp
6. Right-click → **Export Log**, or drag the file to the Desktop

Attach the exported `.ips` (or `.crash`) file.

## Method 3: Analytics on the iPhone (no cable at crash time)

1. Settings → Privacy & Security → **Analytics & Improvements** → **Analytics Data**
2. Find `com.company.app-YYYY-MM-DD-....ips`
3. Share via AirDrop or Files to the Mac

Note: the report may appear with a delay. For “opened and immediately crashed”, prefer live Console or Xcode Device Logs.

## Symbolication (usually for developers)

Readable symbolicated stacks need the matching **dSYM** / CI build. Xcode Organizer or `symbolicatecrash` is typically done by an iOS engineer. For the bug report, a raw `.ips` is enough unless the team asks otherwise.

## What to attach to the bug report

- `.ips` or `.crash` from Device Logs / Analytics, **or** a Console excerpt with timestamps and bundle id
- iPhone model and iOS version (Settings → General → About)
- App version / build (from TestFlight, App Store, or the install source)

## Checklist while capturing

- [ ] Device selected in Console / Xcode (not Mac)
- [ ] Bundle id / app name filter applied
- [ ] Buffer/view cleared before launch
- [ ] Crash reproduced; note exact local time
- [ ] `.ips` exported or Console text saved to Desktop
- [ ] Model + iOS version recorded for the ticket

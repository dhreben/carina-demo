# Common cold-start crash causes (context for triage)

Mentioning hypotheses in the bug report is optional. Prefer attaching the stack trace; these notes help the reporter and assignee.

| Area | Typical signal |
|------|----------------|
| Wrong signing / provisioning (iOS) | Install fails or instant terminate; Console mentions codesign / provisioning |
| Missing `GoogleService-Info.plist` / `google-services.json` | Crash in Firebase / Google init during startup |
| Crash in `Application.onCreate` / `AppDelegate` / native SDK | Stack points at app or third-party SDK init |
| OS incompatibility on new corporate devices | Crash only on newest OS / specific models |
| Debug build missing env / config files | Works on CI device with secrets; fails on clean phone |

The stack from `adb logcat` or an iOS `.ips` narrows this quickly — attach it even if the excerpt is unsymbolicated.

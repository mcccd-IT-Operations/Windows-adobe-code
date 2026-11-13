# Windows Adobe Creative Cloud remediation

Windows PowerShell remediation for local Adobe Creative Cloud sign-in issues associated with the SailPoint implementation.

**Version 2 is pending peer, affected-pillar and final CyberSecurity review. Not approved for production.** This repository describes this Adobe project. Organization policy, review standards and reusable templates are maintained in the [District ITS organization framework](https://github.com/mcccd-IT-Operations/.github/blob/main/README.md).

Original: Jim Ierley  
Version 2 edited 11/12/26 @ 7:02 PM by Alvin Bridges

## Versions and downloads

| Version | Source / download | Status |
| --- | --- | --- |
| 1 | [Adobe-reset-v1.ps1](https://github.com/mcccd-IT-Operations/Windows-adobe-code/blob/review/windows/adobe-creative-cloud-v2/windows-code/adobe-creative-cloud/Adobe-reset-v1.ps1) | Historical baseline; production approval not asserted |
| 2 | [Adobe-reset-v2.ps1](https://github.com/mcccd-IT-Operations/Windows-adobe-code/blob/review/windows/adobe-creative-cloud-v2/windows-code/adobe-creative-cloud/Adobe-reset-v2.ps1) | Review candidate; approval pending |

The code is on [review/windows/adobe-creative-cloud-v2](https://github.com/mcccd-IT-Operations/Windows-adobe-code/tree/review/windows/adobe-creative-cloud-v2) in [draft PR #1](https://github.com/mcccd-IT-Operations/Windows-adobe-code/pull/1). If browsing main before merge, use those branch/PR links to access the candidate files.

Both scripts remain downloadable as assets in the [original review pre-release](https://github.com/mcccd-IT-Operations/Windows-adobe-code/releases/tag/adobe-reset-v2.0.0-rc.1). That release retains its historical code snapshot and is unapproved. No tag or asset is moved by documentation changes.

## What the files do and why

The [Version 1 script](https://github.com/mcccd-IT-Operations/Windows-adobe-code/blob/review/windows/adobe-creative-cloud-v2/windows-code/adobe-creative-cloud/Adobe-reset-v1.ps1) preserves the baseline for comparison. The [Version 2 script](https://github.com/mcccd-IT-Operations/Windows-adobe-code/blob/review/windows/adobe-creative-cloud-v2/windows-code/adobe-creative-cloud/Adobe-reset-v2.ps1) contains the revised remediation with section notes. [Release notes](https://github.com/mcccd-IT-Operations/Windows-adobe-code/blob/review/windows/adobe-creative-cloud-v2/windows-code/adobe-creative-cloud/RELEASE-NOTES.md) explain all Version 1-to-2 changes, usage and limitations. The [approval record](https://github.com/mcccd-IT-Operations/Windows-adobe-code/blob/review/windows/adobe-creative-cloud-v2/docs/APPROVAL.md) holds this project's routing, decisions, validation and authorization status.

Version 2 targets the affected Windows user's local Adobe sign-in state: it closes matching Adobe processes, clears matching Credential Manager targets and removes or backs up the OOBE database/SQLite sidecars and IdentityCache. Forced app closure can interrupt work; the next Adobe launch requires sign-in. Run only in the intended affected-user context, as described by the script; SYSTEM is refused. Review the parameters, side effects and limitations before authorized nonproduction testing.

Neither script was executed on Windows during preparation. Runtime/tenant/user evidence, recovery planning and required approvals remain pending. Source availability and a release do not authorize use.

## Project review

[Project governance](https://github.com/mcccd-IT-Operations/Windows-adobe-code/blob/review/windows/adobe-creative-cloud-v2/GOVERNANCE.md) identifies impacted owners; [template adoption](https://github.com/mcccd-IT-Operations/Windows-adobe-code/blob/review/windows/adobe-creative-cloud-v2/GOVERNANCE-ADOPTION.md) records the central baseline. Infrastructure, Development, Business ERPs, End Point Engineering and CyberSecurity assess impact; add Identity/SailPoint, Adobe/licensing, Service Desk and other affected owners. A maintainer verifies every required approval for the final commit before merge; production authorization is separate.

Organization-wide review standards and reusable templates are maintained centrally. This project inherits community guidance and keeps its own docs/APPROVAL.md.
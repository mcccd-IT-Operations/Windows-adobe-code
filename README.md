# MCCCD District IT Operations — Code Review

This repository serves as the code review base for MCCCD District IT Operations and invited members of District Information Technology Services (ITS). Contributors check out code, review changes with their peers, test in an appropriate nonproduction environment, and obtain Cyber Security review before code is authorized for production use.

Review governance ensures every involved party can review code affecting its support structure, users, services, or products. The five pillars are **Infrastructure, Development, Business ERPs, End Point Engineering, and CyberSecurity**. Each pillar assesses impact; every affected pillar and additional required party must approve. Missing approval or unresolved routing can delay the project and keeps approval pending. See [GOVERNANCE.md](./GOVERNANCE.md).

**Adobe Creative Cloud remediation Version 2 is pending peer and Cyber Security approval. It is not approved for production.** Download availability, a version number, a pull request, or a release does not establish production approval.

## Code organization

| Area | Scope | Location / status |
| --- | --- | --- |
| Windows Code | Windows scripts and endpoint remediation | [windows-code/](./windows-code/) in this repository |
| Adobe Creative Cloud Code | Subset of Windows Code: remediation for Adobe Creative Cloud issues associated with the SailPoint implementation | [windows-code/adobe-creative-cloud/](./windows-code/adobe-creative-cloud/) |
| Jamf — Blueprints | Jamf and Apple endpoint infrastructure as code | [jamf-blueprints-iac](https://github.com/mcccd-IT-Operations/jamf-blueprints-iac) — private; [Python/Zsh draft review](https://github.com/mcccd-IT-Operations/jamf-blueprints-iac/pull/1), both implementations imported |
| Jamf — computer-group erase | Sanitized device-erase review candidate | [jamf-computer-group-erase](https://github.com/mcccd-IT-Operations/jamf-computer-group-erase) — private; [sanitized script draft review](https://github.com/mcccd-IT-Operations/jamf-computer-group-erase/pull/1), not production approved |
| Jamf — Mac Setup | Guided macOS onboarding and operator documentation | [jamf-mac-setup](https://github.com/mcccd-IT-Operations/jamf-mac-setup) — private; [Revision 11A draft review](https://github.com/mcccd-IT-Operations/jamf-mac-setup/pull/1), not production approved |
| Python | Python scripts and utilities | Separate repository planned; URL to be supplied |
| API | API integrations and automation | Separate repository planned; URL to be supplied |

Windows Code and Adobe Creative Cloud are code categories represented by folders. Individual changes use review branches and pull requests. The candidate is on `review/windows/adobe-creative-cloud-v2`, targeting `main` in [draft PR #1](https://github.com/mcccd-IT-Operations/.github/pull/1). Pillars are governance responsibilities, not mandatory Git branches. Each independent Jamf tool or package has its own private project repository; required helper files, language implementations and guides stay with that tool. Locally uploaded projects have no native GitHub fork relationship. The separate Python and API repository URLs remain to be supplied.

## Adobe Creative Cloud versions

Original: Jim Ierely  
Version 2 edited 11/12/26 @ 7:02 PM by Alvin Bridges

| Version | Download | Review status |
| --- | --- | --- |
| 1 | [Adobe-reset-v1.ps1](./windows-code/adobe-creative-cloud/Adobe-reset-v1.ps1) | Original baseline retained for comparison; production approval is not asserted |
| 2 | [Adobe-reset-v2.ps1](./windows-code/adobe-creative-cloud/Adobe-reset-v2.ps1) | Review candidate — pending District ITS peer review and Cyber Security approval; not approved for production |

Open a script's GitHub file page and select **Download raw file** to save it. Both versions must remain available. Any Version 2 review release must be marked **Pre-release**, state the pending approval status prominently, and attach both scripts as individual `.ps1` assets. A public pre-release is still public and downloadable.

The [release notes](./windows-code/adobe-creative-cloud/RELEASE-NOTES.md) document all changes from Version 1 to Version 2, usage, limitations, and validation status. The [approval record](./windows-code/adobe-creative-cloud/APPROVAL.md) tracks routing and review status; it currently records no approvals. The [published review pre-release](https://github.com/mcccd-IT-Operations/.github/releases/tag/adobe-reset-v2.0.0-rc.1) retains both script downloads at the original code commit. Neither script was executed on Windows during this preparation.

## Review and approval process

1. **Document and route.** Write opening notes and continued section comments using the [documentation standard](./docs/code-documentation.md). Open a PR with the [review template](./.github/pull_request_template.md); assess all five pillars and record additional affected parties using the [routing guidance](./docs/review-routing.md). Start as a draft while incomplete.
2. **Peer and pillar reviews.** Obtain an authorized technical peer review and explicit approvals from every affected pillar and additional required route. Each pillar must have an acknowledged impact disposition; unexplained exclusions and unanswered assessments stay pending. Record findings, owners, actions, and schedule impact.
3. **Final CyberSecurity review.** Involve CyberSecurity early and obtain its final approval after technical and other required reviews, on the same final candidate commit. The final CyberSecurity approver must be distinct from the author and approving technical peer. New changes require renewed approvals and impact reassessment.
4. **Maintainer verification and merge.** Verify all routing dispositions, required approvals, code notes, resolved findings/discussions, checks, release notes, validation, and recovery evidence before merging. A missing required approval, unassigned reviewer, or unresolved route keeps approval pending. Escalation does not override a refusal or replace approval.
5. **Production authorization.** Record the approved commit, immutable release/tag, approvers, evidence references, deployment owner, and applicable change/deployment authorization. Only that approved artifact may be promoted to production. Merging code or publishing a pre-release does not deploy it or independently authorize production.

See [GOVERNANCE.md](./GOVERNANCE.md) for the five-pillar policy, [CONTRIBUTING.md](./CONTRIBUTING.md) for responsibilities, and [approval setup](./docs/approval-process.md) for administrator configuration. Reusable [routing records](./templates/review-routing-record.md) and [PowerShell opening notes](./templates/powershell-review-header.ps1.txt) support consistent review.

## Setup status

The workflow above is the proposed operating process. GitHub user/team assignments, repository access, branch rules, and required checks still need to be configured and verified by an authorized administrator. The current documents do not enforce merge restrictions by themselves. Version 2 remains pending until the required reviews and production authorization are recorded.

This repository is currently public. Public source and review discussions must exclude credentials and restricted operational or security evidence; record approved restricted-system evidence references instead of copying sensitive content here.

Because the repository is named `.github`, eligible community files such as the contribution guide and pull request template can also serve as organization defaults for repositories that lack their own. Each separate repository still needs its own applicable reviewer assignments and branch protections. See [GitHub's default community files documentation](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file).
# MCCCD District IT Operations — Code Review

This repository serves as the code review base for MCCCD District IT Operations and invited members of District Information Technology Services (ITS). Contributors check out code, review changes with their peers, test in an appropriate nonproduction environment, and obtain Cyber Security review before code is authorized for production use.

**Adobe Creative Cloud remediation Version 2 is pending peer and Cyber Security approval. It is not approved for production.** Download availability, a version number, a pull request, or a release does not establish production approval.

## Code organization

| Area | Scope | Location / status |
| --- | --- | --- |
| Windows Code | Windows scripts and endpoint remediation | [windows-code/](./windows-code/) in this repository |
| Adobe Creative Cloud Code | Subset of Windows Code: remediation for Adobe Creative Cloud issues associated with the SailPoint implementation | [windows-code/adobe-creative-cloud/](./windows-code/adobe-creative-cloud/) |
| Jamf | Jamf and Apple endpoint code | Separate repository planned; URL to be supplied |
| Python | Python scripts and utilities | Separate repository planned; URL to be supplied |
| API | API integrations and automation | Separate repository planned; URL to be supplied |

Windows Code and Adobe Creative Cloud are code categories represented by folders. Individual changes use review branches and pull requests. The proposed review branch for this candidate is `review/windows/adobe-creative-cloud-v2`, targeting `main`. No additional repositories or branches are represented as already created by this document.

## Adobe Creative Cloud versions

Original: Jim Ierely  
Version 2 edited 11/12/26 @ 7:02 PM by Alvin Bridges

| Version | Download | Review status |
| --- | --- | --- |
| 1 | [Adobe-reset-v1.ps1](./windows-code/adobe-creative-cloud/Adobe-reset-v1.ps1) | Original baseline retained for comparison; production approval is not asserted |
| 2 | [Adobe-reset-v2.ps1](./windows-code/adobe-creative-cloud/Adobe-reset-v2.ps1) | Review candidate — pending District ITS peer review and Cyber Security approval; not approved for production |

Open a script's GitHub file page and select **Download raw file** to save it. Both versions must remain available. Any Version 2 review release must be marked **Pre-release**, state the pending approval status prominently, and attach both scripts as individual `.ps1` assets. A public pre-release is still public and downloadable.

The [release notes](./windows-code/adobe-creative-cloud/RELEASE-NOTES.md) document all changes from Version 1 to Version 2, usage, limitations, and validation status. The [approval record](./windows-code/adobe-creative-cloud/APPROVAL.md) tracks the candidate's review status; it currently records no approvals. Neither script was executed on Windows during this preparation.

## Review and approval process

1. **Prepare a change.** An invited contributor creates a review branch and opens a pull request using the [review template](./.github/pull_request_template.md). Record the problem, changed version, release notes, validation evidence, deployment scope, and recovery plan. Start as a draft while incomplete.
2. **District ITS peer review.** At least one authorized District ITS peer other than the author checks out the branch, reviews the code and differences, and reviews relevant nonproduction test results. Resolve requested changes and record a formal approving GitHub review for the final commit.
3. **Cyber Security review.** After peer review, an assigned Cyber Security reviewer evaluates the same final commit and records a separate approving GitHub review. That reviewer must be distinct from the author and the approving peer. Changes after either review require renewed approvals on the updated commit.
4. **Maintainer verification and merge.** A maintainer verifies both role-specific approvals, resolved discussions, required checks, release notes, and the approval record before merging. Missing or unassigned reviewers block approval. A checklist alone cannot grant approval.
5. **Production authorization.** Record the approved commit, immutable release/tag, approvers, evidence references, deployment owner, and applicable change/deployment authorization. Only that approved artifact may be promoted to production. Merging code or publishing a pre-release does not deploy it or independently authorize production.

See [CONTRIBUTING.md](./CONTRIBUTING.md) for reviewer responsibilities and [approval setup](./docs/approval-process.md) for administrator configuration and release handling.

## Setup status

The workflow above is the proposed operating process. GitHub user/team assignments, repository access, branch rules, and required checks still need to be configured and verified by an authorized administrator. The current documents do not enforce merge restrictions by themselves. Version 2 remains pending until the required reviews and production authorization are recorded.

This repository is currently public. Public source and review discussions must exclude credentials and restricted operational or security evidence; record approved restricted-system evidence references instead of copying sensitive content here.

Because the repository is named `.github`, eligible community files such as the contribution guide and pull request template can also serve as organization defaults for repositories that lack their own. Each separate repository still needs its own applicable reviewer assignments and branch protections. See [GitHub's default community files documentation](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file).

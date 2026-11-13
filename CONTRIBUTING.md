# District ITS code contributions and reviews

This is the proposed review process for invited MCCCD District Information Technology Services contributors. Apply it to code reviewed here and adapt it explicitly for separate Jamf, Python, and API repositories. This guide may be inherited as a default community file by other organization repositories; it does not configure their permissions or branch rules.

Follow [GOVERNANCE.md](./GOVERNANCE.md): assess Infrastructure, Development, Business ERPs, End Point Engineering, and CyberSecurity, and obtain approval from every affected pillar and additional required party. All five must have a recorded impact disposition. No response is not approval; a Not applicable assessment needs a reason and the pillar representative's acknowledgement.

## Contributors

- Work on a review branch and submit a pull request. Do not push code directly to the protected integration branch.
- Describe the issue and scope, identify the baseline and candidate versions, and update release notes with every functional difference.
- Put purpose, business context, impact, account/permissions, dependencies, validation, recovery limits, and review status in opening code notes. Continue explanations through major sections so reviewers understand what each function does and why. Follow [the documentation standard](./docs/code-documentation.md).
- Complete the [routing record](./templates/review-routing-record.md) with all five pillars and any additional owners identified during review. Reassess routing when scope or impact changes.
- Provide a nonproduction validation plan and results, account/privilege assumptions, deployment impact, and a recovery plan. Mark unperformed tests as pending.
- Include no credentials or restricted review evidence in this public repository. Reference the approved restricted evidence location when needed.
- Resolve feedback before seeking approval. New code or governance changes require renewed required approvals for the final candidate; do not reuse approvals from an older commit.

## District ITS peer reviewers

An assigned peer other than the author checks out and inspects the exact candidate commit, reviews the differences from the baseline, and evaluates relevant nonproduction test evidence. For the Adobe candidate, inspect process scope, credential matching, per-user context, file deletion/backup behavior, error paths, and the documented limitations. Use GitHub's formal review decision to approve or request changes; comments and checked boxes alone are not approval.

## Pillar and additional reviewers

Each designated pillar representative assesses impact to their support structure, users, services, and products, records the routing disposition, and formally reviews the final commit when affected. Identify additional owners or dependencies when necessary and ensure those routes are resolved. A technical peer may also represent a pillar when explicitly authorized, but no approval silently counts for multiple pillars. Record blockers, responsible owners, next actions, follow-up dates, and schedule effects. Missing approval may delay the project; silence and escalation do not grant approval.

## Cyber Security reviewers

Participate early when needed. After technical peer and other required reviews are complete, an assigned CyberSecurity reviewer, distinct from the author and approving peer, reviews the same final commit and evidence. Assess access, data handling, execution context, operational impact, and unresolved findings. Record the final formal decision in GitHub. If restricted findings must be tracked elsewhere, include only an approved reference in the PR.

## Maintainers and production owners

Verify all five impact dispositions and all required pillar/additional approvals, plus technical peer and final CyberSecurity approval on the final commit. Verify code notes, resolved findings/discussions, tests, recovery evidence, and checks. Maintain an auditable record linking the PR, final commit, represented roles, decisions, evidence, and release. Do not mark Adobe Version 2 approved while any required assessment, field, or review is pending. Refer to the governance policy for recording final approvals without creating an unreviewed record-only commit.

Production deployment requires the approved artifact and applicable change/deployment authorization, including a named owner and recovery plan. Neither a merge nor a download constitutes production authorization.

Administrator setup and the distinction between documented policy and GitHub enforcement are described in [approval-process.md](./docs/approval-process.md).

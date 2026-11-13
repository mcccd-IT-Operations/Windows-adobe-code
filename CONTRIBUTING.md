# District ITS code contributions and reviews

This is the proposed review process for invited MCCCD District Information Technology Services contributors. Apply it to code reviewed here and adapt it explicitly for separate Jamf, Python, and API repositories. This guide may be inherited as a default community file by other organization repositories; it does not configure their permissions or branch rules.

## Contributors

- Work on a review branch and submit a pull request. Do not push code directly to the protected integration branch.
- Describe the issue and scope, identify the baseline and candidate versions, and update release notes with every functional difference.
- Provide a nonproduction validation plan and results, account/privilege assumptions, deployment impact, and a recovery plan. Mark unperformed tests as pending.
- Include no credentials or restricted review evidence in this public repository. Reference the approved restricted evidence location when needed.
- Resolve feedback before seeking approval. A new code commit requires renewed peer and Cyber Security approval; do not reuse approvals from an older commit.

## District ITS peer reviewers

An assigned peer other than the author checks out and inspects the exact candidate commit, reviews the differences from the baseline, and evaluates relevant nonproduction test evidence. For the Adobe candidate, inspect process scope, credential matching, per-user context, file deletion/backup behavior, error paths, and the documented limitations. Use GitHub's formal review decision to approve or request changes; comments and checked boxes alone are not approval.

## Cyber Security reviewers

After peer review is complete, an assigned Cyber Security reviewer, distinct from the author and approving peer, reviews the same final commit and relevant evidence. Assess the code's access, data handling, execution context, operational impact, and unresolved findings. Record the formal review decision in GitHub. If restricted findings must be tracked elsewhere, include only an approved reference in the pull request.

## Maintainers and production owners

Verify that two distinct authorized reviewers filled the two required roles on the final commit, that requested changes and conversations are resolved, and that required checks pass. Maintain an auditable approval record linking the PR, commit, reviewers, evidence, and approved release. Do not mark Adobe Version 2 as approved while any field or review is pending.

Production deployment requires the approved artifact and applicable change/deployment authorization, including a named owner and recovery plan. Neither a merge nor a download constitutes production authorization.

Administrator setup and the distinction between documented policy and GitHub enforcement are described in [approval-process.md](./docs/approval-process.md).

# Review approvals and repository administration

Status: proposed process prepared for administrator setup. No GitHub access controls, teams, branch protections, required checks, or approval integrations have been configured by these files.

## Access and reviewer assignments

An administrator invites the intended District ITS members and gives contributors/reviewers only the repository access needed for their responsibilities. Assign real, verified GitHub users or teams to these roles before approving code:

| Role | Assignment | Responsibility |
| --- | --- | --- |
| District ITS peer reviewers | Pending administrator assignment | Technical review and nonproduction test review |
| Cyber Security reviewers | Pending administrator assignment | Security review after peer review |
| Maintainers | Pending administrator assignment | Verify role-specific approvals and merge approved changes |
| Production deployment owner | Pending per change | Deploy only the approved artifact with applicable authorization |

For each code candidate, the author cannot fill an approving role. Require one approving peer and one distinct Cyber Security reviewer. An invitation, role label, comment, or completed checklist is not a formal approval.

## Branch and merge controls to configure

For `main` and any future production branch, an authorized administrator must configure and verify:

- Changes through pull requests, with at least two approving reviews from eligible reviewers.
- Dismissal of stale approvals when new commits change the candidate, and review of the latest reviewable push by someone other than its pusher.
- Resolution of review conversations before merge; no unresolved requests for changes.
- Applicable tested status checks once those checks actually exist; do not claim a nonexistent check is enforced.
- Restrictions on direct updates, force pushes, deletion, and bypass permissions so routine work cannot circumvent the review process.
- A real CODEOWNERS assignment using verified reviewer handles with the required repository access. Protect changes to review-governance files as well as code.

Requiring two approvals alone does not prove that one reviewer is a District ITS peer and the other is Cyber Security. Likewise, listing two teams as owners of a path does not require approval from both: GitHub accepts an approval from any matching owner. The maintainer must verify the two distinct role approvals and their order on the final commit until a trusted role-aware required check or applicable team-specific rule is configured and tested. Do not describe the role requirement as automatically enforced until that setup has been verified.

References: [protected branches](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches), [managing a protection rule](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/managing-a-branch-protection-rule), and [code owners](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners).

## Adobe Version 2 review

Code category: Windows Code → Adobe Creative Cloud Code. Purpose: remediation for Adobe Creative Cloud issues associated with the SailPoint implementation.

Use `review/windows/adobe-creative-cloud-v2` as the proposed change branch and open a PR targeting `main`. Preserve the original Version 1 alongside Version 2 and the complete release notes. Start the PR as a draft if validation is incomplete; request peer review when ready, then Cyber Security review after the peer approves. The candidate remains pending during this process.

Reviewers may fetch/check out the PR branch using their normal GitHub/Git tooling. Inspect the exact commit SHA, compare versions, test only in the authorized nonproduction environment, and record evidence. Neither version was executed on Windows during this preparation.

Update [the approval record](../windows-code/adobe-creative-cloud/APPROVAL.md) with the actual review links, approved code commit, test evidence, and applicable production authorization. A later code change invalidates the candidate's previous approvals under this process.

## Downloads and releases

Keep [Version 1](../windows-code/adobe-creative-cloud/Adobe-reset-v1.ps1) and [Version 2](../windows-code/adobe-creative-cloud/Adobe-reset-v2.ps1) in source control so reviewers can download either. A review release must be a clearly named GitHub pre-release with both individual `.ps1` assets and the [release notes](../windows-code/adobe-creative-cloud/RELEASE-NOTES.md). The proposed candidate tag is `adobe-reset-v2.0.0-rc.1`; it is not represented as already created.

Do not label the candidate production approved. After all approvals, a maintainer records the exact approved code commit, immutable version/tag, artifacts, approvers, and authorization. Publish a distinct approved release tied to that code; do not silently move an already published tag or replace reviewed assets. A release is not an automatic deployment.

## Organization defaults and separate repositories

This public `.github` repository can provide default contribution guidance and PR templates for organization repositories lacking their own. Jamf, Python, and API repository URLs are not yet supplied, and these documents do not create them. Configure reviewer ownership, branch rules, tests, and any deployment authorization independently in each repository. GitHub's default community-file behavior is documented [here](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file).

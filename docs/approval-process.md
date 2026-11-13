# Review approvals and repository administration

Status: proposed process prepared for administrator setup. No GitHub access controls, teams, branch protections, required checks, or approval integrations have been configured by these files.

The governing policy is [GOVERNANCE.md](../GOVERNANCE.md). Route every change through impact assessment by all five pillars and obtain approvals from all affected pillars/additional required parties. Missing approval or unresolved routing keeps approval pending and may delay the project. The five governance pillars do not require five Git branches.

## Access and reviewer assignments

An administrator invites the intended District ITS members and gives contributors/reviewers only the repository access needed for their responsibilities. Assign real, verified GitHub users or teams to these roles before approving code:

| Role | Assignment | Responsibility |
| --- | --- | --- |
| Infrastructure | Pending administrator assignment | Infrastructure/shared-service impact and approval when affected |
| Development | Pending administrator assignment | Code/application/integration impact and approval when affected |
| Business ERPs | Pending administrator assignment | Business-system/data/workflow impact and approval when affected |
| End Point Engineering | Pending administrator assignment | Endpoint/user-session/deployment impact and approval when affected |
| CyberSecurity | Pending administrator assignment | Security impact assessment and final production-bound review |
| District ITS peer reviewers | Pending administrator assignment | Technical review and nonproduction test review |
| Additional routed owners | Pending per assessment | Product, identity, data, support, or other impact review as required |
| Maintainers | Pending administrator assignment | Verify all routing dispositions and required approvals before merge |
| Production deployment owner | Pending per change | Deploy only the approved artifact with applicable authorization |

The author cannot fill an approving role. Require a technical peer and a distinct final CyberSecurity approver, along with all required pillar/additional approvals. A peer may represent an affected pillar when authorized and recorded. Obtain representative acknowledgement for Not applicable dispositions; no response stays pending. Invitations, labels, comments, and checklists are not formal approval.

## Branch and merge controls to configure

For `main` and any future production branch, an authorized administrator must configure and verify:

- Changes through pull requests, with at least two approving reviews as a baseline, plus verification of every required pillar/additional role; a fixed count does not encode the complete routing requirement.
- Dismissal of stale approvals when new commits change the candidate, and review of the latest reviewable push by someone other than its pusher.
- Resolution of review conversations before merge; no unresolved requests for changes.
- Applicable tested status checks once those checks actually exist; do not claim a nonexistent check is enforced.
- Restrictions on direct updates, force pushes, deletion, and bypass permissions so routine work cannot circumvent the review process.
- A real CODEOWNERS assignment using verified reviewer handles with the required repository access. Protect changes to review-governance files as well as code.

Requiring two approvals alone does not prove the correct roles approved, and more than two may be required by impact routing. Listing multiple teams as owners of a path does not require approval from every listed team: GitHub accepts an approval from any matching owner. Maintainers must verify each required role, acknowledged exclusions, additional routing, and final CyberSecurity review order until a trusted routing-aware required check or applicable team-specific rules are configured and tested. Do not describe the pillar requirement as automatically enforced before that setup is verified. No placeholder CODEOWNERS entries or inactive checks are presented as enforcement.

References: [protected branches](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/about-protected-branches), [managing a protection rule](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/managing-a-branch-protection-rule), and [code owners](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners).

## Adobe Version 2 review

Code category: Windows Code → Adobe Creative Cloud Code. Purpose: remediation for Adobe Creative Cloud issues associated with the SailPoint implementation.

The candidate is on `review/windows/adobe-creative-cloud-v2` in [draft PR #1](https://github.com/mcccd-IT-Operations/.github/pull/1), targeting `main`. Preserve Version 1, Version 2, and release notes. Follow the [initial routing assessment](./review-routing.md): End Point Engineering and CyberSecurity are required; other pillars and additional identity/Adobe/support routes await impact assessment. Request peer and required pillar reviews when ready, then final CyberSecurity review. Governance changes themselves require all five pillars. The candidate remains pending throughout this process.

Reviewers may fetch/check out the PR branch using their normal GitHub/Git tooling. Inspect the exact commit SHA, compare versions, test only in the authorized nonproduction environment, and record evidence. Neither version was executed on Windows during this preparation.

Update [the approval record](../windows-code/adobe-creative-cloud/APPROVAL.md) with actual routing, acknowledgement/review links, final candidate commit, test evidence, and production authorization. Record final approvals in the PR/change system when committing an approval record would itself change the reviewed commit. New code or governance changes require renewed approvals and impact reassessment.

## Downloads and releases

Keep [Version 1](../windows-code/adobe-creative-cloud/Adobe-reset-v1.ps1) and [Version 2](../windows-code/adobe-creative-cloud/Adobe-reset-v2.ps1) in source control. The [published review pre-release](https://github.com/mcccd-IT-Operations/.github/releases/tag/adobe-reset-v2.0.0-rc.1) includes both `.ps1` assets and version-change notes, pointing to code commit `7ffd71b67ce0a7ebaa9d37b621d678e5b56d451f`. It is an unapproved historical review snapshot. The newer governance proposal is reviewed in the PR; its additions do not silently change the existing tag or assets.

Do not label the candidate production approved. After all approvals, a maintainer records the exact approved code commit, immutable version/tag, artifacts, approvers, and authorization. Publish a distinct approved release tied to that code; do not silently move an already published tag or replace reviewed assets. A release is not an automatic deployment.

## Organization defaults and separate repositories

This public `.github` repository can provide default contribution guidance and PR templates for organization repositories lacking their own. The private [Jamf Blueprints IaC repository](https://github.com/mcccd-IT-Operations/jamf-blueprints-iac) now contains an [initial Python draft review](https://github.com/mcccd-IT-Operations/jamf-blueprints-iac/pull/1) and a planned Zsh area. Separate Python and API repository URLs are not yet supplied. Linking the repository does not grant access or imply code approval. Configure reviewer ownership, branch rules, tests, and any deployment authorization independently in each repository. GitHub's default community-file behavior is documented [here](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file).
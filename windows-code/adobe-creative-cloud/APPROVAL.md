# Adobe Creative Cloud remediation — Version 2 approval record

**Status: PENDING ROUTING, REQUIRED PILLAR, PEER, AND CYBERSECURITY APPROVAL — NOT APPROVED FOR PRODUCTION.**

Purpose: remediation for Adobe Creative Cloud issues associated with the SailPoint implementation.

Original: Jim Ierely  
Version 2 edited 11/12/26 @ 7:02 PM by Alvin Bridges

| Required record | Current value |
| --- | --- |
| Candidate | [Adobe-reset-v2.ps1](./Adobe-reset-v2.ps1) |
| Baseline | [Adobe-reset-v1.ps1](./Adobe-reset-v1.ps1) |
| Change record | [RELEASE-NOTES.md](./RELEASE-NOTES.md) |
| Review branch | `review/windows/adobe-creative-cloud-v2` |
| Pull request | [Draft PR #1](https://github.com/mcccd-IT-Operations/.github/pull/1) |
| Script code snapshot | `7ffd71b67ce0a7ebaa9d37b621d678e5b56d451f`; governance is being revised in the PR |
| Final reviewed candidate SHA | Pending; reviewers must identify the final PR commit |
| Nonproduction test evidence | Pending; no Windows execution performed during preparation |
| District ITS peer reviewer | Unassigned — handle required |
| Peer approval link / commit / date | Pending |
| Cyber Security reviewer | Unassigned — handle required; distinct from author and approving peer |
| Cyber Security approval link / commit / date | Pending; final review follows technical peer and other required reviews |
| Open findings / disposition | Pending review; see release notes for identified code limitations |
| Maintainer verification | Pending |
| Approved immutable release/tag | None |
| Production deployment owner | Unassigned |
| Applicable production change/deployment authorization | Pending |
| Recovery plan and evidence | Pending |

## Impact routing for the Adobe remediation

| Pillar / additional route | Representative | Initial routing | Assessment acknowledgement / decision / review link / commit / date |
| --- | --- | --- | --- |
| Infrastructure | Unassigned | Pending assessment of identity, SSO, shared-service and support dependencies | Pending |
| Development | Unassigned | Pending assessment of application/integration ownership and technical review | Pending |
| Business ERPs | Unassigned | Pending assessment; do not assume ERP/business workflow impact or exclusion | Pending |
| End Point Engineering | Unassigned | Required: Windows user-session, process, credential and cache changes | Pending |
| CyberSecurity | Unassigned | Required: credential/context/security impact and final review | Pending |
| Identity/SailPoint and Adobe service/licensing owners | Unassigned | Pending assessment of rollout issue and intended remediation outcome | Pending |
| Service Desk / affected user support | Unassigned | Pending assessment of interrupted apps, sign-in guidance, support handoff, communications | Pending |

Not applicable requires a reason and the relevant representative's acknowledgement. No response remains pending. Reviewers can add routes; all required routes must be resolved.

## Governance proposal routing

The policy/template changes in this PR affect all five pillars. Infrastructure, Development, Business ERPs, End Point Engineering, and CyberSecurity are all required reviewers of that governance proposal; representatives and decisions are currently unassigned/pending. This is distinct from the Adobe code's initial impact assessment above.

## Blockers and project impact

Reviewer assignments, impact acknowledgements, technical/pillar/security decisions, Windows validation, and production authorization remain pending. Record the accountable owner, next action, follow-up date, schedule impact, and resolution evidence as each blocker is assigned. Do not invent dates or approvals. Escalate unresolved concerns to the relevant pillar lead and project/change owner; escalation does not grant consent.

Do not fill approval fields with proposed names or checkboxes as a substitute for actual decisions. All required routes and roles must approve the final candidate; new changes require renewed approvals. Record final evidence in the PR/change system if committing this record would change the reviewed commit. Downloading either script does not grant production authorization. See [GOVERNANCE.md](../../GOVERNANCE.md) for the full policy.

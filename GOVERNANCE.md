# Adobe Creative Cloud remediation — project governance

The governing review framework is maintained centrally in [District ITS governance](https://github.com/mcccd-IT-Operations/.github/blob/main/GOVERNANCE.md), [routing guidance](https://github.com/mcccd-IT-Operations/.github/blob/main/docs/review-routing.md) and [documentation standards](https://github.com/mcccd-IT-Operations/.github/blob/main/docs/code-documentation.md). This file contains project scope and routing rather than a separate organization policy. See [baseline/adoption record](./GOVERNANCE-ADOPTION.md).

**Pending assessments, technical/pillar/security approvals and operational validation. Not approved for production.** Every pillar gets an impact assessment; all affected pillars and additional required routes approve. Reasoned Not applicable needs representative acknowledgement. No response remains pending.

## Project routing

| Pillar / additional route | Representative | Initial routing | Assessment acknowledgement / decision / review link / commit / date |
| --- | --- | --- | --- |
| Infrastructure | Unassigned | Pending assessment of identity, SSO, shared-service and support dependencies | Pending |
| Development | Unassigned | Pending assessment of application/integration ownership and technical review | Pending |
| Business ERPs | Unassigned | Pending assessment; do not assume ERP/business workflow impact or exclusion | Pending |
| End Point Engineering | Unassigned | Required: Windows user-session, process, credential and cache changes | Pending |
| CyberSecurity | Unassigned | Required: credential/context/security impact and final review | Pending |
| Identity/SailPoint and Adobe service/licensing owners | Unassigned | Pending assessment of rollout issue and intended remediation outcome | Pending |
| Service Desk / affected user support | Unassigned | Pending assessment of interrupted apps, sign-in guidance, support handoff, communications | Pending |

Keep actual decisions, final candidate commit, evidence and additional routes in [windows-code/adobe-creative-cloud/APPROVAL.md](./windows-code/adobe-creative-cloud/APPROVAL.md). Technical peer review is by someone other than the author; final CyberSecurity approval follows required reviews and is by a reviewer distinct from author and approving peer. New changes require renewed review. Record missing approvals/findings, owner, action, follow-up and schedule impact.

Production needs separate authorization for the approved artifact, scope, operator, timing, monitoring, support and recovery. Existing findings and validation limits remain in project documentation. Local templates do not configure reviewer assignments, branch rules or checks.

# Routing code reviews to affected parties

Follow [GOVERNANCE.md](../GOVERNANCE.md). Folder names and code language identify where code lives; they do not determine everyone who must review it. Route based on affected support structures, users, services, products, integrations, and operational dependencies.

## Intake and reassessment

1. List the business problem and affected systems, users, owners, and support teams in the opening code notes and PR.
2. Assess all five pillars with a named representative or mark the assignment pending. Do not assume no impact because a change is small or belongs to another team.
3. Request acknowledgement of each impact assessment. Record Required or an acknowledged Not applicable decision with a reason. No response remains Pending assessment.
4. Add routes identified by reviewers. Distinguish an advisory consultation from a required approval, with an explicit reason and owner for the distinction. Resolve disagreements; do not drop a required route to meet a date.
5. Reassess after scope changes, new findings, new dependencies, or a change in deployment audience.

## Examples of additional routing

| Change or impact | Parties to assess in addition to pillar representatives |
| --- | --- |
| SailPoint, SSO, licensing, or identity lifecycle behavior | Identity/SailPoint service owner, application/licensing owner, affected business service owners |
| Endpoint credential/cache removal or application termination | Service Desk and desktop support, affected application owners, user communications/change owner |
| ERP API, batch job, access, or data changes | Named ERP product owner, integration owner, data steward, scheduled-operations owner |
| Shared service, network, or monitoring changes | Service/network owners, operations/on-call support, recovery owner |
| Third-party product behavior or contractual dependency | Product/service owner and vendor contact where needed |
| User interaction, access, or accessibility changes | Affected user/business representatives and accessibility specialists where applicable |

These are assessment prompts, not evidence that any named service is affected by a particular change. Additional parties may be necessary. Do not send invitations or external communications until the actual recipient and authorized routing have been identified.

## Current Adobe candidate assessment

| Pillar / route | Initial assessment | Reason and outstanding action |
| --- | --- | --- |
| Infrastructure | Pending assessment | Confirm whether identity, SSO, shared services, or support dependencies are affected |
| Development | Pending assessment | Confirm application/integration ownership and technical reviewer assignment |
| Business ERPs | Pending assessment | Confirm whether ERP access, integrations, or business workflows depend on the affected sign-in path; no impact is presumed |
| End Point Engineering | Required; unassigned | Script stops Adobe processes and changes local Windows credentials/caches in a user session |
| CyberSecurity | Required; unassigned | Review credential deletion, account context, permissions, and final production-bound candidate |
| Identity/SailPoint and Adobe service/licensing owners | Pending assessment | Confirm the relationship to SailPoint rollout issues and the intended recovery outcome |
| Service Desk / affected user support | Pending assessment | Assess interrupted applications, sign-in guidance, support handoff, and communications |

This is initial routing, not completed review. Record actual representatives, acknowledgements, decisions, and evidence in the [Adobe approval record](../windows-code/adobe-creative-cloud/APPROVAL.md).

## Governance proposal assessment

Changes to the review policy, documentation standard, routing rules, or approval templates affect all five pillars. All five are required reviewers of this proposal. Each representative can identify further affected parties. Adoption remains pending until their decisions are recorded.

Use the [routing record template](../templates/review-routing-record.md), or open a review-routing issue and link it to the PR. An issue/checklist alone is not a GitHub approval or enforced merge gate.

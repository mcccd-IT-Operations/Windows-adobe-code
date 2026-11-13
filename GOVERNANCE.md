# MCCCD District ITS review governance

Status: governance proposal for review in [pull request #1](https://github.com/mcccd-IT-Operations/.github/pull/1). This policy is not represented as already approved or enforced by GitHub settings.

## Purpose

Review governance gives every involved party an opportunity to understand and review code that affects its support structure, users, services, or products. Infrastructure, Development, Business ERPs, End Point Engineering, and CyberSecurity are the five pillars of this IT governance framework. These are review responsibilities, not five mandatory Git branches.

A missing approval from an affected pillar can delay a project. Identify stakeholders and route reviews at the beginning of the work so objections, dependencies, and scheduling constraints are visible before a production date is promised. Silence, an elapsed deadline, a download, or a checked box is not approval.

## Pillars and responsibilities

| Pillar | Review focus | Typical routing triggers |
| --- | --- | --- |
| Infrastructure | Availability, identity services, networks, compute, storage, shared services, capacity, monitoring, and recovery | Shared infrastructure, authentication dependencies, service restarts, connectivity, or operational monitoring changes |
| Development | Code behavior, maintainability, dependencies, integration contracts, error handling, and testability | New code, application logic, libraries, API changes, or integration behavior |
| Business ERPs | Business workflows, enterprise applications, data integrity, integrations, scheduled processing, and service ownership | ERP dependencies, business-system access, data exchange, or changes to business users' workflows |
| End Point Engineering | Device configuration, packaging, deployment context, user sessions, supportability, and endpoint recovery | Windows/macOS devices, Adobe applications, Intune, ConfigMgr, Jamf, or local credentials/cache changes |
| CyberSecurity | Access, credentials, data handling, security controls, auditability, findings, and security impact | Required for production-bound code; involve early when security implications are identified |

Names are role descriptions. Actual GitHub users, teams, delegates, and backups must be verified and recorded in the routing record. They remain unassigned until supplied by District ITS.

## Review lifecycle

1. **Document and assess impact.** The author writes the opening code notes and section comments, describes changed behavior, and creates a routing record covering all five pillars. Record affected users, products, support teams, external dependencies, validation, and recovery needs.
2. **Give each pillar an opportunity to review.** A designated representative for each pillar acknowledges the impact assessment. Mark it Required, Not applicable, or Pending assessment with evidence. The author cannot silently remove a pillar. Not applicable requires a reason and acknowledgement from that pillar's designated representative. Unanswered or disputed assessments remain pending.
3. **Expand routing as needed.** Reviewers may identify additional product owners, identity/SailPoint owners, Service Desk, data owners, vendors, accessibility specialists, or other affected parties. Record each additional route, why it is needed, whether approval is required, an accountable representative, and its disposition. Resolve added routes before approval.
4. **Perform technical and pillar reviews.** At least one District ITS technical peer other than the author reviews the exact candidate commit and evidence. Every required pillar and additional required route reviews its impact. Work can proceed in parallel; findings and dependencies must remain visible in the pull request or approved evidence system.
5. **Complete CyberSecurity review.** CyberSecurity participates early as appropriate and records final approval after technical and other required reviews are complete. The final CyberSecurity approver must be distinct from the author and approving technical peer. An earlier security comment does not substitute for final approval.
6. **Verify and authorize.** A maintainer verifies resolved routing, all required approvals for the final candidate, resolved findings/discussions, checks, code notes, validation, and recovery evidence. Production still requires the applicable change/deployment authorization and an approved immutable artifact.

## Decisions and project impact

| State | Meaning | Effect |
| --- | --- | --- |
| Pending assessment | Impact, representative, or additional routing is unresolved | Change cannot complete governance review |
| Pending review | A required reviewer has not made a decision | Merge/production approval remains pending under this process |
| Changes requested | A reviewer requires corrections or evidence | Resolve and obtain renewed approval |
| Blocked | A dependency, risk, test, or ownership issue prevents approval | Record owner, next action, and project impact; do not promote |
| Approved | An authorized reviewer has explicitly approved the identified candidate | Counts only for the recorded role and commit |
| Not applicable | A pillar representative acknowledged a supported no-impact assessment | No technical approval needed for that pillar; retain the evidence |

For each delay, record the reason, responsible person, next action, target follow-up date, and schedule impact. Escalate unresolved issues to the relevant pillar lead and project/change owner to resolve concerns or assign an authorized delegate. Escalation does not grant approval, override a refusal, or turn a deadline into consent. No waiver or bypass process is created by this proposal.

## Approval evidence and changes

Record the reviewer handle, represented role/pillar, decision, formal GitHub review or acknowledged assessment link, reviewed commit SHA, date, and any conditions. The author cannot approve their own change. A technical peer may also represent an affected pillar when authorized; each representation must be explicit. One person's approval must not be assumed to represent several pillars without recorded authorization for each.

All required approvals must cover the final reviewable commit. New code or governance changes require renewed approvals. Reassess routing whenever scope, users, products, dependencies, or operational impact changes; reopen previously Not applicable routes when necessary. Approvals tied to an earlier release/tag are not automatically transferred to a later candidate.

Updating an approval record in the branch creates another commit. Have reviewers verify and reaffirm the resulting final commit, or record the final approvals externally in the PR/change system with immutable links; do not chase approval by treating an unreviewed record-only commit as already approved.

## Documentation is part of readiness

Code must begin with notes explaining its purpose, business context, authorship/version, affected systems/users, execution context, dependencies, impact, parameters, outputs, error/exit behavior, validation status, known limits, recovery, and review record. Comments throughout the code must explain each major section's purpose and function, especially changes and consequential operations. A reviewer must be able to connect the code to the operational problem it addresses.

See the [code documentation standard](./docs/code-documentation.md). Missing, misleading, or outdated notes are review findings and can prevent approval. Comments educate reviewers; they do not substitute for testing or formal approval.

## Enforcement and related records

This policy and its templates document responsibilities. They do not configure invitations, reviewer teams, CODEOWNERS, branch rules, status checks, or deployment gates. Maintain a manual role-by-role approval gate until administrator-configured enforcement is verified. A fixed number of approvals alone does not prove all required pillars approved.

- [Routing guidance and examples](./docs/review-routing.md)
- [Administrator setup](./docs/approval-process.md)
- [Routing and approval template](./templates/review-routing-record.md)
- [Pull request template](./.github/pull_request_template.md)

Governance changes affect all five pillars: route this proposal to representatives of all five and CyberSecurity before treating it as adopted. Adobe Version 2 remains a pending review candidate, not production-approved code.

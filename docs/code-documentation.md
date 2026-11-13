# Code notes for informed reviews

Notes at the beginning of code orient reviewers before they inspect implementation details. Continued notes explain each major section's purpose, functions, and operational effect. This standard supports the five-pillar [review governance](../GOVERNANCE.md).

## Opening notes

Use the language's supported comments/help format and cover:

- Purpose and business problem; relevant project, issue, or change reference.
- Original author, editor, version, edit date, and a link to release notes. Preserve original attribution; do not invent authors or dates.
- Affected support structures, products, services, and users; preliminary pillar routing and additional owners to assess.
- Required operating system/runtime, permissions, execution account/session, dependencies, and deployment mechanism.
- Inputs/parameters and defaults, expected outputs, error/exit behavior, and known limitations.
- Consequential actions such as process termination, credential/file changes, service restarts, API writes, and potential interruption.
- Validation performed and not performed, verification criteria, and recovery/rollback limits.
- Review/approval reference and accurate status. A header must not claim approval that has not been recorded.

Use [the PowerShell opening-notes template](../templates/powershell-review-header.ps1.txt) for new scripts or a reviewed revision. Place required language directives such as a shebang first when applicable, then comments before executable behavior. For PowerShell, keep comment-based help associated with the script/parameter block and place any executable statements after the parameter block. Use native comment syntax in embedded languages; do not insert PowerShell comments inside embedded C#.

## Notes throughout code

Introduce each major section with what it does and why it exists. Explain prerequisites and account/session assumptions, non-obvious parsing/filter rules, external calls and dependencies, changes from the prior version, retries, verification, cleanup, and error handling. Describe user/service impact where it occurs.

For PowerShell, `##` section comments are appropriate. Explain intent and limits rather than restating each assignment. Keep notes accurate when behavior changes. In particular, distinguish an attempted action, a verified result, and an assumed outcome. Explain exceptions and gaps a reviewer needs to assess.

Example:

```powershell
## Purpose: Release user-session file locks before clearing the cache.
## Why: An open database can prevent cleanup and leave stale sign-in state.
## Impact: Forced shutdown can interrupt Adobe work; see the bounded grace
## period and survivor checks below. Record validation and known limits.
```

## Reviewer expectations

Confirm that notes match the code and help each routed pillar evaluate its own impact. Ask for clarification when purpose, affected parties, parameters, side effects, verification, or recovery are unclear. Mark incomplete documentation as a finding instead of approving based on assumptions.

For released code, propose documentation changes on the review branch and version them transparently. Do not silently replace an already published release asset or tag. Version 1 remains the historical baseline; the existing Version 2 release remains its original review snapshot until a separately identified candidate is published.

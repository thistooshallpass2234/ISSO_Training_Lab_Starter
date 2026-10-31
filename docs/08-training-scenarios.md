# 08 — Training scenarios and measurable outcomes

Complete each scenario, preserve sanitized evidence, and write a short analyst/ISSO summary. Use synthetic identities and test data.

## Scenario 1 — Asset inventory reconciliation

**Objective:** Identify undocumented assets and stale inventory records.

1. Build a list of all VMs and containers.
2. Compare it with `evidence/asset-register.csv`.
3. Identify missing, duplicate, and retired entries.
4. Record owner role, purpose, OS/image version, IP, and last verified date.
5. Produce a discrepancy report and corrective actions.

**Success criteria:** Every active lab component has a unique ID, purpose, owner role, and current version.

## Scenario 2 — Least-privilege access review

1. Create synthetic users and groups in AD.
2. Add a test user to an intentionally over-privileged group.
3. Export group membership.
4. Identify access inconsistent with the user's role.
5. Propose and implement a lab-approved correction.
6. Preserve before/after membership evidence.

**Success criteria:** The review identifies the excess privilege, records approval, and verifies removal.

## Scenario 3 — Baseline deviation

1. Select one supported Linux or Windows benchmark.
2. Record product version and benchmark revision.
3. Assess the system.
4. Select one non-destructive finding.
5. Document risk, remediation, test, and rollback.
6. Reassess and record the result.

**Success criteria:** The finding is traceable from discovery through retest. Do not claim overall compliance from one check.

## Scenario 4 — Suspicious authentication activity

1. Generate several harmless failed logons on a lab endpoint.
2. Confirm events arrive in the monitoring platform.
3. Correlate source, account, endpoint, and time.
4. Determine whether the activity is expected test traffic.
5. Write a triage note and close with rationale.

**Success criteria:** The note identifies the signal, context, scope, disposition, and evidence.

## Scenario 5 — Web application vulnerability assessment

1. Confirm Juice Shop is reachable only through the loopback-bound proxy.
2. Record the authorized target and test window.
3. Run a safe, limited scan from Kali against the lab-only target.
4. Manually validate a finding.
5. Document severity, impact, evidence, and remediation.
6. Retest after applying a fix or configuration change.

**Success criteria:** Every reported finding has validation and a disposition. Do not scan beyond the lab target.

## Scenario 6 — Network traffic investigation

1. Download a public training PCAP with a clear license/provenance.
2. Calculate SHA-256.
3. Parse it with Zeek.
4. Use `jq` to summarize DNS, connections, and HTTP metadata.
5. Identify an unusual but benign pattern.
6. Create a timeline and analyst note.

**Success criteria:** Findings are reproducible from the exact PCAP hash and tool versions.

## Scenario 7 — Change control

1. Propose a firewall rule change.
2. Record business/mission justification (synthetic).
3. Document source, destination, service, risk, and rollback.
4. Approve within the lab exercise.
5. Implement and test.
6. Record post-change state.

**Success criteria:** Change is authorized, bounded, tested, and reversible.

## Scenario 8 — POA&M lifecycle

1. Select a validated weakness from a previous scenario.
2. Write a concise risk statement.
3. Assign a synthetic owner role and target date.
4. Define milestones and evidence.
5. Remediate and retest.
6. Close only after verification.

**Success criteria:** The record includes a clear weakness, action, owner, milestone, and objective closure evidence.

## Scenario 9 — Incident response tabletop

Use a simulated endpoint alert; do not deploy live malware.

1. Record detection and triage time.
2. Identify affected assets and accounts.
3. Preserve relevant logs.
4. Recommend containment and obtain exercise approval.
5. Define recovery steps.
6. Produce lessons learned and a follow-up action.

**Success criteria:** A defensible timeline and decision record exist.

## Scenario 10 — Assessment evidence package

Select 3–5 controls and prepare:
- Implementation description.
- Responsible role.
- Evidence list.
- Assessment method.
- Result and rationale.
- Identified weakness.
- Corrective action.

**Success criteria:** Another learner can reproduce the test and understand why the result was assigned.

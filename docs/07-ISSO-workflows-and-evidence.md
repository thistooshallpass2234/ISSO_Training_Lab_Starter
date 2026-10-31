# 07 — ISSO workflows and evidence

Use these workstreams to turn technical activity into ISSO deliverables. Templates are training aids, not official forms.

## 1. System boundary and inventory

Deliverables:
- System purpose and mission description (synthetic).
- Boundary diagram.
- Hardware/software inventory.
- External connection inventory.
- Data-flow diagram.
- Ports, protocols, and services list.
- Assumptions and dependencies.

Inventory fields:
`asset_id, hostname, function, owner_role, OS_version, IP, environment, criticality, data_type, interfaces, patch_level, last_verified`.

## 2. Account and access management

Deliverables:
- Account inventory.
- Role/group matrix.
- Privileged account register.
- Access review record.
- Joiner/mover/leaver test.
- Exceptions and remediation.

Review whether access is approved, role-appropriate, least-privileged, periodically reviewed, and removed when no longer required.

## 3. Configuration management

Deliverables:
- Approved baseline and version.
- Change request.
- Impact analysis.
- Test evidence.
- Approval record.
- Implementation record.
- Rollback plan.
- Post-change validation.

For each configuration change, record before/after state and the reason for the change.

## 4. Vulnerability management

Deliverables:
- Approved scan scope.
- Authenticated scan evidence where feasible.
- Finding validation.
- Risk prioritization.
- Remediation ticket.
- Retest result.
- Exception/risk acceptance draft for authorized review.

Do not equate scanner severity with final mission risk. Document asset criticality, exploitability, exposure, compensating controls, and operational impact.

## 5. Continuous monitoring

Deliverables:
- Monitoring strategy.
- Log source inventory.
- Alert triage record.
- Detection coverage matrix.
- Monitoring gaps.
- Metrics and reporting cadence.

Track whether critical assets report, clocks are synchronized, events are retained, alerts are actionable, and monitoring gaps have owners.

## 6. Incident response

Use a synthetic scenario and document:
- Detection source and time.
- Initial triage.
- Affected assets.
- Scope and impact.
- Evidence preservation.
- Containment decision and approval.
- Eradication/recovery.
- Lessons learned.
- Follow-up POA&M item.

Never perform destructive malware or ransomware exercises on the host or a bridged network. Use harmless simulated events and isolated snapshots.

## 7. RMF and assessment practice

Study the current NIST Risk Management Framework and applicable NIST SP 800-53 control catalog. For DoD-specific work, use current authorized DoD policy and the applicable system baseline supplied by the responsible organization.

Practice mapping:
- Control objective
- Implementation statement
- Responsible role
- Evidence artifact
- Assessment procedure
- Result
- Finding/weakness
- Corrective action

Do not assert that this home lab is RMF-authorized, ATO-ready, or DoD compliant. The purpose is to learn the process and evidence discipline.

## 8. POA&M tracking

Suggested fields:
`poam_id, weakness, affected_asset, control_reference, severity, risk_statement, corrective_action, owner_role, target_date, status, milestone, evidence_link, retest_result`.

Use synthetic identifiers and no real government system identifiers.

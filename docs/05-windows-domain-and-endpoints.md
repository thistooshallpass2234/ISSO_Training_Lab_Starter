# 05 — Windows domain and endpoint simulation

## Purpose

Use a Windows Server evaluation VM to practice identity, access control, Group Policy, Windows event collection, account reviews, and Windows security baseline assessment.

## VM setup

- Name: `DC01`
- vCPU: 2–4
- RAM: 6 GB
- Disk: 80–100 GB
- NIC: VMnet2 Host-only
- IP: `10.10.10.20/24`
- Gateway: `10.10.10.1`
- DNS: initially self after AD DS/DNS installation; before promotion use OPNsense DNS as appropriate.

Use a synthetic domain: `lab.example.test`. Never use a real employer or government domain.

## Build the domain

1. Install Windows Server Evaluation from Microsoft's official source.
2. Patch the VM.
3. Set hostname `DC01`.
4. Assign the static IP.
5. Add the Active Directory Domain Services and DNS Server roles.
6. Promote the server to a new forest named `lab.example.test`.
7. Reboot and verify DNS and domain health.
8. Create OUs for `Lab Users`, `Lab Workstations`, `Lab Servers`, and `Privileged Accounts`.
9. Create synthetic user accounts and role-based security groups.
10. Create a separate admin account; do not use Domain Admin for daily work.

Example synthetic roles:
- `GG-Lab-Analysts`
- `GG-Lab-ISSO`
- `GG-Lab-Server-Admins`
- `GG-Lab-ReadOnly-Auditors`

## Group Policy exercises

Create and document policies for:
- Password and account lockout settings (use a lab-safe policy and understand domain policy precedence).
- Windows Defender Firewall.
- Audit Process Creation (include command-line logging only with an explicit lab purpose).
- Logon/logoff and account management auditing.
- PowerShell logging.
- Screen lock and interactive logon.
- Local administrator restrictions.
- Removable storage policy.

Do not copy settings blindly from an unrelated STIG. Identify the Windows Server release and applicable benchmark first.

## Add a Windows client

Create a Windows 11 evaluation/test VM if licensing permits. Use 4–6 GB RAM and join it to `lab.example.test`. Generate synthetic user activity and Windows events. Keep it powered off when not in use to conserve memory.

## Access review exercise

Export a list of enabled users, group membership, last logon information, and privileged group members. Review:
- Is the account owner/role documented?
- Is access justified by job function?
- Is privileged access separately controlled?
- Are stale, disabled, or orphaned accounts identified?
- Is approval evidence recorded?
- Is remediation tracked?

Never use real personnel data in the lab.

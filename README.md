# ISSO Training Lab

A reproducible, **unclassified, synthetic** enterprise-style cybersecurity lab for practicing Information System Security Officer (ISSO) responsibilities: system inventory, boundary protection, access control, secure configuration, vulnerability management, continuous monitoring, incident response, and assessment evidence.

> **Safety and scope:** This is a personal training environment. Do not connect it to classified systems, production DoD networks, government enclaves, or real mission systems. Do not place classified, CUI, export-controlled, PII, credentials, or proprietary data in this repository or lab. Use synthetic data only. This project does not make a system authorized to operate or establish compliance with any DoD requirement.

## Project goals

- Run a small number of full VMs for operating-system and directory-service realism.
- Use Docker Compose for lightweight, repeatable application and infrastructure services.
- Keep the lab isolated behind a virtual firewall.
- Practice evidence-driven ISSO workflows and maintain artifacts in Git.
- Scale gradually to protect the laptop's 32 GB RAM and 8 GB GPU memory.

## Architecture at a glance

```text
                         Host Windows 11
                               |
                 VMware virtual network switch
                               |
             +-----------------+------------------+
             |                                    |
        OPNsense VM                         Ubuntu Server VM
      (virtual firewall)                    (Docker host)
       WAN: VMware NAT                         LAN: lab LAN
       LAN: host-only                              |
             |                             Docker Compose lab
        LAB-LAN segment                 +-----------+-----------+
             |                          |           |           |
       Windows Server VM              Web       App test     DB
       Kali VM (on demand)           Nginx       Juice Shop  PostgreSQL
       SIFT VM (on demand)                       synthetic
```

The starter Compose stack uses Docker bridge networks for an isolated application sandbox. **Docker bridge networks do not automatically traverse OPNsense.** For a true routed multi-zone lab, use the VLAN/bridge expansion in `docs/network-segmentation.md`.

## Suggested host resources

| Component | vCPU | RAM | Notes |
|---|---:|---:|---|
| OPNsense | 2 | 2 GB | Firewall/router; 2 virtual NICs |
| Ubuntu Server Docker host | 4 | 6–8 GB | Start with 6 GB; increase for heavier tools |
| Windows Server evaluation VM | 2–4 | 6 GB | AD DS, DNS, Group Policy, Windows event logs |
| Kali VM | 2–4 | 4 GB | Run when needed |
| SIFT VM | 2–4 | 4–6 GB | Run instead of Kali when doing forensics |
| Windows 11 host | — | Reserve 6–8 GB | Close unnecessary applications |

Do not run every VM and every heavy security platform simultaneously. Wazuh, Greenbone, Security Onion, and packet-analysis stacks can consume substantial memory and storage. The RTX 5070 is not required for this lab's network services.

## Repository map

```text
isso-training-lab/
├── README.md
├── LICENSE
├── .gitignore
├── .env.example
├── compose/
│   ├── docker-compose.yml
│   └── nginx/
│       └── default.conf
├── docs/
│   ├── 01-prerequisites-and-host-prep.md
│   ├── 02-build-the-virtual-network.md
│   ├── 03-install-ubuntu-docker-host.md
│   ├── 04-deploy-container-lab.md
│   ├── 05-windows-domain-and-endpoints.md
│   ├── 06-security-monitoring.md
│   ├── 07-ISSO-workflows-and-evidence.md
│   ├── 08-training-scenarios.md
│   ├── network-segmentation.md
│   └── troubleshooting.md
├── evidence/
│   └── README.md
└── scripts/
    ├── lab-status.sh
    └── collect-host-inventory.sh
```

## Quick start

1. Read `docs/01-prerequisites-and-host-prep.md`.
2. Create the isolated VMware networks and firewall VM using `docs/02-build-the-virtual-network.md`.
3. Install Ubuntu Server and Docker using `docs/03-install-ubuntu-docker-host.md`.
4. Copy `.env.example` to `.env`, review every value, then deploy:
   ```bash
   cd compose
   cp ../.env.example .env
   docker compose config
   docker compose up -d
   docker compose ps
   ```
5. Browse to `http://127.0.0.1:8080` **from the Ubuntu Docker host** or use an SSH tunnel from the host workstation.
6. Follow the workstreams and scenarios in `docs/07-ISSO-workflows-and-evidence.md` and `docs/08-training-scenarios.md`.

## Core technologies

- Hypervisor: VMware Workstation (or another type-2 hypervisor)
- Firewall: OPNsense
- Container runtime: Docker Engine + Docker Compose plugin
- Operating systems: Ubuntu Server, Windows Server evaluation, Kali Linux, SIFT
- Monitoring: Wazuh, Zeek, Suricata (separate optional deployment phases)
- Compliance: OpenSCAP and SCAP Security Guide where supported
- Vulnerability management: Greenbone Community Edition (optional; resource-intensive)
- Documentation: Markdown, Git, GitHub

Use current vendor installation documentation for supported versions. Pin versions for repeatability after validating them; avoid blindly using `latest` for long-lived assessment evidence.

## Important implementation notes

- The starter Compose file publishes the demo web services only on loopback (`127.0.0.1`). Keep that restriction unless you deliberately change the network design.
- The intentionally vulnerable OWASP Juice Shop container is for local lab use only. Never expose it to the public internet or a production LAN.
- Do not use `privileged: true` as a convenience. Packet sensors may need narrowly scoped capabilities or host networking; document and understand each permission.
- Store secrets in local `.env` files, never commit them. `.env` is ignored by Git.
- Record the exact image tag, date, configuration, and test results for every assessment. A scan result alone is not proof of compliance.
- A STIG checklist, SCAP result, or vendor hardening guide must be matched to the exact product/version and applicable baseline. Do not claim compliance from a generic scan.

## Suggested learning progression

| Phase | Outcome |
|---|---|
| 1. Build | Isolated virtual network and Docker host |
| 2. Inventory | System boundary, asset register, data-flow diagram |
| 3. Identity | AD users/groups, least privilege, access review |
| 4. Baselines | Linux and Windows hardening evidence |
| 5. Monitoring | Centralized events, alerts, network telemetry |
| 6. Vulnerability mgmt | Authenticated scans, findings, remediation |
| 7. Incident response | Triage, timeline, containment, lessons learned |
| 8. RMF practice | Draft SSP sections, control evidence, POA&M |
| 9. Assessment | Repeatable assessment package and executive summary |

## Disclaimer

This repository is an educational lab template, not an official DoD, USMC, F-35, PMA, or government-approved configuration. Publicly available guidance changes. Always verify current policy, applicable STIGs, control baselines, and authorization requirements with the responsible security authority.

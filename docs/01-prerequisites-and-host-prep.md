# 01 — Prerequisites and host preparation

## Hardware baseline

This plan targets the Lenovo Legion 7 with Core Ultra 9 275HX, RTX 5070 Laptop GPU, 32 GB DDR5, and NVMe storage. The GPU is not central to the network lab. RAM and SSD capacity are the constraints.

Recommended improvements when practical:
- 64 GB RAM (2 × 32 GB) for running Windows Server, Ubuntu, firewall, and analysis VMs together.
- A second 2–4 TB NVMe drive for VM disks, packet captures, and evidence.
- Keep at least 20% of the VM storage volume free.

Do not assume every listed VM can run at once with 32 GB RAM. Use Kali or SIFT as an on-demand analysis VM. Start with 2–3 VMs.

## Software

Install:
1. VMware Workstation (or an equivalent hypervisor).
2. Ubuntu Server LTS ISO.
3. Windows Server Evaluation ISO from Microsoft's official evaluation center.
4. Kali Linux prebuilt VMware image or official installer.
5. SIFT Workstation from its official distribution channel, if desired.
6. OPNsense ISO.

Download only from official project/vendor sites. Verify checksums where published. Record ISO version, download date, and SHA-256 in `evidence/software-manifest.md`.

## Host preparation

1. Update Windows 11 and the hypervisor.
2. Confirm virtualization is enabled in firmware.
3. Ensure the laptop is on AC power during long deployments.
4. Configure VMware VM storage on the fastest available NVMe volume.
5. Create a dedicated folder for the lab, e.g. `D:\\VMs\\ISSO-Lab`.
6. Disable shared folders and drag/drop for sensitive analysis VMs unless specifically needed.
7. Take clean snapshots before major changes.
8. Keep the lab disconnected from corporate, government, and home production networks where practical.

## Resource plan for 32 GB RAM

| VM | vCPU | RAM | Disk |
|---|---:|---:|---:|
| OPNsense | 2 | 2 GB | 20 GB |
| Ubuntu Docker host | 4 | 6 GB | 100–150 GB thin |
| Windows Server | 2–4 | 6 GB | 80–100 GB |
| Kali | 2–4 | 4 GB | 60 GB |
| SIFT | 2–4 | 4–6 GB | 80 GB |

Run OPNsense + Ubuntu + Windows Server first. Shut down Kali/SIFT when memory pressure is high. Leave memory for Windows host, hypervisor overhead, and file cache.

## Naming convention

Use a consistent scheme:
- `FW01` — OPNsense firewall
- `LNX-DKR01` — Ubuntu Docker host
- `DC01` — Windows Server domain controller
- `KALI01` — Kali analysis workstation
- `SIFT01` — forensic workstation
- `WEB01` / `DB01` — containerized logical service names

Use a synthetic domain such as `lab.example.test`. Do not use a real organization domain.

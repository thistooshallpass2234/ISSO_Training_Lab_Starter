# 03 — Install Ubuntu Server and Docker

## Install Ubuntu Server

1. Create VM `LNX-DKR01` with 4 vCPU, 6 GB RAM, and 100–150 GB thin-provisioned disk.
2. Attach one NIC to VMnet2 Host-only.
3. Install Ubuntu Server LTS with OpenSSH Server selected.
4. Create a non-root administrator account.
5. Set hostname to `lnx-dkr01`.
6. Configure static IPv4 `10.10.10.10/24`, gateway `10.10.10.1`, and DNS `10.10.10.1`.
7. Update packages:
   ```bash
   sudo apt update
   sudo apt full-upgrade -y
   sudo reboot
   ```
8. Confirm:
   ```bash
   hostnamectl
   ip -br addr
   ip route
   ```

## Install Docker Engine

Use Docker's official Ubuntu installation instructions for the current supported repository and package names. The standard package set is Docker Engine, CLI, containerd, Buildx plugin, and Compose plugin.

After installation:
```bash
sudo systemctl enable --now docker
sudo docker version
sudo docker compose version
sudo docker run --rm hello-world
```

Optional convenience:
```bash
sudo usermod -aG docker "$USER"
```
Log out and back in before using Docker without `sudo`. **Membership in the `docker` group is effectively root-level access** on the host. For a security training system, understand this privilege and consider using `sudo docker` instead.

## Host firewall and administration

- Permit SSH only from the management workstation/subnet.
- Do not expose Docker's remote API on TCP 2375/2376 without a properly secured design.
- Do not disable Ubuntu's host firewall to make containers work.
- Record enabled services and listening ports:
  ```bash
  sudo ss -tulpn
  sudo systemctl --type=service --state=running
  ```
- Apply Ubuntu security updates and document the baseline.

## Snapshot

Shut down the VM and take a hypervisor snapshot named `ubuntu-docker-clean-install`. This is your known-good rollback point.

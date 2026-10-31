# 04 — Deploy the container lab

## Prepare project directory

On Ubuntu:
```bash
sudo apt install -y git
mkdir -p ~/isso-training-lab
cd ~/isso-training-lab
```

Clone your GitHub repository after creating it, or copy this repository folder to the VM. Keep the local `.env` file out of Git.

## Configure environment

```bash
cd compose
cp ../.env.example .env
nano .env
```

Change `POSTGRES_PASSWORD` to a unique lab-only value. Do not reuse personal, work, or production passwords.

Validate Compose:
```bash
docker compose config
```

Deploy:
```bash
docker compose pull
docker compose up -d
docker compose ps
```

Expected services:
- `isso-nginx`
- `isso-juice-shop`
- `isso-postgres`

Check logs:
```bash
docker compose logs --tail=100
docker compose logs -f reverse-proxy
```

## Access the training web application

The proxy binds to `127.0.0.1:8080` on the Ubuntu VM only. From the Ubuntu console, open:
`http://127.0.0.1:8080`

To access it from your Windows host without publishing it on the lab LAN, create an SSH local tunnel from Windows:
```powershell
ssh -L 8080:127.0.0.1:8080 <ubuntu-user>@10.10.10.10
```
Then browse on Windows to `http://127.0.0.1:8080`.

If SSH is not available, use the Ubuntu VM browser or temporarily use a management-only firewall rule and a deliberate bind address. Revert that rule after testing.

## Validate network exposure

On Ubuntu:
```bash
sudo ss -tulpn
docker network ls
docker network inspect isso-lab_frontend
docker network inspect isso-lab_backend
```

Expected:
- Nginx host port is bound to loopback only.
- Juice Shop has no host-published port.
- PostgreSQL has no host-published port.
- The frontend and backend Docker networks are marked internal.
- PostgreSQL is attached only to backend.
- Juice Shop is attached only to frontend in this starter design.

Note: This is a demonstration application topology, not a fully integrated production-like three-tier application. Add application-to-database connectivity only when you intentionally build and document that integration.

## Lifecycle commands

```bash
docker compose stop
docker compose start
docker compose down
docker compose down -v  # DESTRUCTIVE: removes persistent database volume
docker compose pull
docker compose up -d
```

Do not run `down -v` unless you intend to erase the lab database.

## Record deployment evidence

Capture:
- Docker Engine and Compose versions.
- Container image names and immutable digests (`docker image inspect`).
- `docker compose ps` output.
- Network inspection output.
- Host listening-port inventory.
- A screenshot of the local training landing page.
- Date/time and configuration revision.

Remove secrets, tokens, hostnames, and any personal information before committing evidence.

#!/usr/bin/env bash
set -euo pipefail
echo "=== Host ==="
hostnamectl 2>/dev/null | sed -n '1,8p' || hostname
echo
echo "=== Addresses ==="
ip -br addr
echo
echo "=== Routes ==="
ip route
echo
echo "=== Docker ==="
docker version --format 'Engine: {{.Server.Version}}' 2>/dev/null || true
docker compose version 2>/dev/null || true
docker compose -f "$(dirname "$0")/../compose/docker-compose.yml" ps 2>/dev/null || true
echo
echo "=== Listening sockets ==="
sudo ss -tulpn

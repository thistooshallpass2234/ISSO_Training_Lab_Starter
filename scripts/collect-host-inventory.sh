#!/usr/bin/env bash
# Creates a local host inventory snapshot. Review and sanitize before sharing.
set -euo pipefail
OUT="${1:-host-inventory-$(date -u +%Y%m%dT%H%M%SZ).txt}"
{
  echo "Collected UTC: $(date -u --iso-8601=seconds)"
  echo "Hostname: $(hostname)"
  echo
  echo "OS:"
  cat /etc/os-release
  echo
  echo "Kernel:"
  uname -a
  echo
  echo "CPU:"
  lscpu | sed -n '1,25p'
  echo
  echo "Memory:"
  free -h
  echo
  echo "Disk:"
  lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT
  echo
  echo "Interfaces:"
  ip -br addr
  echo
  echo "Routes:"
  ip route
  echo
  echo "Listening sockets:"
  sudo ss -tulpn
  echo
  echo "Docker containers:"
  docker ps --no-trunc 2>/dev/null || true
  echo
  echo "Docker images:"
  docker images --digests 2>/dev/null || true
} > "$OUT"
chmod 600 "$OUT"
echo "Wrote $OUT. Review for sensitive details before sharing."

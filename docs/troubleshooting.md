# Troubleshooting

## `docker compose config` reports missing environment variable

Confirm you copied `.env.example` to `compose/.env` and set `POSTGRES_PASSWORD`. Do not commit the populated file.

## Container cannot resolve another service

Confirm both containers share a Docker network:
```bash
docker network ls
docker inspect isso-nginx
docker inspect isso-juice-shop
```
Use the Compose service name for DNS resolution, not a hard-coded container IP.

## Web service is not reachable

Check:
```bash
docker compose ps
docker compose logs --tail=100 reverse-proxy
sudo ss -tulpn | grep 8080
curl -i http://127.0.0.1:8080/health
```
Remember the port is bound to Ubuntu loopback. Use an SSH tunnel from the host.

## VM cannot reach OPNsense

Check VMnet2 attachment, OPNsense LAN interface, guest IP/mask, gateway, and duplicate DHCP servers. Verify interface assignment by MAC address.

## VM has no internet

Check OPNsense WAN is attached to VMware NAT, WAN has an address, outbound NAT is enabled as appropriate, DNS works, and firewall rules allow the required outbound traffic. Do not solve this by bridging the lab to the home LAN.

## Host is running out of memory

Shut down SIFT/Kali when unused, stop optional containers, reduce concurrent services, and monitor:
```bash
free -h
docker stats
```
Consider 64 GB RAM before adding multiple heavy monitoring platforms.

## Container image tag changed

Record the image digest and tested tag. Update one component at a time, test, and preserve a rollback plan. Avoid updating all lab components immediately before an evidence exercise.

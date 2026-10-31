# 02 — Build the virtual network

## Target topology (starter)

Use two VMware virtual networks:
- **VMnet8 NAT:** OPNsense WAN interface. Provides outbound updates through the host NAT.
- **VMnet2 Host-only:** Isolated lab LAN. No direct connection to the physical LAN.

Example addressing:
- OPNsense LAN: `10.10.10.1/24`
- Ubuntu Docker host: `10.10.10.10/24`, gateway `10.10.10.1`
- Windows Server: `10.10.10.20/24`, gateway `10.10.10.1`
- Kali: DHCP reservation or `10.10.10.30/24`
- DNS initially: OPNsense `10.10.10.1`; later use Windows DNS if promoting DC01.

Reserve addresses and record them in `evidence/asset-register.csv`.

## Create the isolated host-only network

1. Open VMware Virtual Network Editor with administrative privileges.
2. Add a host-only network, for example VMnet2.
3. Set subnet `10.10.10.0`, mask `255.255.255.0`.
4. Disable VMware DHCP on VMnet2 if OPNsense will provide DHCP. Avoid two DHCP servers on the same segment.
5. Ensure VMnet2 is not bridged to a physical adapter.
6. Do not enable host-to-guest routing beyond what is needed for management.

VMware UI labels vary by release. Verify the resulting adapter and subnet before continuing.

## Create OPNsense VM

1. Create a new VM with 2 vCPU, 2 GB RAM, and 20 GB disk.
2. Attach the OPNsense ISO.
3. Add two virtual network adapters:
   - Adapter 1: VMnet8 NAT (WAN)
   - Adapter 2: VMnet2 Host-only (LAN)
4. Install OPNsense using the console installer.
5. Assign interfaces by MAC address; confirm which is WAN and LAN.
6. Set LAN IPv4 to `10.10.10.1/24`.
7. From a lab guest, browse to `https://10.10.10.1`.
8. Change default credentials immediately.
9. Update OPNsense using its supported update workflow.
10. Configure DHCP only if desired; choose a pool such as `10.10.10.100–10.10.10.180`.

## Firewall baseline

Start with default-deny inbound behavior. Add only the minimum rules needed:
- Allow lab clients to query the chosen DNS service.
- Allow lab clients outbound web access for OS/package updates if needed.
- Allow administration to the firewall GUI only from a designated management host.
- Block unsolicited WAN-to-LAN traffic.
- Do not create port forwards from the WAN interface.
- Do not expose Juice Shop or management interfaces to the internet.

Document each rule with purpose, source, destination, protocol/port, owner, and test evidence. Avoid broad `any-any` rules.

## Validate isolation

From Ubuntu:
```bash
ip -br addr
ip route
ping -c 3 10.10.10.1
```

Confirm:
- Ubuntu can reach OPNsense LAN.
- Ubuntu receives only the intended DNS/gateway configuration.
- A device on the physical home LAN cannot browse to Ubuntu's lab services.
- No WAN port-forward exists.
- The lab can be shut down without affecting the home network.

If your host-only network still provides internet via OPNsense NAT, that is expected. It remains logically isolated from unsolicited inbound connections, but it is not physically air-gapped.

## Important: Docker network boundaries

The Compose starter creates internal Docker bridge networks on the Ubuntu host. Those networks are not separate OPNsense interfaces and do not automatically appear as separate routed subnets. Use `docs/network-segmentation.md` before claiming the web, database, management, and monitoring zones are independently firewalled.

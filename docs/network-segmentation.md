# Network segmentation — expansion guide

## Why expand beyond the starter LAN?

The starter design gives you an isolated lab LAN plus internal Docker networks. It is useful for learning but does not provide a true enterprise routed boundary between user, server, management, and security-monitoring zones.

## Target multi-zone plan

| Zone | VLAN | Example subnet | Purpose |
|---|---:|---|---|
| Management | 10 | 10.10.10.0/24 | Hypervisor/lab administration |
| User | 20 | 10.10.20.0/24 | Synthetic endpoints |
| Server | 30 | 10.10.30.0/24 | Domain/app/file services |
| Security | 40 | 10.10.40.0/24 | SIEM, log collection, sensors |
| Testing | 50 | 10.10.50.0/24 | Kali and approved scanners |
| Sandbox | 60 | 10.10.60.0/24 | Deliberately vulnerable targets |

Gateway convention: `.1` on each subnet.

## Implementation choices

Choose one approach and document it:

### Option A — VLAN trunk to OPNsense

1. Create VLAN-capable virtual switches/port groups in the hypervisor.
2. Present a trunk-capable virtual NIC to OPNsense.
3. Create VLAN interfaces in OPNsense.
4. Assign each VLAN an interface and gateway.
5. Create DHCP scopes if needed.
6. Create explicit inter-zone rules.
7. Attach guest VMs to the correct virtual port group/VLAN.

Hypervisor VLAN support and virtual switch configuration vary. Verify that the selected VMware Workstation version supports the intended design before relying on VLAN trunking.

### Option B — Separate virtual NICs and isolated virtual networks

Create one host-only virtual network per zone and attach a separate OPNsense interface to each. This is easier to reason about in some desktop hypervisors but consumes virtual NICs and can be cumbersome.

### Option C — Dedicated Linux bridges / VLAN-aware Docker host

Use a Linux Docker host with VLAN-aware networking only after understanding Linux bridges, 802.1Q, macvlan/ipvlan, routing, and host reachability limitations. Do not assume a Docker bridge is a VLAN or that Docker Compose creates firewall-enforced security zones.

## Example policy matrix

| Source | Destination | Default |
|---|---|---|
| Management | Firewall/admin interfaces | Allow only required admin ports |
| User | Server | Allow documented business services only |
| User | Security | Allow required log/agent traffic only |
| Testing | Sandbox | Allow approved assessment traffic |
| Testing | Management | Deny |
| Sandbox | User/Management | Deny |
| Server | Internet | Deny by default; temporary update exceptions |
| WAN | Any lab zone | Deny unsolicited inbound |

This is a training starting point, not a universal policy. Add only required flows and record the justification.

## Validation

For every zone:
- Confirm the expected IP, gateway, and DNS.
- Test permitted traffic.
- Test denied traffic.
- Review OPNsense firewall logs.
- Capture a packet trace when needed.
- Record source/destination/port and expected result.
- Verify no route or bridge bypasses the firewall.

Do not claim segmentation is effective until both allowed and denied paths have been tested.

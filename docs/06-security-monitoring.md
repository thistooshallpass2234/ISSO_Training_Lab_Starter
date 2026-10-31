# 06 — Security monitoring: staged deployment

Do not install every monitoring product at once. Deploy one platform, validate it, capture evidence, then add the next. Heavy platforms may exceed the 32 GB laptop's comfortable capacity.

## Stage A: Host and container visibility

Start with:
```bash
docker stats
docker ps --no-trunc
sudo journalctl -p warning --since today
sudo ss -tulpn
```

Enable Docker log rotation using the daemon's supported logging configuration. Avoid unbounded JSON log growth.

## Stage B: Wazuh

Use the official Wazuh documentation and the official Wazuh Docker deployment repository for the currently supported version. Follow the documented single-node lab deployment, certificate generation, host prerequisites, and version-matched Compose files.

Suggested roles:
- Wazuh manager: alert analysis and rules.
- Wazuh indexer: event storage/search.
- Wazuh dashboard: analyst interface.
- Agents: Ubuntu and Windows endpoints.

Do not invent or reuse default credentials. Store generated passwords and certificates locally, not in Git. Keep dashboard access limited to the lab management network. Record version, resource use, agent enrollment, and test alerts.

Exercises:
1. Enroll Ubuntu agent.
2. Enroll Windows endpoint agent.
3. Generate a benign failed-login event.
4. Confirm event receipt and timestamp.
5. Review rule ID, severity, source, and endpoint.
6. Create a case note and evidence reference.
7. Tune a false positive and document why.

## Stage C: Zeek

Deploy Zeek on a dedicated sensor interface or a controlled packet-capture source. Zeek needs visibility into traffic; a container attached to an ordinary Docker bridge does not automatically see all host or VM traffic.

Start with offline PCAP analysis:
- Obtain a public, benign training PCAP from a reputable source.
- Verify its source and license.
- Do not use captures containing personal or sensitive data.
- Run Zeek against the PCAP using its official installation and usage instructions.
- Preserve generated logs such as `conn.log`, `dns.log`, `http.log`, and `ssl.log`.
- Parse JSON logs with `jq` and Python.

Example JSON parsing:
```bash
jq -r '[.ts, .id.orig_h, .id.resp_h, .proto, .service, .duration] | @tsv' conn.log
```
Confirm the log format before using this query; Zeek TSV and JSON formats differ.

## Stage D: Suricata

Use Suricata's official installation guide. Start with offline PCAP inspection and a small, documented ruleset. Validate rules before relying on alerts. Record:
- Suricata version
- Rule source and revision
- Rule update date
- PCAP provenance
- Alert output
- Analyst disposition

## Stage E: Vulnerability scanning

Greenbone Community Edition is optional and resource-intensive. Follow the official deployment guide and allow initial feed synchronization to complete. Use it only against your isolated lab targets. Do not scan public IPs, home devices, employer networks, or government networks.

For each scan, record:
- Authorized target scope
- Scanner version/feed date
- Scan profile
- Credentials used (never commit them)
- Findings and severity
- Validation and false-positive disposition
- Remediation owner and due date

## Stage F: Linux compliance checks

Use OpenSCAP and the SCAP Security Guide content that matches the exact Ubuntu release and applicable profile. A generic profile is not automatically a DoD STIG.

Example discovery commands (package availability and profile names vary by release):
```bash
sudo apt update
apt-cache policy openscap-scanner ssg-base ssg-debderived
```
After installing supported packages, enumerate available content and profiles using the OpenSCAP tooling. Read the selected profile's applicability and rules before scanning. Save results outside the repository if they contain sensitive host details; commit only sanitized summaries.

## Evidence quality

An alert or scanner report is an input to analysis, not a conclusion. Record scope, method, tool version, date, result, validation, disposition, and reviewer.

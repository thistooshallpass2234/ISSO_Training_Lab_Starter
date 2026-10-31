# Evidence directory

Store only sanitized, synthetic, non-sensitive training evidence here.

Suggested structure:
```text
evidence/
├── asset-register.csv
├── software-manifest.md
├── diagrams/
├── baseline-assessments/
├── access-reviews/
├── vulnerability-assessments/
├── incident-reports/
├── change-records/
└── poam/
```

Do not commit:
- Classified, CUI, export-controlled, proprietary, or personal data.
- Real credentials, tokens, private keys, certificates, or password hashes.
- Raw endpoint logs, packet captures, memory images, or forensic artifacts unless reviewed and explicitly safe to publish.
- Screenshots showing personal accounts, public IPs, serial numbers, or unrelated host details.

Use a sanitized summary and a hash/reference for large evidence files. For private working evidence, use local storage outside the Git repository.

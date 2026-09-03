# Terradome — Secure AWS Landing Zone (Terraform)

![Terraform](https://img.shields.io/badge/Terraform-844FBA?logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?logo=amazonaws&logoColor=white)
![IaC](https://img.shields.io/badge/IaC-Infrastructure_as_Code-0FB39A)

A secure-by-default AWS landing zone built entirely with Terraform. It provisions a hardened baseline — network, identity, logging, and detection — following least-privilege and defense-in-depth principles.

> Built to demonstrate cloud security engineering: not just *provisioning* infrastructure, but making deliberate **security decisions** and encoding them as version-controlled infrastructure-as-code.

---

## What it provisions
<!-- Adjust to match what you actually build -->
- **Networking** — VPC with public/private subnets, least-privilege security groups, no default-open rules
- **Identity** — IAM roles/policies with least privilege (no wildcard `*` actions/resources)
- **Data** — S3 buckets with encryption at rest, public-access block, and versioning
- **Logging** — CloudTrail enabled across regions, logs to a dedicated, access-restricted bucket
- **Detection** — AWS Config rules and GuardDuty enabled for continuous monitoring

## Architecture
<!-- Paste an ASCII diagram or link an image (e.g. from diagrams.net) -->
```
<!-- diagram here: VPC → subnets → SGs; CloudTrail → S3; Config/GuardDuty -->
```

---

## Security decisions
The point of this project. Each choice below is deliberate — this is how I think about securing a cloud foundation.

| Area | Decision | Why |
|------|----------|-----|
| IAM | Least-privilege policies, no wildcards | Limits blast radius if a credential is compromised |
| S3 | Encryption + public-access block enforced | Prevents the #1 cloud data-leak cause (public buckets) |
| Logging | Centralized, access-restricted CloudTrail | Tamper-resistant audit trail for investigations |
| Network | Explicit security groups, deny-by-default | No implicit trust; every path is intentional |
| Detection | Config rules + GuardDuty on by default | Continuous compliance + threat detection from day one |
<!-- Add/replace rows to match your build. This table is what hiring managers read. -->

---

## How to run
**Prerequisites:** Terraform >= <!-- version -->, an AWS account, AWS CLI configured with least-privilege credentials.

```bash
git clone https://github.com/<your-username>/terradome.git
cd terradome
terraform init
terraform plan      # review every change before applying
terraform apply
```

**Tear down:** `terraform destroy`

> ⚠️ This provisions real AWS resources. Review `terraform plan` and check the free-tier / cost implications before applying.

---

## What I learned
<!-- 2-3 honest bullets: a real challenge you hit (e.g., remote state, an IAM policy you had to tighten, a Config rule that flagged something) and how you solved it. This section signals genuine hands-on work. -->
-
-

---

**Hansley Jean** — Cloud Security Engineer
AWS Certified Security – Specialty · Microsoft Certified: Azure Security Engineer (AZ-500)
[LinkedIn](https://linkedin.com/in/hansley-j-0522711b9) · [GitHub](https://github.com/<your-username>)

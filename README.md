# AWS Gateway Load Balancer Architecture with Terraform

This repository provisions a secure multi-VPC AWS infrastructure using Terraform. It includes the deployment of a Gateway Load Balancer (GWLB) to route traffic between two VPCs — an "AWS Course VPC" and a "Security VPC" — through a centralized inspection appliance (e.g., firewall or monitoring EC2).

---

## 📌 Architecture Overview

```
                ┌─────────────────────┐
                │    AWS Account      │
                └─────────────────────┘
                     │            │
                     ▼            ▼
          ┌────────────────┐  ┌────────────────┐
          │ AWS Course VPC │  │  Security VPC  │
          │   31.0.0.0/16  │  │   81.0.0.0/16  │
          └────────────────┘  └────────────────┘
            │         │              │
            ▼         ▼              ▼
      Public Sub   Private Sub   Appliance Sub
     (31.0.1.0/24) (31.0.2.0/24) (81.0.1.0/24)
          │           │              │
          ▼           ▼              ▼
        EC2         EC2        Security EC2 (e.g., Firewall)
          └────┬──────┘              ▲
               ▼                    │
          Gateway Load Balancer────┘
```

---

## 🔧 Components

### 1. VPC Setup (`/vpc`)
- **AWS Course VPC**: `31.0.0.0/16`
  - Public Subnet: `31.0.1.0/24` with Internet Gateway
  - Private Subnet: `31.0.2.0/24` routed through GWLB
- **Security VPC**: `81.0.0.0/16`
  - Private Subnet: `81.0.1.0/24` with appliance instance
  - Internet Gateway for outbound traffic

### 2. Compute Instances (`/ec2`)
- **Public EC2 Instance**: Deployed in public subnet of AWS Course VPC.
- **Private EC2 Instance**: Deployed in private subnet of AWS Course VPC.
- **Appliance EC2**: Deployed in the Security VPC, represents a monitoring/security appliance.

### 3. Gateway Load Balancer (`/gwlb`)
- Internal Gateway Load Balancer (type: `gateway`)
- Target group configured with GENEVE protocol (port 6081)
- Routes configured to direct traffic from Course VPC’s private subnet to appliance EC2.

---

## 🗂 Project Structure

```bash
aws-gwlb-terraform/
├── main.tf                # Root modules loading VPC, EC2, GWLB modules
├── variables.tf           # Global variables
├── outputs.tf             # Global outputs
├── providers.tf           # AWS Provider configuration
├── vpc/
│   ├── main.tf            # VPCs, Subnets, IGWs, and Route Tables
│   ├── variables.tf
│   ├── outputs.tf
├── ec2/
│   ├── main.tf            # EC2 instances in subnets
│   ├── variables.tf
│   ├── outputs.tf
├── gwlb/
│   ├── main.tf            # Gateway Load Balancer setup
│   ├── variables.tf
│   ├── outputs.tf
```

---

## ✅ Deployment Instructions

1. **Initialize Terraform**
```bash
terraform init
```

2. **Preview the execution plan**
```bash
terraform plan
```

3. **Apply the infrastructure**
```bash
terraform apply
```

---

## 🧠 Notes

- Ensure the AMI ID in EC2 modules is up-to-date for your region or use the AWS AMI data lookup.
- GWLB is designed to route traffic between VPCs for inspection or firewalling.
- Be sure to configure appropriate security groups for EC2 instances and GWLB target access.
- For production, use more granular IAM permissions and parameterized resources (e.g., SSM parameters).

---

## 👤 Author

**John Itopa ISAH**

---

## 📜 License

MIT License

# 🚀 Automated Linux Infrastructure Lab

A hands-on Infrastructure-as-Code lab that provisions an AWS EC2 Linux server with Terraform and configures an Apache web server with Ansible.

## 🏗️ Architecture Diagram

![Automated Linux Infrastructure Diagram](new%20linux_infra_architecture.png)

---

## 📌 Project Overview

This project demonstrates a practical infrastructure automation workflow using Terraform and Ansible.

Terraform defines and provisions the AWS EC2 instance and its security group. After the instance is available, Ansible connects to the server over SSH, installs Apache (httpd), and ensures the web service is started and enabled.

The repository is intentionally small and focused on the relationship between infrastructure provisioning, Linux administration, and configuration management.

---

## 🧠 Current Architecture

**Administrator → Terraform → AWS EC2 + Security Group → Ansible over SSH → Apache Web Server**

### What the code currently does

- **Terraform** uses the AWS provider in `us-east-1`.
- **Terraform** creates an AWS security group that permits inbound SSH on TCP port 22.
- **Terraform** creates a `t3.micro` EC2 instance using the configured AMI and key pair.
- **Ansible** connects to the EC2 host over SSH as `ec2-user`.
- **Ansible** installs the Apache `httpd` package.
- **Ansible** starts Apache and enables it to start automatically.
- **Git/GitHub** provide version control for the infrastructure and configuration-management code.

> **Note:** The current Terraform configuration does not create a custom VPC, subnet, Internet Gateway, route table, or GitHub Actions workflow.

---

## 🛠️ Technologies & Tools

| Category | Tools |
|---|---|
| Infrastructure as Code | Terraform |
| Configuration Management | Ansible |
| Cloud Provider | AWS EC2 |
| Operating System | Linux / Amazon Linux |
| Web Server | Apache HTTP Server (httpd) |
| Remote Administration | SSH |
| Version Control | Git & GitHub |

---

## ⚙️ Implemented Features

- AWS EC2 provisioning with Terraform
- Terraform-managed EC2 security group
- SSH key-based server access
- Ansible-based Linux configuration
- Automated Apache package installation
- Automated Apache service startup and enablement
- Terraform provider dependency lock file
- Git exclusions for private keys, Terraform working files, and local state
- Infrastructure teardown through Terraform

---

## 🔐 Security Notes

The repository excludes common sensitive/local infrastructure files through `.gitignore`, including:

```text
*.pem
.terraform/
terraform.tfstate
terraform.tfstate.backup
```

The current Terraform security group permits SSH on port 22 from `0.0.0.0/0`. This was used for the lab and is intentionally documented as a limitation rather than a production security configuration.

For a production-style deployment, SSH should be restricted to a trusted IP/CIDR range or replaced with a more controlled administrative access method.

The SSH private key itself is not stored in this repository.

---

## 📂 Project Structure

```text
linux-infra-lab/
├── .gitignore
├── LICENSE
├── README.md
├── linux_infra_architecture.png
├── ansible/
│   ├── inventory
│   ├── inventory.txt
│   └── webserver.yml
└── terraform/
    ├── .terraform.lock.hcl
    └── ec2.tf
```

> The two inventory files reflect lab connection information and different private-key path formats used during the project.

---

## 🚀 Deployment Workflow

### 1. Provision the AWS Infrastructure

From the Terraform directory:

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

The current Terraform configuration creates:

- An EC2 security group
- A `t3.micro` EC2 instance associated with that security group

The configuration expects an existing AWS key pair named `linux-lab-key`.

---

### 2. Configure the Linux Server with Ansible

After the EC2 instance is running, update the Ansible inventory with the current EC2 public IP and the correct path to the SSH private key.

Then run:

```bash
cd ansible
ansible-playbook -i inventory webserver.yml
```

The playbook:

1. Connects to the host in the `web` inventory group.
2. Uses privilege escalation with `become: yes`.
3. Installs the `httpd` package.
4. Starts the `httpd` service.
5. Enables `httpd` to start automatically.

---

### 3. Validate the Server Configuration

Confirm that the Ansible playbook completes successfully and that Apache is running on the EC2 instance.

> **Current limitation:** The Terraform security group in this repository does not define an inbound HTTP/80 rule. Public browser access to Apache therefore requires an appropriate HTTP rule to be added separately.

---

### 4. Destroy the Infrastructure

When the lab is complete:

```bash
cd terraform
terraform destroy
```

This removes the Terraform-managed EC2 instance and security group.

---

## 📜 Terraform Configuration

The Terraform configuration defines the AWS provider, security group, and EC2 instance in `terraform/ec2.tf`.

Key implementation details include:

- AWS region: `us-east-1`
- Instance type: `t3.micro`
- Existing key pair: `linux-lab-key`
- Inbound SSH: TCP/22
- Outbound traffic: allowed
- EC2 tag: `Name = "LinuxLabServer"`

---

## 📜 Ansible Configuration

The Ansible playbook in `ansible/webserver.yml` targets the `web` host group and uses privilege escalation to configure Apache.

It performs two configuration tasks:

- Ensures `httpd` is installed.
- Ensures `httpd` is started and enabled.

This demonstrates repeatable Linux configuration using Ansible rather than manually installing and starting the service on the server.

---

## 🎯 Key Learning Outcomes

- Practiced Infrastructure as Code with Terraform
- Provisioned AWS EC2 infrastructure from declarative configuration
- Managed basic AWS network access through a Terraform security group
- Used SSH key-based authentication for Linux administration
- Applied Ansible configuration management to an AWS-hosted Linux server
- Automated Apache installation and service management
- Used Git and GitHub to version infrastructure and configuration code
- Practiced infrastructure lifecycle management, including teardown

---

## 📄 Resume-Ready Bullet Points

- Provisioned AWS EC2 infrastructure using Terraform and Infrastructure-as-Code practices.
- Automated Linux web-server configuration with Ansible, including Apache installation and service management.
- Configured SSH key-based administrative access and Terraform-managed security-group rules.
- Version-controlled Terraform and Ansible configuration in GitHub while excluding private keys and local Terraform state.

---

## 🔮 Future Enhancements

Potential extensions to the current lab include:

- Restrict SSH access to a trusted IP/CIDR range
- Add Terraform-managed HTTP/HTTPS security-group rules
- Replace hard-coded values with Terraform variables
- Add Terraform outputs for instance connection information
- Build a custom VPC, subnet, Internet Gateway, and route table
- Add HTTPS
- Introduce reusable Terraform modules
- Add remote Terraform state
- Add monitoring and logging
- Add GitHub Actions only if CI/CD automation is intentionally implemented

---

## ✅ Conclusion

This project demonstrates a focused infrastructure automation workflow: Terraform provisions an AWS EC2 Linux server and its security group, and Ansible performs repeatable server configuration by installing and managing Apache.

The repository documents the infrastructure that is currently implemented while leaving more advanced networking, security, observability, and CI/CD capabilities as future enhancements.

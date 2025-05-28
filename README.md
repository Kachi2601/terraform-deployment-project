
# 🚀 Automated AWS EC2 Deployment with Terraform, GitHub Actions & Docker

This project simulates a real-world DevOps/Cloud Engineer workflow by deploying a Dockerized web portfolio application on **Amazon EC2**, with infrastructure provisioned using **Terraform** and automated through **GitHub Actions**. The project demonstrates principles of Infrastructure as Code (IaC), secure automation, and modular architecture in the AWS ecosystem.

---

## 🧠 Project Overview

The goal was to automatically run a pre-built Docker image (a web portfolio site) on an EC2 instance. All infrastructure resources — EC2, IAM, Security Groups — were provisioned via **Terraform**, while **GitHub Actions** was used to automate the Terraform lifecycle on manual trigger.

This setup reflects a typical DevOps practice: building cloud infrastructure declaratively, handling secrets securely, and attempting full automation.

---

## 🛠️ Tech Stack

* **Terraform** – to provision AWS resources like EC2, IAM, and Security Groups
* **GitHub Actions** – to automate Terraform execution through a CI/CD pipeline
* **Docker** – to containerize the portfolio application
* **Amazon EC2** – to host the Docker container
* **Amazon IAM** – to manage resource-specific access securely
* **GitHub Secrets** – to securely store AWS CLI and Docker Hub credentials

---

## ✅ What I Implemented

* Created a **modular Terraform setup** to provision:

  * EC2 instance
  * IAM role (limited to EC2 and CloudWatch for security)
  * Security group allowing traffic on port 80
* Configured **user data scripts** to install Docker and pull the portfolio image from Docker Hub
* Developed a **manual-trigger GitHub Actions workflow** to:

  * Authenticate with AWS (via GitHub Secrets)
  * Pull from Docker Hub (via GitHub Secrets)
  * Run `terraform init`, `plan`, and `apply`
* Connected EC2 to Docker Hub to pull and serve the web portfolio

---

## ⚠️ Challenges Faced

* **EC2 connectivity with Docker:**
  While the EC2 instance was being created successfully, the Docker container was not running as expected. The image itself was verified and functional, but due to automation, the EC2 setup wasn’t picking up the container correctly.

* **Security group misconfiguration:**
  Initially, ingress/egress rules on port 80 were not allowing traffic to reach the container, blocking access to the web app.

* **IAM principle of least privilege:**
  I applied best practices by limiting the IAM role to only **EC2 and CloudWatch** access. While CloudWatch was not yet used, the permissions were pre-scoped for future monitoring additions.

* **Region-based latency concerns:**
  Being in a different AWS region than my location possibly introduced delays or contributed to unexpected provisioning behavior.

---

## 🎯 Outcome

✅ **Terraform** successfully created all infrastructure components
✅ **GitHub Actions workflow** authenticated securely and executed the Terraform pipeline
✅ **Secrets** were stored and used securely within GitHub
✅ The **project structure is reusable and modular**

❌ **Docker container did not launch automatically on EC2** (due to automation issue)
🔧 I chose **not to manually run it** on EC2 to preserve the automated nature of the project
🎓 Still, the experience was a strong **learning win** for DevOps tooling, workflow design, and cloud security practices

---

## 🧱 Architecture Diagram
                    +-----------------------+
                    |     GitHub Repo       |
                    +-----------------------+
                              |
                              v
                  +--------------------------+
                  |  GitHub Actions Workflow |
                  | (manual trigger only)    |
                  +--------------------------+
                              |
                              v
            +-----------------------------------------+
            |   Terraform Code (modular)              |
            |   - EC2 Instance                        |
            |   - IAM Role (scoped)                   |
            |   - Security Group (port 80)            |
            +--------------------------+--------------+
                                       |
                                       v
              +----------------------------------------------+
              |     AWS EC2 Instance                         |
              |     - User Data installs Docker              |
              |     - Pulls Docker Image from Docker Hub     |
              |     - Expected to run web portfolio          |
              +----------------------------------------------+
```

---

## 🔐 Security Best Practices

* **AWS CLI credentials** stored in **GitHub Secrets**, never hardcoded
* **Docker Hub credentials** stored securely for GitHub Actions
* **IAM Role** granted *only* permissions needed (EC2 and CloudWatch) to follow least privilege principles

---

## 📌 Additional Notes

* The GitHub Actions workflow is currently **manually triggered**, rather than based on code/image changes, due to the project being in a volatile testing state.
* **CloudWatch integration** was scoped for future expansion but not yet implemented.

---

## 🚫 No Next Steps Planned

This project was completed to demonstrate specific skills around Terraform, automation, and AWS IAM. While there's room to improve (e.g., debugging EC2 + Docker automation), the project is considered complete in its current form. Future projects will focus on different services (e.g., databases) rather than being a continuation of this one.

---


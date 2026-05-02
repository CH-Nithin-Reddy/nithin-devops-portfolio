# 🚀 Nithin DevOps Portfolio — End-to-End CI/CD Pipeline

![CI/CD](https://img.shields.io/badge/CI%2FCD-Jenkins-blue)
![Docker](https://img.shields.io/badge/Container-Docker-2496ED)
![AWS](https://img.shields.io/badge/Cloud-AWS%20EC2-FF9900)
![Node.js](https://img.shields.io/badge/App-Node.js-339933)
![Status](https://img.shields.io/badge/Status-Live-brightgreen)

---

## 📌 Project Overview

A production-grade CI/CD pipeline that automates the full software delivery lifecycle — from code push to live deployment — using Jenkins, Docker, and AWS EC2.

Every push to GitHub automatically triggers the pipeline, builds a Docker image, runs tests, performs a Blue/Green deployment with zero downtime, and rolls back automatically on failure.

---

## 🏗️ Architecture

```
Developer (Local PC)
       ↓
   GitHub Repo
       ↓  (Webhook trigger)
Jenkins Pipeline (AWS EC2)
       ↓
  Clone → Build → Test
       ↓
 Docker Image Built
       ↓
Deploy GREEN (port 3001)
       ↓
  Health Check ✅
       ↓
Switch to BLUE (port 3000)
       ↓
  App LIVE 🔥
       ↓
Auto Rollback if failure ❌
```

---

## 🔧 Tech Stack

| Tool | Purpose |
|------|---------|
| **Jenkins 2.555.1** | CI/CD automation server |
| **Docker** | Application containerization |
| **AWS EC2** | Cloud server (Ubuntu 22.04) |
| **GitHub** | Source code + Webhook triggers |
| **Node.js 18** | Portfolio web application |
| **Linux / Bash** | Server configuration & scripting |

---

## 📁 Project Structure

```
nithin-devops-portfolio/
├── Dockerfile            # Container build instructions
├── Jenkinsfile           # Full CI/CD pipeline definition
├── app.js                # Node.js web server
├── package.json          # App dependencies & scripts
├── .dockerignore         # Docker build exclusions
└── public/
    └── index.html        # Portfolio website
```

---

## 🔄 Pipeline Stages

| Stage | Description |
|-------|-------------|
| **Clone** | Pull latest code from GitHub |
| **Build** | Build Docker image (retry x3 on failure) |
| **Test** | Run tests inside container |
| **Deploy Green** | Deploy new version on port 3001 |
| **Health Check Green** | Verify new version is healthy (retry x5) |
| **Switch Traffic** | Move live traffic to port 3000 |
| **Health Check Final** | Confirm app is live |
| **Cleanup** | Remove unused Docker images |

---

## 🛡️ Resilience Features

- **Retry Logic** — Build retries 3 times before failing
- **Blue/Green Deployment** — Zero downtime releases
- **Health Checks** — Verifies app is running after every deploy
- **Automatic Rollback** — Reverts to previous version on failure
- **Docker Cleanup** — Prunes unused images after every build

---

## 🔵🟢 Blue/Green Deployment Strategy

```
New Code Pushed
      ↓
Build new Docker image (:new)
      ↓
Deploy to GREEN container (port 3001)
      ↓
Health check GREEN → passes ✅
      ↓
Stop GREEN → Start BLUE on port 3000
      ↓
App live with ZERO downtime 🚀
      ↓
If health check fails → rollback to :previous ❌
```

---

## ⚡ Trigger

GitHub Webhook → automatically triggers Jenkins on every `git push` to `main` branch.

No manual intervention required.

---

## 🚀 How to Run Locally

```bash
# Clone the repo
git clone https://github.com/CH-Nithin-Reddy/nithin-devops-portfolio.git
cd nithin-devops-portfolio

# Run with Node.js
npm install
npm start

# OR run with Docker
docker build -t nithin-portfolio .
docker run -p 3000:3000 nithin-portfolio
```

Visit: `http://localhost:3000`

---

## ☁️ Infrastructure Setup

| Component | Details |
|-----------|---------|
| **Cloud** | AWS EC2 |
| **OS** | Ubuntu 22.04 LTS |
| **Instance** | t2.medium |
| **Storage** | 20 GB |
| **Open Ports** | 22 (SSH), 80 (HTTP), 8080 (Jenkins), 3000 (App) |

---

## 📝 Jenkins Configuration

- **Jenkins URL:** `http://EC2_IP:8080`
- **Pipeline type:** Pipeline script from SCM
- **Branch:** `*/main`
- **Script path:** `Jenkinsfile`
- **Build trigger:** GitHub hook trigger for GITScm polling

---

## 🎯 Key Learnings

- Designed end-to-end CI/CD automation using Jenkins declarative pipelines
- Containerized a Node.js application using Docker with multi-layer optimization
- Implemented Blue/Green deployment strategy for zero downtime releases
- Configured GitHub Webhooks for automatic pipeline triggers
- Added production-grade resilience with retry logic, health checks, and rollback
- Deployed and managed live application on AWS EC2

---

## 👤 Author

**Nithin (CH Nithin Reddy)**
DevOps Engineer · CI/CD · Cloud · Automation

- GitHub: [CH-Nithin-Reddy](https://github.com/CH-Nithin-Reddy)
- LinkedIn: [linkedin.com/in/nithin](https://linkedin.com)
- Email: nithin@email.com

---

## 📄 License

MIT License — feel free to use this project as a reference.

---

*Built and deployed via CI/CD Pipeline 🔥*

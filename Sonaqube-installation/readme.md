Here is your **SonarQube Installation and Setup Guide** customized for **Alexa Edge Systems**:

---

# **Alexa Edge Systems, Paris France**

📞 **Contact:** +33-609-878-741

🌐 **Website:** [https://alexaedgesystems.com/](https://alexaedgesystems.com/)

📧 **Email:** [alexaedgesystems@gmail.com](mailto:alexaedgesystems@gmail.com)

---

## **SonarQube Installation and Setup in AWS EC2 Red Hat and Amazon linux Instance**

### ✅ Prerequisites

* AWS Account
* EC2 Red Hat instance or Amazon linux: **t2.medium (4GB RAM recommended)**
* Open necessary ports (e.g. **9000** for SonarQube)
* Attach the custom Security Group to the EC2 instance
* Install Java OpenJDK 1.8+ (Java 17 for SonarQube 8.9.10)

---

### 🔧 1. Create a Sonar user to manage the SonarQube server

> **Best Practice**: Avoid running SonarQube as root

```bash
sudo useradd sonar
sudo echo "sonar ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/sonar
sudo hostnamectl set-hostname sonar
sudo su - sonar
sudo timedatectl set-timezone America/New_York
```

---

### ☕ 2. Install Java (JDK 17)

```bash
cd /opt
sudo yum -y install unzip wget git
sudo yum remove java* -y
sudo yum install fontconfig java-17-openjdk -y
or
sudo yum update
sudo dnf install java-17-openjdk -y
```

---

### 📦 3. Install SonarQube

```bash
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.10.61524.zip
sudo unzip sonarqube*
sudo rm -rf *zip
sudo mv sonarqube* sonarqube
```

---

### 🔐 4. Set permissions for the sonar user

```bash
sudo chown -R sonar:sonar /opt/sonarqube/
sudo chmod -R 775 /opt/sonarqube/
```

---

### 🚀 5. Start SonarQube server

```bash
sh /opt/sonarqube/bin/linux-x86-64/sonar.sh start
sh /opt/sonarqube/bin/linux-x86-64/sonar.sh status
```

---

### 🌍 6. Access SonarQube in Browser

* Visit: `http://<Public-IP>:9000`
* Example: `http://54.236.232.85:9000`
* Default credentials:

  * **Username:** `admin`
  * **Password:** `admin`

---

For enterprise DevOps and cloud training, trust **Alexa Edge Systems** – your partner in becoming job-ready in 6 months.

Let me know if you'd like a downloadable `.md` or `.pdf` version of this!


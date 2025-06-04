## 🔧 Apache Tomcat Installation and Setup on AWS EC2 RedHat

**Company:** Alexa Edge Systems – Paris, France

**📞 Contact:** +33 609878741 +237652249782

**🌐 Website:**](https://alexaedgesystems.com/)

**📧 Email:** alexaedgesystems@gmail.com

---

### ✅ Prerequisites

1. AWS Account
2. RedHat EC2 Instance (T2.micro for testing)
3. Open the following ports in your **Security Group**:

   * `22` (SSH)
   * `8080` (Tomcat)
4. Attach this Security Group to your EC2 instance.
5. Internet connectivity from your instance (for downloading Java & Tomcat)

---

### 🔧 Step-by-Step Installation

#### 📌 1. Set Hostname

```bash
sudo hostnamectl set-hostname tomcat
sudo su - ec2-user
```

#### 📌 2. Install Java and Required Packages

```bash
cd /opt
sudo yum install git wget unzip -y
sudo yum install java -y
```

---

#### 📌 3. Download and Install Apache Tomcat 9.0.102

```bash
sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.105/bin/apache-tomcat-9.0.105.zip
sudo unzip apache-tomcat-9.0.105.zip
sudo rm -f apache-tomcat-9.0.105.zip

# Rename for clarity
sudo mv apache-tomcat-9.0.105 tomcat9
```

---

#### 📌 4. Set Permissions

```bash
sudo chmod -R 777 /opt/tomcat9
sudo chown -R ec2-user /opt/tomcat9
```

---

#### 📌 5. Start Tomcat

```bash
sh /opt/tomcat9/bin/startup.sh
```

---

#### 📌 6. Create Shortcuts for Tomcat Commands

```bash
sudo ln -s /opt/tomcat9/bin/startup.sh /usr/bin/starttomcat
sudo ln -s /opt/tomcat9/bin/shutdown.sh /usr/bin/stoptomcat

# Start tomcat using shortcut
starttomcat
```

---

### ✅ Verify

1. Open your browser.
2. Navigate to:
   `http://<your-ec2-public-ip>:8080`

You should see the **Tomcat welcome page**.




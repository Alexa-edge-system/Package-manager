

## **AlexaEdge Systems**

📞 **Contact:** +33 609-878-741

🌐 **Website:** https://alexaedgesystems.com/ 

📧 **Email:** [alexaedgesystems@gmail.com]

---

# 🚀 Nexus Installation and Setup on AWS EC2 (RedHat – t2.medium)

### 🔧 **Pre-requisites**

* Valid **AWS Account**
* Launch a **RedHat EC2 Instance** (t2.medium) with at least **4GB RAM**
* Create and attach a **Security Group** with required open ports (e.g. `8081` for Nexus)
* **Install OpenJDK 1.8+**

---

### 🛠️ **1. Prepare EC2 Instance**

```bash
# Set timezone and hostname
sudo timedatectl set-timezone America/New_York
sudo hostnamectl set-hostname nexus

# Create 'nexus' user (do not run Nexus as root)
sudo useradd nexus

# Grant passwordless sudo access to nexus user
echo "nexus ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/nexus

# Switch to nexus user
sudo su - nexus
```



### ☕ **2. Install Java and Required Packages**

```bash
# Back to root
exit

# Install dependencies
sudo yum install wget git nano unzip -y

# Install Java (OpenJDK 1.8 and 11)
sudo rpm --import https://yum.corretto.aws/corretto.key
sudo curl -Lo /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
sudo yum install java-11-amazon-corretto-devel -y
sudo yum install java-1.8.0-openjdk-devel -y



---

### 📦 **3. Download and Extract Nexus**

```bash
cd /opt

# Download Nexus 3.15.2-01
sudo wget http://download.sonatype.com/nexus/3/nexus-3.15.2-01-unix.tar.gz

# Extract and rename
sudo tar -zxvf nexus-3.15.2-01-unix.tar.gz
sudo mv nexus-3.15.2-01 nexus

# Clean up tar file
sudo rm -f nexus-3.15.2-01-unix.tar.gz
```

---

### 🔐 **4. Set Permissions**

```bash
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work
sudo chmod -R 775 /opt/nexus
sudo chmod -R 775 /opt/sonatype-work
```

---

### ⚙️ **5. Configure Nexus to Run as nexus User**

```bash
echo 'run_as_user="nexus"' | sudo tee /opt/nexus/bin/nexus.rc
```

---

### ▶️ **6. Start Nexus**

```bash
# Switch to nexus user
sudo su - nexus

# Start Nexus
sh /opt/nexus/bin/nexus start

# Check status
sh /opt/nexus/bin/nexus status

# Exit to root
exit
```

---

### 🔄 **7. Configure Nexus as a Systemd Service**

```bash
# Create a symlink for systemd management
sudo ln -s /opt/nexus/bin/nexus /etc/init.d/nexus

# Enable service to run on boot
sudo systemctl enable nexus

# Start Nexus service
sudo systemctl start nexus

# Check Nexus service status
sudo systemctl status nexus
```

---

✅ **Access Nexus in Browser:**
`http://<your-ec2-public-ip>:8081`

---

📌 **Important Notes:**

* Default admin password is located in:

  ```bash
  /opt/sonatype-work/nexus3/admin.password
  ```
* Use it to log into the Nexus UI and configure users/repositories.

---

🟢 **End of Nexus Installation – Powered by AlexaEdge Systems**




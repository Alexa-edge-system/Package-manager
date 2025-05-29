# Alexa edge systems
 - contact number : +33 609-878 741 or 237652249782
 - website : https://alexaedgesystems.com/
 - copyright :Alexa edge systems
# 📦 Apache Maven Installation on AWS EC2 RedHat Instance

This guide provides step-by-step instructions to install and configure Apache Maven on an AWS EC2 instance running Red Hat (RHEL).


## ✅ Prerequisites

- An active **AWS Account**
- A **Red Hat EC2 Instance** (recommended: `t2.medium` with 4 GB RAM)
- A **Security Group** with the following ports open:
  - **Port 22** (for SSH access)

## ☁️ EC2 Setup

1. Launch a new **RedHat EC2 Instance** (`t2.medium` recommended)
2. Attach your configured **security group**
3. Connect via SSH:
   ```bash
   ssh -i your-key.pem ec2-user@<EC2_PUBLIC_IP>
````
## ⚙️ System Setup

1. **Set the Hostname**:

   ```bash
   sudo hostnamectl set-hostname maven
   ```

2. **Switch to ec2-user**:

   ```bash
   sudo su - ec2-user
   ```

3. **Install Required Tools**:

   ```bash
   sudo yum install wget nano tree unzip git-all -y
   ```

4. **Install Java (OpenJDK 11 and 1.8)**:

   ```bash
   sudo yum install java-11-openjdk-devel java-1.8.0-openjdk-devel -y
   ```

5. **Verify Installations**:

   ```bash
   java -version
   git --version
   ```

## 🧰 Maven Installation

1. **Download and Extract Maven**:

   ```bash
   cd /opt
   sudo wget https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.zip
   sudo unzip apache-maven-3.9.9-bin.zip
   sudo rm -rf apache-maven-3.9.9-bin.zip
   sudo mv apache-maven-3.9.9/ maven
   ```

2. **Set Environment Variables** (for current user):
   Edit the profile file:

   ```bash
   vi ~/.bash_profile
   ```

   Add the following lines:

   ```bash
   export M2_HOME=/opt/maven
   export PATH=$PATH:$M2_HOME/bin
   ```

3. **Apply the Profile Changes**:

   ```bash
   source ~/.bash_profile
   ```

4. **Verify Maven Installation**:

   ```bash
   mvn -version
   ```

   ✅ You should see the Maven version info if installed successfully.

---

## 📌 Summary

You’ve successfully:

* Installed Java and Git
* Downloaded and configured Apache Maven
* Set up environment variables
* Verified your Maven setup

You're now ready to **build and manage Java projects** using Maven on your AWS EC2 instance.

---

## 🧠 Tip

To make Maven available for **all users**, place the environment variables in `/etc/profile.d/maven.sh` instead of `~/.bash_profile`.


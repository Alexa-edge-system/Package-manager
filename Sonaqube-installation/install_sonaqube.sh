#!/bin/bash

# SonarQube installation script for Alexa Edge Systems

echo "=============================================="
echo "Installing SonarQube on Red Hat EC2 Instance"
echo "Organization: Alexa Edge Systems"
echo "Contact: +33-609-878-741"
echo "Website: https://alexaedgesystems.com/"
echo "=============================================="

# 1. Set hostname
sudo hostnamectl set-hostname sonar

# 2. Create sonar user and grant sudo access
sudo useradd sonar
echo "sonar ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/sonar

# 3. Update system and install necessary packages
sudo yum update -y
sudo yum install -y wget unzip git fontconfig java-17-openjdk

# 4. Set timezone
sudo timedatectl set-timezone America/New_York

# 5. Download and install SonarQube
cd /opt
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.10.61524.zip
sudo unzip sonarqube-8.9.10.61524.zip
sudo rm -f sonarqube-8.9.10.61524.zip
sudo mv sonarqube-8.9.10.61524 sonarqube

# 6. Set permissions
sudo chown -R sonar:sonar /opt/sonarqube
sudo chmod -R 775 /opt/sonarqube

# 7. Start SonarQube as sonar user
echo "Starting SonarQube..."
sudo -u sonar sh /opt/sonarqube/bin/linux-x86-64/sonar.sh start

# 8. Display status
echo "Checking SonarQube status..."
sudo -u sonar sh /opt/sonarqube/bin/linux-x86-64/sonar.sh status

# 9. Output access info
PUBLIC_IP=$(curl -s http://checkip.amazonaws.com)
echo "=============================================="
echo "SonarQube installation completed successfully!"
echo "Access SonarQube at: http://${PUBLIC_IP}:9000"
echo "Default Username: admin"
echo "Default Password: admin"
echo "=============================================="

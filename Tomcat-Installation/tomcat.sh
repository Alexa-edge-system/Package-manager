#!/bin/bash

# -----------------------------
# Apache Tomcat 9 Installation Script
# For RedHat/CentOS EC2 Instance
# Alexa Edge Systems – Paris, France
# -----------------------------

echo "🔧 Setting hostname to 'tomcat'..."
sudo hostnamectl set-hostname tomcat

echo "🔐 Switching to ec2-user..."
sudo su - ec2-user

cd /opt

echo "📦 Installing required packages (git, wget, unzip)..."
sudo yum install -y git wget unzip

echo "☕ Installing Java OpenJDK 1.8..."
sudo yum install -y java-1.8.0-openjdk-devel

echo "⬇️ Downloading Apache Tomcat 9.0.102..."
sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.102/bin/apache-tomcat-9.0.102.zip

echo "📂 Extracting Tomcat..."
sudo unzip apache-tomcat-9.0.102.zip
sudo rm -f apache-tomcat-9.0.102.zip

echo "🔧 Renaming to 'tomcat9'..."
sudo mv apache-tomcat-9.0.102 tomcat9

echo "🔐 Setting permissions..."
sudo chmod -R 777 /opt/tomcat9
sudo chown -R ec2-user /opt/tomcat9

echo "🚀 Starting Tomcat..."
/opt/tomcat9/bin/startup.sh

echo "🔗 Creating shortcuts to start and stop Tomcat..."
sudo ln -s /opt/tomcat9/bin/startup.sh /usr/bin/starttomcat
sudo ln -s /opt/tomcat9/bin/shutdown.sh /usr/bin/stoptomcat

echo "✅ Installation complete! Access Tomcat at:"
curl -s http://checkip.amazonaws.com | awk '{print "http://"$1":8080"}'

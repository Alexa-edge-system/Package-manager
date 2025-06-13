### ✅ **Bash Script: `install_nexus.sh`**

```bash
#!/bin/bash

# AlexaEdge Systems - Nexus Installation Script
# Contact: +1437 215 2483 | Website: www.alexaedge.com

set -e

echo "📦 Starting Nexus installation..."

# Set timezone and hostname
sudo timedatectl set-timezone America/New_York
sudo hostnamectl set-hostname nexus

# Create nexus user
sudo useradd nexus || echo "User 'nexus' already exists."

# Grant sudo access without password
echo "nexus ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/nexus

# Install dependencies
sudo yum install -y wget git nano unzip
sudo yum install -y java-1.8.0-openjdk-devel java-11-openjdk-devel

# Download and extract Nexus
cd /opt
sudo wget -q http://download.sonatype.com/nexus/3/nexus-3.15.2-01-unix.tar.gz
sudo tar -xzf nexus-3.15.2-01-unix.tar.gz
sudo mv nexus-3.15.2-01 nexus
sudo rm -f nexus-3.15.2-01-unix.tar.gz

# Create sonatype-work directory if not exists
sudo mkdir -p /opt/sonatype-work

# Set permissions
sudo chown -R nexus:nexus /opt/nexus /opt/sonatype-work
sudo chmod -R 775 /opt/nexus /opt/sonatype-work

# Set nexus user in the config
echo 'run_as_user="nexus"' | sudo tee /opt/nexus/bin/nexus.rc

# Link Nexus as a systemd service
sudo ln -sf /opt/nexus/bin/nexus /etc/init.d/nexus

# Enable and start Nexus
sudo systemctl enable nexus
sudo systemctl start nexus
sleep 10
sudo systemctl status nexus

echo "✅ Nexus installed and running on port 8081"
echo "🔐 Default admin password:"
sudo cat /opt/sonatype-work/nexus3/admin.password
echo "🌐 Access Nexus: http://<your-ec2-public-ip>:8081"
echo "✅ End of Nexus installation – AlexaEdge Systems"
```

---

### 📌 Instructions:

1. **Create the script on your EC2:**

   ```bash
   nano install_nexus.sh
   ```

2. **Paste the script, then save and exit (`CTRL+X`, `Y`, `Enter`).**

3. **Make it executable and run:**

   ```bash
   chmod +x install_nexus.sh
   ./install_nexus.sh
   


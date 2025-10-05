
#🧭 Kubernetes Setup Using Kubeadm on AWS EC2 (Ubuntu)

Author: Tita Lavet

Website: https://alexaedgesystems.com/

Contact: +33 (609 878 741)

Email: alexaedgesystems@gmail.com

---

## 📘 Overview

This guide provides step-by-step instructions to set up a **Kubernetes Cluster** using **Kubeadm** on **AWS EC2 Ubuntu 18.04** servers.

You will deploy:

* **1 Master Node** (t2.medium – 4GB RAM, 2 vCPU)
* **2 Worker Nodes** (t2.micro – 1GB RAM, 1 vCPU each)

---

## ⚙️ Prerequisites

Before beginning:

* You must have an **AWS account**.
* Create **3 Ubuntu 18.04 servers**:

  * **1 Master Node**
  * **2 Worker Nodes**
* Create and attach a **Security Group** that allows **all inbound/outbound traffic** (for demo purposes).
* SSH into each instance and switch to the root user.

---

## 🖥️ Set Hostname and Switch to Root

Run these commands on each node:

```bash
sudo hostnamectl set-hostname master     # Run on Master node
sudo hostnamectl set-hostname node1      # Run on Worker 1
sudo hostnamectl set-hostname node2      # Run on Worker 2
sudo -i
```

---

## 🚀 Common Setup Script (`common.sh`)

Copy and run this script on **all Master and Worker nodes**.

```bash
#!/bin/bash
# common.sh

sudo hostnamectl set-hostname  node1
sudo -i

# Disable swap & add kernel settings
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Add kernel settings & enable IP tables (CNI Prerequisites)
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sysctl --system

# Install containerd runtime
apt-get update -y
apt-get install ca-certificates curl gnupg lsb-release -y

# Add Docker GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Add Docker repo
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install containerd
apt-get update -y
apt-get install containerd.io -y

# Configure containerd
containerd config default > /etc/containerd/config.toml
sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
systemctl restart containerd
systemctl enable containerd

# Install kubeadm, kubelet, kubectl
apt-get update
apt-get install -y apt-transport-https ca-certificates curl

# Add Kubernetes GPG key and repository
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# Install specific versions
apt-get update
sudo apt install -y kubeadm=1.28.1-1.1 kubelet=1.28.1-1.1 kubectl=1.28.1-1.1

# Hold versions
apt-mark hold kubelet kubeadm kubectl

# Enable and start kubelet
systemctl daemon-reload
systemctl start kubelet
systemctl enable kubelet.service
```

---

## 🧩 Initialize Kubernetes Master Node

Run on **Master Node**:

```bash
sudo kubeadm init

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

Verify if Kubernetes is working:

```bash
kubectl get pods -A
```

---

## 🌐 Deploy Network Plugin (Weave)

Run on **Master Node**:

```bash
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
kubectl get pods -A
kubectl get node
```

---

## 🧱 Join Worker Nodes

Copy the **kubeadm join token** from the master and execute it on all worker nodes:

```bash
kubeadm join 172.31.10.12:6443 --token cdm6fo.dhbrxyleqe5suy6e \
        --discovery-token-ca-cert-hash sha256:1fc51686afd16c46102c018acb71ef9537c1226e331840e7d401630b96298e7d
```

---

## ✅ Verification

On the master node, verify all nodes joined the cluster:

```bash
kubectl get nodes -o wide
```

---

## 📞 Support

**Alexa edge systems**
📧 Email: alexaedgesystems@gmail.com
🌐 https://alexaedgesystems.com/
📞 +33 609 878 741

---




## **AlexaEdge Systems**

📞 **Contact:** +33 609-878-741

🌐 **Website:** https://alexaedgesystems.com/ 

📧 **Email:** [alexaedgesystems@gmail.com]

---

# 🚀 Jenkins Installation and Setup on AWS EC2 (Amazon linux or RedHat – t2.medium)

### 🔧 **Pre-requisites**

* Valid **AWS Account**
* Launch a **RedHat or amazon linux EC2 Instance** (t2.medium) with at least **4GB RAM**
* Create and attach a **Security Group** with required open ports (e.g. `8080` for jenkins)
* **Install OpenJDK 1.8+**

# Start Jenkins
You can enable the Jenkins service to start at boot with the command:

- sudo systemctl enable jenkins

You can start the Jenkins service with the command:

- sudo systemctl start jenkins

You can check the status of the Jenkins service using the command:

 -sudo systemctl status jenkins

If everything has been set up correctly, you should see an output like this:

 -Loaded: loaded (/lib/systemd/system/jenkins.service; enabled; vendor preset: enabled)
 Active: active (running) since Tue 2023-06-22 16:19:01 +03; 4min 57s ago
 ...


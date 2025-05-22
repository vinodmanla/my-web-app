# my-web-app

🚀 Jenkins Installation & CI/CD Pipeline on Ubuntu
This guide outlines how to install Jenkins on an Ubuntu server and set up a basic CI/CD pipeline to deploy a web application.

📦 Prerequisites
Ubuntu 20.04 or later

EC2 instance or local VM with internet access

SSH access and sudo privileges

GitHub repository with a sample web app (e.g., HTML, Node.js, etc.)

🔧 Step 1: Install Java
bash
Copy
Edit
sudo apt update
sudo apt install openjdk-11-jdk -y
java -version
📥 Step 2: Add Jenkins Repository & Key
bash
Copy
Edit
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update
📌 Step 3: Install Jenkins
bash
Copy
Edit
sudo apt install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
🌐 Step 4: Access Jenkins
Open your browser: http://<your-server-ip>:8080

Retrieve the initial admin password:

bash
Copy
Edit
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
Paste the password to unlock Jenkins.

Install Suggested Plugins

Create an Admin user

🔄 Step 5: Create CI/CD Pipeline
1. Install Git & Ansible on Jenkins Server
bash
Copy
Edit
sudo apt install git ansible -y
2. Install Jenkins Plugins
In Jenkins Dashboard:

Go to Manage Jenkins → Manage Plugins

Install:

Git Plugin

Pipeline Plugin

Ansible Plugin (optional)

SSH Agent Plugin

3. Create New Pipeline Job
Go to New Item → Pipeline

Name: web-app-deploy

Choose: Pipeline

4. Example Jenkinsfile (declarative pipeline)
groovy
Copy
Edit
pipeline {
    agent any

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/yourusername/your-repo.git'
            }
        }

        stage('Build & Test') {
            steps {
                sh 'echo "Run tests or build commands here"'
            }
        }

        stage('Deploy') {
            steps {
                sh 'ansible-playbook -i inventory deploy.yml'
            }
        }
    }
}
📁 Notes
inventory should contain your target EC2 instance IP and SSH credentials.

deploy.yml is your Ansible playbook for deploying the app (e.g., copying files, restarting server).

Ensure Jenkins has SSH access to the EC2 target (use SSH keys or SSH Agent plugin).

✅ Final Outcome
You now have a Jenkins server that:

Pulls code from GitHub

Builds/tests it

Deploys it to another EC2 instance using Ansible

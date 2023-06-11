## Launch Maven Environment and Configure
- Name: Maven-Build-Env
- AMI: Amazon Linux 2
- Instance type: t2.micro
- Security group ports: 22

## Install and Configure Java11 and Apache Maven
```
#!/bin/bash
sudo su
yum update
amazon-linux-extras install java-openjdk11
java --version
wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
yum install -y apache-maven

## Configure MAVEN_HOME and PATH Environment Variables
echo "MAVEN_HOME=/usr/share/apache-maven" >> .bash_profile
echo "PATH=$MAVEN_HOME/bin:$PATH" >> .bash_profile
source .bash_profile
mvn -v

## Provision Jenkins Master User
useradd jenkinsmaster 
echo jenkinsmaster | passwd jenkinsmaster --stdin ## Amazon Linux

## Enable Password Authentication and Authorization
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd
echo "jenkinsmaster ALL=(ALL)" >> /etc/sudoers
chown -R jenkinsmaster:jenkinsmaster /opt

## Install Git SCM
yum install git -y

## Download the settings.xml file into /home/USER/.m2 to provide Authorization to Nexus
mkdir /home/jenkinsmaster/.m2
wget https://raw.githubusercontent.com/awanmbandi/realworld-cicd-pipeline-project/maven-sonarqube-nexus-jenkins/settings.xml -P /home/jenkinsmaster/.m2/
```

- NOTE/Test: ssh jenkinsmaster@MAVEN_VM_PUBLIC_IP

## Post Operations (Only Neccessary If You Must Test The Environment Before Integrating Jenkins)
```
git clone https://github.com/awanmbandi/realworld-cicd-pipeline-project.git
git checkout maven-sonarqube-nexus
```
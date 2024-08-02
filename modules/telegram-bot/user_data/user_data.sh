#!/bin/bash

# Update and install necessary packages
apt-get update && apt-get upgrade -y
apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Set up iptables firewall rules
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Allow inbound SSH (port 22)
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow inbound Kubernetes API server (port 6443)
iptables -A INPUT -p tcp --dport 6443 -j ACCEPT

# Allow inbound Docker daemon (port 2375)
iptables -A INPUT -p tcp --dport 2375 -j ACCEPT

# Allow inbound traffic for established connections
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Save iptables rules
iptables-save > /etc/iptables/rules.v4

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
usermod -aG docker $USER

# Install Docker Compose
DOCKER_COMPOSE_VERSION="1.29.2"
curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Verify Docker and Docker Compose installations
docker --version
docker-compose --version

# Install Kubernetes (kubeadm, kubelet, kubectl)
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubelet kubeadm kubectl

# Disable swap (Kubernetes requirement)
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Initialize Kubernetes Master Node
kubeadm init --pod-network-cidr=10.244.0.0/16

# Set up kubectl for the 'ubuntu' user
mkdir -p /home/ubuntu/.kube
cp -i /etc/kubernetes/admin.conf /home/ubuntu/.kube/config
chown ubuntu:ubuntu /home/ubuntu/.kube/config

# Deploy a pod network (Flannel in this example)
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# Allow scheduling on the master node (optional, for single-node clusters)
kubectl taint nodes --all node-role.kubernetes.io/control-plane- node-role.kubernetes.io/master-

# Output completion message
echo "Setup complete. Docker, Docker Compose, and Kubernetes have been installed and configured."

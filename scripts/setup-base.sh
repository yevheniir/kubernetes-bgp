#!/bin/bash

echo "[------ Begin install-sh -----]"

# Base kubernetes requirements
echo "Enable Forwarding"

cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sysctl --system

echo "Disable swap"
swapoff -a
sed -i.bak '/swap/s/^/#/g' /etc/fstab

# Download the matching version
curl -L  \
	https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 \
	-o /usr/local/bin/jq

# Make it executable
chmod +x /usr/local/bin/jq

# Verify
cat /proc/swaps

echo "[----- install-bash.sh Complete -----]"

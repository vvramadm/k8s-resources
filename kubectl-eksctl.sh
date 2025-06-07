#!/bin/bash

#Download the kubectl binary for your cluster’s Kubernetes version from Amazon S3.

# Kubernetes 1.33 

curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.33.0/2025-05-01/bin/linux/arm64/kubectl

# Download the SHA-256 checksum for your cluster’s Kubernetes version from Amazon S3using the command for your device’s hardware platform.

# Kubernetes 1.33 

curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.33.0/2025-05-01/bin/linux/arm64/kubectl.sha256


# Apply execute permissions to the binary.

sha256sum -c kubectl.sha256

# Copy the binary to a folder in your PATH. If you have already installed a version of kubectl, then we recommend creating a $HOME/bin/kubectl and ensuring that $HOME/bin comes first in your $PATH.

mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH


## Install eksctl

# The IAM account used for EKS cluster creation should have these minimal access levels.
# AWS Service 	Access Level
# CloudFormation 	Full Access
# EC2 	Full: Tagging Limited: List, Read, Write
# EC2 Auto Scaling 	Limited: List, Write
# EKS 	Full Access
# IAM 	Limited: List, Read, Write, Permissions Management
# Systems Manager 	Limited: List, Read

#For Unix

# To download the latest release, run:

# for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"

# (Optional) Verify checksum
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check

tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz

sudo mv /tmp/eksctl /usr/local/bin

eksctl create cluster --config-file=eks.yaml
Kubernetes Cluster with Vagrant
This project provides a Vagrant configuration to quickly set up a local Kubernetes cluster for development and testing purposes.

Features

- One Kubernetes master node (kubemaster)
- Scalable worker nodes (kubenode series)
- Preconfigured network for cluster communication (192.168.56.*)
- Basic provisioning for nodes setup, SSH Keys, DNS

Prerequisites

- VirtualBox: https://www.virtualbox.org/
- Vagrant: https://www.vagrantup.com/

Getting Started

1. Clone this repository.
2. Install the necessary Vagrant plugins, if needed:

Bash
vagrant plugin install vagrant-vbguest

3. Start the virtual machines:
Bash
vagrant up

Accessing the Cluster

- SSH: Use vagrant ssh [machine-name] (e.g., vagrant ssh kubemaster)
- Kubernetes API: The master node exposes the API server port to localhost. You can use kubectl configured with appropriate context to access the API.

Configuration

The Vagrantfile contains the following important settings:

- NUM_WORKER_NODE: The number of Kubernetes worker nodes.
- IP_NW: The base IP address for the private network.
- MASTER_IP_START & NODE_IP_START: Starting addresses for master and worker nodes, respectively, within the private network.

Provisioning Scripts (scripts/)

The following scripts handle node setup:

- node_setup.sh: Common setup steps for all nodes.
- master.sh: Specific configuration for the Kubernetes master node.
- worker.sh: Specific configuration for Kubernetes worker nodes.
- common/: Contains scripts for tasks like setting up hosts file, DNS, and SSH.

Customization

- Modify the Vagrantfile to align to your desired cluster size, IP addresses, or resource allocation.
- Extend the provisioning scripts to install additional software, tools, or Kubernetes-specific components.

Notes

- The virtual machines are configured with an Ubuntu/jammy64 base box.
- Port forwarding is used for SSH access to the individual VMs. Check the Vagrantfile for specifics.

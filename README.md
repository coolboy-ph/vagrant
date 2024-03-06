# Kubernetes Cluster with Vagrant
This project provides a Vagrant configuration to quickly set up a local Kubernetes cluster for development and testing purposes.

## Features

- One Kubernetes master node (**_kubemaster_**)
- Scalable worker nodes (**_kubenode series_**)
- Preconfigured network for cluster communication (**_192.168.56.*_**)
- Basic provisioning for nodes setup, SSH Keys, DNS

## Prerequisites

- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://developer.hashicorp.com/vagrant/install)

## Getting Started

1. Clone this repository.
2. Install the necessary Vagrant plugins, if needed:

```bash
vagrant plugin install vagrant-vbguest
```

3. Start the virtual machines:

```bash
vagrant up
```

## Accessing the Cluster

- SSH: Use vagrant ssh [machine-name] (e.g., vagrant ssh kubemaster)
- Kubernetes API: The master node exposes the API server port to localhost. You can use kubectl configured with appropriate context to access the API.

## Configuration

The Vagrantfile contains the following important settings:

- **_NUM_WORKER_NODE_**: The number of Kubernetes worker nodes.
- **_IP_NW_**: The base IP address for the private network.
- **_MASTER_IP_START & NODE_IP_START_**: Starting addresses for master and worker nodes, respectively, within the private network.

## Provisioning Scripts (scripts/)

The following scripts handle node setup:

- **_node_setup.sh_**: Common setup steps for all nodes.
- **_master.sh_**: Specific configuration for the Kubernetes master node.
- **_worker.sh_**: Specific configuration for Kubernetes worker nodes.
- **_common/_**: Contains scripts for tasks like setting up hosts file, DNS, and SSH.

## Customization

- Modify the Vagrantfile to align to your desired cluster size, IP addresses, or resource allocation.
- Extend the provisioning scripts to install additional software, tools, or Kubernetes-specific components.

## Notes

- The virtual machines are configured with an **_Ubuntu/jammy64_** base box.
- Port forwarding is used for SSH access to the individual VMs. Check the Vagrantfile for specifics.

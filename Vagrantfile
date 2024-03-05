NUM_WORKER_NODE = 2

IP_NW = "192.168.56."
MASTER_IP_START = 11
NODE_IP_START = 20

# Sets up hosts file and DNS
def setup_dns(node)
  # Set up /etc/hosts
  node.vm.provision "setup-hosts", :type => "shell", :path => "scripts/common/setup-hosts.sh" do |s|
    s.args = ["enp0s8", node.vm.hostname]
  end
  # Set up DNS resolution
  node.vm.provision "setup-dns", type: "shell", :path => "scripts/common/update-dns.sh"
end

# Runs provisioning steps that are required by masters and workers
def provision_kubernetes_node(node)
  # Set up DNS
  setup_dns node
  # Set up ssh
  node.vm.provision "setup-ssh", :type => "shell", :path => "scripts/common/ssh.sh"
end

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.boot_timeout = 900
  config.vm.define "kubemaster" do |node|
    node.vm.provider "virtualbox" do |vb|
      vb.name = "kubemaster"
      vb.memory = 5120
      vb.cpus = 4
    end
    node.vm.hostname = "kubemaster"
    node.vm.network :private_network, ip: IP_NW + "#{MASTER_IP_START}"
    node.vm.network "forwarded_port", guest: 22, host: "#{2710}"
    node.vm.provision "shell", path: "scripts/node_setup.sh"
    node.vm.provision "shell", path: "scripts/master.sh"
    node.vm.provision "file", source: "./scripts/common/tmux.conf", destination: "$HOME/.tmux.conf"
    node.vm.provision "file", source: "./scripts/common/vimrc", destination: "$HOME/.vimrc"
  end

  (1..NUM_WORKER_NODE).each do |i|
    config.vm.define "kubenode0#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "kubenode0#{i}"
        vb.memory = 3072
        vb.cpus = 2
      end
      node.vm.hostname = "kubenode0#{i}"
      node.vm.network :private_network, ip: IP_NW + "#{NODE_IP_START + i}"
      node.vm.network "forwarded_port", guest: 22, host: "#{2720 + i}"
      node.vm.provision "shell", path: "scripts/node_setup.sh"
      node.vm.provision "shell", path: "scripts/worker.sh"
    end
  end
end

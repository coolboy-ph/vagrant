POD_CIDR=10.244.0.0/16
SERVICE_CIDR=10.96.0.0/16
MASTER_IP=192.168.56.11

# Initializing control-plane node
echo "Initialize Kubernetes Cluster"
sudo kubeadm init --pod-network-cidr $POD_CIDR --service-cidr $SERVICE_CIDR --apiserver-advertise-address $MASTER_IP

# Copy Kube admin config
echo "Copy kube admin config to Vagrant user .kube directory"
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Save Configs to shared /Vagrant location
# For Vagrant re-runs, check if there is existing configs in the location and delete it for saving new configuration.
config_path="/vagrant/configs"

if [ -d $config_path ]; then
  rm -f $config_path/*
else
  mkdir -p $config_path
fi

cp -i /etc/kubernetes/admin.conf $config_path/config
touch $config_path/join.sh
chmod +x $config_path/join.sh

kubeadm token create --print-join-command > $config_path/join.sh

# Generete KUBECONFIG on the host
sudo mkdir -p configs
sudo mkdir -p /home/vagrant/.kube
sudo cp -f /etc/kubernetes/admin.conf configs/config
sudo cp -i configs/config /home/vagrant/.kube/

# Deploy Weave network
echo "Deploy Weave network"
kubectl apply -f "https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s-1.11.yaml"
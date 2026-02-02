#!/bin/bash
set -xv
cat /sys/module/apparmor/parameters/enabled
sudo aa-status
ps auxZ|  grep -v '^unconfined'
kubeadm reset
sudo apt-get purge kubeadm kubectl kubelet kubernetes-cni kube*
sudo apt-get autoremove
sudo rm -rf ~/.kube
sudo rm -r /var/snap/microk8s
sudo snap remove eks
sudo snap remove microk8s
sudo snap refresh microk8s --classic --channel=1.23/stable
snap info microk8s
systemctl status snap.microk8s.daemon-kubelet
sudo journalctl -u snap.microk8s.daemon-kubelet
sudo systemctl restart snap.microk8s.daemon-kubelet
nano /var/snap/microk8s/current/args/kube-apiserver
sudo microk8s.kubectl config view --raw
microk8s.stop
mv /var/snap/microk8s/common/var/lib/containerd /var/snap/microk8s/common/var/lib/_containerd
microk8s.start
sudo ufw allow in on cni0&&  sudo ufw allow out on cni0
sudo ufw default allow routed
microk8s status --wait-ready
sudo snap alias microk8s.kubectl kubectl
alias mkctl="microk8s kubectl"
sudo usermod -a -G microk8s albandrieu
microk8s.kubectl config view --raw > $HOME/.kube/config
microk8s.config
microk8s.kubectl cluster-info
microk8s.kubectl get all
microk8s enable dashboard dns registry istio
microk8s enable gpu
--container-runtime=runtime
microk8s enable prometheus traefik
microk8s status
microk8s kubectl port-forward -n kube-system service/kubernetes-dashboard 10443:443
chrome://flags/#allow-insecure-localhost
microk8s dashboard-proxy
kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret|  grep admin-user|  awk '{print $1}')
microk8s.kubectl get service --all-namespaces
microk8s.kubectl get nodes -o wide
microk8s add-node
microk8s join 10.41.40.40:25000/TODO
microk8s remove-node albandrieu.com
microk8s join 10.41.40.40:25000/TODO
microk8s leave
microk8s enable ha-cluster
$()$(k get nodes --show-labels
  k label nodes albandrieu disktype=ssd
  k label nodes albandrieu jenkins=master)$()
kubectl config view --kubeconfig $HOME/.kube/config
chmod go-r ~/.kube/config
sudo chmod go-r /home/jenkins/.kube/config
echo -e '#!/bin/bash \nkubectl --kubeconfig=$HOME/.kube/config $@' > /snap/bin/kubectlxx
chmod +x /snap/bin/kubectlxx
alias k='kubectl --kubeconfig=$HOME/.kube/config'
source ~/.bash_profile
kubectl config view
microk8s inspect
sudo lsof -i :1338
sudo lsof -i :10252
ls -lrta /var/snap/microk8s/common/default-storage
kubectl config set-context --current --namespace=jenkins
k config set-context --current --namespace=fr-standalone-devops
k get pods --watch
microk8s enable kubeflow --bundle=cs:kubeflow
exit 0

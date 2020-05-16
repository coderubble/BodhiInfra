# Docker
## docker compose detach.
```
docker-compose up -f bodhi-doc.yml -d user_db clinic_db clinic_cache
```

# Kube
## Setting up minikube on a VirtualBox VM.
install debian stable

## before ssh into VM
In Vbox make sure HostNetworkManager has DHCP created and enabled. Then in the VM instance Network>
use the following settings
```Bridge Adapter```
,wlp2s0,Intel PRO/1000 MT Desktop(8254EM),Allow all,Cable Connected

### IP Forwarding
#### ifconfig to see ip details
```
$ sudo apt install net-tools -y
$ /sbin/ifconfig 
```

#### enable ip fwding.
```
$ sudo vim /etc/sysctl.conf
```
and uncomment line ``` net.ipv4.ip_forward=1```, then to reboot.
```
$ sudo reboot.
```

## Starting VM 
```
$ VBoxManage startvm debian --type headless
```
#### SSH
```
$ ssh c@<ip>
$ su 
$ apt-get install sudo
$ /usr/sbin/adduser c sudo
$ sudo apt-get install curl
```

## Install minikube
```
$ curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
$ chmod +x ./minikube
$ sudo mv ./minikube /usr/local/bin/
```

## Install Kubectl
```
$ curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
$ chmod +x ./kubectl
$ sudo mv ./kubectl /usr/local/bin/
```

## Installing docker
```
$ sudo apt install docker.io
$ sudo systemctl start docker
$ sudo systemctl enable docker
$ sudo groupadd docker
$ sudo su
$ newgrp docker 
$ sudo usermod -aG docker $USER
```
restart the container.
```
$ docker ps
```
must work without sudo.

## starting minikube
```
$ minikube start --driver=docker
$ minikube status
$ minikube stop
```

## testing postgres
```
psql -U gitlab -d gitlabhq_production -h 172.17.0.2 -p 30007 
```

# Questions:
### how did you find the host/port?
```
$ minikube service postgresql
|-----------|------------|-------------|-------------------------|
| NAMESPACE |    NAME    | TARGET PORT |           URL           |
|-----------|------------|-------------|-------------------------|
| default   | postgresql | http/5432   | http://172.17.0.2:30007 |
|-----------|------------|-------------|-------------------------|
* Opening service default/postgresql in default browser...
```

## Visual Studio code
### install plugin (ctrl+p)
```
ext install ms-vscode-remote.vscode-remote-extensionpack
```

### Remote ssh
```
sudo apt-get install ssh-askpass-gnome ssh-askpass
```

### Config file
```
# Read more about SSH config files: https://linux.die.net/man/5/ssh_config
Host 127.0.0.1
    User c
    Port 2222
    PasswordAuthentication yes
    NumberOfPasswordPrompts 3
```

### add entry into iptables for prerouting
```
$ sudo iptables -t nat -A PREROUTING -p tcp -d 192.168.1.109 --dport 8888 -j DNAT --to 172.17.0.3:32000
```
http://172.17.0.2:32000/

# Troubleshooting

```Template parsing error: template: :1:8: executing "" at <.State.Status>: map has no entry for key "State"```
```
c@debian:~$ minikube delete -all
Error: unknown shorthand flag: 'a' in -all
See 'minikube delete --help' for usage.
c@debian:~$ minikube delete --all
🔥  Deleting "minikube" in docker ...
💀  Removed all traces of the "minikube" cluster.
🔥  Successfully deleted all profiles

c@debian:~$ minikube start --driver=docker
😄  minikube v1.10.1 on Debian 10.4 (vbox/amd64)
✨  Using the docker driver based on user configuration
👍  Starting control plane node minikube in cluster minikube
🔥  Creating docker container (CPUs=2, Memory=2200MB) ...
🐳  Preparing Kubernetes v1.18.2 on Docker 19.03.2 ...
    ▪ kubeadm.pod-network-cidr=10.244.0.0/16
🔎  Verifying Kubernetes components...
🌟  Enabled addons: default-storageclass, storage-provisioner
🏄  Done! kubectl is now configured to use "minikube"
```

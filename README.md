# Docker
## docker compose detach.
```
docker-compose up -f bodhi-doc.yml -d user_db clinic_db clinic_cache
```

# Kube
## Setting up minikube on a VirtualBox VM.

* install debian stable 
* in the virtual box under Networking change Network Adapter 1 to NAT
Under Port fowarding:
name: SSH
Protocol: TCP
Host Port 2222
Guest Port:22
## Starting VM 
```
$ VBoxManage startvm debian --type headless
```
## ssh into VM
```
$ ssh c@127.0.0.1 -p 2222
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
$ newgrp docker 
$ sudo usermod -aG docker $USER
```

## starting minikube
```
$ minikube start --driver=docker
$ minikube status
$ minikube stop
```

psql -h postgresql -U gitlabhq_production -p 30007


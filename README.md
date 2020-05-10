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
In Vbox make sure HostNetworkManager has DHCP created and enabled. Then in the VM instance Network>
use the following settings
Bridge Adapter,wlp2s0,Intel PRO/1000 MT Desktop(8254EM),Allow all,Cable Connected

#### Install ifconfig and view IP (192.168.1.14 in this case)
```
$ sudo apt install net-tools -y
$ /sbin/ifconfig 
```

#### SSH
```
$ ssh c@192.168.1.14 -p 22
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
### IP Forwarding
```
#### set a static ip
```
$ /sbin/ifconfig
```
#### above will provide a static ip
```
$ sudo vim /etc/sysctl.conf
```
and uncomment net.ipv4.ip_forward=1
```Note:``` you may need to restart.
### add entry into iptables for prerouting
```
$ sudo iptables -t nat -A PREROUTING -p tcp -d 192.168.0.104 --dport 8888 -j DNAT --to 172.17.0.2:30008
```

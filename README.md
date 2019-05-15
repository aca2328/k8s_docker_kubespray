# Kubespray_indocker
Install a k8s cluster in aws using kubespray from a docker image

# Prerequises
client host installed with docker
(tested with ubuntu 18.04 + docker CE 18.09.6, 2vCPU 4G ram/ osx mojave + Docker desktop Version 2.0.0.3 (31259))

k8s nodes hosts installed with CentOS 7 (x86_64) on 
(tested with AWS ami-0e1ab783dc9489f34 2vCPU 4G ram)

all nodes must have internet acces during install, after install, the cluster can work in a local vpc

# Usage
1. launch one instance to run kubespray from within the VPC you plan to install the cluster
2. Install docker, then clone the repository `git clone https://github.com/aca2328/Kubespray_indocker.git` then `cd /kubespay_indocker`
3. fill `id_rsa_priv` with the ssh key ansible will use to ssh on the K8s nodes
4. fill `get_aws_keys.yml` and `get_aws_vars.yml` with aws IAM credentials and AWS region info
5. lauch manually from aws console 4 or more instances in the same subnet, adding tag `k8s` with value `ok`
6. then lauch the build using `./run.sh`
7. after the docker build the container shoud run in interactive mode, you may want to adjust the builted config located in `inventory/k8s/` (suggested are `host.yaml` and `/group_vars/k8s-cluster/k8s-cluster.yml`)
8. then finally, lauch `ansible-playbook -i inventory/k8s1/hosts.yaml --become --become-user=root cluster.yml --private-key=key.priv -u centos` to initiate kubespray k8s cluster building
9. to check everything is ok, you may ssh on node1 ( the k8s master ) and type `sudo su -` `kubectl get nodes`


# References

on kubespray `https://github.com/kubernetes-sigs/kubespray``
on installing docker `https://github.com/docker/docker-install`
ON Ansible automation `https://docs.ansible.com/ansible/latest/user_guide/playbooks.html`


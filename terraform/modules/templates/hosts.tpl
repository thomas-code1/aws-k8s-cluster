[controlplane]
controlplane ansible_ssh_host=${controlplane_ip} private_ip=${controlplane_private_ip}

[workers]
%{ for index, ip in worker_ip ~}
worker0${index + 1} ansible_ssh_host=${ip} private_ip=${worker_private_ip[index]}
%{ endfor ~}

[nfs]
nfs ansible_ssh_host=${nfs_ip} private_ip=${nfs_private_ip}

[k8s:children]
controlplane
workers

[all:vars]
ansible_ssh_port=22
ansible_ssh_user=ubuntu
ansible_ssh_common_args='-o StrictHostKeyChecking=accept-new'
ansible_ssh_private_key_file="~/.ssh/thomas_perso.pem"

[controlplane:vars]
kubernetes_role=control_plane

[workers:vars]
kubernetes_role=node
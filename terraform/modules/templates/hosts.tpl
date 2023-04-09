[controlplane]
controlplane ansible_ssh_host=${controlplane_ip}

[workers]
%{ for index, ip in worker_ip ~}
worker0${index + 2} ansible_ssh_host=${ip}
%{ endfor ~}

[nfs]
controlplane ansible_ssh_host=${nfs_ip} 

[nodes:children]
controlplane
workers

[nodes:vars]
ansible_ssh_port=22
ansible_ssh_user=ubuntu
ansible_ssh_common_args='-o StrictHostKeyChecking=accept-new'
ansible_ssh_private_key_file="~/.ssh/thomas_perso.pem"

[controlplane:vars]
kubernetes_role=control_plane

[workers:vars]
kubernetes_role=node
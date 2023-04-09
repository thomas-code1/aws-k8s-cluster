#!/bin/bash

cd terraform
terraform apply -auto-approve

sleep 5

cd ../ansible
ansible-playbook -i hosts deploy-k8s-cluster.yml

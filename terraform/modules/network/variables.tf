locals {
  controlplane_port_rules = {
    rule1 = {
      description = "K8S 6443"
      from_port   = 6443
      to_port     = 6443
    },
    rule2 = {
      description = "K8S 2379-2380"
      from_port   = 2379
      to_port     = 2380
    },
    rule3 = {
      description = "K8S 10250"
      from_port   = 10250
      to_port     = 10250
    },
    rule4 = {
      description = "K8S 10259"
      from_port   = 10259
      to_port     = 10259
    },
    rule5 = {
      description = "K8S 10257"
      from_port   = 10257
      to_port     = 10257
    }
  }
  worker_port_rules = {
    rule1 = {
      description = "K8S 10250"
      from_port   = 10250
      to_port     = 10250
    },
    rule2 = {
      description = "K8S 30000-32767"
      from_port   = 30000
      to_port     = 32767
    }
  }
}





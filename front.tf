provider "kubernetes" {
    config_context_cluster   = "minikube"

}
resource "kubernetes_deployment" "wordpress" {
  metadata {
    name = "wp"
  }
  spec {
    replicas = 3

    selector{
      match_labels = {
        env = "develop"
        dc = "In"
        App = "wp"
      }
    
     
        match_expressions {
            key = "env"
            values = ["develop" , "wp"]
            operator = "In"
        }
    }

    template {
        metadata {
            labels = {
                env = "develop"
                dc = "In"
                App = "wp"
            }
        }
         spec {
    container {
      image = "wordpress:4.8-apache"
      name  = "wp"
    }
         }
    }
     }
}

resource "kubernetes_service" "loadbalancer" {
  metadata {
    name = "loadbalancer"
  }
  spec {
    selector = {
      App = "wp"
    }
    port {
      node_port   = 32123 
      port        = 80
      target_port = 80
    }
    type = "NodePort"
} 
}
/*
output "lb_ip" {
  value = "${kubernetes_service.loadbalancer.load_balancer_ingress.0.ip}"
}
*/
resource "kubernetes_service" "jenkins-svs" {
  metadata {
    name = "terraform-jenkins"
    namespace = "tools"
  }

  spec {
    selector {
      app = "${kubernetes_pod.jenkins-pod.metadata.0.labels.app}"
    }

    port {
      port        = 80
      target_port = 8080
      node_port   = 30618
      protocol    = TCP
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_pod" "jenkins-pod" {
  metadata {
    name = "terraform-jenkins"

    labels {
      app = "jenkins"
    }
  }

  spec {
    container {
      image = "fsadykov/centos_jenkins:0.2"
      name  = "jenkins"
    }
  }
}

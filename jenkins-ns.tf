resource "kubernetes_namespace" "tools" {
  metadata {
    annotations {
      name = "jenkins-annotation"
    }

    labels {
      mylabel = "jenkins-value"
    }

    name = "terraform-lenkins-ns"
  }
}

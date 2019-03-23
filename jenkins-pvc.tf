resource "kubernetes_persistent_volume" "jenkins-pv" {
  metadata {
    name = "terraform-jenkins"
  }

  spec {
    capacity {
      storage = "15Gi"
    }

    access_modes = ["ReadWriteOnce"]

    persistent_volume_source {
      gce_persistent_disk {
        pd_name = "jenkins-pv-pd"
      }
      vspere_volume {
        volume_path = "/home/jenkins-app/volume"
     }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "jenkins-pvc" {
  metadata {
    name = "terraform-jenkins"
    namespace = "tools"
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests {
        storage = "15Gi"
      }
    }

    volume_name = "${kubernetes_persistent_volume.jenkins-pv.metadata.0.terraform-jenkins}"
  }
}

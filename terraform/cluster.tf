resource "google_container_cluster" "gke-cluster" {
  name               = "${var.cluster_name}"
  network            = "default"
  location           = "${var.region}"
  initial_node_count = 1

  remove_default_node_pool = true
}

// resource to create the node pool
resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "activo"
  location   = "${var.region}"
  cluster    = "${google_container_cluster.gke-cluster.name}"
  node_count = 1
  project    = "${var.gcp_project}"

 // parameters used in creating the default node pool
  node_config {
    preemptible  = false
    machine_type = "n1-standard-1"

     metadata = {
      disable-legacy-endpoints = "true"
    }
    // set of google API's made available on all of the nodes
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  autoscaling {
    min_node_count = "3"
    max_node_count = "5"
  }

   management {
    auto_repair     = true
    auto_upgrade    = true
  }
}
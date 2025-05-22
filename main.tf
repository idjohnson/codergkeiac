resource "google_container_cluster" "autopilot" {
  provider = google-beta
  name     = var.cluster_name
  location = var.region

  enable_autopilot = true

  release_channel {
    channel = "REGULAR"
  }

  networking_mode = "VPC_NATIVE"

  # Minimal required settings for Autopilot
  initial_node_count = 1

  # Remove master_auth block for Autopilot
}

resource "google_gke_hub_membership" "membership" {
  provider      = google-beta
  membership_id = "${google_container_cluster.autopilot.name}-membership"
  endpoint {
    gke_cluster {
      resource_link = "//container.googleapis.com/${google_container_cluster.autopilot.id}"
    }
  }
  location = var.region
}

resource "google_gke_hub_feature" "acm" {
  provider = google-beta
  name     = "configmanagement"
  location = "global"
}

resource "google_gke_hub_feature_membership" "acm_membership" {
  provider   = google-beta
  location   = "global"
  feature    = google_gke_hub_feature.acm.name
  membership = google_gke_hub_membership.membership.membership_id

  configmanagement {
    config_sync {
      source_format = "unstructured"
      git {
        sync_repo   = "https://forgejo.freshbrewed.science/builderadmin/codermanifests"
        sync_branch = "main"
        policy_dir  = "/"
        secret_type = "none"
      }
    }
    policy_controller {
      enabled = true
    }
  }
}


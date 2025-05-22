variable "project_id" {
  description = "The GCP project ID where the GKE Autopilot cluster will be created."
  type        = string
  default     = "my-gcp-project"
}

variable "region" {
  description = "The region to deploy the GKE Autopilot cluster."
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "The name of the GKE Autopilot cluster."
  type        = string
  default     = "autopilot-acm"
}

variable "acm_repo_url" {
  description = "The Git repository URL for Anthos Config Management."
  type        = string
  default     = "https://forgejo.freshbrewed.science/builderadmin/codermanifests"
}

variable "acm_repo_branch" {
  description = "The branch of the ACM Git repository to sync."
  type        = string
  default     = "main"
}

variable "acm_policy_dir" {
  description = "The directory in the ACM Git repository to sync."
  type        = string
  default     = "/"
}

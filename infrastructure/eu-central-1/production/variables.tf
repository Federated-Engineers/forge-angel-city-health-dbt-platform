variable "github_repos" {
  type        = list(string)
  description = "List of GitHub repositories allowed for OIDC authentication & ECR Deployment"
  # repo:<github_org | owner>@<github_ord_id | owner_id>/<repo_name>@<repo_id>:ref:refs/heads/branch_name
  # repo:<github_org | owner>/<repo_name>@:ref:refs/heads/branch_name # If repo was created before 15th July use this format
  default = [
    "repo:Federated-Engineers/forge-angel-city-health-dbt-platform:ref:refs/heads/main",
    "repo:Federated-Engineers/forge-angel-city-health-dbt-platform:ref:refs/heads/*" # To Do: This line for testing only, remove it after testing is done
  ]
  sensitive = false
  nullable  = false

  validation {
    condition     = alltrue([for repo in var.github_repos : substr(repo, 0, 5) == "repo:"])
    error_message = "Repostories must be in the format 'repo:<github_org | owner>@<github_org_id | owner_id>/<repo_name>@<repo_id>:*' and must be a list of strings."
  }
}

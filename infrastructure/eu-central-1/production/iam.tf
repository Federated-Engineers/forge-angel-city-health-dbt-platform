resource "aws_iam_role" "github_action_oidc_role" {
  name        = "DBT-Deployment-Github-Actions-Role"
  description = "IAM Role for Github Actions to assume via OIDC for DBT Deployment"
  path        = "/achs/cd/"
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Federated" : data.aws_iam_openid_connect_provider.github_user_id_provider.arn
          },
          "Action" : "sts:AssumeRoleWithWebIdentity",
          "Condition" : {
            "StringEquals" : {
              "token.actions.githubusercontent.com:aud" : "sts.amazonaws.com"
            },
            "StringLike" : {
              "token.actions.githubusercontent.com:sub" : var.github_repos
            }
          }
        }
      ]
    }
  )
}

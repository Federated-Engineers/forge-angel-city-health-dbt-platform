
locals {
  github_oidc_url = "https://token.actions.githubusercontent.com"
  oidc_audiences  = ["sts.amazonaws.com"]
}

resource "aws_iam_openid_connect_provider" "gh_action_oidc" {
  url            = local.github_oidc_url
  client_id_list = local.oidc_audiences
  tags = {
    Purpose = "GitHub Action OIDC Authentication"
  }
}

resource "aws_iam_role" "gh_action_role" {
  name        = "Github-Action-OIDC-Role"
  description = "Role to be assumed by GithHub Actions for OIDC authentication to AWS"
  path        = "/achs/deployment/"
  # Trust Policy
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : "sts:AssumeRoleWithWebIdentity",
          "Principal" : {
            "Federated" : aws_iam_openid_connect_provider.gh_action_oidc.arn
          },
          "Condition" : {
            "StringEquals" : {
              "token.actions.githubusercontent.com:aud" : [
                "sts.amazonaws.com"
              ]
            },
            "StringLike" : {
              "token.actions.githubusercontent.com:sub" : [
                "repo:Federated-Engineers/forge-angel-city-health-dbt-platform:*",
                "repo:temmyzeus/DevOps:*"
              ]
            }
          }
        }
      ]
    }
  )
  depends_on = [aws_iam_openid_connect_provider.gh_action_oidc]
}

resource "aws_iam_policy" "ecr_private_login_policy" {
  name        = "ECRPublishPolicy"
  path        = "/achs/deployment/"
  description = "Policy to be attached to github action role for ECR Access"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "GetAuthorizationToken",
          "Effect" : "Allow",
          "Action" : [
            "ecr:GetAuthorizationToken"
          ],
          "Resource" : "*"
        },
        {
          "Sid" : "AllowECRImagePublish",
          "Effect" : "Allow",
          "Action" : [
            "ecr:CompleteLayerUpload",
            "ecr:UploadLayerPart",
            "ecr:InitiateLayerUpload",
            "ecr:BatchCheckLayerAvailability",
            "ecr:PutImage",
            "ecr:BatchGetImage"
          ],
          "Resource" : [
            aws_ecr_repository.dbt_repo.arn
          ]
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "attach_ecr_login_policy" {
  role       = aws_iam_role.gh_action_role.name
  policy_arn = aws_iam_policy.ecr_private_login_policy.arn
}

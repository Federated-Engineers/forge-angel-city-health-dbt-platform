locals {
  iam_path                   = "/achs/cd/"
  snowflake_path             = "/achs/snowflake"
  snowflake_integration_path = "/achs/snowflake/storage_integration/"
}

resource "aws_iam_role" "github_action_oidc_role" {
  name        = "DBT-Deployment-Github-Actions-Role"
  description = "IAM Role for Github Actions to assume via OIDC for DBT Deployment"
  path        = local.iam_path
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
              "token.actions.githubusercontent.com:aud" : [
                "sts.amazonaws.com"
              ]
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

resource "aws_iam_policy" "gh_action_role_policy" {
  name = "ECRAuthPublishPolicy"
  path = local.iam_path
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "ECRAuth",
        "Effect" : "Allow",
        "Action" : "ecr:GetAuthorizationToken",
        "Resource" : "*"
      },
      {
        "Sid" : "ECRPushPull",
        "Effect" : "Allow",
        "Action" : [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ],
        "Resource" : aws_ecr_repository.achs_dbt_repo.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_gh_action_role_policy" {
  role       = aws_iam_role.github_action_oidc_role.name
  policy_arn = aws_iam_policy.gh_action_role_policy.arn
}

resource "aws_iam_role" "achs_dbt_core_ecs_execution_role" {
  name = "AirflowClusterECSExecutionRole"
  path = local.iam_path
  # Trust Policy
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "AllowECSToAssumeRole",
          "Effect" : "Allow",
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "ecs-tasks.amazonaws.com"
          }
        }
      ]
    }
  )
}

resource "aws_iam_policy" "achs_dbt_core_ecs_execution_role_policy" {
  name = "AirflowClusterECSExecutionRolePolicy"
  path = local.iam_path
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "AllowECRImagePull",
          "Effect" : "Allow",
          "Action" : [
            "ecr:BatchGetImage",
            "ecr:GetDownloadUrlForLayer",
            "ecr:GetAuthorizationToken"
          ],
          "Resource" : "*"
        },
        {
          "Sid" : "AllowSecretsManagerAccess",
          "Effect" : "Allow",
          "Action" : [
            "secretsmanager:GetSecretValue"
          ],
          "Resource" : "*"
        },
        {
          "Sid" : "AllowCloudWatchLogs",
          "Effect" : "Allow",
          "Action" : [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ],
          "Resource" : "*"
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "attach_achs_dbt_core_ecs_execution_role_policy" {
  role       = aws_iam_role.achs_dbt_core_ecs_execution_role.name
  policy_arn = aws_iam_policy.achs_dbt_core_ecs_execution_role_policy.arn
}

resource "aws_iam_role" "achs_dbt_core_task_role" {
  name = "AirflowClusterECSTaskRole"
  path = local.iam_path
  # Trust Policy
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "AllowECSTaskToAssumeRole",
          "Effect" : "Allow",
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "ecs-tasks.amazonaws.com"
          }
        }
      ]
    }
  )
}

resource "aws_iam_policy" "achs_dbt_core_task_role_policy" {
  name = "AirflowClusterECSTaskRolePolicy"
  path = local.iam_path
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "ssmmessages:CreateControlChannel",
            "ssmmessages:CreateDataChannel",
            "ssmmessages:OpenControlChannel",
            "ssmmessages:OpenDataChannel"
          ],
          "Resource" : "*"
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "attach_achs_dbt_core_task_role_policy" {
  role       = aws_iam_role.achs_dbt_core_task_role.name
  policy_arn = aws_iam_policy.achs_dbt_core_task_role_policy.arn
}

resource "aws_iam_role" "snowflake_storage_integration_role" {
  name = "SnowflakeStorageIntegrationRole"
  path = local.snowflake_integration_path
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "AllowSnowflakeToAssumeRole",
          "Effect" : "Allow",
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "AWS" : snowflake_storage_integration_aws.achs_source_data_integration.describe_output[0].iam_user_arn
          },
          "Condition" : {
            "StringEquals" : {
              "sts:ExternalId" : snowflake_storage_integration_aws.achs_source_data_integration.describe_output[0].external_id
            }
          }
        }
      ]
    }
  )
}

resource "aws_iam_policy" "snowflake_storage_integration_policy" {
  name = "SnowflakeStorageIntegrationPolicy"
  path = local.snowflake_integration_path
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "AllowObjectLevelAccess",
          "Effect" : "Allow",
          "Action" : [
            "s3:GetObject",
            "s3:GetObjectVersion"
          ],
          "Resource" : "${data.aws_s3_bucket.achs_data_source_bucket.arn}/achs_data/*"
        },
        {
          "Sid" : "AllowBucketLevelAccess",
          "Effect" : "Allow",
          "Action" : [
            "s3:ListBucket",
            "s3:GetBucketLocation"
          ],
          "Resource" : data.aws_s3_bucket.achs_data_source_bucket.arn,
          "Condition" : {
            "StringLike" : {
              "s3:prefix" : [
                "achs_data/*"
              ]
            }
          }
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "attach_snowflake_storage_integration_policy" {
  role       = aws_iam_role.snowflake_storage_integration_role.name
  policy_arn = aws_iam_policy.snowflake_storage_integration_policy.arn
}

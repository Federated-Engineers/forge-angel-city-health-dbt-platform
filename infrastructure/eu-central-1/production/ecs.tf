resource "aws_ecs_cluster" "dbt_cluster" {
  name = "dbt-core-cluster"

  setting {
    name  = "containerInsights"
    value = "enhanced"
  }
}


resource "aws_ecs_cluster_capacity_providers" "dbt_cluster_capacity_providers" {
  cluster_name       = aws_ecs_cluster.dbt_cluster.name
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    base              = 0  # Minimum number of tasks that runs on this capacity provider before others are used
    weight            = 95 # Percentage of tasks that uses this capacity provider
  }

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    base              = 0
    weight            = 5
  }
}

resource "aws_ecs_task_definition" "dbt_core_cluster_task_definition" {
  family                   = "dbt-core-task-definition"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "4096"
  memory                   = "8192"
  network_mode             = "awsvpc"
  task_role_arn            = aws_iam_role.achs_dbt_core_task_role.arn
  execution_role_arn       = aws_iam_role.achs_dbt_core_ecs_execution_role.arn
  pid_mode                 = "task"

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name      = "dbt-core"
      essential = false
      command   = ["dbt", "--help"]
      image     = "${aws_ecr_repository.achs_dbt_repo.repository_url}:LATEST"
      cpu       = 4096
      memory    = 4096

      secrets = [
        { "name" = "SNOWFLAKE_ORGANIZATION_NAME", "valueFrom" = "${aws_ssm_parameter.snowflake_org_name.arn}" },
        { "name" = "SNOWFLAKE_ACCOUNT_NAME", "valueFrom" = "${aws_ssm_parameter.snowflake_account_name.arn}" },
        { "name" = "SNOWFLAKE_USER", "valueFrom" = "${aws_ssm_parameter.snowflake_user.arn}" },
        { "name" = "SNOWFLAKE_PRIVATE_KEY", "valueFrom" = "${aws_ssm_parameter.snowflake_private_key.arn}" },
        { "name" = "SNOWFLAKE_ROLE", "valueFrom" = "${aws_ssm_parameter.snowflake_role.arn}" }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/achs/dbt/logs"
          "awslogs-region"        = "eu-central-1"
          "awslogs-stream-prefix" = "achs"
          "awslogs-create-group"  = "true"
        }
      }
    }
  ])
}

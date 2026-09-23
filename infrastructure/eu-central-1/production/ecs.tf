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

# resource "aws_ecs_task_definition" "airflow_cluster_task_definition" {
#   family                   = "airflow-cluster-task-definition"
#   requires_compatibilities = ["FARGATE"]
#   cpu                      = "4096"
#   memory                   = "8192"
#   network_mode             = "awsvpc"
#   task_role_arn            = aws_iam_role.airflow_cluster_task_role.arn
#   execution_role_arn       = aws_iam_role.airflow_cluster_execution_role.arn
#   pid_mode                 = "task"

#   runtime_platform {
#     operating_system_family = "LINUX"
#     cpu_architecture        = "X86_64"
#   }

#   ephemeral_storage {
#     size_in_gib = 21
#   }

#   container_definitions = jsonencode([
#     {
#       name      = "airflow-standalone"
#       essential = true
#       command   = ["standalone"]
#       image     = "${aws_ecr_repository.airflow_repo.repository_url}:latest"
#       cpu       = 4096
#       memory    = 4096

#       portMappings = [
#         {
#           containerPort = 8080
#           protocol      = "tcp"
#         }
#       ]

#       environment = [
#         { name = "AIRFLOW__API__PORT", value = "8080" },
#         { name = "AIRFLOW__CORE__EXECUTOR", value = "LocalExecutor" },
#         { name = "AIRFLOW__CORE__DAGS_ARE_PAUSED_AT_CREATION", value = "true" },
#         { name = "AIRFLOW__SCHEDULER__ENABLE_HEALTH_CHECK", value = "true" }
#       ]

#       secrets = [
#         {
#           "name" : "AIRFLOW__DATABASE__SQL_ALCHEMY_CONN",
#           "valueFrom" : aws_secretsmanager_secret_version.airflow_meta_db_conn_uri.secret_arn
#         }
#       ]

#       logConfiguration = {
#         logDriver = "awslogs"
#         options = {
#           "awslogs-group"         = "/ecs/airflow-cluster/api-standalone"
#           "awslogs-region"        = "eu-central-1"
#           "awslogs-stream-prefix" = "ecs"
#           "awslogs-create-group"  = "true"
#         }
#       }
#     }
#   ])
# }

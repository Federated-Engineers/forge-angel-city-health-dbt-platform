output "github_action_oidc_role_arn" {
  value = aws_iam_role.github_action_oidc_role.arn
}

output "dbt_core_vpc_id" {
  value = aws_vpc.dbt_core.id
}

output "dbt_core_subnet_id" {
  value = aws_subnet.dbt_core_subnet.id
}

output "dbt_core_security_group_id" {
  value = aws_security_group.dbt_core_sg.id
}

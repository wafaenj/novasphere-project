
# Resultats de la partie Compute & Auto-Scaling

output "alb_dns_name" {
  description = "Adresse DNS publique de l'ALB"
  value       = aws_lb.web.dns_name
}

output "target_group_arn" {
  description = "ARN du Target Group"
  value       = aws_lb_target_group.web.arn
}

output "autoscaling_group_name" {
  description = "Nom de l'Auto Scaling Group"
  value       = aws_autoscaling_group.web.name
}

output "launch_template_id" {
  description = "Identifiant du Launch Template"
  value       = aws_launch_template.web.id
}

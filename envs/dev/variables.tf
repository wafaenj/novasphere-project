
variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "Région AWS Learner Lab"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Nom de l'environnement"
}

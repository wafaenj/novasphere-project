
# Variables propres a la partie Compute & Auto-Scaling

variable "compute_ami_id" {
  description = "Identifiant de l'AMI compatible avec le script de demarrage"
  type        = string
}

variable "compute_instance_type" {
  description = "Type des instances EC2"
  type        = string
  default     = "t3.micro"
}

variable "compute_instance_profile_name" {
  description = "Profil IAM permettant la lecture du secret SSM"
  type        = string
  default     = "LabInstanceProfile"
}

variable "compute_user_data_base64" {
  description = "Script de demarrage encode en Base64"
  type        = string
  sensitive   = true
}

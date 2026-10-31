
# Variables propres a la partie Compute & Auto-Scaling


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



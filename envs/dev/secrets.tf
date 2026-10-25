# Création du secret dans le Parameter Store (écriture seule pour la sécurité)
resource "aws_ssm_parameter" "db_password" {
  name             = "/novasphere/dev/db_password"
  description      = "Mot de passe de la base de donnees pour dev"
  type             = "SecureString"
  value_wo         = "SuperSecretDev2026!"
  value_wo_version = 1

  tags = {
    Environment = "dev"
    Project     = "NovaSphere"
  }
}
# Architecture du Projet NovaSphere

Ce projet utilise **Terraform** pour gérer l'infrastructure cloud AWS de manière simple, propre et organisée.

## Organisation générale
- **Module d'équipe (`terraform-aws-module`)** : Stocké dans un dépôt séparé et versionné avec le tag `v1.0.0`.
- **Environnements (`envs/dev` et `envs/prod`)** : Dossiers dédiés à l'isolation des environnements de développement et de production.
- **CI/CD (`.github/workflows/`)** : Workflows GitHub Actions pour l'automatisation des vérifications et des déploiements.

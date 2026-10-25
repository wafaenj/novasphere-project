# NovaSphere - Infrastructure Cloud Multi-Environnements

Ce dépôt contient le code Terraform permettant de déployer l'infrastructure web haute disponibilité du projet **NovaSphere** sur AWS (environnements `dev` et `prod`).

---

## Prérequis

Avant de commencer, assurez-vous d'avoir installé sur votre poste :
- [Terraform](https://www.terraform.io/downloads) (version >= 1.5.0)
- [AWS CLI](https://aws.amazon.com/cli/) (version >= 2.0)
- [Git](https://git-scm.com/)

---

## 1. Configuration des Identifiants AWS (Learner Lab)

1. Connectez-vous à votre espace **AWS Learner Lab**.
2. Cliquez sur **AWS Details** puis sur **Show** à côté d'AWS CLI.
3. Copiez la configuration et collez-la dans votre fichier local `~/.aws/credentials` :

```ini
[default]
aws_access_key_id = VOTRE_ACCESS_KEY
aws_secret_access_key = VOTRE_SECRET_KEY
aws_session_token = VOTRE_SESSION_TOKEN

```

---

## 2. Déploiement de l'Environnement DEV

### Étape 2.1 : Initialisation

Se placer dans le répertoire `envs/dev` et initialiser le backend S3 partagé :

```bash
cd envs/dev
terraform init

```

### Étape 2.2 : Vérification du plan

Générer et vérifier le plan d'exécution :

```bash
terraform plan

```

### Étape 2.3 : Déploiement

Appliquer la configuration sur AWS :

```bash
terraform apply

```

*(Saisir `yes` pour confirmer le déploiement)*.

---

## 3. Vérification du Déploiement

* **Secret Parameter Store** : Vérifiez que le secret `/novasphere/dev/db_password` est bien créé sous **AWS Systems Manager > Parameter Store**.
* **Application Web** : Récupérez le nom DNS de l'ALB affiché dans les outputs de Terraform et ouvrez-le dans votre navigateur : `http://<alb_dns_name>`

---

## 4. Destruction de l'Infrastructure

Pour éviter toute consommation inutile du budget Learner Lab à la fin de votre session de travail :

```bash
cd envs/dev
terraform destroy

```

*(Saisir `yes` pour confirmer la suppression)*.

---

## 5. Structure du Projet


novasphere-infra/
├── .github/workflows/   # Pipelines CI/CD GitHub Actions
├── envs/
│   ├── dev/             # Environnement de développement (backend S3, secrets, etc.)
│   └── prod/            # Environnement de production
├── templates/
│   └── bootstrap.sh     # Script d'amorçage EC2 (< 10 lignes)
├── CADRAGE.md           # Fiche de cadrage du projet
├── CONTRIBUTING.md      # Règles de collaboration de l'équipe
├── SECURITE.md          # Rapport de sécurité et gestion des secrets
└── README.md            # Ce guide d'utilisation

```


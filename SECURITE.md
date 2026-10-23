## Sécurité

## Gestion des secrets : 

Dans ce projet, nous avons choisi de stocker les informations sensibles dans AWS Systems Manager Parameter Store sous forme de SecureString
L'objectif est d'éviter d'exposer des mots de passe ou des informations confidentielles dans le code ou dans le dépôt Git

## Bonnes pratiques appliquées : 

- Aucun mot de passe n'est enregistré dans le dépôt GitHub
- Les secrets ne sont pas écrits directement dans les fichiers Terraform
- Le script de démarrage ne contient pas d'information sensible
- Les instances récupèrent les informations nécessaires depuis AWS au moment du démarrage
- Vérifications de sécurité
- Avant la livraison du projet, un scan de sécurité sera réalisé avec Checkov ou Trivy afin d'identifier d'éventuels problèmes de configuration

## Remarques : 
Certaines contraintes sont liées au fonctionnement du Learner Lab AWS fourni dans le cadre du module. Les choix retenus ont donc été adaptés à cet environnement tout en respectant les exigences du cahier des charges

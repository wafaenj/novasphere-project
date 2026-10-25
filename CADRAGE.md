
# Fiche de Cadrage - Projet NovaSphere

- **Équipe : Groupe NovaSphere
- **Référent Git :Awatef Boulakhras
- **Référent AWS :Awatef Boulakhras (Secrets & Configuration) Maëva Lellouche & Téa-Gabrielle Guesdon
- **Compte AWS de démonstration :** Learner Lab (région us-east-1)

## Le contexte (cinq lignes)
NovaSphere déploie une application web SaaS moderne de gestion pour ses clients. L'application est servie sur un cluster d'instances déployées dans deux zones de disponibilité et placées derrière un Application Load Balancer (ALB). L'infrastructure est segmentée en deux environnements isolés (`dev` et `prod`) afin d'assurer des tests en toute sécurité avant toute livraison.

## L'extension choisie
[X] Administration sans SSH (Session Manager)

## Ce que l'extension exige en plus du socle
Accès sécurisé aux instances EC2 via AWS Systems Manager Session Manager sans aucun port SSH ouvert sur Internet.

## Ce que l'équipe écarte, et pourquoi
L'équipe écarte l'utilisation d'une NAT Gateway en raison du coût horaire sur le compte Learner Lab ; les instances vivent dans des subnets publics mais sont sécurisées en n'acceptant le trafic que depuis l'ALB.
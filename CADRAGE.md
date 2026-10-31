# Fiche de Cadrage - NovaSphere
Mettre en place une infrastructure cloud AWS sécurisée, modulaire et automatisée.

## Objectif du Projet
NovaSphere déploie une application web SaaS moderne de gestion pour ses clients. L'application est servie sur un cluster d'instances déployées dans deux zones de disponibilité et placées derrière un ALB. L'infrastructure est segmentée en deux environnements isolés (dev et prod) afin d'assurer des tests en toute sécurité. Le socle technique intègre un VPC multi-zones, un groupe de calcul auto-scalé, et un versioning par module Terraform dédié.

## Équipe et Rôles
- **Téa-Gabrieille Guesdon** — Network & VPC
- **Maëva Lellouche** — Compute & Auto Scaling
- **Awatef Boulakhras** — Secrets & Configuration
- **Jemima Bidingenyi Nzadi** — Terraform Module
- **Wafa Enouijah** — CI/CD & Documentation

## Extension Choisie
-[X] Administration sans SSH (Session Manager ou bastion)
- Ce qu'elle exige en plus du socle :* Accès sécurisé aux instances EC2 via AWS Systems Manager Session Manager sans aucun port SSH ouvert.

## Ce que l'équipe écarte, et pourquoi
Écart de la NAT Gateway en raison du coût horaire sur le compte Learner Lab ; subnets publics sécurisés via l'ALB

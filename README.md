# Projet de test d'intégration MCP d'un elasticMS

## Setup

* Installer un elasticMS admin vide
* S'y créer un compte avec les droits admin et API
* Lancer la commande `make start` pour démarrer le client local
* Lancer la commande `make login` pour s'identifier auprès du serveur elasticMS admin avec le compte créé
* Lancer la commande `make restore-configs` pour configurer le serveur elasticMS admin
* Lancer la commande `make emsch-push` pour mettre les contenus locaux à jour (templates, routes et labels)
* Lancer la commande `make restore-documents` pour ajouter les recettes

## Connecter un agent

Il faut d'abord aller récupérer une clé d'identification dans l'interface d'administration d'elasticMS :

* Se connecter avec l'utisateur admin créé
* Aller dans le menu `Gestion des utilisateurs` choisir `Utilisateurs`
* Pour l'utisateur avec lequel on veut tester l'API MPC choisir `Clé API` puis `Générer une clé API pour cet utilisateur ?`
  * A minima, pour cet utilisateur, il faut les roles `Auteur` et `API`
* Un message s'affiche en haut de l'écran avec la nouvelle clé.

### Connecter OepnAI Codex

Ajouter les infomation suivante dans le fichier `vi ~/.codex/config.toml` :

```toml
[mcp_servers.myam]          
url = "https://recipes.theus.be/api/mcp"
enabled = true                          
                                        
[mcp_servers.myam.http_headers]         
Authorization = "Bearer eDpMcRK+5D5ZDm6CHs7qed1L1eW8l4WXiLPYK8mN6p9CM6PnRF2SaksN6trJkCppLD8="
```

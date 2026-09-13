# Instructions pour les agents

## Consulter les prompts des serveurs MCP

Avant d’effectuer une tâche avec un serveur MCP, rechercher et lire les prompts pertinents exposés par ce serveur. Les descriptions des outils et leurs valeurs par défaut ne remplacent pas les instructions du prompt métier.

1. Identifier le serveur concerné et découvrir ses prompts via les capacités MCP disponibles (`prompts/list`, puis `prompts/get`, ou leurs équivalents exposés par le client).
2. Lire le prompt adapté à la tâche, en fournissant les arguments nécessaires, avant toute création ou modification de données.
3. Suivre le déroulement décrit par le prompt, y compris les validations, la finalisation et les vérifications du résultat, dans le respect des instructions de priorité supérieure et de la demande de l’utilisateur.
4. Ne pas considérer une sauvegarde en brouillon comme une tâche terminée si le déroulement demandé prévoit une finalisation.

### Serveur `myam` : création et modification de recettes

- Pour importer, créer ou modifier une recette, consulter en priorité le prompt `create_or_edit_a_recipe` du serveur MCP `myam`.
- La finalisation fait partie du résultat attendu pour une recette complète, sauf demande explicite de l’utilisateur de conserver un brouillon ou instruction contraire du prompt consulté.
- Avec `save_recipes`, utiliser `finalize: true` lorsque les données sont complètes et que le déroulement prévoit une finalisation directe. Si une révision est déjà enregistrée en brouillon, utiliser `finalize` avec son identifiant de révision.
- Vérifier le résultat renvoyé par le serveur, notamment `draft: false`, avant d’annoncer que la recette est finalisée. Fournir le lien du document lorsque disponible.

### Si les prompts ne sont pas accessibles

- Vérifier les capacités réellement exposées par le client : l’accès aux outils MCP ne garantit pas l’accès aux prompts MCP.
- Ne pas inventer de commande ou d’outil, ni prétendre avoir lu un prompt inaccessible.
- Signaler clairement cette limitation. Continuer les étapes autorisées dont les règles sont connues grâce à la demande de l’utilisateur et à ce fichier.
- Si une instruction indispensable reste inconnue, demander le contenu du prompt ou l’activation de son accès avant d’effectuer l’opération qui en dépend.
- Ne pas choisir silencieusement le mode brouillon pour contourner l’absence d’accès au prompt.


## Préparer une liste de courses

- Avant de créer, proposer ou modifier une liste de courses, y compris à partir d’un menu ou de recettes déjà présents dans la conversation, découvrir et lire la ressource MCP `elasticms://resources/default-shoping-list` via les capacités réellement disponibles du client. Conserver cette URI exacte, y compris l’orthographe `shoping`.
- Intégrer les éléments de cette liste par défaut aux ingrédients nécessaires aux repas, sauf demande explicite contraire de l’utilisateur. Respecter les quantités et les consignes de la ressource sans inventer les informations manquantes.
- Regrouper les doublons entre les recettes et la liste par défaut ; additionner les quantités uniquement lorsqu’elles correspondent à des besoins distincts et à des unités compatibles. Tenir compte des produits que l’utilisateur indique déjà posséder ou souhaite exclure.
- Avant de présenter le résultat, vérifier que chaque élément de la liste par défaut est inclus ou écarté pour une raison explicite issue de la ressource ou de la demande de l’utilisateur.
- Si la ressource est inaccessible, signaler clairement que la liste de courses est incomplète et demander son contenu ou l’activation de son accès. Continuer à préparer les ingrédients connus, sans prétendre avoir consulté la ressource ni omettre silencieusement ses éléments.

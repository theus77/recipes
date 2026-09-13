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

########## Locators pour la gestion des groupes ############
# Accès à la page Groupes

# Champs du formulaire de création
input_group_identifier = (
    "id=page_x002e_ctool_x002e_admin-console_x0023_default-create-shortname"
)
input_group_display_name = (
    "id=page_x002e_ctool_x002e_admin-console_x0023_default-create-displayname"
)

# Bouton de validation
btn_create_group = "xpath=//button[normalize-space()='Créer un groupe']"

########## Script ##########

# Crée un groupe Alfresco.
# ${vGroupIdentifier} correspond à l'identifiant du groupe.
# ${vGroupDisplayName} correspond au nom affiché du groupe.
Creer Un Groupe
    [Arguments]    ${vGroupIdentifier}    ${vGroupDisplayName}
    Go To    ${vURL}/share/page/console/admin-console/groups#state=panel%3Dcreate
    # Saisie de l'identifiant du groupe
    Wait Until Element Is Visible    ${input_group_identifier}    ${TIMEOUT}
    Input Text    ${input_group_identifier}    ${vGroupIdentifier}

    # Saisie du nom affiché
    Wait Until Element Is Visible    ${input_group_display_name}    ${TIMEOUT}
    Input Text    ${input_group_display_name}    ${vGroupDisplayName}

    # Création du groupe
    Wait Until Element Is Enabled    ${btn_create_group}    ${TIMEOUT}
    Click Button    ${btn_create_group}

    # Vérification du succès
    Wait Until Page Contains    Succès de la création du nouveau groupe.    ${TIMEOUT}
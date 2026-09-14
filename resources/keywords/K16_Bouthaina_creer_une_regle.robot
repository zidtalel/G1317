## Locators pour creer les regles
# Dossier reglesAlfresco
lnk_rules_folder = "xpath=//a[@rel='|path|/TARGET_FOLDER|']"

# Cellule d’actions
folder_actions_cell = "//a[normalize-space()='FOLDER_NAME']/ancestor::tr//td[contains(@class,'actions')]"

# Bouton « Plus… »
lnk_more_folder_actions = "//a[contains(@class,'show-more')]"

# Lien « Gérer les règles »
lnk_manage_rules = "//a[normalize-space()='Gérer les règles']"
# Lien « Créer des règles » dans la page règles
lnk_create_rules = "//a[normalize-space()='Créer des règles']"

# Champ général « Nom ».
# Le suffixe complet évite de sélectionner un éventuel champ caché
# partageant seulement la partie « default-title » de l'identifiant.
input_rule_title = (
    "id=template_x002e_rule-edit_x002e_rule-edit_x0023_default-title"
)

# Liste déroulante des actions de la règle
sel_rule_action = "//select[@id='alf-id11']"

# Bouton de création
btn_create_rule = (
    "id=template_x002e_rule-edit_x002e_rule-edit_x0023_default-create-button-button"
)

######### Script ##############

# Crée une règle avec uniquement les champs obligatoires.
# ${vRuleTitle} : nom obligatoire de la règle.
# ${vRuleAction} : action obligatoire de la règle.

Creer Une Regle

    [Arguments]    ${vFolderName}    ${vRuleTitle}    ${vRuleAction}

    # Accès à fichiers partagés
    Go To    ${vURL}/share/page/context/shared/sharedfiles

    # Construire le locator dynamique de la cellule d'actions
    ${actions_cell}=    Replace String    ${folder_actions_cell}    FOLDER_NAME    ${vFolderName}

    # Survoler la cellule d’actions
    Wait Until Element Is Visible    ${actions_cell}    ${TIMEOUT}
    Mouse Over    ${actions_cell}
    Sleep    0.3s

    # Cliquer sur « Plus… »
    Wait Until Element Is Visible    ${lnk_more_folder_actions}    ${TIMEOUT}
    Click Element    ${lnk_more_folder_actions}

    # Cliquer sur « Gérer les règles »
    Wait Until Element Is Visible    ${lnk_manage_rules}    ${TIMEOUT}
    Click Element    ${lnk_manage_rules}

    # Cliquer sur « Créer des règles »
    Wait Until Element Is Visible    ${lnk_create_rules}    ${TIMEOUT}
    Click Element    ${lnk_create_rules}

    # Sélectionner l’action (ex: script, copy, move…)
    Wait Until Element Is Visible    ${sel_rule_action}    ${TIMEOUT}
    Select From List By Value    ${sel_rule_action}    ${vRuleAction}

    # La sélection de l’action peut reconstruire le formulaire Alfresco.
    # Remplir le nom après cette reconstruction évite qu’il soit réinitialisé.
    Wait Until Element Is Visible    ${input_rule_title}    ${TIMEOUT}
    Wait Until Element Is Enabled    ${input_rule_title}    ${TIMEOUT}
    Clear Element Text               ${input_rule_title}
    Input Text                       ${input_rule_title}    ${vRuleTitle}
    Press Keys                       ${input_rule_title}    TAB
    Element Attribute Value Should Be    ${input_rule_title}    value    ${vRuleTitle}

    # Créer la règle
    Wait Until Element Is Visible    ${btn_create_rule}    ${TIMEOUT}
    Click Button    ${btn_create_rule}

    # Critère de succès : la règle créée apparaît dans la page.
    Wait Until Page Contains    ${vRuleTitle}    ${TIMEOUT}

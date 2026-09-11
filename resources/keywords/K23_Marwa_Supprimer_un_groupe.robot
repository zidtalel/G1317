
*** Variables ***
# Lien vers le module « Groupes » dans la console d'administration.
${link_Groupes}    xpath=//div[@id='page_x002e_tools_x002e_admin-console_x0023_default-body']//a[normalize-space(.)='Groupes']

# Bouton d'ouverture de l'écran de parcours des groupes.
${btn_ParcourirGroupes}    id=page_x002e_ctool_x002e_admin-console_x0023_default-browse-button-button

# Locators dynamiques du groupe ciblé et de son action de suppression.
${link_Groupe_1}    xpath=//a[contains(@class,'groups-item-group') and .//span[contains(@class,'yui-columnbrowser-item-label') and normalize-space(.)='
${link_Groupe_2}    ']]//span[@title='Supprimer le Groupe']

# Bouton de confirmation affiché dans la boîte de dialogue.
${btn_ConfirmerSuppressionGroupe}    xpath=//div[@role='dialog']//span[@role='button' and normalize-space(.)='Supprimer']

*** Keywords ***
Supprimer un groupe
    [Documentation]    Supprime un groupe existant dans la console d'administration Alfresco.
    ...
    ...    Le keyword ouvre la console d'administration, accède au module « Groupes »,
    ...    ouvre le parcours des groupes, sélectionne le groupe demandé, déclenche
    ...    l'action de suppression et confirme l'opération dans la boîte de dialogue.
    ...
    ...    Arguments :
    ...    - `${vURL}` : URL de base de l'instance Alfresco.
    ...    - `${vNomGroupe}` : nom exact du groupe à supprimer.
    ...
    ...    Exemple :
    ...    | K23_Marwa_Supprimer_un_groupe | http://localhost:8084 | GROUP_Test_A supprimer |
    ...
    ...    Préconditions :
    ...    - L'utilisateur est authentifié.
    ...    - L'utilisateur possède les droits d'administration.
    ...    - Le groupe ciblé existe.
    ...
    ...    Résultat attendu :
    ...    La boîte de dialogue de confirmation est validée et le groupe est supprimé.
    [Arguments]    ${vURL}    ${vNomGroupe}

    # Accède à la console d'administration Alfresco.
    Go To    ${vURL}/share/page/console/admin-console
    Wait Until Element Is Visible    ${link_Groupes}    ${TIMEOUT}

    # Ouvre le module « Groupes ».
    Click Element    ${link_Groupes}
    Wait Until Element Is Visible    ${btn_ParcourirGroupes}    ${TIMEOUT}

    # Affiche la liste permettant de parcourir les groupes existants.
    Click Button    ${btn_ParcourirGroupes}

    # Construit le locator du groupe à partir de son nom exact.
    ${locator_Groupe}=    Set Variable    ${link_Groupe_1}${vNomGroupe}${link_Groupe_2}
    Wait Until Element Is Visible    ${locator_Groupe}    ${TIMEOUT}
    Click Element    ${locator_Groupe}

    # Attend la boîte de dialogue avant de confirmer la suppression.
    Wait Until Element Is Visible    ${btn_ConfirmerSuppressionGroupe}    ${TIMEOUT}
    Click Element    ${btn_ConfirmerSuppressionGroupe}

    # Attend que l'action de suppression soit traitée par Alfresco.
    Wait Until Element Is Not Visible    ${btn_ConfirmerSuppressionGroupe}    ${TIMEOUT}
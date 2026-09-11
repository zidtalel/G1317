
*** Variables ***

# Accès au gestionnaire des modèles depuis la console d'administration.
${lnk_GestionnaireModeles}    xpath=//a[@href='custom-model-manager' and normalize-space(.)='Gestionnaire de modèles']

# Locators dynamiques du modèle et de l'aspect sélectionnés.
${lnk_Modele_1}    xpath=//span[contains(@class,'value') and normalize-space(.)='
${lnk_Modele_2}    ']
${lnk_Aspect_1}    xpath=//span[contains(@class,'value') and normalize-space(.)='
${lnk_Aspect_2}    ']

# Tableau et propriété à supprimer.
${tbl_Proprietes}    id=PROPERTIES_LIST
${lbl_Propriete_1}    xpath=//div[@id='PROPERTIES_LIST']//tr[.//span[contains(@class,'value') and normalize-space(.)='
${lbl_Propriete_2}    ']]

# Menu Actions de la ligne de la propriété.
${btn_ActionsPropriete_1}    xpath=//div[@id='PROPERTIES_LIST']//tr[.//span[contains(@class,'value') and normalize-space(.)='
${btn_ActionsPropriete_2}    ']]//div[contains(@class,'AlfMenuBarPopup') and .//span[normalize-space(.)='Actions']]

# Option Supprimer du menu Actions actuellement visible.
${item_SupprimerPropriete}    xpath=(//td[@role='presentation' and normalize-space(.)='Supprimer' and not(ancestor::div[contains(@class,'dijitHidden')])])[last()]

# Bouton Supprimer de la boîte de confirmation visible.
${btn_ConfirmerSuppressionPropriete}    xpath=(//span[contains(@class,'dijitButton') and @role='presentation' and .//span[contains(@class,'dijitButtonText') and normalize-space(.)='Supprimer'] and not(ancestor::div[contains(@class,'dijitHidden')])])[last()]

*** Keywords ***

Supprimer une propriété
    [Documentation]    Supprime une propriété dans un aspect existant du gestionnaire de modèles Alfresco.
        ...
        ...    Le keyword ouvre le gestionnaire de modèles, sélectionne le modèle et l'aspect
        ...    ciblés, localise la propriété dans le tableau, ouvre son menu Actions,
        ...    sélectionne « Supprimer » et confirme l'opération.
        ...
        ...    Arguments :
        ...    - `${vURL}` : URL de base de l'instance Alfresco.
        ...    - `${vNomModele}` : nom visible du modèle cible.
        ...    - `${vNomAspect}` : nom visible de l'aspect cible.
        ...    - `${vNomPropriete}` : nom visible de la propriété à supprimer.
        ...
        ...    Exemple :
        ...    | K33_Marwa_Supprimer_une_propriete | http://localhost:8084 | Model_Name_Test | Test:aspect_test | Test:test_propriete_marwa |
        ...
        ...    Préconditions : l'utilisateur est authentifié, dispose des droits d'administration,
        ...    et le modèle, l'aspect ainsi que la propriété existent.
        ...
        ...    Attention : la suppression d'une propriété est une opération destructive.
    [Arguments]    ${vURL}    ${vNomModele}    ${vNomAspect}    ${vNomPropriete}

    # Ouvre le gestionnaire de modèles dans la console d'administration.
    Go To    ${vURL}/share/page/console/admin-console/application
    Wait Until Element Is Visible    ${lnk_GestionnaireModeles}    10s
    Click Element    ${lnk_GestionnaireModeles}

    # Sélectionne le modèle cible à partir de son nom visible.
    ${locator_Modele}=    Set Variable    ${lnk_Modele_1}${vNomModele}${lnk_Modele_2}
    Wait Until Element Is Visible    ${locator_Modele}    10s
    Scroll Element Into View    ${locator_Modele}
    Wait Until Element Is Enabled    ${locator_Modele}    10s
    Click Element    ${locator_Modele}

    # Sélectionne l'aspect cible à partir de son nom visible.
    ${locator_Aspect}=    Set Variable    ${lnk_Aspect_1}${vNomAspect}${lnk_Aspect_2}
    Wait Until Element Is Visible    ${locator_Aspect}    10s
    Scroll Element Into View    ${locator_Aspect}
    Wait Until Element Is Enabled    ${locator_Aspect}    10s
    Click Element    ${locator_Aspect}

    # Vérifie que le tableau des propriétés est chargé.
    Wait Until Element Is Visible    ${tbl_Proprietes}    10s

    # Localise la propriété dans le tableau.
    ${locator_Propriete}=    Set Variable    ${lbl_Propriete_1}${vNomPropriete}${lbl_Propriete_2}
    Wait Until Element Is Visible    ${locator_Propriete}    10s

    # Ouvre le menu Actions de la ligne de la propriété.
    ${locator_Actions}=    Set Variable    ${btn_ActionsPropriete_1}${vNomPropriete}${btn_ActionsPropriete_2}
    Wait Until Element Is Visible    ${locator_Actions}    10s
    Scroll Element Into View    ${locator_Actions}
    Wait Until Element Is Enabled    ${locator_Actions}    10s
    Click Element    ${locator_Actions}

    # Sélectionne l'option Supprimer dans le menu visible.
    Wait Until Element Is Visible    ${item_SupprimerPropriete}    10s
    Click Element    ${item_SupprimerPropriete}

    # Confirme la suppression dans la boîte de dialogue.
    Wait Until Element Is Visible    ${btn_ConfirmerSuppressionPropriete}    10s
    Click Element    ${btn_ConfirmerSuppressionPropriete}
    
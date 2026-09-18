*** Variables ***

# Locators

# Locator dynamique du modèle ciblé dans la liste du gestionnaire de modèles.
${lnk_Modele_1}    xpath=//span[contains(@class,'value') and normalize-space(.)='
${lnk_Modele_2}    ']

# Locator dynamique de la ligne de l'aspect ciblé, une fois à l'intérieur du modèle.
${lgn_Aspect_1}    xpath=//span[contains(@class,'value') and normalize-space(.)='
${lgn_Aspect_2}    ']

# Bouton "Actions" de la ligne de l'aspect ciblé.
${btn_ActionsAspect_1}    xpath=//tr[.//span[contains(@class,'value') and normalize-space(.)='
${btn_ActionsAspect_2}    ']]//*[contains(text(),'Actions')]

# Option "Supprimer" du menu Actions actuellement visible.
${item_SupprimerAspect}    xpath=(//td[@role='presentation' and normalize-space(.)='Supprimer' and not(ancestor::div[contains(@class,'dijitHidden')])])[last()]

# Bouton "Supprimer" de la boîte de confirmation (CMM_DELETE_PROPERTYGROUP_DIALOG).
${btn_ConfirmerSuppressionAspect}    xpath=//div[@id='CMM_DELETE_PROPERTYGROUP_DIALOG']//span[contains(@class,'dijitButtonText') and normalize-space(text())='Supprimer']/ancestor::span[@role='button'][1]


*** Keywords ***

Supprimer un aspect
    [Documentation]    Supprime un aspect existant dans un modèle déjà créé du gestionnaire
    ...                de modèles Alfresco Share.
    ...
    ...    = Arguments =
    ...    - `${vNomModele}` : nom visible du modèle contenant l'aspect.
    ...    - `${vNomAspect}` : nom visible de l'aspect à supprimer (ex. `testadil:AspectTestAdil`).
    ...
    ...    = Étapes exécutées =
    ...    1. Ouvre le gestionnaire de modèles dans la console d'administration.
    ...    2. Sélectionne le modèle cible à partir de son nom visible.
    ...    3. Localise la ligne de l'aspect ciblé et ouvre son menu "Actions".
    ...    4. Sélectionne l'option "Supprimer".
    ...    5. Confirme la suppression dans la boîte de dialogue.
    ...    6. Vérifie que l'aspect a disparu de la liste.
    ...
    ...    = Exemple =
    ...    | Supprimer un aspect | ModeleTestAdil | testadil:AspectTestAdil |
    ...
    ...    Préconditions : l'utilisateur est authentifié, dispose des droits d'administration,
    ...    et le modèle ainsi que l'aspect existent déjà.
    ...
    ...    Attention : la suppression d'un aspect est une opération destructive — toutes ses
    ...    propriétés sont supprimées avec lui.

    [Arguments]    ${vNomModele}    ${vNomAspect}

    # 1. Ouvre le gestionnaire de modèles dans la console d'administration
    Go To    ${vURL}/share/page/console/admin-console/custom-model-manager

    # 2. Sélectionne le modèle cible à partir de son nom visible
    ${locator_Modele}=    Set Variable    ${lnk_Modele_1}${vNomModele}${lnk_Modele_2}
    Wait Until Element Is Visible    ${locator_Modele}    10s
    Click Element    ${locator_Modele}

    # 3. Localise l'aspect et ouvre son menu "Actions"
    ${locator_Aspect}=    Set Variable    ${lgn_Aspect_1}${vNomAspect}${lgn_Aspect_2}
    Wait Until Element Is Visible    ${locator_Aspect}    10s

    ${locator_Actions}=    Set Variable    ${btn_ActionsAspect_1}${vNomAspect}${btn_ActionsAspect_2}
    Wait Until Element Is Visible    ${locator_Actions}    10s
    Click Element    ${locator_Actions}

    # 4. Sélectionne l'option "Supprimer" dans le menu visible
    Wait Until Element Is Visible    ${item_SupprimerAspect}    10s
    Click Element    ${item_SupprimerAspect}

    # 5. Confirme la suppression dans la boîte de dialogue
    Wait Until Element Is Visible    ${btn_ConfirmerSuppressionAspect}    10s
    Click Element    ${btn_ConfirmerSuppressionAspect}

    # 6. Vérifie que l'aspect a disparu de la liste
    Wait Until Page Does Not Contain Element    ${locator_Aspect}    15s

*** Settings ***
Documentation     Keyword K02 de creation d'un aspect dans un modele.
Library           SeleniumLibrary
Variables         ../locators/alfresco_locators.py
Variables         ../variables/global_variables.py
Resource          ./Login_Logout.robot

*** Keywords ***
Créer un aspect dans un modèle
    [Arguments]    ${vNom_Modele}    ${vNom_Aspect}    ${vTitre_Aspect}    ${vDescription_Aspect}
    # 1. Navigation vers le gestionnaire de modèles personnalisés
    Go To    ${vAdminURL}/custom-model-manager
    # 2. Sélection du modèle cible dans la liste
    Wait Until Element Is Visible    ${link_Modele1}${vNom_Modele}${link_Modele2}    10s
    Click Element    ${link_Modele1}${vNom_Modele}${link_Modele2}
    # 3. Ouverture du formulaire de création d'aspect    
    Wait Until Element Is Visible    ${btn_Modele_Creer_Aspect}    10s
    Click Element    ${btn_Modele_Creer_Aspect}
    # 4. Renseignement des champs (Nom, Titre, Description)
    Wait Until Element Is Visible    ${txt_Aspect_Nom}    10s
    Input Text    ${txt_Aspect_Nom}    ${vNom_Aspect}
    Input Text    ${txt_Aspect_Titre}    ${vTitre_Aspect}
    Input Text    ${txt_Aspect_Description}    ${vDescription_Aspect}
    # 5. Validation et enregistrement de l'aspect
    Wait Until Element Is Visible    ${btn_Aspect_Enregistrer}    10s
    Click Element    ${btn_Aspect_Enregistrer}


# --- Locateurs pour le module de création d'aspect ---
link_Modele1=             " //td[contains(@class,'nameColumn')]//span[normalize-space(.)='"
link_Modele2=               " ']"
btn_Modele_Creer_Aspect=    " xpath=//*[normalize-space(.)='Create Aspect' or normalize-space(.)='Créer un aspect']"
txt_Aspect_Name=              "name=name"
txt_Aspect_Display_Label=     "name=title"
txt_Aspect_Description=       "xpath=(//textarea)[last()]"
btn_Aspect_Create=           "xpath=//*[normalize-space(.)='Create' or normalize-space(.)='Créer']"


*** Keywords ***
Créer un aspect dans un modèle
    [Documentation]     Crée un aspect dans le gestionnaire de modèles personnalisés.
    ...                 
    ...                 = Arguments =
    ...                 - `${vNom_Modele}` : Nom exact du modèle où l'aspect doit être créé.
    ...                 - `${vNom_Aspect}` : Nom (Name) de l'aspect.
    ...                 - `${txt_Aspect_Dslpy_Label}` : Libellé d'affichage (Display Label) de l'aspect.
    ...                 - `${vDescription_Aspect}` : Description de l'aspect.
    ...                 
    ...                 = Étapes exécutées =
    ...                 1. Navigation vers le gestionnaire de modèles personnalisés.
    ...                 2. Sélection du modèle cible dans la liste.
    ...                 3. Ouverture du formulaire de création d'aspect.
    ...                 4. Renseignement des champs (Name, Display Label, Description).
    ...                 5. Validation et enregistrement de l'aspect.
    
    [Arguments]    ${vNom_Modele}    ${vNom_Aspect}    ${txt_Aspect_Dslpy_Label}    ${vDescription_Aspect}
    
    # 1. Navigation vers le gestionnaire de modèles personnalisés
    Go To    ${vK02ModelManagerURL}
    
    # 2. Sélection du modèle cible dans la liste
    Wait Until Element Is Visible    ${link_Modele1}${vNom_Modele}${link_Modele2}    ${vK02Timeout}
    Click Element    ${link_Modele1}${vNom_Modele}${link_Modele2}
    
    # 3. Ouverture du formulaire de création d'aspect
    Wait Until Element Is Visible    ${btn_Modele_Creer_Aspect}    ${vK02Timeout}
    Click Element    ${btn_Modele_Creer_Aspect}
    
    # 4. Renseignement des champs (Name, Display Label, Description)
    Wait Until Element Is Visible    ${txt_Aspect_Name}    ${vK02Timeout}
    Input Text    ${txt_Aspect_Name}             ${vNom_Aspect}
    Input Text    ${txt_Aspect_Display_Label}    ${txt_Aspect_Dslpy_Label}
    Input Text    ${txt_Aspect_Description}      ${vDescription_Aspect}
    
    # 5. Validation et enregistrement de l'aspect
    Wait Until Element Is Visible    ${btn_Aspect_Create}    ${vK02Timeout}
    Click Element    ${btn_Aspect_Create}
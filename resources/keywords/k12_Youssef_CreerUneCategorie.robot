
# --- Locateurs pour le module de création de catégorie ---
link_Categorie_Root=        " xpath=//*[normalize-space(.)='Category Root']"
btn_Category_Add=           "xpath=//span[@id='ygtvlabelel1']/span"
txt_Category_Name=            "xpath=//input[@id='alf-id1']"
btn_Category_OK=              "xpath=//*[normalize-space(.)='OK']"


*** Keywords ***
Créer une catégorie
    [Documentation]     Crée une catégorie dans le gestionnaire de catégories d'Alfresco.
    ...                 
    ...                 = Arguments =
    ...                 - `${vCategory_Name}` : Nom de la catégorie à créer.
    ...                 
    ...                 = Étapes exécutées =
    ...                 1. Navigation vers le gestionnaire de catégories.
    ...                 2. Attente du chargement de l'élément racine et survol.
    ...                 3. Clic sur le bouton d'ajout de catégorie.
    ...                 4. Renseignement du nom de la catégorie dans lw champ de saisie.
    ...                 5. Validation et enregistrement de la catégorie.
    [Arguments]     ${vCategory_Name}
    
    #  # 1. Navigation vers le gestionnaire de catégories
    Go To    ${vK12AdminURL}/category-manager
    
    # 2. Attente du chargement de l'élément racine
    Wait Until Element Is Visible    ${link_Categorie_Root}    ${vK12Timeout}
    
    # Survol optionnel pour afficher les actions contextuelles (si nécessaire)
    Mouse Over    ${link_Categorie_Root}
    
    # 3. Clic sur le bouton d'ajout (le "+" ou l'icône associée)
    Wait Until Element Is Visible    ${btn_Category_Add}    ${vK12Timeout}
    Scroll Element Into View    ${btn_Category_Add}
    Click Element    ${btn_Category_Add}
    
    # 4. Renseignement du nom de la catégorie dans la modale
    Wait Until Element Is Visible    ${txt_Category_Name}    ${vK12Timeout}
    Input Text    ${txt_Category_Name}    ${vCategory_Name}
    
    # 5. Validation et enregistrement de la catégorie
    Wait Until Element Is Visible    ${btn_Category_OK}    ${vK12Timeout}
    Click Element    ${btn_Category_OK}


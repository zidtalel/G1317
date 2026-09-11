
*** Variables ***

# ++++++++++++++++++++++++++++Locators+++++++++++++++++++++++++++++++++++++++++

# Bouton permettant d'ouvrir le menu de création de contenu.
${btn_CreerContenu}    id=template_x002e_documentlist_v2_x002e_myfiles_x0023_default-createContent-button-button

# Option du menu permettant de créer un fichier texte.
${link_CreerFichierTexte}    //span[contains(@class,'text-file')]

# Champs du formulaire de création.
${txt_NomFichier}           name=prop_cm_name
${txt_TitreFichier}         name=prop_cm_title
${txt_DescriptionFichier}   name=prop_cm_description
${txt_ContenuFichier}       name=prop_cm_content

# Bouton de validation du formulaire.
${btn_CreerFichier}    id=template_x002e_create-content_x002e_create-content_x0023_default-form-submit-button

# Locator de vérification du fichier créé.
${fichier_Cree}    //a[normalize-space()='${vNomFichier}']

*** Keywords ***

Créer un fichier texte

    [Documentation]    Crée un fichier texte dans le site « Fichiers partagés » d'Alfresco.
    ...
    ...    Le keyword ouvre la page des fichiers partagés, sélectionne l'action
    ...    « Fichier texte », renseigne les propriétés du fichier puis valide sa création.
    ...
    ...    Arguments :
    ...    - `${vNomFichier}` : nom du fichier, avec ou sans extension `.txt` selon la configuration Alfresco.
    ...    - `${vTitre}` : titre affiché ou enregistré dans les propriétés du document.
    ...    - `${vDescription}` : description du fichier. Une chaîne vide est acceptée.
    ...    - `${vContenu}` : contenu textuel à enregistrer dans le fichier.
    ...
    ...    Exemple :
    ...    | K3_Marwa_creer_un_fichier_text | README.txt | Guide de démarrage | Documentation du projet | Bienvenue dans le projet Alfresco. |
    ...
    ...    Notes :
    ...    - Les champs sont remplis après vérification de leur visibilité.
    ...    - Le keyword attend ensuite que le fichier apparaisse dans la liste.
    ...    - Le locator de confirmation utilise le nom du fichier fourni.


    [Arguments]    ${vNomFichier}    ${vTitre}    ${vDescription}    ${vContenu}
    
    # Accède à la bibliothèque de documents partagés.
    Go To    ${vURL}/share/page/context/shared/sharedfiles
    Wait Until Page Contains Element    ${btn_CreerContenu}    10s

    # Ouvre le menu de création et choisit l'option « Fichier texte ».
    Click Element    ${btn_CreerContenu}
    Wait Until Element Is Visible    ${link_CreerFichierTexte}    10s
    Click Element    ${link_CreerFichierTexte}

    # Attend l'ouverture du formulaire avant de renseigner les propriétés.
    Wait Until Element Is Visible    ${txt_NomFichier}    10s
    Input Text    ${txt_NomFichier}    ${vNomFichier}
    Input Text    ${txt_TitreFichier}    ${vTitre}
    Input Text    ${txt_DescriptionFichier}    ${vDescription}
    Input Text    ${txt_ContenuFichier}    ${vContenu}

    # Soumet le formulaire de création.
    Click Element    ${btn_CreerFichier}

    # Vérifie que le fichier créé est visible dans la liste des documents.
    Wait Until Element Is Visible    ${fichier_Cree}    10s
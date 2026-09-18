*** Variables ***

# Locators

# Bouton "Créer..." de la barre d'outils de "Mes fichiers".
${btn_CreerContenu}    id=template_x002e_documentlist_v2_x002e_myfiles_x0023_default-createContent-button-button

# Option "HTML..." du menu déroulant "Créer...".
${link_CreerFichierHTML}    //span[contains(@class,'html-file')]

# Champs du formulaire de création (page complète "Créer un contenu Web").
${txt_NomFichier}           name=prop_cm_name
${txt_TitreFichier}         name=prop_cm_title
${txt_DescriptionFichier}   name=prop_cm_description

# Id de l'éditeur riche (TinyMCE) utilisé pour le contenu HTML.
${id_EditeurContenu}    template_x002e_create-content_x002e_create-content_x0023_default_prop_cm_content

# Bouton de validation du formulaire.
${btn_CreerFichier}    id=template_x002e_create-content_x002e_create-content_x0023_default-form-submit-button


*** Keywords ***

Créer un fichier HTML
    [Documentation]    Crée un nouveau fichier HTML dans "Mes fichiers" d'Alfresco Share.
    ...
    ...    = Arguments =
    ...    - `${vNomFichier}` : nom du fichier, avec l'extension `.html`.
    ...    - `${vTitre}` : titre du fichier.
    ...    - `${vDescription}` : description du fichier. Une chaîne vide est acceptée.
    ...    - `${vContenu}` : contenu HTML à enregistrer (ex. `<p>Bonjour</p>`).
    ...
    ...    = Étapes exécutées =
    ...    1. Navigue vers "Mes fichiers".
    ...    2. Attend que le bouton "Créer..." soit actif puis ouvre son menu.
    ...    3. Sélectionne l'option "HTML..." (ouvre la page de création de contenu).
    ...    4. Renseigne les propriétés du fichier (nom, titre, description).
    ...    5. Renseigne le contenu dans l'éditeur riche (TinyMCE) via JavaScript,
    ...       car ce champ est un `<textarea>` masqué remplacé par un iframe WYSIWYG :
    ...       une saisie clavier classique n'est pas synchronisée avec le formulaire.
    ...    6. Valide la création du fichier.
    ...    7. Vérifie la redirection vers la page de détails du document créé.
    ...
    ...    = Exemple =
    ...    | Créer un fichier HTML | Rapport.html | Rapport annuel | Rapport 2026 | <p>Contenu</p> |
    ...
    ...    Notes :
    ...    - Après validation, Alfresco Share redirige automatiquement vers la page
    ...      "Détails du document" du fichier créé (contrairement à d'autres créations
    ...      de contenu qui restent sur la liste).

    [Arguments]    ${vNomFichier}    ${vTitre}    ${vDescription}    ${vContenu}

    # 1. Navigation vers "Mes fichiers"
    Go To    ${vURL}/share/page/context/mine/myfiles

    # 2. Attente de l'activation du bouton "Créer..." et ouverture du menu
    Wait Until Element Is Enabled    ${btn_CreerContenu}    15s
    Click Element    ${btn_CreerContenu}

    # 3. Sélection de l'option "HTML..."
    Wait Until Element Is Visible    ${link_CreerFichierHTML}    10s
    Click Element    ${link_CreerFichierHTML}

    # 4. Renseignement des propriétés du fichier
    Wait Until Element Is Visible    ${txt_NomFichier}    10s
    Input Text    ${txt_NomFichier}    ${vNomFichier}
    Input Text    ${txt_TitreFichier}    ${vTitre}
    Input Text    ${txt_DescriptionFichier}    ${vDescription}

    # 5. Renseignement du contenu HTML dans l'éditeur TinyMCE via JavaScript
    Execute Javascript
    ...    tinyMCE.get('${id_EditeurContenu}').setContent('${vContenu}'); tinyMCE.triggerSave();

    # 6. Validation de la création du fichier
    Click Element    ${btn_CreerFichier}

    # 7. Vérification de la redirection vers la page de détails du document
    Wait Until Location Contains    document-details    10s
    Wait Until Page Contains    ${vNomFichier}    10s

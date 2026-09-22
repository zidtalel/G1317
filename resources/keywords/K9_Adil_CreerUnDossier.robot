*** Variables ***

# Locators

# Bouton "Créer..." de la barre d'outils de "Fichiers partagés".
${btn_CreerContenu}    id=template_x002e_documentlist_v2_x002e_sharedfiles_x0023_default-createContent-button-button

# Option "Dossier" du menu déroulant "Créer...".
${link_CreerDossier}    //span[contains(@class,'folder-file')]

# Champs du formulaire de création du dossier (popup "Créer un dossier").
${txt_NomDossier}           id=template_x002e_documentlist_v2_x002e_sharedfiles_x0023_default-createFolder_prop_cm_name
${txt_TitreDossier}         id=template_x002e_documentlist_v2_x002e_sharedfiles_x0023_default-createFolder_prop_cm_title
${txt_DescriptionDossier}   id=template_x002e_documentlist_v2_x002e_sharedfiles_x0023_default-createFolder_prop_cm_description

# Bouton "Enregistrer" du formulaire de création.
${btn_ValiderCreationDossier}    id=template_x002e_documentlist_v2_x002e_sharedfiles_x0023_default-createFolder-form-submit-button

# Locator de vérification du dossier créé (basé sur le nom fourni).
${lien_DossierCree1}    //a[normalize-space()='
${lien_DossierCree2}    ']


*** Keywords ***

Créer un dossier
    [Documentation]    Crée un nouveau dossier dans "Fichiers partagés" d'Alfresco Share.
    ...
    ...    = Arguments =
    ...    - `${vNomDossier}` : Nom du dossier à créer.
    ...    - `${vTitre}` : Titre du dossier (peut être identique au nom).
    ...    - `${vDescription}` : Description du dossier. Une chaîne vide est acceptée.
    ...
    ...    = Étapes exécutées =
    ...    1. Navigue vers "Fichiers partagés".
    ...    2. Attend que le bouton "Créer..." soit actif puis ouvre son menu.
    ...    3. Sélectionne l'option "Dossier".
    ...    4. Renseigne les propriétés du dossier (nom, titre, description).
    ...    5. Valide la création du dossier ("Enregistrer").
    ...    6. Vérifie que le dossier créé apparaît dans la liste.
    ...
    ...    = Exemple =
    ...    | Créer un dossier | Rapport_2026 | Rapport annuel | Dossier contenant les rapports 2026 |
    ...
    ...    Notes :
    ...    - Le bouton "Créer..." reste désactivé le temps que le composant JS s'initialise ;
    ...      on attend donc qu'il soit "Enabled" avant de cliquer, pas seulement visible.
    ...    - Le locator de confirmation utilise le nom du dossier fourni.

    [Arguments]    ${vNomDossier}    ${vTitre}    ${vDescription}

    # 1. Navigation vers "Fichiers partagés"
    Go To    ${vURL}/share/page/context/shared/sharedfiles

    # 2. Attente de l'activation du bouton "Créer..." et ouverture du menu
    Wait Until Element Is Enabled    ${btn_CreerContenu}    15s
    Click Element    ${btn_CreerContenu}

    # 3. Sélection de l'option "Dossier"
    Wait Until Element Is Visible    ${link_CreerDossier}    10s
    Click Element    ${link_CreerDossier}

    # 4. Renseignement des propriétés du dossier
    Wait Until Element Is Visible    ${txt_NomDossier}    10s
    Input Text    ${txt_NomDossier}    ${vNomDossier}
    Input Text    ${txt_TitreDossier}    ${vTitre}
    Input Text    ${txt_DescriptionDossier}    ${vDescription}

    # 5. Validation de la création du dossier
    Click Element    ${btn_ValiderCreationDossier}

    # 6. Vérification que le dossier créé apparaît dans la liste
    # Le rafraîchissement de la liste après soumission peut prendre plus de 10s.
    Wait Until Element Is Visible    ${lien_DossierCree1}${vNomDossier}${lien_DossierCree2}    20s

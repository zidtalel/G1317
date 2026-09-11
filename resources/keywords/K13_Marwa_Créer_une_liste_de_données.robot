
*** Variables ***

# Bouton d'accès à la création d'une nouvelle liste.
${btn_NouvelleListe}          id=template_x002e_datalists_x002e_data-lists_x0023_default-newListButton-button

# Conteneur affichant les types de listes disponibles.
${container_TypesListe}       xpath=//div[@id='template_x002e_datalists_x002e_data-lists_x0023_default-newList-itemTypesContainer']

# Locators dynamiques permettant de sélectionner un type de liste par son libellé.
${link_TypeListe_1}           xpath=//div[@id='template_x002e_datalists_x002e_data-lists_x0023_default-newList-itemTypesContainer']//a[normalize-space(.)='
${link_TypeListe_2}           ']

# Champs du formulaire de création.
${txt_TitreListe}             id=template_x002e_datalists_x002e_data-lists_x0023_default-newList_prop_cm_title
${txt_DescriptionListe}       id=template_x002e_datalists_x002e_data-lists_x0023_default-newList_prop_cm_description
${btn_EnregistrerListe}       id=template_x002e_datalists_x002e_data-lists_x0023_default-newList-form-submit-button

*** Keywords ***

Créer une liste de contacts
    [Documentation]    Crée une liste de données dans un site Alfresco existant.
    ...
    ...    Le keyword accède au module « Listes de données », ouvre le formulaire
    ...    de création, sélectionne un type de liste, renseigne son titre et sa
    ...    description, puis enregistre la liste.
    ...
    ...    Arguments :
    ...    - `${vURL}` : adresse de base de l'instance Alfresco.
    ...    - `${vNomSite}` : identifiant technique du site existant.
    ...    - `${vTypeListe}` : libellé exact du type de liste à sélectionner.
    ...    - `${vTitre}` : titre de la liste.
    ...    - `${vDescription}` : description de la liste. Une valeur vide est acceptée.
    ...
    ...    Exemple :
    ...    | K13_Marwa_Créer_une_liste_de_données | ${vURL} | testsite2 | Liste de contacts | Contacts de l'entreprise | Liste des contacts professionnels |
    ...
    ...    Préconditions :
    ...    - L'utilisateur est authentifié dans Alfresco.
    ...    - Le site `${vNomSite}` existe.
    ...    - L'utilisateur possède les droits de création dans le site.
    ...
    ...    Résultat attendu :
    ...    La liste est enregistrée et apparaît dans le module « Listes de données ».
    [Arguments]    ${vURL}    ${vNomSite}    ${vTypeListe}    ${vTitre}    ${vDescription}

    # Accède au module « Listes de données » du site cible.
    Go To    ${vURL}/share/page/site/${vNomSite}/data-lists
    Wait Until Element Is Visible    ${btn_NouvelleListe}    ${TIMEOUT}

    # Ouvre la fenêtre de sélection du type de liste.
    Click Element    ${btn_NouvelleListe}
    Wait Until Element Is Visible    ${container_TypesListe}    ${TIMEOUT}

    # Sélectionne le type demandé à partir de son libellé visible.
        ####### Types de Listes possibles ############
            #Agenda d'événement
            #Carnet d'adresses
            #Liste d'événements
            #Liste de contacts
            #Liste de publications
            #Liste de tâches
            #Liste de tâches (avancées)
            #Liste de tâches (simples)
            #Ordre du jour
    ${locator_TypeListe}=    Set Variable    ${link_TypeListe_1}${vTypeListe}${link_TypeListe_2}
    Wait Until Element Is Visible    ${locator_TypeListe}    ${TIMEOUT}
    Click Element    ${locator_TypeListe}

    # Attend le formulaire puis renseigne ses propriétés.
    Wait Until Element Is Visible    ${txt_TitreListe}    ${TIMEOUT}
    Input Text    ${txt_TitreListe}    ${vTitre}
    Input Text    ${txt_DescriptionListe}    ${vDescription}

    # Enregistre la liste de données.
    Click Button    ${btn_EnregistrerListe}


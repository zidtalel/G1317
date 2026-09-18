*** Variables ***

# Locators

# Bouton "Créer un nouveau filtre" du gestionnaire de recherche.
${btn_CreerNouveauFiltre}    xpath=//span[contains(@class,'dijitButtonText') and normalize-space(text())='Créer un nouveau filtre']/ancestor::span[@role='button'][1]

# Champs obligatoires du formulaire de création (les autres champs conservent
# leurs valeurs par défaut : propriété "Site", type "Filtre simple", tri "A-Z").
${txt_IdFiltre}    name=filterID
${txt_NomFiltre}   name=displayName

# Bouton "Enregistrer" du formulaire.
${btn_EnregistrerFiltre}    xpath=//span[contains(@class,'dijitButtonText') and normalize-space(text())='Enregistrer']/ancestor::span[@role='button'][1]

# Locator de vérification du filtre créé dans le tableau (basé sur son ID).
${lgn_FiltreCree_1}    xpath=//div[@id='SEARCH_CONFIG_FACET_LIST_VIEW']//tr[.//span[(@class='value' or contains(@class,'inlineEditValue')) and normalize-space(.)='
${lgn_FiltreCree_2}    ']]


*** Keywords ***

Créer un nouveau filtre
    [Documentation]    Crée un nouveau filtre de recherche dans le gestionnaire de recherche
    ...                d'Alfresco Share (Outils admin > Gestionnaire de recherche).
    ...
    ...    = Arguments =
    ...    - `${vIdFiltre}` : identifiant unique du filtre (ex. `filtre_test`).
    ...    - `${vNomFiltre}` : nom affiché du filtre.
    ...
    ...    = Étapes exécutées =
    ...    1. Navigue vers le gestionnaire de recherche (configuration des filtres).
    ...    2. Ouvre la boîte de dialogue "Créer un nouveau filtre".
    ...    3. Renseigne l'ID et le nom du filtre (les autres champs gardent leurs
    ...       valeurs par défaut : propriété "Site", type "Filtre simple", tri "A-Z").
    ...    4. Valide la création du filtre ("Enregistrer").
    ...    5. Vérifie que le filtre créé apparaît dans le tableau.
    ...
    ...    = Exemple =
    ...    | Créer un nouveau filtre | filtre_test_adil | Filtre Test Adil |
    ...
    ...    Préconditions : l'utilisateur est authentifié et dispose des droits d'administration.

    [Arguments]    ${vIdFiltre}    ${vNomFiltre}

    # 1. Navigation vers le gestionnaire de recherche
    Go To    ${vURL}/share/page/dp/ws/faceted-search-config

    # 2. Ouverture de la boîte de dialogue "Créer un nouveau filtre"
    Wait Until Element Is Visible    ${btn_CreerNouveauFiltre}    10s
    Click Element    ${btn_CreerNouveauFiltre}

    # 3. Renseignement de l'ID et du nom du filtre
    Wait Until Element Is Visible    ${txt_IdFiltre}    10s
    Input Text    ${txt_IdFiltre}    ${vIdFiltre}
    Input Text    ${txt_NomFiltre}    ${vNomFiltre}

    # 4. Validation de la création du filtre
    Click Element    ${btn_EnregistrerFiltre}

    # 5. Vérification que le filtre créé apparaît dans le tableau
    Wait Until Element Is Visible    ${lgn_FiltreCree_1}${vIdFiltre}${lgn_FiltreCree_2}    15s

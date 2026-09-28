
*** Variables ***

# Bouton « Nouvelle liste » (panneau de gauche de la page « Listes de données »).
btn_NouvelleListe = "id=template_x002e_datalists_x002e_data-lists_x0023_default-newListButton-button"

# Conteneur des types de listes proposés dans la boîte « Nouvelle liste ».
container_TypesListe = "xpath=//div[@id='template_x002e_datalists_x002e_data-lists_x0023_default-newList-itemTypesContainer']"

# Type de liste, choisi par son libellé visible (ex. « Ordre du jour ») -> découpé en 2 morceaux.
link_TypeListe_1 = "xpath=//div[@id='template_x002e_datalists_x002e_data-lists_x0023_default-newList-itemTypesContainer']//a[normalize-space(.)=\""
link_TypeListe_2 = "\"]"

# Champs et bouton « Enregistrer » du formulaire « Nouvelle liste » (ID, pas name).
txt_TitreListe = "id=template_x002e_datalists_x002e_data-lists_x0023_default-newList_prop_cm_title"
txt_DescriptionListe = "id=template_x002e_datalists_x002e_data-lists_x0023_default-newList_prop_cm_description"
btn_EnregistrerListe = "id=template_x002e_datalists_x002e_data-lists_x0023_default-newList-form-submit-button"

# Masque gris de la boîte « Nouvelle liste » (id relevé dans l'erreur du 1er run réel).
# Il est affiché tant que la boîte est ouverte. ATTENTION : sur un site SANS aucune liste,
# Alfresco ouvre la boîte AUTOMATIQUEMENT à l'arrivée sur « Listes de données » : le masque
# couvre alors le bouton « Nouvelle liste » (clic intercepté).
mask_DialogueNouvelleListe = "id=template_x002e_datalists_x002e_data-lists_x0023_default-newList-dialog_mask"
########## Navigation : lien d'une liste de données (panneau « Listes ») ############
# DOM : <a class="filter-link" title="<description>" href="data-lists?list=<uuid>">
#          <span class="delete" .../><span class="edit" .../>liste_ODJ_test</a>
# Les 2 <span> sont vides : normalize-space(.) du lien = nom exact de la liste.
# Sert à vérifier la création de la liste (précondition) ET à l'ouvrir (étape de navigation).
lien_ListeDonnees_1 = "xpath=//a[contains(@class,'filter-link') and normalize-space(.)='"
lien_ListeDonnees_2 = "']"

*** Keywords ***

Créer une liste de contacts

    [Documentation]    Crée une liste de données dans un site existant.
    ...    Reprend le keyword K13 (Marwa), adapté au contexte : locators déplacés dans
    ...    locators.py, URL construite comme les autres keywords, garde-fou sur le type et
    ...    vérification de la présence de la liste dans le panneau « Listes ».
    ...
    ...    = Arguments =
    ...    - `${vURL}` : adresse de l'application (se termine par `/share/page/`).
    ...    - `${vNomSite}` : identifiant technique (shortName) du site.
    ...    - `${vTypeListe}` : libellé exact du type (ex. `Ordre du jour`).
    ...    - `${vTitre}` : titre de la liste (= nom affiché dans le panneau « Listes »).
    ...    - `${vDescription}` : description de la liste. Une chaîne vide est acceptée.
    ...
    ...    = Étapes exécutées =
    ...    1. Go To sur « Listes de données » du site.
    ...    2. Clic sur « Nouvelle liste » (sauf si Alfresco a déjà ouvert la boîte tout seul,
    ...       cas d'un site sans aucune liste), puis sur le type demandé.
    ...    3. Saisie du titre et de la description, clic sur « Enregistrer ».
    ...    4. Vérifie que la liste apparaît dans le panneau « Listes ».
    ...
    ...    = Exemple =
    ...    | Créer une liste de données | ${vURL} | ${vNomSiteCourt} | Ordre du jour | Liste_ODJ | Ordres du jour |
    [Arguments]    ${vURL}    ${vNomSite}    ${vTypeListe}    ${vTitre}    ${vDescription}

    # Garde-fou « champ de type liste » : libellés des types proposés par Alfresco (FR).
    ${vTypesAutorises}=    Create List    Agenda d'événement    Carnet d'adresses    Liste d'événements
    ...    Liste de contacts    Liste de publications    Liste de tâches    Liste de tâches (avancées)
    ...    Liste de tâches (simples)    Ordre du jour
    IF    $vTypeListe not in $vTypesAutorises
        Fail    Type de liste inconnu : "${vTypeListe}". Valeurs attendues : ${vTypesAutorises}.
    END

    # 1. Module « Listes de données » du site (le bouton « Nouvelle liste » existe = page chargée).
    Go To    ${vURL}site/${vNomSite}/data-lists
    Wait Until Page Contains Element    ${btn_NouvelleListe}    15s

    # 2. Boîte « Nouvelle liste ».
    #    Constaté au 1er run réel : sur un site qui n'a ENCORE AUCUNE liste (notre cas, site créé
    #    en précondition), Alfresco ouvre la boîte tout seul ; son masque couvre alors le bouton
    #    « Nouvelle liste » et un clic échoue (ElementClickInterceptedException).
    #    -> on regarde d'abord si la boîte est déjà ouverte ; sinon on clique sur le bouton.
    ${vBoiteDejaOuverte}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${container_TypesListe}    5s
    IF    not ${vBoiteDejaOuverte}
        Wait Until Element Is Enabled    ${btn_NouvelleListe}    15s
        # Clic toléré : si la boîte s'ouvre toute seule juste après les 5 s, le clic est
        # intercepté par son masque, ce qui n'est pas grave (la boîte est ouverte).
        Run Keyword And Ignore Error    Click Element    ${btn_NouvelleListe}
    END
    Wait Until Element Is Visible    ${container_TypesListe}    10s

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
    Wait Until Element Is Visible    ${locator_TypeListe}    10s
    Click Element    ${locator_TypeListe}

    # 3. Propriétés de la liste, puis enregistrement.
    Wait Until Element Is Visible    ${txt_TitreListe}    10s
    Input Text    ${txt_TitreListe}    ${vTitre}
    Input Text    ${txt_DescriptionListe}    ${vDescription}
    Wait Until Element Is Enabled    ${btn_EnregistrerListe}    10s
    Click Element    ${btn_EnregistrerListe}
    # La boîte se ferme (masque masqué) une fois la liste enregistrée par le serveur.
    Wait Until Element Is Not Visible    ${mask_DialogueNouvelleListe}    15s

    # 4. Pas de message de succès : la preuve est la présence de la liste dans le panneau « Listes ».
    ${locator_Liste}=    Set Variable    ${lien_ListeDonnees_1}${vTitre}${lien_ListeDonnees_2}
    Wait Until Element Is Visible    ${locator_Liste}    15s
    ...    error=La liste '${vTitre}' n'apparaît pas dans le panneau « Listes » après sa création.

  
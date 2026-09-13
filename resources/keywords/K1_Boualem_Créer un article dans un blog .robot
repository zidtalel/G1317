#Créer un article dans un blog (dans un site déjà créé)

lbl_BlogArticle_TitrePage = "css:.page-form-header h1"
txt_BlogArticle_Titre = "id:template_x002e_postedit_x002e_blog-postedit_x0023_default-title"
iframe_BlogArticle_Texte = "id:template_x002e_postedit_x002e_blog-postedit_x0023_default-content_ifr"
txt_BlogArticle_TexteEditable = "css:body"
txtarea_BlogArticle_Texte = "id:template_x002e_postedit_x002e_blog-postedit_x0023_default-content"
txt_BlogArticle_Tag = "id:template_x002e_postedit_x002e_blog-postedit_x0023_default-tag-input-field"
btn_BlogArticle_AjouterTag = "id:template_x002e_postedit_x002e_blog-postedit_x0023_default-add-tag-button-button"
link_BlogArticle_TagsPopulaires = "id:template_x002e_postedit_x002e_blog-postedit_x0023_default-load-popular-tags-link"
list_BlogArticle_TagsCourants = "id:template_x002e_postedit_x002e_blog-postedit_x0023_default-current-tags"
btn_BlogArticle_EnregistrerBrouillon = "id:template_x002e_postedit_x002e_blog-postedit_x0023_default-save-button-button"
btn_BlogArticle_PublierInterne = "id:template_x002e_postedit_x002e_blog-postedit_x0023_default-publish-button-button"
btn_BlogArticle_Annuler = "id:template_x002e_postedit_x002e_blog-postedit_x0023_default-cancel-button-button"





creer un article sur le blog

     
    [Documentation]    Crée un article dans le blog d'un site Alfresco existant.
    ...    
    ...    = Arguments =
    ...    - `${vSite}` : Nom technique du site Alfresco.
    ...    - `${vTitre}` : Titre de l'article.
    ...    - `${vTexte}` : Contenu de l'article.
    ...    - `@{vTags}` : Liste des tags à associer à l'article.
    ...    - `${vAction}` : Action finale : `brouillon` ou `publier`.
    ...    
    ...    = Exemple =
    ...    | creer un article sur le blog | projet-alpha | Lancement du Projet | Bienvenue sur le projet. | Tag1 | Tag2 | publier |
    [Arguments]    ${vSite}    ${vTitre}    ${vTexte}    @{vTags}    ${vAction}

    # 1. Redirection vers la page de création d'article
    Go To    ${vURL}/site/${vSite}/blog-postedit
    Wait Until Element Is Visible    ${lbl_BlogArticle_TitrePage}    10s

    # 2. Saisie du titre
    Wait Until Element Is Visible    ${txt_BlogArticle_Titre}
    Input Text    ${txt_BlogArticle_Titre}    ${vTitre}

    # 3. Saisie du texte dans l'éditeur enrichi (TinyMCE -> bascule sur l'iframe)
    Wait Until Element Is Visible    ${iframe_BlogArticle_Texte}
    Select Frame    ${iframe_BlogArticle_Texte}
    Wait Until Element Is Visible    ${txt_BlogArticle_TexteEditable}
    Click Element    ${txt_BlogArticle_TexteEditable}
    Input Text    ${txt_BlogArticle_TexteEditable}    ${vTexte}
    Unselect Frame

    # Ajout des tags (un par un, si la liste n'est pas vide)
    FOR    ${vTag}    IN    @{vTags}
        Wait Until Element Is Visible    ${txt_BlogArticle_Tag}
        Input Text    ${txt_BlogArticle_Tag}    ${vTag}
        Click Element    ${btn_BlogArticle_AjouterTag}
    END

    # Enregistrement en brouillon ou publication, selon vAction
    Run Keyword If    '${vAction}' == 'brouillon'
    ...    Click Element    ${btn_BlogArticle_EnregistrerBrouillon}
    ...    ELSE IF    '${vAction}' == 'publier'
    ...    Click Element    ${btn_BlogArticle_PublierInterne}
    ...    ELSE
    ...    Fail    vAction doit valoir 'brouillon' ou 'publier' (valeur reçue : ${vAction})

    # Attendre que le formulaire de saisie ait disparu (retour à la vue de l'article)
    Wait Until Element Is Not Visible    ${txt_BlogArticle_Titre}    timeout=10s
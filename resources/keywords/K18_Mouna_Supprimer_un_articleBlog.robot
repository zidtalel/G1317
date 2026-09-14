
# ----------------------------------------------------------------------------
# Supprimer Un Article De Blog Elements
# ----------------------------------------------------------------------------
tab_Blog = "id=HEADER_SITE_BLOG-POSTLIST"
 
lnk_SupprimerArticle = (
    "xpath=//div[contains(@class,'node') and contains(@class,'post') "
    "and .//*[normalize-space(text())='{titre_article}']]"
    "//div[contains(@class,'onDeleteBlogPost')]"
    "//a[contains(@class,'blogpost-action-link-div')]")

BOUTON_SUPPRESSION = "xpath=//div[contains(@class,'yui-dialog')]//button[normalize-space(text())='Supprimer']"


Supprimer Un Article De Blog
    [Documentation]
    ...    Supprime un article existant dans le module Blog d'un site Alfresco,
    ...    en suivant le même parcours qu'un utilisateur : menu Sites > site >
    ...    onglet Blog > article > lien Supprimer > confirmation.
    ...
    ...    Précondition : l'utilisateur est déjà connecté (voir keyword Login) ;
    ...    le site et l'article existent déjà ; le site doit apparaître dans la
    ...    liste "Sites récents" du menu.
    ...    ce keyword accepte deux arguments : le nom du site et le titre de l'article à supprimer${vnom_site}, ${vtitre_article}
    
    [Arguments]    ${vnom_site}    ${vtitre_article}
    Go To    ${vURL}site/${vnom_site}/blog-postlist
    Wait Until Page Contains    ${vtitre_article}    ${TIMEOUT}
    ${lien_suppression}=    Evaluate    '''${lnk_SupprimerArticle}'''.format(titre_article='''${vtitre_article}''')
    Wait Until Element Is Visible    ${lien_suppression}    ${TIMEOUT}
    Click Element    ${lien_suppression}
    Confirmer Suppression Article Blog    
    Wait Until Page Does Not Contain    ${vtitre_article}    ${TIMEOUT}
Confirmer Suppression Article Blog
    [Documentation]
    ...    Clique sur le bouton "Supprimer" de la boîte de dialogue de confirmation
    Wait Until Element Is Visible    ${BOUTON_SUPPRESSION}    ${TIMEOUT}
    Click Element    ${BOUTON_SUPPRESSION}
#Creer un lien dans un site
btn_nouveau_lien = "//button[@id='template_x002e_links_x002e_links_x0023_default-create-link-button-button']"
# Create Link form fields (use id or name when possible)
txt_Link_Title = "id=template_x002e_linkedit_x002e_links-linkedit_x0023_default-title"
txt_Link_URL = "id=template_x002e_linkedit_x002e_links-linkedit_x0023_default-url"
txt_Link_Description = "id=template_x002e_linkedit_x002e_links-linkedit_x0023_default-description"
chk_Link_Internal = "id=template_x002e_linkedit_x002e_links-linkedit_x0023_default-internal"
txt_Link_Tags = "id=template_x002e_linkedit_x002e_links-linkedit_x0023_default-tag-input-field"
btn_Link_AddTag = "id=template_x002e_linkedit_x002e_links-linkedit_x0023_default-add-tag-button-button"
ul_Link_CurrentTags = "id=template_x002e_linkedit_x002e_links-linkedit_x0023_default-current-tags"
btn_Link_Save = "id=template_x002e_linkedit_x002e_links-linkedit_x0023_default-ok-button"
btn_Link_Cancel = "id=template_x002e_linkedit_x002e_links-linkedit_x0023_default-cancel-button"
lk_link_Title = "//div[contains(@class,'linksview')]//div[contains(@class,'nodeTitle')]/a"


Creer un lien dans un site
[Documentation]    Crée un lien dans un site Alfresco.
    # vNom_Site est le nom du site cible. (string)
    # vTitle est le titre du lien (string)
    # vLinkURL est l'URL du lien (string)
    # vDescription est la description du lien (string, peut être vide)
    # vInternal coche le champ "Interne" si `True` (valeurs admises: True/False, true/false). True: Les liens seront ouvert dans la même fenêtre. False: Les liens seront ouvert dans une nouvelle fenêtre.
    # vTags est une liste de zéro ou plusieurs tags (liste de strings). Exemple : @{['tag1','tag2']}
    [Arguments]    ${vNom_Site}    ${vTitle}    ${vLinkURL}    ${vDescription}    ${vInternal}=False    @{vTags}
    Go To    ${vURL}/share/page/site/${vNom_Site}/links
    Wait Until Element Is Visible    ${btn_nouveau_lien}
    Click Element    ${btn_nouveau_lien}
    Wait Until Element Is Visible    ${txt_Link_Title}
    Input Text    ${txt_Link_Title}    ${vTitle}
    Input Text    ${txt_Link_URL}    ${vLinkURL}
    Input Text    ${txt_Link_Description}    ${vDescription}
    Run Keyword If    '${vInternal}'=='True' or '${vInternal}'=='true'    Select Checkbox    ${chk_Link_Internal}
    Run Keyword If    '${vInternal}'!='True' and '${vInternal}'!='true'    Unselect Checkbox    ${chk_Link_Internal}
    # Ajout des tags
    FOR    ${tag}    IN    @{vTags}
        Input Text    ${txt_Link_Tags}    ${tag}
        Click Button    ${btn_Link_AddTag}
        Sleep    300ms
    END
    # Enregistrer
    Click Button    ${btn_Link_Save}
    # Vérifier que le lien a été créé avec succès
    Wait Until Element Is Visible    ${lk_link_Title}    10s
    Element Text Should Be    ${lk_link_Title}    ${vTitle}
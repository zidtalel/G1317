# Creer un modèle
btn_Model_New = "//span[contains(@class,'alfresco-buttons-AlfButton')][.//span[contains(@class,'dijitButtonText') and normalize-space()='Créer un modèle']]//span[@role='button']"
txt_Model_Namespace = "name=namespace"
txt_Model_Prefix = "name=prefix"
txt_Model_Name = "name=name"
txt_Model_Author = "name=author"
txt_Model_Description = "//div[@id='CMM_CREATE_MODEL_DIALOG']//textarea[@name='description']"
btn_Model_Create = "id=CMM_CREATE_MODEL_DIALOG_OK"
btn_Model_Cancel = "id=CMM_CREATE_MODEL_DIALOG_CANCEL"
nom_Modele_Affiche1 = "//div[contains(@class,'AlfListView')]//td[contains(@class,'nameColumn')]//span[@class='value' and normalize-space()='"
nom_Modele_Affiche2 = "']"


Creer modele
    [Documentation]    Crée un modèle dans Alfresco via la boîte de dialogue "Créer un modèle".
    ...    Arguments :
    ...    - `${vNamespace}` : espace de nom du modèle (string, ex: http://www.example.com/model/1.0)
    ...    - `${vPrefix}` : préfixe d'espace de nom (string, ex: ex)
    ...    - `${vName}` : nom du modèle (string)
    ...    - `${vAuthor}` : nom du créateur (string, peut être vide)
    ...    - `${vDescription}` : description du modèle (string, peut être vide)
    ...
    # Tous les localisateurs référencés ci-dessous proviennent de `ressources/locators/alfresco_locators.py`
    [Arguments]    ${vNamespace}    ${vPrefix}    ${vName}    ${vAuthor}=${EMPTY}    ${vDescription}=${EMPTY}
    # Aller à la page d'administration des modèles (si nécessaire)
    Go To    ${vURL}/share/page/console/admin-console/custom-model-manager
    Wait Until Element Is Visible    ${btn_Model_New}    5s
    Click Element    ${btn_Model_New}
    Wait Until Element Is Visible    ${txt_Model_Namespace}    5s
    Input Text    ${txt_Model_Namespace}    ${vNamespace}
    Input Text    ${txt_Model_Prefix}    ${vPrefix}
    Input Text    ${txt_Model_Name}    ${vName}
    Input Text    ${txt_Model_Author}    ${vAuthor}
    Input Text    ${txt_Model_Description}    ${vDescription}
    Click Element    ${btn_Model_Create}
    sleep    2s
    Element Should Be Visible    ${nom_Modele_Affiche1}${vName}${nom_Modele_Affiche2}

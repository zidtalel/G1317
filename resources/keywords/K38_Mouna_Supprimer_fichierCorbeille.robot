# Supprimer Definitivement Un Element De La Corbeille Elements
div_BoiteConfirmation = "xpath=//div[contains(@class,'yui-dialog')]"

btn_SupprimerElement = (
    "xpath=//tr[contains(@class,'yui-dt-rec') and .//div[@class='name' "
    "and contains(., '{nom_element}')]]"
    "//button[normalize-space(text())='Supprimer']")

btn_ConfirmerAction = "xpath=//div[contains(@class,'yui-dialog')]//button[normalize-space(text())='{libelle_bouton}']"

Supprimer Definitivement Un Element De La Corbeille
    [Documentation]
    ...    Supprime définitivement (purge) un élément de la corbeille
    ...    d'un utilisateur Alfresco. Attention l'ation est  irréversible.
    ...
    ...    Précondition : l'utilisateur est déjà connecté (voir keyword Login) ;
    ...    l'élément visé se trouve déjà dans la corbeille de l'utilisateur donné.
    
    [Arguments]    ${vnom_utilisateur}    ${vnom_element}    
    Go To    ${vURL}user/${vnom_utilisateur}/user-trashcan
    Wait Until Page Contains    ${vnom_element}    ${TIMEOUT}
    ${bouton_suppression}=    Evaluate    '''${btn_SupprimerElement}'''.format(nom_element='''${vnom_element}''')
    Wait Until Element Is Visible    ${bouton_suppression}    ${TIMEOUT}
    Click Element    ${bouton_suppression}
    Confirmer La Suppression    OK   
    Wait Until Page Does Not Contain    ${vnom_element}    ${TIMEOUT}

Confirmer La Suppression 
    [Arguments]    ${libelle_bouton_confirmation}
    Wait Until Element Is Visible    ${div_BoiteConfirmation}    ${TIMEOUT}
    ${bouton_confirmer}=    Evaluate    '''${btn_ConfirmerAction}'''.format(libelle_bouton='''${libelle_bouton_confirmation}''')
    Click Element    ${bouton_confirmer}
    Wait Until Element Is Not Visible    ${div_BoiteConfirmation}    ${TIMEOUT}
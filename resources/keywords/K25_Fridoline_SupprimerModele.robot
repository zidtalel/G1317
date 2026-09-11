# Supprimer un modele Elements
model_delete_button = "//div[@id='CMM_DELETE_MODEL_DIALOG']//span[@role='button' and .//span[text()='Supprimer']]"
model_Name = "xpath=//td[contains(@class,'nameColumn')]//span[normalize-space(text())='"
model_NameEnd = "']"


Supprimer un modele
    # Ce mot clé permet de supprimer un modèle existant.
    # Il prend deux paramètres :
    # vModele est le nom du modèle.
    # vOptionSuppression est l'option à choisir pour la suppression du modèle.
    # Il fait appel au keyword Menu Action dont le rôle est d'afficher les differentes Actions d'un modèle.
    
    # la seule valeur possible pour ce mot clé est Supprimer
    [Arguments]    ${vNomModele}    ${vOptionSuppression}    
    Go To    ${vURL}/share/page/console/admin-console/custom-model-manager
    Wait Until Element Is Visible    ${model_Name}${vNomModele}${model_NameEnd}
    Menu Action    ${vNomModele}    ${vOptionSuppression}
    Wait Until Element Is Visible    ${model_delete_button}    
    click Element    ${model_delete_button}  

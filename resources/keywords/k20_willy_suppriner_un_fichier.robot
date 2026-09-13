# suppression  fichiers
link_Fichier1 = "//h3[contains(@class,'filename')]/span/a[normalize-space(.)='"
link_Fichier2 = "']"
menu_ActionsFichier1 = "//h3[contains(@class,'filename')]/span/a[normalize-space(.)='"
menu_ActionsFichier2 = "']/ancestor::tr//div[contains(@class,'internal-show-more')]//a[@class='show-more']"
btn_SupprimerFichier1 = "//h3[contains(@class,'filename')]/span/a[normalize-space(.)='"
btn_SupprimerFichier2 = "']/ancestor::tr//div[contains(@class,'document-delete')]/a[@title='Supprimer le document']"
btn_ConfirmerSuppression = "//button[starts-with(@id, 'yui-gen') and substring(@id, string-length(@id) - 6) = '-button' and text()='Supprimer']"












#supprimer un ficchier existant
Supprimer un fichier existant

    # Définition de la fonction/mot clé permettant de supprimer un fichier.
    # vNom_Fichier est Le nom du fichier à supprimer est reçu en argument.
    [Arguments]    ${vNom_Fichier}
     # Accède directement à la page "Mes fichiers" de l'application Alfresco.
    Go To    ${vURL}/share/page/context/mine/myfiles
    # Vérifie que le fichier recherché est visible à l'écran.
    # ${link_Fichier1} et ${link_Fichier2} permettent de construire
    # le localisateur en utilisant le nom du fichier.
    # Le test attend au maximum 10 secondes.
    Wait Until Element Is Visible    ${link_Fichier1}${vNom_Fichier}${link_Fichier2}    10s
    Mouse Over    ${link_Fichier1}${vNom_Fichier}${link_Fichier2}
    Wait Until Element Is Visible    ${menu_ActionsFichier1}${vNom_Fichier}${menu_ActionsFichier2}    10s
    Click Element    ${menu_ActionsFichier1}${vNom_Fichier}${menu_ActionsFichier2}
    # Clique sur le menu des actions associé au fichier.
    Wait Until Element Is Visible    ${btn_SupprimerFichier1}${vNom_Fichier}${btn_SupprimerFichier2}    10s
    Click Element    ${btn_SupprimerFichier1}${vNom_Fichier}${btn_SupprimerFichier2}
    Wait Until Element Is Visible    ${btn_ConfirmerSuppression}    10s
     # Clique sur le bouton de confirmation pour supprimer définitivement
    Click Element    ${btn_ConfirmerSuppression}

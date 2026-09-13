# Gestionnaire de categories
link_Categorie1 = "//span[@class='ygtvlabel' and normalize-space(text())='"
link_Categorie2 = "']"
btn_SupprimerCategorie1 = "//span[@class='ygtvlabel' and normalize-space(text())='"
btn_SupprimerCategorie2 = "']/span[@class='insitu-delete-category']"
btn_ConfirmerSuppressionCategorie = "//div[@id='prompt']//button[text()='Supprimer']"










Supprimer une categorie existante
    # vNom_Categorie est le nom de la catégorie à supprimer.
    [Arguments]    ${vNom_Categorie}
    Go To    ${vURL}/share/page/console/admin-console/category-manager
    Wait Until Element Is Visible    ${link_Categorie1}${vNom_Categorie}${link_Categorie2}    10s
    Mouse Over    ${link_Categorie1}${vNom_Categorie}${link_Categorie2}
    Sleep    1s
    #Capture Page Screenshot    apres_survol.png
    Wait Until Element Is Visible    ${btn_SupprimerCategorie1}${vNom_Categorie}${btn_SupprimerCategorie2}    10s
    Click Element    ${btn_SupprimerCategorie1}${vNom_Categorie}${btn_SupprimerCategorie2}
    Sleep    1s
    #Capture Page Screenshot    apres_clic_x.png
    Wait Until Element Is Visible    ${btn_ConfirmerSuppressionCategorie}    10s
    Click Element    ${btn_ConfirmerSuppressionCategorie}
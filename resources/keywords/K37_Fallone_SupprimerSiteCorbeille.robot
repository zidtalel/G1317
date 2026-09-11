#Supprimer un site de la corbeille : Localisateurs et keyword
btn_supprimer_part1 = "//tr[.//div[@class='name' and normalize-space()='"
btn_supprimer_part2 = "']]//button[normalize-space()='Supprimer']"
input_search = "id=template_x002e_user-trashcan_x002e_user-trashcan_x0023_default-search-text"
btn_search = "id=template_x002e_user-trashcan_x002e_user-trashcan_x0023_default-search-button-button"
btn_OK_confirmation = "//div[@id='prompt']//button[normalize-space()='OK']"


Supprimer site corbeille
    [Documentation]    Supprime un site Alfresco.
    # vNom_Site est le nom du site cible.
    [Arguments]    ${vNom_Site}
    Go To    ${vURL}/share/page/user/admin/user-trashcan
    Wait Until Element Is Visible    ${input_search}
    Input Text    ${input_search}    ${vNom_Site}
    click Element    ${btn_search}
    Sleep    2s
    Click Element    ${btn_supprimer_part1}${vNom_Site}${btn_supprimer_part2}
    Wait Until Element Is Visible    ${btn_OK_confirmation} 
    Click Element    ${btn_OK_confirmation}
    # Vérifier que le site a été supprimé avec succès
    Input Text    ${input_search}    ${vNom_Site}
    click Element    ${btn_search}
    Sleep    2s
    element Should Not Be Visible    ${btn_supprimer_part1}${vNom_Site}${btn_supprimer_part2}

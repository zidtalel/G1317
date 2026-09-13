# Gestionnaire des filtres de recherche
lbl_Filtre1 = "//div[@id='SEARCH_CONFIG_FACET_LIST_VIEW']//tr[.//span[(@class='value' or contains(@class,'inlineEditValue')) and normalize-space(.)='"
lbl_Filtre2 = "']]"
btn_SupprimerFiltre1 = "//div[@id='SEARCH_CONFIG_FACET_LIST_VIEW']//tr[.//span[(@class='value' or contains(@class,'inlineEditValue')) and normalize-space(.)='"
btn_SupprimerFiltre2 = "']]//span[contains(@class,'PublishAction')]//img[@title]"
btn_confirmation_suppression_filtre = "//*[@id='ALF_CRUD_SERVICE_DELETE_CONFIRMATION_DIALOG_CONFIRM_label'] "









Supprimer un filtre existant
    # vNom_Filtre peut être soit l'ID du filtre (colonne "ID du filtre"),
    # soit le nom affiché (colonne "Nom du filtre").
    [Arguments]    ${vNom_Filtre}
    Go To    ${vURL}/share/page/dp/ws/faceted-search-config
    Wait Until Element Is Visible    ${lbl_Filtre1}${vNom_Filtre}${lbl_Filtre2}    10s
    Wait Until Element Is Visible    ${btn_SupprimerFiltre1}${vNom_Filtre}${btn_SupprimerFiltre2}    10s
    Click Element    ${btn_SupprimerFiltre1}${vNom_Filtre}${btn_SupprimerFiltre2}
    Click Element    ${btn_confirmation_suppression_filtre}
     



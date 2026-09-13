#Supprimer une regle
    rule_item_start = "//a[text()='"
    rule_item_end = "']"
    rule_delete_button = "//button[contains(@id, 'rule-details') and text()='Supprimer']"
    linkFile = "//a[text()='"
    linkfileEnd = "']"
    linkPlus = "//tr[.//a[normalize-space()='"
    linkPlusEnd = "']]//a[contains(@class,'show-more')]"
    linkGererRegle = "//tr[.//a[normalize-space()='"
    linkGererRegleEnd = "']]//a[@title='Gérer les règles']"

Supprimer une regle
    # Ce mot clé permet de supprimer une règle existante.
    # Il prend deux paramètres :
    # vNomFile est le nom du dossier ou fichier contenant la règle.
    # vNomRegle est le nom de la règle à supprimer.    
    [Arguments]    ${vNomFile}    ${vNomRegle}
    Go To     ${vURL}/share/page/context/shared/sharedfiles
    Wait Until Element Is Visible    ${linkFile}${vNomFile}${linkfileEnd}
    Mouse Over    ${linkFile}${vNomFile}${linkfileEnd}
    # fait le survol de la souris sur le lien du fichier ou dossier contenant la règle
    wait Until Element Is Visible    ${linkPlus}${vNomFile}${linkPlusEnd}
    Click Element    ${linkPlus}${vNomFile}${linkPlusEnd}
    wait Until Element Is Visible    ${linkGererRegle}${vNomFile}${linkGererRegleEnd}
    Click Element    ${linkGererRegle}${vNomFile}${linkGererRegleEnd}
    Wait Until Element Is Visible    ${rule_item_start}${vNomRegle}${rule_item_end}
    Click Element    ${rule_item_start}${vNomRegle}${rule_item_end}
    Wait Until Element Is Visible    ${rule_delete_button}
    Click Button    ${rule_delete_button}
    wait Until Element Is Visible    ${confirmation_delete}
    click Element    ${confirmation_delete}
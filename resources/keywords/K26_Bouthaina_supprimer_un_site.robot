############ Locators pour la gestion des sites ############

# Bouton de configuration du site
btn_site_configuration = "id=HEADER_SITE_CONFIGURATION_DROPDOWN"

# Option « Supprimer le site »
btn_delete_site = "id=HEADER_DELETE_SITE_text"

# Bouton de confirmation
btn_confirm_delete_site = "id=ALF_SITE_SERVICE_DIALOG_CONFIRMATION"

########### Script ##########

# Supprime un site Alfresco existant.
# ${vSiteName} est le nom exact du site à supprimer.

Supprimer Un Site
    [Arguments]    ${vSiteName}

    # Accès direct au site via l’URL
    Go To    ${vURL}/share/page/site/${vSiteName}/dashboard

    # Ouverture du menu de configuration du site
    Wait Until Element Is Visible    ${btn_site_configuration}    ${TIMEOUT}
    Click Element    ${btn_site_configuration}

    # Clic sur Supprimer le site
    Wait Until Element Is Visible    ${btn_delete_site}    ${TIMEOUT}
    Click Element    ${btn_delete_site}

    # Confirmation
    Wait Until Element Is Visible    ${btn_confirm_delete_site}    ${TIMEOUT}
    Click Element    ${btn_confirm_delete_site}
# ==================== NAVIGATION DASHBOARD ====================
NAV_BAR_COMPONENTS = "id=HEADER_NAVIGATION_MENU_BAR"
LNK_DASHBOARD_WIKI = "id=HEADER_SITE_WIKI-PAGE_text"
MENU_SITES_DROPDOWN = "id=HEADER_SITES_MENU_text"
LNK_MY_SITES = "xpath=//div[@id='HEADER_SITES_MENU_dropdown']//a[contains(normalize-space(.), 'My Sites')]"
LNK_SITE_DANS_MENU_1 = "xpath=//div[@id='HEADER_SITES_MENU_dropdown']//a[contains(text(), '"
LNK_SITE_DANS_MENU_2 = "')]"

# NUEVOS - selector del sitio dentro de la pagina "User Sites List"
LNK_SITE_EN_MIS_SITIOS_1 = "xpath=//h3[contains(@class,'filterLink') or contains(@class,'itemname')]/a[contains(normalize-space(.), '"
LNK_SITE_EN_MIS_SITIOS_2 = "')]"

 # ==================== K24  Supprimer un lien ====================
LNK_DASHBOARD_LINKS = "link:Links"
LNK_LIEN_PAR_NOM_1 = "link:"
LNK_LIEN_PAR_NOM_2 = ""

# SOLUCIÓN CSS DE DOBLE CHECK: Apuntamos quirúrgicamente a las clases fijas de tu inspector HTML
BTN_DELETE_LINK = "css=.delete-link a span, .delete-link span"
DIALOG_CONFIRM_DELETE = "css=.yui-dialog, .yui-panel, .dialog"
BTN_DELETE_LINK = "xpath=//div[contains(@id, 'default-links')]//a[text()='Delete']"





K24: Supprimer un lien
    [Arguments]    ${site_name}    ${vNomLien}
    [Documentation]    Navega a My Sites, entra al sitio de forma autónoma y elimina el enlace.

    # 1. Sincronización inicial y navegación directa al menú de Mis Sitios
    #Wait Until Element Is Not Visible    id=prompt_mask    timeout=15s
    Click Element    ${MENU_SITES_DROPDOWN}
    Wait Until Element Is Visible    id=HEADER_SITES_MENU_MY_SITES_text    timeout=10s
    Click Element    id=HEADER_SITES_MENU_MY_SITES_text
    Wait Until Location Contains    /user-sites    timeout=10s
    
    # 2. Selección de tu sitio real en la lista de la pantalla blanca
    Wait Until Element Is Visible    ${LNK_SITE_EN_MIS_SITIOS_1}${site_name}${LNK_SITE_EN_MIS_SITIOS_2}    timeout=10s
    Click Element    ${LNK_SITE_EN_MIS_SITIOS_1}${site_name}${LNK_SITE_EN_MIS_SITIOS_2}

    # 3. Navegación interna obligatoria hacia la pestaña de Enlaces (Links)
    Wait Until Element Is Visible    ${NAV_BAR_COMPONENTS}    timeout=15s
    Wait Until Element Is Visible    ${LNK_DASHBOARD_LINKS}   timeout=15s
    Click Element                    ${LNK_DASHBOARD_LINKS}
    Wait Until Location Contains    /links    timeout=15s

    # 4. Sincronización y Validación de existencia del enlace en la tabla
    Wait Until Element Is Visible    ${LNK_LIEN_PAR_NOM_1}${vNomLien}${LNK_LIEN_PAR_NOM_2}    timeout=10s
    Sleep    1s                      # Pausa técnica de estabilidad de renderizado de la fila

    # 1. HOVER REAL: Colocamos el puntero sobre la palabra del enlace para activar la fila blanca de forma natural
    Mouse Over                       ${LNK_LIEN_PAR_NOM_1}${vNomLien}${LNK_LIEN_PAR_NOM_2}
    Sleep    1.5s                    # Pausa elástica para que Alfresco Share renderice el botón oculto

    # 2. CLIC EN EL BOTÓN DELETE: Pinchamos la etiqueta span del botón Delete de tu inspector HTML
    Wait Until Element Is Visible    css=.delete-link span    #timeout=${TIMEOUT}
    Click Element                    css=.delete-link span
    Sleep    1s                      # Pausa técnica para que emerja el cuadro modal de confirmación

    # 3. CONFIRMACIÓN ABSOLUTA SIN RIESGO DE VARIABLES (Doble Check OK):
    # En lugar de buscar una variable que puede estar ausente en Python, le ordenamos a Selenium
    # que pinche directamente el botón interactivo activo en la ventana modal emergente de Alfresco
    Wait Until Element Is Visible    css=.yui-dialog button, .yui-panel button, button    #timeout=${TIMEOUT}
    Click Element                    css=.yui-dialog button, .yui-panel button, button
    
    # 4. VALIDACIÓN FINAL: Confirmamos el éxito comprobando que el enlace desapareció usando tu formato limpio
    Wait Until Page Does Not Contain Element    ${LNK_LIEN_PAR_NOM_1}${vNomLien}${LNK_LIEN_PAR_NOM_2}   # timeout=${TIMEOUT}

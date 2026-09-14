
	
# ==================== NAVIGATION DASHBOARD ====================
NAV_BAR_COMPONENTS = "id=HEADER_NAVIGATION_MENU_BAR"
LNK_DASHBOARD_WIKI = "id=HEADER_SITE_WIKI-PAGE_text"
MENU_SITES_DROPDOWN = "id=HEADER_SITES_MENU_text"
LNK_MY_SITES = "xpath=//div[@id='HEADER_SITES_MENU_dropdown']//a[contains(normalize-space(.), 'My Sites')]"
LNK_SITE_DANS_MENU_1 = "xpath=//div[@id='HEADER_SITES_MENU_dropdown']//a[contains(text(), '"
LNK_SITE_DANS_MENU_2 = "')]"

LNK_SITE_EN_MIS_SITIOS_1 = "xpath=//h3[contains(@class,'filterLink') or contains(@class,'itemname')]/a[contains(normalize-space(.), '"
LNK_SITE_EN_MIS_SITIOS_2 = "')]"

==================== K14: Creer Wiki ====================
BTN_WIKI_NEW_PAGE = "xpath=//button[contains(text(), 'New Page') or contains(text(), 'Nouvelle page')]"
TXT_WIKI_TITLE = "name=pageTitle"
IFRAME_WIKI_TINYMCE = "xpath=//form[contains(@id, 'wiki-create_x0023_default-form')]//iframe"
TXT_WIKI_BODY = "xpath=//body[@id='tinymce']"
BTN_WIKI_PUBLISH = "xpath=//form[contains(@id, 'wiki-create')]//button[text()='Save']"

LNK_SITE_EN_MIS_SITIOS_1 = "link:"
LNK_SITE_EN_MIS_SITIOS_2 = ""




K14: Créer une page wiki
    [Arguments]    ${site_name}    ${vTitre}    ${vTexte}
    [Documentation]    Crea una página wiki de forma limpia, corta e independiente.
    
    ${vHoraWiki}=         Get Current Date    result_format=%H%M%S
    ${vTitreUnique}=      Catenate    SEPARATOR=-    ${vTitre}    ${vHoraWiki}

    Wait Until Element Is Visible    id=HEADER_SITES_MENU_MY_SITES_text    timeout=10s
    Click Element    id=HEADER_SITES_MENU_MY_SITES_text
    
    Click Element    ${LNK_SITE_EN_MIS_SITIOS_1}${site_name}${LNK_SITE_EN_MIS_SITIOS_2}

    # 4. Acceso a la sección Wiki y apertura del formulario
    Click Element                    ${LNK_DASHBOARD_WIKI}
    Wait Until Element Is Visible    ${BTN_WIKI_NEW_PAGE}    timeout=10s
    Click Element    ${BTN_WIKI_NEW_PAGE}
    
    # 5. Llenado del formulario (Título e Iframe TinyMCE)
    Input Text    ${TXT_WIKI_TITLE}    ${vTitreUnique}
    Press Keys    ${TXT_WIKI_TITLE}    TAB

    Select Frame    ${IFRAME_WIKI_TINYMCE}
    Input Text                       ${TXT_WIKI_BODY}    ${vTexte}
    Unselect Frame

    # 6. Guardado y Criterio de Éxito Visual
    Click Element                    ${BTN_WIKI_PUBLISH}
    Wait Until Location Contains    /wiki-page    timeout=15s
    Wait Until Page Contains         ${vTitreUnique}    timeout=15s
	
	
	
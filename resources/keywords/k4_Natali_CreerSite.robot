
###
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

# ==================== K4: CREATE A SITE ====================
DIALOG_CREATE_SITE = "id=CREATE_SITE_DIALOG"
TXT_SITE_TITLE = "xpath=//div[@id='CREATE_SITE_DIALOG']//input[@name='title']"
TXT_SITE_SHORTNAME = "xpath=//div[@id='CREATE_SITE_DIALOG']//input[@name='shortName']"
TXT_SITE_DESCRIPTION = "xpath=//div[@id='CREATE_SITE_DIALOG']//textarea[@name='description']"
BTN_SUBMIT_SITE = "xpath=//div[@id='CREATE_SITE_DIALOG']//*[self::button or self::input or self::span][normalize-space()='Create' or normalize-space()='Créer' or @value='Create' or @value='Créer']"

# Radio de visibilidad del sitio. Valores validos: PUBLIC, MODERATED, PRIVATE
RADIO_VISIBILITY_1 = "xpath=//input[@value='"
RADIO_VISIBILITY_2 = "']/ancestor::div[contains(@class, 'dijitRadio')]"









K4: Créer un site avec tous les composants
    # Crea un nuevo sitio en Alfresco Share con nombre y URL unicos.
    # site_name es el nombre visible base del sitio (se le agrega la hora para que sea unico).
    # site_url_id es el identificador tecnico base del sitio (se le agrega la hora para que sea unico).
    # site_description es la descripcion del sitio.
    # vVisibilite es la visibilidad del sitio: PUBLIC, MODERATED o PRIVATE.
    [Arguments]    ${site_name}    ${site_url_id}    ${site_description}    ${vVisibilite}

    ${vHeureNomSite}=      Get Current Date    result_format=%H:%M:%S
    ${vHeureSiteId}=       Get Current Date    result_format=%H%M%S
    ${vNomSiteUnique}=     Catenate    ${site_name}    ${vHeureNomSite}
    ${vShortNameUnique}=   Catenate    SEPARATOR=-    ${site_url_id}    ${vHeureSiteId}

    # Abre el menu Sites y selecciona la opcion para crear un sitio nuevo.
    Wait Until Element Is Visible    ${MENU_SITES_DROPDOWN}    timeout=${TIMEOUT}
    Click Element    ${MENU_SITES_DROPDOWN}

    Wait Until Element Is Visible    id=HEADER_SITES_MENU_CREATE_SITE_text    timeout=${TIMEOUT}
    Click Element    id=HEADER_SITES_MENU_CREATE_SITE_text

    # Completa el nombre visible del sitio y su identificador tecnico.
    Wait Until Element Is Visible    ${DIALOG_CREATE_SITE}    timeout=${TIMEOUT}
    Input Text    ${TXT_SITE_TITLE}    ${vNomSiteUnique}
    Press Keys    ${TXT_SITE_TITLE}    TAB

    Wait Until Element Is Visible    ${TXT_SITE_SHORTNAME}    timeout=${TIMEOUT}
    Wait Until Element Is Enabled    ${TXT_SITE_SHORTNAME}    timeout=${TIMEOUT}
    Scroll Element Into View          ${TXT_SITE_SHORTNAME}
    Click Element                    ${TXT_SITE_SHORTNAME}
    Clear Element Text    ${TXT_SITE_SHORTNAME}
    Wait Until Keyword Succeeds    5x    1s    Input Text    ${TXT_SITE_SHORTNAME}    ${vShortNameUnique}
    Press Keys    ${TXT_SITE_SHORTNAME}    TAB

    # Completa la descripcion del sitio.
    Wait Until Element Is Visible    ${TXT_SITE_DESCRIPTION}    timeout=${TIMEOUT}
    Scroll Element Into View          ${TXT_SITE_DESCRIPTION}
    Input Text                        ${TXT_SITE_DESCRIPTION}    ${site_description}
    Press Keys                        ${TXT_SITE_DESCRIPTION}    TAB
    Sleep    2s

    # Selecciona la visibilidad elegida por el usuario y confirma que Alfresco la marco.
    Wait Until Element Is Visible    ${RADIO_VISIBILITY_1}${vVisibilite}${RADIO_VISIBILITY_2}    timeout=${TIMEOUT}
    Scroll Element Into View          ${RADIO_VISIBILITY_1}${vVisibilite}${RADIO_VISIBILITY_2}
    Click Element                    ${RADIO_VISIBILITY_1}${vVisibilite}${RADIO_VISIBILITY_2}
    ${visibilidad_seleccionada}=    Execute Javascript    return document.querySelector("input[value='${vVisibilite}']").checked;
    Should Be True             ${visibilidad_seleccionada}
    Sleep    1s

    # Desplaza el boton Create, crea el sitio y espera el cierre del dialogo.
    Scroll Element Into View          ${BTN_SUBMIT_SITE}
    Wait Until Element Is Visible    ${BTN_SUBMIT_SITE}    timeout=${TIMEOUT}
    Click Element                    ${BTN_SUBMIT_SITE}

    # Comprueba la redireccion al sitio creado.
    Wait Until Location Contains    /site/${vShortNameUnique}/dashboard    timeout=${TIMEOUT}
    Wait Until Page Contains    ${vNomSiteUnique}    timeout=${TIMEOUT}

    # Criterio de exito: el sitio aparece listado en "My Sites".
    Click Element    ${MENU_SITES_DROPDOWN}
    Wait Until Element Is Visible    ${LNK_MY_SITES}    timeout=${TIMEOUT}
    Click Element    ${LNK_MY_SITES}
    Wait Until Location Contains    /user-sites    timeout=${TIMEOUT}
    Wait Until Page Contains    ${vNomSiteUnique}    timeout=${TIMEOUT}

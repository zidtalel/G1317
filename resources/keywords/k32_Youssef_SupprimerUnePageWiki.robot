
# --- Locateurs pour la suppression d'une page Wiki ---
locateur_Wiki_Page_Avant=        "xpath=//*[contains(normalize-space(.), '"
locateur_Wiki_Page_Apres=        "')]"
btn_Wiki_Confirmer_Suppression=   "xpath=//*[@id='prompt']//button[contains(normalize-space(.), 'Delete') or contains(normalize-space(.), 'Supprimer')]"


*** Keywords ***
Supprimer une page wiki
    [Documentation]     Supprime une page Wiki spécifique dans un site.
    ...                 
    ...                 = Arguments =
    ...                 - `${siteName}` : Nom du site contenant le Wiki.
    ...                 - `${pageTitle}` : Titre de la page Wiki à supprimer.
    ...                 
    ...                 = Étapes exécutées =
    ...                 1. Navigation vers le module Wiki du site et initialisation des locateurs.
    ...                 2. Sélection de la page Wiki cible (Attente, puis Clic pour l'ouvrir).
    ...                 3. Déclenchement de la suppression de la page.
    ...                 4. Confirmation de la suppression.
    ...                 5. Retour à la liste et vérification de la disparition de la page.
    ...                 
    ...                 = Exemple =
    ...                 | Supprimer une page wiki | mon-site | MaPageWiki |
    [Arguments]         ${siteName}     ${pageTitle}
    
    # 1. Navigation vers le module Wiki du site
    Go To                ${vK32SiteURL}/${siteName}/wiki-page?title=${pageTitle}
    ${locateur_page}=    Set Variable    ${locateur_Wiki_Page_Avant}${pageTitle}${locateur_Wiki_Page_Apres}
    ${locateur_page_liste}=    Set Variable    xpath=//a[normalize-space(.)='${pageTitle}']
    
    # 2. Sélection de la page Wiki cible (Attente, puis Clic pour l'ouvrir)
    Wait Until Element Is Visible    ${locateur_page}    ${vK32Timeout}
    Wait Until Keyword Succeeds    ${vK32Timeout}    500ms    Click Element    ${locateur_page}
    
    # 3. Déclenchement de la suppression de la page
    ${btn_supprimer_page}=    Set Variable    xpath=//*[self::button or self::span or self::div][normalize-space(.)='Delete' or normalize-space(.)='Supprimer la page']
    Wait Until Element Is Visible    ${btn_supprimer_page}    ${vK32Timeout}
    Wait Until Keyword Succeeds    ${vK32Timeout}    500ms    Click Element    ${btn_supprimer_page}
    
    # 4. Confirmation de la suppression
    ${alerte_acceptee}=    Run Keyword And Return Status    Handle Alert    ACCEPT    1s
    IF    not ${alerte_acceptee}
        Wait Until Element Is Visible    ${btn_Wiki_Confirmer_Suppression}    ${vK32Timeout}
        Wait Until Keyword Succeeds    ${vK32Timeout}    500ms    Click Element    ${btn_Wiki_Confirmer_Suppression}
    END
    
    # 5. Retour à la liste et vérification de la disparition de la page
    Wait Until Keyword Succeeds    ${vK32Timeout}    500ms    Click Element    xpath=//a[normalize-space(.)='Wiki Page List']
    Wait Until Element Is Not Visible    ${locateur_page_liste}    ${vK32Timeout}
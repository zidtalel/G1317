
# --- Locators for calendar event deletion ---
xpath_Calendrier_Evenement_Avant=        " xpath=//*[contains(normalize-space(.), '"
xpath_Calendrier_Evenement_Apres=        " ') and not(*)]"
btn_Calendrier_Supprimer_Evenement=     " xpath=//*[self::button or @role='button'][normalize-space(.)='Delete' or normalize-space(.)='Supprimer']"
btn_Calendrier_Confirmer_Suppression=     "xpath=//*[self::button or @role='button'][normalize-space(.)='Delete' or normalize-space(.)='Supprimer']"


*** Keywords ***
Supprimer un évènement
    [Documentation]     Supprime un événement spécifique dans le calendrier d'un site.
    ...                 
    ...                 = Arguments =
    ...                 - `${vNom_Site}` : Nom du site contenant le calendrier.
    ...                 - `${vTitre_Evenement}` : Titre exact de l'événement à supprimer.
    ...                 
    ...                 = Étapes exécutées =
    ...                 1. Navigation vers le calendrier du site et construction du locateur dynamique.
    ...                 2. Sélection et ouverture de l'événement dans le calendrier.
    ...                 3. Déclenchement de la suppression et confirmation de l'action.
    ...                 4. Rechargement de la page et vérification que l'événement n'est plus visible.
    ...                 
    ...                 = Exemple =
    ...                 | Supprimer un évènement | mon-site | Reunion_Equipe |
    [Arguments]     ${vNom_Site}     ${vTitre_Evenement}
    
    # 1. Navigate to the site calendar and build the dynamic event locator
    Go To   ${vK22SiteURL}/${vNom_Site}/calendar
    ${locateur_evenement}=    Set Variable    ${xpath_Calendrier_Evenement_Avant}${vTitre_Evenement}${xpath_Calendrier_Evenement_Apres}
    
    # 2. Select and open the event in the calendar
    Wait Until Element Is Visible   ${locateur_evenement}   ${vK22Timeout}
    Click Element   ${locateur_evenement}
    
    # 3. Trigger deletion and confirm the action
    Wait Until Element Is Visible   ${btn_Calendrier_Supprimer_Evenement}   ${vK22Timeout}
    Click Element   ${btn_Calendrier_Supprimer_Evenement}
    Wait Until Element Is Visible   ${btn_Calendrier_Confirmer_Suppression}   ${vK22Timeout}
    Click Element   ${btn_Calendrier_Confirmer_Suppression}
    
    # 4. Reload page and verify that the event is no longer visible
    Reload Page
    Wait Until Element Is Not Visible   ${locateur_evenement}   ${vK22Timeout}
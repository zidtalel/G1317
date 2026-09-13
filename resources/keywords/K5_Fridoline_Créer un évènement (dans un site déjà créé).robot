# Creer un evenement Elements
    event_AddButton = "id=template_x002e_toolbar_x002e_calendar_x0023_default-addEvent-button-button"
    event_Title = "id=eventEditPanel-title"
    event_Location = "id=eventEditPanel-location"
    event_Description = "id=eventEditPanel-description"
    event_AllDay = "id=eventEditPanel-allday"
    event_StartDate = "id=fd"
    event_StartTime = "id=eventEditPanel-start"
    event_EndDate = "id=td"
    event_EndTime = "id=eventEditPanel-end"
    event_TagInput = "id=eventEditPanel-tag-input-field"
    event_AddTag = "id=eventEditPanel-add-tag-button-button"
    event_Save = "id=eventEditPanel-ok-button"

Creer un evenement dans un site
# Ce mot clé permet de créer un événement dans un site existant.
    # Il prend ... paramètres :
    # vNomSite est le nom du site cible.
    # vTitre est le titre de l'événement.
    # il fait appel au mot clé Set Date Field pour forcer la valeur d'un champ date readonly (widget calendrier YUI) via JS
    # vDateDebut est la date de début de l'événement au format ISO (YYYY-MM-DD).
    # vHeureDebut est l'heure de début de l'événement au format HH:MM.
    # vDateFin est la date de fin de l'événement au format ISO (YYYY-MM-DD).
    # vHeureFin est l'heure de fin de l'événement au format HH:MM.
    [Documentation]    Crée un événement dans un site existant.
    [Arguments]    ${vNomSite}    ${vTitre}    ${vLieu}    ${vDescription}    ${vJourneeEntiere}    ${vDateDebut}    ${vHeureDebut}    ${vDateFin}    ${vHeureFin}    ${vTags}

    Go To    ${vURL}/share/page/site/${vNomSite}/calendar
    Wait Until Element Is Visible    ${event_AddButton}
    Click Button    ${event_AddButton}
    Wait Until Element Is Visible    ${event_Title}
    Input Text    ${event_Title}          ${vTitre}
    Input Text    ${event_Location}       ${vLieu}
    Input Text    ${event_Description}    ${vDescription}
    Run Keyword If    '${vJourneeEntiere}' == 'True'
    ...    Select Checkbox    ${event_AllDay}
    # Date de début
    Set Date Field    fd    ${vDateDebut}
    Set Event Date    ${vDateDebut}    start
    Run Keyword If    '${vJourneeEntiere}' == 'False'
    ...    Input Text    ${event_StartTime}    ${vHeureDebut}    clear=True
    # Date de fin
    Set Date Field    td    ${vDateFin}
    Set Event Date    ${vDateFin}    end
    Run Keyword If    '${vJourneeEntiere}' == 'False'
    ...    Input Text    ${event_EndTime}    ${vHeureFin}    clear=True
    Input Text    ${event_TagInput}    ${vTags}
    Click Button    ${event_AddTag}
    Sleep    2s
    Click Button    ${event_Save}

Set Date Field
    [Documentation]    Force la date visible et la date ISO du formulaire Alfresco.
    [Arguments]    ${vFieldId}    ${vDateISO}

    Execute Javascript
    ...    var el = document.getElementById('${vFieldId}');
    ...    if (!el) { throw new Error('Champ introuvable : ${vFieldId}'); }
    ...    el.removeAttribute('readonly');
    ...    el.value = '${vDateISO}';
    ...    el.setAttribute('rel', '${vDateISO}T00:00:00.000-04:00');
    ...    el.dispatchEvent(new Event('change', { bubbles: true }));
    ...    el.setAttribute('readonly', 'readonly');

Set Event Date
    [Documentation]    Met à jour la date visible et la date ISO utilisée par Alfresco.
    [Arguments]    ${vDateISO}    ${vType}

    ${dateISO}=    Set Variable    ${vDateISO}T00:00:00.000-04:00

    Execute Javascript
    ...    var dateISO = '${dateISO}';
    ...    if ('${vType}' === 'start') {
    ...        document.getElementById('fd').value = '${vDateISO}';
    ...        document.getElementById('eventEditPanel-startAt').value = dateISO;
    ...    } else {
    ...        document.getElementById('td').value = '${vDateISO}';
    ...        document.getElementById('eventEditPanel-endAt').value = dateISO;
    ...    }   
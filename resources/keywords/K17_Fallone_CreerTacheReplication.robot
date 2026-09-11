#Creer une tache de replication
txt_Nom_Tache = "name=name"
txt_Description_Tache = "name=description"
btn_Selectionner_Source = "//div[@id='alf-id0_payload-cntrl-itemGroupActions']//button[normalize-space()='Sélectionner']"
btn_Selectionner_Cible = "//div[@id='alf-id1_targetName-cntrl-itemGroupActions']//button[normalize-space()='Sélectionner']"
chk_Tache_Planifiee = "id=template_x002e_replication-job_x002e_replication-job_x0023_default-scheduleEnabled"
txt_Date_Debut = "id=alf-id2_schedule.start.iso8601-cntrl-date"
txt_Heure_Debut = "id=alf-id2_schedule.start.iso8601-cntrl-time"
txt_Nombre_Repetition = "id=template_x002e_replication-job_x002e_replication-job_x0023_default-prop_intervalCount"
lst_Unite_Repetition = "id=template_x002e_replication-job_x002e_replication-job_x0023_default-prop_intervalPeriod"
chk_Tache_Active = "id=template_x002e_replication-job_x002e_replication-job_x0023_default-prop_enabled-entry"
btn_Creer_Tache = "id=template_x002e_replication-job_x002e_replication-job_x0023_default-form-submit-button"
btn_OK_Source = "id=alf-id0_payload-cntrl-ok-button"
btn_OK_Cible = "id=alf-id1_targetName-cntrl-ok-button"
icone_ajouter_element = "//a[@title='Ajouter' and ./ancestor::tr/td/div/h3/a[text()='"
icone_ajouter_element_fin ="']]"
nom_Tache_affiche1 = "//div[@class='jobs-list']//li//span[normalize-space()='"
nom_Tache_affiche2 = "']"

Creer tache replication
    [Documentation]    Crée une tâche de réplication dans Alfresco.
    ...
    ...    Arguments :
    ...    - `${vNomTache}` : nom de la tâche de réplication.
    ...    - `${vDescription}` : description de la tâche. Peut être vide.
    ...    - `${vElementSource}` : nom de l'élément source à répliquer.
    ...    - `${vCibleTransfert}` : nom de la cible de transfert.
    ...    - `${vEstPlanifie}` : indique si la tâche est planifiée.
    ...      Valeurs admises : True/False, true/false.
    ...      Si True, la date, l'heure, le nombre et l'unité de répétition sont renseignés.
    ...    - `${vDate}` : date de début de la tâche au format JJ/MM/AAAA.
    ...      Obligatoire lorsque `${vEstPlanifie}` vaut True.
    ...    - `${vHeure}` : heure de début au format HH:MM (24 heures).
    ...      Obligatoire lorsque `${vEstPlanifie}` vaut True.
    ...    - `${vRepetition}` : unité de répétition.
    ...      Valeurs admises : Second, Minute, Hour, Day, Week, Month.
    ...    - `${vNombre}` : nombre d'unités entre deux exécutions.
    ...      Exemple : 2 + Day = toutes les 2 journées.
    ...    - `${vEstActif}` : indique si la tâche doit être activée.
    ...      Valeurs admises : True/False, true/false.
    ...
    ...    Exemple :
    ...    Creer tache de replication
    ...    ...    Ma tâche
    ...    ...    Réplication quotidienne
    ...    ...    Dossier_source
    ...    ...    Serveur_cible
    ...    ...    True
    ...    ...    10/09/2026
    ...    ...    08:00
    ...    ...    Day
    ...    ...    1
    ...    ...    True

    [Arguments]    ${vNomTache}    ${vDescription}    ${vElementSource}    ${vCibleTransfert}    ${vEstPlanifie}    ${vDate}    ${vHeure}    ${vRepetition}    ${vNombre}    ${vEstActif}
    
    Go To    ${vURL}/share/page/console/replication-job
    Wait Until Element Is Visible    ${txt_Nom_Tache}    10s
    Input Text    ${txt_Nom_Tache}    ${vNomTache}
    Input Text    ${txt_Description_Tache}    ${vDescription}
    Click Element    ${btn_Selectionner_Source}
    wait Until Element Is Visible    ${icone_ajouter_element}${vElementSource}${icone_ajouter_element_fin}    10s
    Click Element    ${icone_ajouter_element}${vElementSource}${icone_ajouter_element_fin}
    Click Element    ${btn_OK_Source}

    wait Until Element Is Visible    ${btn_Selectionner_Cible}    10s
    Click Element    ${btn_Selectionner_Cible}
    wait Until Element Is Visible    ${icone_ajouter_element}${vCibleTransfert}${icone_ajouter_element_fin}    10s
    Click Element    ${icone_ajouter_element}${vCibleTransfert}${icone_ajouter_element_fin}
    Click Element    ${btn_OK_Cible}

    IF    '${vEstPlanifie}' == 'True' or '${vEstPlanifie}' == 'true'
        Select Checkbox    ${chk_Tache_Planifiee}
        Wait Until Element Is Visible    ${txt_Date_Debut}    10s
        Input Text    ${txt_Date_Debut}    ${vDate}
        Input Text    ${txt_Heure_Debut}    ${vHeure}
        Input Text    ${txt_Nombre_Repetition}    ${vNombre}
        Select From List By Value
        ...    ${lst_Unite_Repetition}
        ...    ${vRepetition}
    ELSE
        Unselect Checkbox    ${chk_Tache_Planifiee}
    END
    IF    '${vEstActif}' == 'True' or '${vEstActif}' == 'true'
        Select Checkbox    ${chk_Tache_Active}
    ELSE
        Unselect Checkbox    ${chk_Tache_Active}
    END
    Click Element    ${btn_Creer_Tache}
    sleep    2s
    Element Should Be visible    ${nom_Tache_affiche1}${vNomTache}${nom_Tache_affiche2}
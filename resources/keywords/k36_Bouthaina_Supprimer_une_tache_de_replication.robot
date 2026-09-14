########## Locators pour tache de replication ############

# Lien vers les tâches de réplication

# Modèle du lien d'une tâche de réplication.
# TASK_NAME sera remplacé par le nom fourni en argument.
lnk_replication_task_by_name = (
    "xpath=//div[@id='page_x002e_ctool_x002e_admin-console_x0023_default-jobsList']"
    "//*[normalize-space()='TASK_NAME']"
)

# Bouton Supprimer identifié directement dans le HTML fourni
btn_delete_replication_task = (
    "xpath=//button[normalize-space()='Supprimer']"
)

####### Script #####################

# Supprime une tâche de réplication déjà créée.
# ${vTaskName} est le nom exact de la tâche à supprimer.
Supprimer Une Tache De Replication
    [Arguments]    ${vTaskName}
    Go To    ${vURL}/share/page/console/admin-console/replication-jobs
    
    # Création du locator à partir du nom de la tâche
    ${task_locator}=    Replace String
    ...    ${lnk_replication_task_by_name}
    ...    TASK_NAME
    ...    ${vTaskName}

    # Sélection de la tâche
    Wait Until Element Is Visible    ${task_locator}    ${TIMEOUT}
    Click Element    ${task_locator}

    # Suppression de la tâche
    Wait Until Element Is Enabled    ${btn_delete_replication_task}    ${TIMEOUT}
    Click Element    ${btn_delete_replication_task}
    Press Keys    ${btn_delete_replication_task}    ENTER
    Wait Until Page Contains    Aucune tâche sélectionnée    ${TIMEOUT}
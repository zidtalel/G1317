# Discussions - Suppression d'un sujet
LIGNE_SUJET_CONTENANT_TITRE_XPATH = "//tr[.//a[contains(text(), '{titre_sujet}')]]"

LIEN_SUPPRESSION_SUJET_DANS_LIGNE_XPATH = ".//a[contains(@class,'topic-action-link-div')]"
LIEN_ACTION_SUPPRIMER_SUJET = "//a[contains(@class, 'topic-action-link') and contains(text(), 'Supprimer')]"
BOUTON_CONFIRMER_SUPPRESSION = "//span[contains(@class,'alf-primary-button')]//button[contains(text(),'Supprimer')]"


Supprimer Un Sujet De Discussion
    [Documentation]
    ...    Supprime un sujet existant dans le module Discussions d'un site Alfresco.
    ...
    ...    Précondition : le site et le sujet existent déjà, et l'utilisateur exécutant
    ...    le test est connecté avec les droits suffisants pour supprimer le sujet.
    ...    Postconditions :
    ...    - Le sujet est supprimé définitivement de la liste des discussions
    ...    - Toutes les réponses associées sont supprimées
    ...    ce keyword accepte deux arguments : le nom du site et le titre du sujet à supprimer${vnom_site}, ${vtitre_sujet}

    [Arguments]    ${vnom_site}    ${vtitre_sujet}
    Go To    ${vURL}site/${vnom_site}/discussions-topiclist
    Wait Until Page Contains    ${vtitre_sujet}    timeout=${TIMEOUT}
    ${ligne_sujet}=    Evaluate    '''${LIGNE_SUJET_CONTENANT_TITRE_XPATH}'''.format(titre_sujet='''${vtitre_sujet}''')
    ${lien_suppression}=    Set Variable    ${ligne_sujet}/${LIEN_SUPPRESSION_SUJET_DANS_LIGNE_XPATH}    
    Wait Until Element Is Visible    ${lien_suppression}    ${TIMEOUT}
    Click Element    ${lien_suppression}
    Confirmer Suppression Sujet Discussion     
    Wait Until Page Does Not Contain    ${vtitre_sujet}    ${TIMEOUT}

Confirmer Suppression Sujet Discussion
    [Documentation]
    ...    Clique sur le lien d'action "Supprimer" du sujet, puis confirme
    ...    la suppression dans la boîte de dialogue qui s'affiche ensuite.
    Wait Until Element Is Visible    ${LIEN_ACTION_SUPPRIMER_SUJET}    ${TIMEOUT}
    Click Element    ${LIEN_ACTION_SUPPRIMER_SUJET}
    Wait Until Element Is Visible    ${BOUTON_CONFIRMER_SUPPRESSION}    ${TIMEOUT}
    Click Element    ${BOUTON_CONFIRMER_SUPPRESSION}
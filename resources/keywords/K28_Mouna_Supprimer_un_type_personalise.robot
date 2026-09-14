# ----------------------------------------------------------------------------
# Supprimer Un Type Personnalise Elements
# ----------------------------------------------------------------------------

lnk_ActionsTypeParNom = ("xpath=//tr[.//span[@class='value' and contains(., '{nom_type}')]]"
    "//div[@role='menuitem' and contains(@aria-label,'Actions')]")

lnk_SupprimerDansMenuActions = "xpath=//td[contains(@class,'dijitMenuItemLabel') and normalize-space(text())='Supprimer']"

div_BoiteConfirmationTypeParTitre =(
    "xpath=//div[contains(@class,'dijitDialog') and "
    ".//*[normalize-space(text())='Supprimer le type personnalisé']]")

btn_ConfirmerSuppressionType = "//span[contains(@class,'dijitButtonText') and normalize-space(text())='Supprimer']"


Supprimer Un Type Personnalise
    [Documentation]
    ...    Supprime un type personnalisé existant dans un modèle du Gestionnaire
    ...    de modèles (console admin d'Alfresco).
    ...
    ...    Précondition : l'utilisateur est déjà connecté (voir keyword Login),
    ...    avec les droits administrateur nécessaires pour accéder à la console
    ...    admin ; le modèle et le type personnalisé existent déjà.
   
    ...    elle accepter deux arguments : le nom du modèle et le nom du type personnalisé à supprimer...${vnom_modele}, ${vnom_type}
    
    [Arguments]    ${vnom_modele}    ${vnom_type}
    Go To    ${vURL}console/admin-console/custom-model-manager#view=types_property_groups&model=${vnom_modele}
    Wait Until Page Contains    ${vnom_type}    ${TIMEOUT}
    ${bouton_actions}=    Evaluate    '''${lnk_ActionsTypeParNom}'''.format(nom_type='''${vnom_type}''')
    Wait Until Element Is Visible    ${bouton_actions}    ${TIMEOUT}
    Click Element    ${bouton_actions}
    Wait Until Keyword Succeeds    ${TIMEOUT}    0.5s    Cliquer Sur L'Item Supprimer Visible Du Menu Actions
    Wait Until Element Is Visible    ${div_BoiteConfirmationTypeParTitre}    ${TIMEOUT}
    ${bouton_confirmer}=    Set Variable    ${div_BoiteConfirmationTypeParTitre}${btn_ConfirmerSuppressionType}
    Wait Until Element Is Visible    ${bouton_confirmer}    ${TIMEOUT}
    Click Element    ${bouton_confirmer}
    Wait Until Page Does Not Contain    ${vnom_type}    ${TIMEOUT}
Cliquer Sur L'Item Supprimer Visible Du Menu Actions
    [Documentation]
    ...    Keyword partagé, utile pour tout menu déroulant "Actions" de la
    ...    console admin (Dojo/Aikau). Dojo conserve souvent en mémoire
    ...    plusieurs popups de menu identiques (un par ligne du tableau,
    ...    voire un par type d'action comme "Types" et "Aspects"), la plupart
    ...    masqués. Un XPath simple sur le texte "Supprimer" renvoie le
    ...    PREMIER trouvé dans le code source, qui n'est pas forcément celui
    ...    actuellement affiché à l'écran.
    ...
    ...    Ce keyword récupère TOUS les éléments correspondants, puis clique
    ...    sur le premier qui est réellement visible. Échoue explicitement si
    ...    aucun n'est visible (plutôt que de rester silencieux), pour que
    ...    l'appel à "Wait Until Keyword Succeeds" puisse réessayer pendant
    ...    l'animation d'ouverture du menu.
    @{elements}=    Get WebElements    ${lnk_SupprimerDansMenuActions}
    FOR    ${element}    IN    @{elements}
        ${est_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${element}
        IF    ${est_visible}
            Click Element    ${element}
            RETURN
        END
    END
    Fail    Aucun item "Supprimer" visible trouvé dans le menu Actions ouvert.

Confirmer La Suppression de type Personnalise
  
    [Arguments]    ${libelle_bouton_confirmation}
    Wait Until Element Is Visible    ${div_BoiteConfirmation}    ${TIMEOUT}
    ${bouton_confirmer}=    Evaluate    '''${btn_ConfirmerAction}'''.format(libelle_bouton='''${libelle_bouton_confirmation}''')
    Click Element    ${bouton_confirmer}
    Wait Until Element Is Not Visible    ${div_BoiteConfirmation}    ${TIMEOUT}
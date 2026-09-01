*** Settings ***
Documentation      bibiotheque de mots cles pour les tests
Library            SeleniumLibrary
Variables         ../Locators/locator.py
Library          String
Library          DateTime



*** Variables ***
${vTIMEOUT}    5s
${valeurModifier}    4
${vURL}    http://localhost:8082




*** Keywords ***
Login
    [Arguments]    ${vURL}    ${vBrowser}    ${vLogin}    ${vPassword}
    Open Browser    ${vURL}/login    ${vBrowser}
    Maximize Browser Window
    Input Text    ${input_username}    ${vLogin}
    Wait Until Element Is Visible    ${input_password}    10s
    Input Text    ${input_password}    ${vPassword}
    Click Element    ${input_submit}
    Title Should Be    Ma page - Redmine



Logout
     
    Click Element    ${link_Deconnexion}
    Close Browser

Ajout K7
    Click Element    ${link_Deconnexion}
    Close Browser


creer champ personaliser 
    [Arguments]    ${choix_format_champs}    ${nom_champs}    ${description_champs}    ${longueur_min}    ${longueur_max}
    Go To    ${vURL}/custom_fields/new?utf8=✓&type=GroupCustomField
    Select From List By Value    ${select_format}    ${choix_format_champs} 
    Input Text    ${input_nom_champs}    ${nom_champs}
    Input Text    ${input_description_champs}    ${description_champs}
    Input Text    ${input_longueur_mini}    ${longueur_min}
    Input Text    ${input_longueur_maxi}    ${longueur_max}
    Click Element    ${Bouton_creer_champs}
       

valider_champs_personnel
    [Arguments]    ${mon_champs}
    Go To    ${vURL}/groups/new
    Element Should Be Visible    ${confirmation_champs1}${mon_champs}${confirmation_champs2}
 

supprimer_champs_personaliser
    [Arguments]    ${nom_champs}
    Go To    ${vURL}/custom_fields?tab=GroupCustomField
    Click Element    ${bouton_supprimer_champs1}${nom_champs}${bouton_supprimer_champs2}
    Handle Alert    action=ACCEPT
    Wait Until Element Is Visible    ${message_confirmation_suppresion}
    














Template Creer projet nominal et suppression projet
    [Arguments]    ${projectname}       ${projectDescription}   ${projetIdentifiant}    
    creer projet nominal    ${projectname}       ${projectDescription}   ${projetIdentifiant}
    supprimer un projet     ${projetIdentifiant}






# configuration
    
    
#     Click Element    ${link_Administration}
#     Click Element     ${link_Configuration}
#     Click Element     ${link_Suivitemps}
#     Input Text     ${link_Modifiervaleur}    ${valeurModifier}
#     Click Element     ${link_Sauvegarder}
#     Element Text Should Be     ${link_messagesucces}    Mise à jour effectuée avec succès.
#     Element Attribute Value Should Be     ${link_Modifiervaleur}    value    ${valeurModifier}



# Ajouter un cadran

#         # issuesassignedtome    -->    Demandes qui me sont assignées
#         # issuesreportedbyme    -->    Demandes soumises
#         # issuesupdatedbyme     -->    Demandes mises à jour
#         # issueswatched         -->    Demandes surveillées
#         # issuequery            -->    Demandes
#         # news                  -->    Dernières annonces
#         # calendar              -->    Calendrier
#         # documents             -->    Documents
#         # timelog               -->    Temps passé
#         # activity              -->    Activité
#      [Arguments]    ${vnom_cadran}
#     Click Element    ${link_ma_page}
#     Select From List By Value    ${list_cadran}    ${vnom_cadran}  


# supprimer un cadran 

#     [Arguments]    ${vnom_cadran}
#     Click Element    ${link_ma_page}
#     Click Element    ${bouton_supprimer_cadran1}${vnom_cadran}${bouton_supprimer_cadran2}

 
                               

     

# generer id
#     ${vDateSysteme}=    Get Current Date    result_format=%Y-%m-%d %H:%M:%S%f
#     ${vDate}=           Get Substring    ${vDateSysteme}    0     10
#     ${vHeure}=          Get Substring    ${vDateSysteme}    11    13
#     ${vMinute}=         Get Substring    ${vDateSysteme}    14    16
#     ${vSeconde}=        Get Substring    ${vDateSysteme}    17    19
#     ${vMilliseconde}=    Get Substring    ${vDateSysteme}    20    23

#     ${vId}=             Catenate    SEPARATOR=    ${vDate}    ${vHeure}    ${vMinute}    ${vSeconde}

#     RETURN    ${vId}      
    




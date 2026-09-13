# Creation d'un sujet dans une discussion
frm_CreationSujet = "id=template_x002e_createtopic_x002e_discussions-createtopic_x0023_default-form"
txt_TitreSujet  = "id=template_x002e_createtopic_x002e_discussions-createtopic_x0023_default-title"
frm_TexteSujet =  "id=template_x002e_createtopic_x002e_discussions-createtopic_x0023_default-content_ifr"
txt_TexteSujet =  "xpath=//body[@contenteditable='true']"
txt_TagSujet = " id=template_x002e_createtopic_x002e_discussions-createtopic_x0023_default-tag-input-field"
btn_AjouterTagSujet = " id=template_x002e_createtopic_x002e_discussions-createtopic_x0023_default-add-tag-button-button"
btn_EnregistrerSujet = " id=template_x002e_createtopic_x002e_discussions-createtopic_x0023_default-submit-button"






Creer un sujet dans une discussion
# ${vNom_Site}    : nom du site Alfresco dans lequel le sujet sera créé.
# ${vTitreSujet}  : titre du nouveau sujet de discussion.
# ${vTexteSujet}  : contenu ou texte du sujet.
# ${vTags}        : tag/mot-clé associé au sujet.
    [Arguments]    ${vNom_Site}    ${vTitreSujet}    ${vTexteSujet}    ${vTags}
    Go To    ${vURL}/share/page/site/${vNom_Site}/discussions-createtopic
# Attendre le formulaire
    Wait Until Element Is Visible    ${frm_CreationSujet}    10s
# =====================================================
# 1. SAISIR UNIQUEMENT LE TITRE
# =====================================================
    Wait Until Element Is Visible    ${txt_TitreSujet}    10s
    Click Element    ${txt_TitreSujet}
    Clear Element Text    ${txt_TitreSujet}
    Input Text    ${txt_TitreSujet}    ${vTitreSujet}
# =====================================================
# 2. SAISIR UNIQUEMENT LE CONTENU
# =====================================================
    Wait Until Element Is Visible    ${frm_TexteSujet}    10s
    Select Frame    ${frm_TexteSujet}

    # Le body de l'éditeur correspond au contenu du sujet
    Wait Until Element Is Visible    ${txt_TexteSujet}    10s
    Click Element    ${txt_TexteSujet}
    Clear Element Text    ${txt_TexteSujet}
    Input Text    ${txt_TexteSujet}    ${vTexteSujet}

    # Sortir de l'iframe
    Unselect Frame

# =====================================================
# 3. SAISIR LE TAG
# =====================================================
    Wait Until Element Is Visible    ${txt_TagSujet}    10s
    Click Element    ${txt_TagSujet}
    Clear Element Text    ${txt_TagSujet}
    Input Text    ${txt_TagSujet}    ${vTags}

# Ajouter le tag
    Click Button    ${btn_AjouterTagSujet}

# =====================================================
# 4. ENREGISTRER
# =====================================================
    Wait Until Element Is Enabled    ${btn_EnregistrerSujet}    10s
    Click Button    ${btn_EnregistrerSujet}
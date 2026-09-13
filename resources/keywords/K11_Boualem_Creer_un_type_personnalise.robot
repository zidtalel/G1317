#Création d'un type personnalisé dans Alfresco

txt_TypePersonnalise_Nom = "//input[@name='name']"
txt_TypePersonnalise_Etiquette = "//input[@name='title']"
txt_TypePersonnalise_Description = "//textarea[@data-dojo-attach-point='focusNode,containerNode,textbox']"
btn_TypePersonnalise_Creer = "//span[@id='CMM_CREATE_TYPE_DIALOG_OK_label']"
link_btn_TypePersonnalise_Creer = "//span[normalize-space(text())='Créer un type personnalisé' or normalize-space(text())='Create Custom Type']"





creer un type personnalise
    [Documentation]    Crée un type personnalisé dans le gestionnaire de modèles de données d'Alfresco.
    ...
    ...    = Arguments =
    ...    - `${vNom_TypePersonnalise}` : Nom technique du nouveau type personnalisé.
    ...    - `${vTypeParent}` : Type hérité ou parent, par exemple `cm:content`.
    ...    - `${vEtiquette_TypePersonnalise}` : Libellé d'affichage visible par les utilisateurs.
    ...    - `${vDescription_TypePersonnalise}` : Description détaillée du type personnalisé.
    ...    - `${vnOmsite}` : Nom ou identifiant du modèle Alfresco cible.
    ...
    ...    = Exemple =
    ...    | creer un type personnalise | ContratVente | cm:content | Contrat de Vente | Type pour les contrats de vente | Modele_RH |


    [Arguments]    ${vNom_TypePersonnalise}    ${vTypeParent}    ${vEtiquette_TypePersonnalise}    ${vDescription_TypePersonnalise}    ${vnOmsite}
    Go To    ${vURL}/console/admin-console/custom-model-manager#view=types_property_groups&model=${vnOmsite}

    # Saisie du nom
    Wait Until Element Is Visible    ${link_btn_TypePersonnalise_Creer}
    Click Element    ${link_btn_TypePersonnalise_Creer}
    Wait Until Element Is Visible    ${txt_TypePersonnalise_Nom}
    Input Text    ${txt_TypePersonnalise_Nom}    ${vNom_TypePersonnalise}

    # Saisie de l'étiquette d'affichage
    Wait Until Element Is Visible    ${txt_TypePersonnalise_Etiquette}
    Input Text    ${txt_TypePersonnalise_Etiquette}    ${vEtiquette_TypePersonnalise}

    # Saisie de la description
    Wait Until Element Is Visible    ${txt_TypePersonnalise_Description}
    Input Text    ${txt_TypePersonnalise_Description}    ${vDescription_TypePersonnalise}

    # Création du type
    Wait Until Element Is Enabled    ${btn_TypePersonnalise_Creer}
    Click Element    ${btn_TypePersonnalise_Creer}
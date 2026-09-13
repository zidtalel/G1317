# Creer une propriete Elements
    model_Name = "xpath=//td[contains(@class,'nameColumn')]//span[normalize-space(text())='"
    model_NameEnd = "']"
    aspect_Name = "//span[@class='value' and text()='"
    aspect_NameEnd = "']"
    property_Create = "xpath=//span[normalize-space(text())='Créer une propriété']"
    property_Name = "css=input[name='name']"
    property_Title = "css=input[name='title']"
    property_Description = "//textarea[contains(@class, 'dijitTextArea') and @name='description']"
    property_DataType = "//input[@name='datatype']/ancestor::td[contains(@class, 'dijitButtonContents')]"
    property_Mandatory ="//span[text()='Facultative' and @role='option']"
    property_Multiple = "css=input[name='multiple']"
    property_DefaultText = "css=input[name='defaultValue']"
    property_Constraint = "//span[text()='Aucun' and @role='option']"
    property_ConstraintExpression = "css=input[name='constraintExpression']"
    property_MinLength = "css=input[name='constraintMinLength']"
    property_MaxLength = "css=input[name='constraintMaxLength']"
    property_MinValue = "css=input[name='constraintMinValue']"
    property_MaxValue = "css=input[name='constraintMaxValue']"
    property_AllowedValues = "css=textarea[name='constraintAllowedValues']"
    property_Sorted = "css=input[name='constraintSorted']"
    property_ConstraintClass = "css=input[name='constraintClass']"
    property_Indexing = "//span[text()='Texte libre' and @role='option']"
    property_CreateButton = "//span[@id='CMM_CREATE_PROPERTY_DIALOG_CREATE_label' and text() = 'Créer']"
    property_DataTypeOption = "//tr[@data-value='"
    property_DataTypeOptionEnd = "']//td[contains(@class, 'dijitMenuItemLabel')]"
    property_MandatoryOption = "//td[text()='"
    property_MandatoryOptionEnd = "' and @role='presentation']"
    property_ConstraintOption = "//td[text()='"
    property_ConstraintOptionEnd = "' and @role='presentation']"
    property_IndexingOption = "//td[text()='"
    property_IndexingOptionEnd = "' and @role='presentation']"
    property_OptionEnd = "']"

Creer une propriete dans un aspect
    # Ce mot clé permet de créer une propriété dans un aspect existant.#     
    # vTypeDonnees est l'un de ses parametres qui peut avoir l'une des valeurs suivantes :
        # d:text
        # d:mltext
        # d:int
        # d:long
        # d:float
        # d:double
        # d:boolean
        # d:date
        # d:datetime
    #vObligatoire est l'un de ses parametres qui peut avoir l'une des valeurs suivantes :
        # Obligatoire
        # Facultative
    #vIndexation est l'un de ses parametres qui peut avoir l'une des valeurs suivantes :
        # Liste de valeurs - correspondance totale
        # Liste de valeurs - correspondance partielle
        # Texte libre
        # Aucun
        # Motif - correspondance uniques
        # Motif - correspondance multiples
    [Arguments]    ${vNomModele}    ${vNomAspect}    ${vNomPropriete}    ${vEtiquetteAffichage}    ${vDescriptionPropriete}    ${vTypeDonnees}    ${vObligatoire}    ${vMultiple}    ${vValeurDefaut}    ${vContrainte}    ${vExpressionReguliere}    ${vLongueurMinimum}    ${vLongueurMaximum}    ${vValeurMinimum}    ${vValeurMaximum}    ${vListeValeurs}    ${vTriAlphanumerique}    ${vNomClasse}    ${vIndexation}

    Go To    ${vURL}/share/page/console/admin-console/custom-model-manager

    Wait Until Element Is Visible    ${model_Name}${vNomModele}${model_NameEnd}
    Click Element    ${model_Name}${vNomModele}${model_NameEnd}

    Wait Until Element Is Visible    ${aspect_Name}${vNomAspect}${aspect_NameEnd}    timeout=20s
    Wait Until Element Is Enabled    ${aspect_Name}${vNomAspect}${aspect_NameEnd}    timeout=20s
    Scroll Element Into View    ${aspect_Name}${vNomAspect}${aspect_NameEnd}
    Click Element    ${aspect_Name}${vNomAspect}${aspect_NameEnd}

    Wait Until Element Is Visible    ${property_Create}
    Click Element    ${property_Create}

    Wait Until Element Is Visible    ${property_Name}

    Input Text    ${property_Name}           ${vNomPropriete}
    Input Text    ${property_Title}          ${vEtiquetteAffichage}
    Input Text    ${property_Description}    ${vDescriptionPropriete}

    Click Element    ${property_DataType}
    Click Element    ${property_DataTypeOption}${vTypeDonnees}${property_DataTypeOptionEnd}

    Click Element    ${property_Mandatory}
    Click Element    ${property_MandatoryOption}${vObligatoire}${property_MandatoryOptionEnd}

    Run Keyword If    '${vMultiple}' == 'True'
    ...    Select Checkbox    ${property_Multiple}

    Input Text    ${property_DefaultText}    ${vValeurDefaut}

    # Sélection de la contrainte
    Click Element    ${property_Constraint}

    Wait Until Element Is Visible    ${property_ConstraintOption}${vContrainte}${property_ConstraintOptionEnd}
    Click Element    ${property_ConstraintOption}${vContrainte}${property_ConstraintOptionEnd}
   
    # Remplissage des champs selon la contrainte

    Run Keyword If    '${vContrainte}' == 'Expression régulière'
    ...    Input Text    ${property_ConstraintExpression}    ${vExpressionReguliere}

    Run Keyword If    '${vContrainte}' == 'Longueur minimum'
    ...    Input Text    ${property_MinLength}    ${vLongueurMinimum}

    Run Keyword If    '${vContrainte}' == 'Longueur maximum'
    ...    Input Text    ${property_MaxLength}    ${vLongueurMaximum}

    Run Keyword If    '${vContrainte}' == 'Valeur minimum'
    ...    Input Text    ${property_MinValue}    ${vValeurMinimum}

    Run Keyword If    '${vContrainte}' == 'Valeur maximum'
    ...    Input Text    ${property_MaxValue}    ${vValeurMaximum}

    Run Keyword If    '${vContrainte}' == 'Liste de valeurs'
    ...    Input Text    ${property_AllowedValues}    ${vListeValeurs}

    Run Keyword If    '${vContrainte}' == 'Liste de valeurs'
    ...    Run Keyword If    '${vTriAlphanumerique}' == 'True'
    ...    Select Checkbox    ${property_Sorted}

    Run Keyword If    '${vContrainte}' == 'Classe Java'
    ...    Input Text    ${property_ConstraintClass}    ${vNomClasse}

    Click Element    ${property_Indexing}

    Wait Until Element Is Visible    ${property_IndexingOption}${vIndexation}${property_IndexingOptionEnd}
    Scroll Element Into View    ${property_IndexingOption}${vIndexation}${property_IndexingOptionEnd}
    Click Element    ${property_IndexingOption}${vIndexation}${property_IndexingOptionEnd}

    Click Element    ${property_CreateButton}    



BTN_ADMIN_TOOLS = "id=HEADER_ADMIN_CONSOLE_text"
LNK_MODEL_MANAGER = "xpath=//a[contains(text(), 'Model Manager')]"

LNK_MODELE_DANS_LISTE_1 = "xpath=//td[contains(@class,'nameColumn')]//span[@class='value' and normalize-space(text())='"
LNK_MODELE_DANS_LISTE_2 = "']"

LNK_TYPE_DANS_LISTE_1 = "xpath=//td[contains(@class,'nameColumn')]//span[@class='value' and normalize-space(text())='"
LNK_TYPE_DANS_LISTE_2 = "']"
ROW_ACTIONS_PROPRIETE_1 = "xpath=(//tr[.//span[@class='value' and normalize-space(text())='"
ROW_ACTIONS_PROPRIETE_2 = "'] and not(ancestor::*[contains(concat(' ',normalize-space(@class),' '),' dijitHidden ')])])[1]//div[@role='menuitem' and contains(@aria-label,'Actions')]"
OPTION_DELETE_PROPRIETE = "xpath=//tr[@role='menuitem' and contains(@title,'Delete')]"
BTN_CONFIRMAR_DELETE_PROPRIETE = "xpath=//span[@role='button' and .//span[contains(@class,'dijitButtonText') and normalize-space(text())='Delete']]"




K34: Supprimer une propiedad dans un type personnalisé
    [Arguments]    ${vModele}    ${vType}    ${vPropriete}
    [Documentation]    Navega a Admin Tools > Model Manager > Modelo > Type > elimina la propiedad.

    # 1. Admin Tools
    Wait Until Element Is Not Visible    id=prompt_mask    timeout=15s
    Wait Until Element Is Visible        ${BTN_ADMIN_TOOLS}    timeout=15s
    Click Element                        ${BTN_ADMIN_TOOLS}

    # 2. Model Manager (sidebar)
    Wait Until Element Is Visible    ${LNK_MODEL_MANAGER}    timeout=10s
    Click Element                    ${LNK_MODEL_MANAGER}

    # 3. Clic en el Modelo (ej. 'nat')
    Wait Until Element Is Visible    ${LNK_MODELE_DANS_LISTE_1}${vModele}${LNK_MODELE_DANS_LISTE_2}    timeout=15s
    Click Element                    ${LNK_MODELE_DANS_LISTE_1}${vModele}${LNK_MODELE_DANS_LISTE_2}

    # 4. Clic en el Type (ej. 'nat:1234') -> navega a la página de Properties
    Wait Until Element Is Visible    ${LNK_TYPE_DANS_LISTE_1}${vType}${LNK_TYPE_DANS_LISTE_2}    timeout=10s
    Click Element                    ${LNK_TYPE_DANS_LISTE_1}${vType}${LNK_TYPE_DANS_LISTE_2}

    # 5. Esperamos a que la tabla de Properties termine de cargar por AJAX
    #    (vimos que a veces aparece "There was a problem getting properties..." mientras carga)
    Wait Until Element Is Visible    ${ROW_ACTIONS_PROPRIETE_1}${vPropriete}${ROW_ACTIONS_PROPRIETE_2}    timeout=15s
    Click Element                    ${ROW_ACTIONS_PROPRIETE_1}${vPropriete}${ROW_ACTIONS_PROPRIETE_2}
    Sleep    1s

    # 6. De todos los "Delete" que existen en el DOM (Alfresco deja varios ocultos),
    #    dejamos que el propio navegador (no nosotros adivinando CSS) nos diga cuál
    #    está realmente visible, y le hacemos clic a ese.
        @{candidatos_delete}=    Get WebElements    ${OPTION_DELETE_PROPRIETE}
    FOR    ${candidato}    IN    @{candidatos_delete}
        ${es_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${candidato}
        IF    ${es_visible}
            Click Element    ${candidato}
            BREAK
        END
    END

    # 7. Confirmar el diálogo "Delete Property"
    Wait Until Element Is Visible    ${BTN_CONFIRMAR_DELETE_PROPRIETE}    timeout=10s
    Click Element                    ${BTN_CONFIRMAR_DELETE_PROPRIETE}

   #8. Verificación de éxito: la FILA de la propiedad (no el texto global) debe desaparecer.
    # (el Type se llama igual que la Property, asi que buscar el texto en toda la pagina nunca funcionaria)
    Wait Until Element Is Not Visible    ${ROW_ACTIONS_PROPRIETE_1}${vPropriete}${ROW_ACTIONS_PROPRIETE_2}    timeout=30s
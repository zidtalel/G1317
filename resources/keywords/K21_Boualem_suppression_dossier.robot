#  Suppression dossier

case_SelectionnerDossier1 = "//a[text()='"
case_SelectionnerDossier2 = "']/ancestor::tr"
lien_PlusActionsDossier1 = "xpath=//tr[.//a[@class='filter-change' and text()='"
lien_PlusActionsDossier2 = "']]//a[@class='show-more']"
lien_SupprimerDossier1 = "//a[text()='"
lien_SupprimerDossier2 = "']/ancestor::tr//div[@id='onActionDelete']/a"
btn_ConfirmerSuppressionDossier = "//div[@id='prompt_c']//button[text()='Supprimer' or text()='Delete']"
mask_Popup = "id=prompt_mask"


Supprimer un dossier ciblé
    [Documentation]    Supprime un dossier spécifique dans la section "Fichiers partagés" d'Alfresco.
    ...
    ...    = Arguments =
    ...    - `${vNomDossier}` : Nom exact du dossier à supprimer.
    ...
    ...    = Étapes exécutées =
    ...    1. Navigue vers l'espace des fichiers partagés.
    ...    2. Localise et survole le dossier ciblé.
    ...    3. Ouvre le menu "Plus d'actions".
    ...    4. Clique sur l'option de suppression.
    ...    5. Confirme la suppression.
    ...    6. Attend la disparition du masque de traitement.
    ...
    ...    = Exemple =
    ...    | Supprimer un dossier ciblé | Rapport_2026 |

    [Arguments]    ${vNomDossier}

    # 1. Navigation vers l'espace des fichiers partagés
    Go To    ${vURL}/context/shared/sharedfiles

    # 2. Localisation et survol du dossier
    Wait Until Element Is Visible    ${case_SelectionnerDossier1}${vNomDossier}${case_SelectionnerDossier2}
    Mouse Over    ${case_SelectionnerDossier1}${vNomDossier}${case_SelectionnerDossier2}

    # 3. Ouverture du menu "Plus d'actions"
    Wait Until Element Is Visible    ${lien_PlusActionsDossier1}${vNomDossier}${lien_PlusActionsDossier2}
    Click Element    ${lien_PlusActionsDossier1}${vNomDossier}${lien_PlusActionsDossier2}

    # 4. Action de suppression du dossier
    Wait Until Element Is Visible    ${lien_SupprimerDossier1}${vNomDossier}${lien_SupprimerDossier2}
    Click Element    ${lien_SupprimerDossier1}${vNomDossier}${lien_SupprimerDossier2}

    # 5. Validation de la confirmation
    Click Element    ${btn_ConfirmerSuppressionDossier}

    # 6. Attente de la disparition du pop-up / masque de traitement
    Wait Until Element Is Not Visible    ${mask_Popup}    timeout=10s

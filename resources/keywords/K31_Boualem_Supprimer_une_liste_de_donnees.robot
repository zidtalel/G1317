
#Supprimer une liste de données (dans un site déjà créé)

lien_SupprimerListeDonnees1 = "//a[@class='filter-link' and contains(normalize-space(), '"
lien_SupprimerListeDonnees2 = "')]"
btn_supp1="//a[contains(@class, 'filter-link') and contains(normalize-space(), '"
btn_supp2="')]//span[@class='delete']"
btn_ConfirmerSuppressionListeDonniers = "//div[@id='prompt_c']//button[text()='Supprimer' or text()='Delete']"




Supprimer une liste de donnees
    [Documentation]    Supprime une liste de données spécifique dans un site Alfresco.
    ...
    ...    = Arguments =
    ...    - `${vNom_Site}` : Nom unique ou identifiant du site Alfresco.
    ...    - `${vNomListe}` : Nom exact de la liste de données à supprimer.
    ...
    ...    = Étapes exécutées =
    ...    1. Navigue vers la page des listes de données du site.
    ...    2. Localise et survole la liste de données ciblée.
    ...    3. Clique sur le bouton de suppression.
    ...    4. Confirme la suppression définitive de la liste.
    ...
    ...    = Exemple =
    ...    | Supprimer une liste de donnees | Projet-Alpha | Liste-Des-Taches |
    [Arguments]    ${vNom_Site}    ${vNomListe}

    # 1. Navigation vers la page des listes de données du site
    Go To    ${vURL}/site/${vNom_Site}/data-lists

    # 2. Localisation et survol de la liste de données ciblée
    Wait Until Element Is Visible    ${lien_SupprimerListeDonnees1}${vNomListe}${lien_SupprimerListeDonnees2}    timeout=10s
    Mouse Over                        ${lien_SupprimerListeDonnees1}${vNomListe}${lien_SupprimerListeDonnees2}

    # 3. Attente et clic sur le bouton de suppression ("Delete")
    Wait Until Element Is Visible    ${btn_supp1}${vNomListe}${btn_supp2}      timeout=5s
    Click Element                    ${btn_supp1}${vNomListe}${btn_supp2}

    # 4. Confirmation de la suppression
    click Element                    ${btn_ConfirmerSuppressionListeDonniers}

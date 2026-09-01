*** Settings ***
Library    SeleniumLibrary
Resource    ../Ressources/PageObjects/Keywords/LoginPage.robot
Resource    ../Ressources/PageObjects/Keywords/FormProjectPage.robot
Resource    ../Ressources/PageObjects/Keywords/ProjectAdminPage.robot
Resource    ../Ressources/PageObjects/Keywords/AdminPage.robot
Resource    ../Ressources/PageObjects/Keywords/MainPage.robot
Variables    ../Ressources/PageObjects/Locators/Locators.py


*** Variables ***

${vTIMEOUT}    5
${vBrowser}    chrome
${vURL}    http://localhost:8082
${vUsername}    6386444
${vPassword}    6386444
${vNomProjet}    ProjetTestFrido100   
${vIdProjet}    projettestfrido10a
${vDescription}    Projet Test Fridoline
${vSiteweb}    Bienvenue a vous

*** Test Cases ***

Test Login
    Login    ${vURL}    ${vBrowser}    ${vUsername}    ${vPassword}

test logout    
    Click Deconnexion



         
        
   
    
        
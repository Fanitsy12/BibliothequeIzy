@echo off
echo ----------------------------------
echo [1] Compilation du projet Maven...
echo ----------------------------------
mvn clean package

if errorlevel 1 (
    echo Erreur lors de la compilation Maven.
    pause
    exit /b 1
)

REM Chercher le war généré (tu peux modifier l'extension si besoin)
for %%f in (target\*.war) do set WARFILE=%%f

if not defined WARFILE (
    echo Fichier WAR introuvable dans target\.
    pause
    exit /b 1
)

echo WAR généré : %WARFILE%

REM Définir chemin Tomcat (à modifier selon ton installation)
set TOMCAT_WEBAPPS=C:\apache-tomcat-10.1.28\webapps

echo Copie du fichier %WARFILE% vers %TOMCAT_WEBAPPS%\Bibliotheque.war
copy "%WARFILE%" "%TOMCAT_WEBAPPS%\Bibliotheque.war"

if errorlevel 1 (
    echo Erreur lors de la copie du fichier WAR.
    pause
    exit /b 1
)

echo Déploiement terminé avec succès.
pause

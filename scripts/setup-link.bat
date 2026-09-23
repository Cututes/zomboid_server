@echo off
REM Corre esto UNA sola vez, despues de clonar el repo, desde cualquier carpeta.
REM Crea un "junction" (link de carpeta) para que tu Zomboid escriba directo
REM dentro de la carpeta del repo clonado. No necesita permisos de administrador.

set REPO_DIR=%~dp0..
set REPO_DIR=%REPO_DIR:~0,-1%
set SAVE_LINK=%USERPROFILE%\Zomboid\Saves\Multiplayer\Cututes
set SAVE_TARGET=%REPO_DIR%\Saves\Multiplayer\Cututes

if exist "%SAVE_LINK%" (
    echo Ya existe algo en "%SAVE_LINK%".
    echo Si es una carpeta normal de un intento anterior, borrala manualmente y vuelve a correr este script.
    echo Si ya es un link, no necesitas hacer nada.
    goto :links_server
)

if not exist "%USERPROFILE%\Zomboid\Saves\Multiplayer" mkdir "%USERPROFILE%\Zomboid\Saves\Multiplayer"

mklink /J "%SAVE_LINK%" "%SAVE_TARGET%"
if errorlevel 1 (
    echo Fallo al crear el link del save. Revisa el mensaje de arriba.
    goto :end
)
echo Link del save creado correctamente.

:links_server
if not exist "%USERPROFILE%\Zomboid\Server" mkdir "%USERPROFILE%\Zomboid\Server"

for %%F in (Cututes.ini Cututes_SandboxVars.lua Cututes_spawnpoints.lua Cututes_spawnregions.lua) do (
    if exist "%USERPROFILE%\Zomboid\Server\%%F" del "%USERPROFILE%\Zomboid\Server\%%F"
    mklink "%USERPROFILE%\Zomboid\Server\%%F" "%REPO_DIR%\Server\%%F" >nul 2>&1
    if errorlevel 1 (
        echo No se pudo linkear %%F como symlink de archivo ^(necesita Modo Desarrollador o admin^).
        echo Copiando el archivo en su lugar como respaldo...
        copy /Y "%REPO_DIR%\Server\%%F" "%USERPROFILE%\Zomboid\Server\%%F" >nul
    )
)

echo.
echo Listo. Ahora edita %USERPROFILE%\Zomboid\Server\Cututes.ini y pon la contrasena real
echo en la linea Password= ^(no la subas al repo^).
echo.
echo IMPORTANTE: antes de hostear corre scripts\before-hosting.bat
echo y despues de cerrar el server corre scripts\after-hosting.bat

:end
pause

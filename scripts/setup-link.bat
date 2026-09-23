@echo off
setlocal enabledelayedexpansion
REM Corre esto UNA sola vez, despues de clonar el repo, desde cualquier carpeta.
REM Crea un "junction" (link de carpeta) para que tu Zomboid escriba directo
REM dentro de la carpeta del repo clonado. No necesita permisos de administrador.

set REPO_DIR=%~dp0..
set REPO_DIR=%REPO_DIR:~0,-1%
set CACHE_FILE=%~dp0.zomboid-path.txt

REM --- 1. Averiguar donde vive tu carpeta Zomboid (saves/mods/server configs) ---
REM No siempre es %USERPROFILE%\Zomboid: si usas -cachedir en Steam, o moviste la
REM carpeta a otro disco (ej. D:\Zomboid), puede estar en cualquier lado.

set ZOMBOID_DIR=

if exist "%CACHE_FILE%" (
    for /f "usebackq delims=" %%P in ("%CACHE_FILE%") do set ZOMBOID_DIR=%%P
    if not exist "!ZOMBOID_DIR!" set ZOMBOID_DIR=
)

if "!ZOMBOID_DIR!"=="" (
    if exist "%USERPROFILE%\Zomboid\" set ZOMBOID_DIR=%USERPROFILE%\Zomboid
)

if "!ZOMBOID_DIR!"=="" (
    echo Buscando la carpeta Zomboid en la raiz de cada disco...
    for %%D in (C D E F G H) do (
        if exist "%%D:\Zomboid\" (
            echo Encontrada: %%D:\Zomboid
            set ZOMBOID_DIR=%%D:\Zomboid
        )
    )
)

if "!ZOMBOID_DIR!"=="" (
    echo No encontre tu carpeta Zomboid automaticamente.
) else (
    echo Se detecto tu carpeta Zomboid en: !ZOMBOID_DIR!
)

echo.
set /p CONFIRM="Presiona ENTER para usar esa ruta, o escribe la ruta correcta (ej. D:\Zomboid) y ENTER: "
if not "!CONFIRM!"=="" set ZOMBOID_DIR=!CONFIRM!

if "!ZOMBOID_DIR!"=="" (
    echo No se especifico ninguna ruta. Cancelando.
    goto :end
)
if not exist "!ZOMBOID_DIR!" (
    echo La ruta "!ZOMBOID_DIR!" no existe. Revisa y vuelve a correr el script.
    goto :end
)

REM Guardar la ruta para no volver a preguntar la proxima vez
echo !ZOMBOID_DIR!> "%CACHE_FILE%"

REM --- 2. Link de la carpeta del save ---
set SAVE_LINK=!ZOMBOID_DIR!\Saves\Multiplayer\Cututes
set SAVE_TARGET=%REPO_DIR%\Saves\Multiplayer\Cututes

if exist "!SAVE_LINK!" (
    echo Ya existe algo en "!SAVE_LINK!".
    echo Si es una carpeta normal de un intento anterior, borrala manualmente y vuelve a correr este script.
    echo Si ya es un link, no necesitas hacer nada.
    goto :links_server
)

if not exist "!ZOMBOID_DIR!\Saves\Multiplayer" mkdir "!ZOMBOID_DIR!\Saves\Multiplayer"

mklink /J "!SAVE_LINK!" "%SAVE_TARGET%"
if errorlevel 1 (
    echo Fallo al crear el link del save. Revisa el mensaje de arriba.
    goto :end
)
echo Link del save creado correctamente.

:links_server
if not exist "!ZOMBOID_DIR!\Server" mkdir "!ZOMBOID_DIR!\Server"

for %%F in (Cututes.ini Cututes_SandboxVars.lua Cututes_spawnpoints.lua Cututes_spawnregions.lua) do (
    if exist "!ZOMBOID_DIR!\Server\%%F" del "!ZOMBOID_DIR!\Server\%%F"
    mklink "!ZOMBOID_DIR!\Server\%%F" "%REPO_DIR%\Server\%%F" >nul 2>&1
    if errorlevel 1 (
        echo No se pudo linkear %%F como symlink de archivo ^(necesita Modo Desarrollador o admin^).
        echo Copiando el archivo en su lugar como respaldo...
        copy /Y "%REPO_DIR%\Server\%%F" "!ZOMBOID_DIR!\Server\%%F" >nul
    )
)

echo.
echo Listo. Ahora edita "!ZOMBOID_DIR!\Server\Cututes.ini" y pon la contrasena real
echo en la linea Password= ^(no la subas al repo^).
echo.
echo IMPORTANTE: antes de hostear corre scripts\before-hosting.bat
echo y despues de cerrar el server corre scripts\after-hosting.bat

:end
pause

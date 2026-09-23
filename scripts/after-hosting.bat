@echo off
REM Corre esto SIEMPRE despues de cerrar el server (cerrar el juego /
REM detener el host), para subir el progreso y que otra persona del grupo
REM pueda continuar la partida.

cd /d "%~dp0.."

echo Revisando cambios en el mundo...
git add -A

git diff --cached --quiet
if %errorlevel%==0 (
    echo No hubo cambios en el mundo desde la ultima subida. Nada que hacer.
    pause
    exit /b 0
)

for /f "tokens=1-3 delims=/ " %%a in ('date /t') do set FECHA=%%a-%%b-%%c
for /f "tokens=1-2 delims=: " %%a in ('time /t') do set HORA=%%a-%%b

git commit -m "Sesion %FECHA% %HORA%"
if errorlevel 1 (
    echo Fallo el commit. Revisa el mensaje de arriba.
    pause
    exit /b 1
)

echo Subiendo cambios...
git push
if errorlevel 1 (
    echo.
    echo ================================================================
    echo ERROR al subir. Probablemente alguien mas subio cambios primero.
    echo Corre "git pull" manualmente y pide ayuda para resolverlo antes
    echo de que alguien mas intente hostear.
    echo ================================================================
    pause
    exit /b 1
)

echo.
echo Listo, el progreso quedo subido. Cualquiera del grupo puede continuar.
pause

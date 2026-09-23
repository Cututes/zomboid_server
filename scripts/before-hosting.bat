@echo off
REM Corre esto SIEMPRE antes de darle a Host, para traer la ultima version
REM del mundo que haya subido otra persona del grupo.

cd /d "%~dp0.."

echo Buscando cambios nuevos...
git fetch

git status -uno | findstr /C:"Your branch is behind" >nul
if %errorlevel%==0 (
    echo Hay cambios nuevos, actualizando...
    git pull
    if errorlevel 1 (
        echo.
        echo ================================================================
        echo ERROR al actualizar. Puede que tengas cambios locales sin subir
        echo de una sesion anterior. Corre scripts\after-hosting.bat primero
        echo si acabas de jugar, o pide ayuda antes de continuar.
        echo ================================================================
        pause
        exit /b 1
    )
    echo Mundo actualizado correctamente.
) else (
    echo Ya tienes la ultima version del mundo. Todo listo para hostear.
)

echo.
echo Puedes iniciar el juego y darle Host normalmente.
pause

@echo off
chcp 65001 >nul
REM =============================================
REM Unreal Engine Projekt Cleanup & VS Solution Start
REM =============================================

REM ----------
REM Pfade setzen
REM ----------
set "SCRIPT_DIR=C:\Projects\InventoryPlugin"
set "UPROJECT=%SCRIPT_DIR%\InventorySystem.uproject"
set "UBT=C:\Program Files\Epic Games\UE_5.6\Engine\Binaries\DotNET\UnrealBuildTool\UnrealBuildTool.exe"
set "UEEDITOR=C:\Program Files\Epic Games\UE_5.6\Engine\Binaries\Win64\UnrealEditor.exe"
set "PROJECT_FILE=%SCRIPT_DIR%\InventorySystem.sln"
set "PLUGIN_DIR=%SCRIPT_DIR%\Plugins\Inventory"

REM -------------------------
REM 1. Voraussetzungen prüfen
REM -------------------------
echo Prüfe Voraussetzungen...

if not exist "%UBT%" (
    echo ❌ UBT nicht gefunden
    pause
    exit /b 1
)

if not exist "%UPROJECT%" (
    echo ❌ .uproject nicht gefunden
    pause
    exit /b 1
)

if not exist "%UEEDITOR%" (
    echo ❌ Editor nicht gefunden
    pause
    exit /b 1
)

REM ---------------------
REM 2. Cleanup durchführen
REM ---------------------
echo Führe Cleanup durch...

for %%D in (Binaries Intermediate Saved .vs .vscode) do (
    if exist "%SCRIPT_DIR%\%%D" (
        echo Lösche %%D...
        rmdir /S /Q "%SCRIPT_DIR%\%%D" 2>nul
    )
)

for %%D in (Binaries Intermediate) do (
    if exist "%PLUGIN_DIR%\%%D" (
        echo Lösche Plugin\%%D...
        rmdir /S /Q "%PLUGIN_DIR%\%%D" 2>nul
    )
)

REM Alte Projektdateien löschen
for %%F in (*.sln) do (
    if exist "%SCRIPT_DIR%\%%F" (
        echo Lösche %%F...
        del /Q "%SCRIPT_DIR%\%%F" 2>nul
    )
)

REM --------------------------
REM 3. Visual Studio Solution generieren
REM --------------------------
echo.
echo Generiere Visual Studio Solution...

cd /d "%SCRIPT_DIR%"

"%UBT%" -projectfiles -project="%UPROJECT%" -game -rocket -progress -vscode=0 2>nul

REM --------------------------
REM 4. Prüfen ob .sln erstellt wurde
REM --------------------------
if exist "%PROJECT_FILE%" (
    echo.
    echo ✅ .sln erfolgreich erstellt!
) else (
    echo.
    echo ❌ Fehler: .sln wurde nicht gefunden!
    pause
    exit /b 1
)

REM --------------------------
REM 5. Unreal Editor starten
REM --------------------------
echo.
echo Starte Unreal Editor...

start "" "%UEEDITOR%" "%UPROJECT%" -editor

timeout /t 3 /nobreak >nul

powershell -command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}')" 2>nul

echo.
echo ✅ Fertig!
echo Öffne Solution mit: start "" "%PROJECT_FILE%"

exit /b 0
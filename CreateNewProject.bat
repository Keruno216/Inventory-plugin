@echo off
REM =============================================
REM Unreal Engine Projekt Cleanup & Editor Start
REM =============================================
REM ----------
REM Pfade setzen
REM ----------
set "SCRIPT_DIR=%~dp0"
set "UPROJECT=%SCRIPT_DIR%InventorySystem.uproject"
set "UBT=C:\Program Files\Epic Games\UE_5.6\Engine\Binaries\DotNET\UnrealBuildTool\UnrealBuildTool.exe"
set "UEEDITOR=C:\Program Files\Epic Games\UE_5.6\Engine\Binaries\Win64\UnrealEditor.exe"
set "PLUGIN_DIR=%SCRIPT_DIR%Plugins\Inventory"

REM -------------------------
REM 1. Voraussetzungen prüfen
REM -------------------------
echo Prüfe Voraussetzungen...
if not exist "%UBT%" (
    echo ❌ Fehler: UnrealBuildTool.exe nicht gefunden unter %UBT%
    pause
    exit /b 1
)
if not exist "%UPROJECT%" (
    echo ❌ Fehler: .uproject nicht gefunden unter %UPROJECT%
    pause
    exit /b 1
)
if not exist "%UEEDITOR%" (
    echo ❌ Fehler: UnrealEditor.exe nicht gefunden unter %UEEDITOR%
    pause
    exit /b 1
)

REM ---------------------
REM 2. Cleanup durchführen
REM ---------------------
echo Führe Cleanup durch...
for %%D in (Binaries Intermediate Saved) do (
    if exist "%SCRIPT_DIR%%%D" (
        echo Lösche %SCRIPT_DIR%%%D...
        rmdir /S /Q "%SCRIPT_DIR%%%D"
    )
)
for %%D in (Binaries Intermediate) do (
    if exist "%PLUGIN_DIR%\%%D" (
        echo Lösche %PLUGIN_DIR%\%%D...
        rmdir /S /Q "%PLUGIN_DIR%\%%D"
    )
)
if exist "%SCRIPT_DIR%InventorySystem.sln" (
    echo Lösche alte .sln-Datei...
    del /Q "%SCRIPT_DIR%InventorySystem.sln"
)

REM --------------------------
REM 3. Projektdateien generieren
REM --------------------------
echo Generiere Projektdateien...
cd /d "%SCRIPT_DIR%"
"%UBT%" -projectfiles -project="%UPROJECT%" -game -rocket -progress

REM --------------------------
REM 4. Auf .sln warten
REM --------------------------
echo Warte auf .sln-Generierung...
:WAIT_FOR_SLN
if not exist "%SCRIPT_DIR%InventorySystem.sln" (
    timeout /t 1 /nobreak >nul
    goto WAIT_FOR_SLN
)

REM --------------------------
REM 5. Editor starten
REM --------------------------
echo .sln-Datei gefunden! Starte Unreal Editor...
start "" "%UEEDITOR%" "%UPROJECT%" -editor

REM --------------------------
REM 6. Warten und Enter senden
REM --------------------------
echo Warte 3 Sekunden und sende Enter-Taste...
timeout /t 3 /nobreak >nul

REM Enter-Taste senden
powershell -command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}')"

echo ✅ Alle Schritte erfolgreich abgeschlossen!
exit /b 0
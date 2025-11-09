@echo off
chcp 65001 >nul
REM =============================================
REM Unreal Engine Projekt Cleanup & Editor Start
REM =============================================
REM ----------
REM Pfade setzen
REM ----------
set "SCRIPT_DIR=C:\Projects\InventorySystem"
set "UPROJECT=%SCRIPT_DIR%\InventorySystem.uproject"
set "UBT=C:\Program Files\Epic Games\UE_5.6\Engine\Binaries\DotNET\UnrealBuildTool\UnrealBuildTool.exe"
set "UEEDITOR=C:\Program Files\Epic Games\UE_5.6\Engine\Binaries\Win64\UnrealEditor.exe"
set "PLUGIN_DIR=%SCRIPT_DIR%\Plugins\Inventory"
set "WORKSPACE=%SCRIPT_DIR%\InventorySystem.code-workspace"
REM -------------------------
REM 1. Voraussetzungen prüfen
REM -------------------------
echo Prüfe Voraussetzungen...
if not exist "%UBT%" (echo ❌ UBT nicht gefunden & pause & exit /b 1)
if not exist "%UPROJECT%" (echo ❌ .uproject nicht gefunden & pause & exit /b 1)
if not exist "%UEEDITOR%" (echo ❌ Editor nicht gefunden & pause & exit /b 1)
REM ---------------------
REM 2. Cleanup durchführen
REM ---------------------
echo Führe Cleanup durch...
REM Ordner löschen
for %%D in (Binaries Intermediate Saved .vs .vscode) do (
    if exist "%SCRIPT_DIR%\%%D" (
        echo Lösche %%D...
        rmdir /S /Q "%SCRIPT_DIR%\%%D" 2>nul
    )
)
REM Plugin-Ordner löschen
for %%D in (Binaries Intermediate) do (
    if exist "%PLUGIN_DIR%\%%D" (
        echo Lösche Plugin\%%D...
        rmdir /S /Q "%PLUGIN_DIR%\%%D" 2>nul
    )
)
REM Alte Projektdateien löschen
for %%F in (*.sln *.code-workspace) do (
    if exist "%SCRIPT_DIR%\%%F" (
        echo Lösche %%F...
        del /Q "%SCRIPT_DIR%\%%F" 2>nul
    )
)
REM --------------------------
REM 3. VS Code Projektdateien generieren
REM --------------------------
echo.
echo Generiere VS Code Projektdateien...
cd /d "%SCRIPT_DIR%"
"%UBT%" -projectfiles -project="%UPROJECT%" -game -rocket -progress -vscode 2>nul | findstr /V "Re-writing"
REM --------------------------
REM 4. .code-workspace manuell erstellen
REM --------------------------
echo.
echo Erstelle .code-workspace Datei...
(
echo {
echo   "folders": [
echo     {
echo       "name": "InventorySystem",
echo       "path": "."
echo     },
echo     {
echo       "name": "UE5",
echo       "path": "C:\\Program Files\\Epic Games\\UE_5.6"
echo     }
echo   ],
echo   "settings": {
echo     "typescript.tsc.autoDetect": "off"
echo   },
echo   "extensions": {
echo     "recommendations": [
echo       "ms-vscode.cpptools",
echo       "ms-dotnettools.csharp"
echo     ]
echo   }
echo }
) > "%WORKSPACE%"
if exist "%WORKSPACE%" (
    echo ✅ .code-workspace erfolgreich erstellt!
) else (
    echo ❌ Fehler beim Erstellen der .code-workspace
    pause
    exit /b 1
)
REM --------------------------
REM 5. Unreal Editor starten
REM --------------------------
echo.
echo Starte Unreal Editor...
start "" "%UEEDITOR%" "%UPROJECT%" -editor
REM Warte auf Editor-Start
timeout /t 3 /nobreak >nul
REM Enter-Taste senden (falls Dialogfenster)
powershell -command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}')" 2>nul
echo.
echo ✅ Fertig!
echo.
echo Öffne in VS Code mit: code "%WORKSPACE%"
echo.
exit /b 0
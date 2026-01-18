@echo off
chcp 65001 >nul
title MSGBOX - PRO GENERATOR
:BOX
cls
set "Schildericon=0"
set "Schildknöpfe=0"
set "Summe=0"

echo Hallo! Und Willkommen in meinem Schild Generator!
echo.
set /p Schildername="Wie soll dein Schild Heißen?: "
set /p Schildinhalt="Was soll in deinem Schild stehen?: "

echo.
echo Was für ein Icon willst du haben?
echo 1. Rotes Stopp-Schild (X)
echo 2. Blaues Fragezeichen (?)
echo 3. Gelbes Warn-Dreieck (!)
echo 4. Blaues Info-Zeichen (i)
choice /c 1234 /N /M "Deine Wahl: "
if errorlevel 4 set Schildericon=64
if errorlevel 3 set Schildericon=48
if errorlevel 2 set Schildericon=32
if errorlevel 1 set Schildericon=16

echo.
echo Welche Knöpfe willst du in deinem Schild haben?
echo 1. Nur "OK"
echo 2. "OK" und "Abbrechen"
echo 3. "Abbruch", "Wiederholen", "Ignorieren"
echo 4. "Ja", "Nein" und "Abbrechen"
echo 5. "Ja" und "Nein"
echo 6. "Wiederholen" und "Abbrechen"
echo 7. "Ja" und "Nein" (Programmieren)
choice /c 1234567 /N /M "Deine Wahl: "

if errorlevel 7 goto PRO
if errorlevel 6 set Schildknöpfe=5
if errorlevel 5 set Schildknöpfe=4
if errorlevel 4 set Schildknöpfe=3
if errorlevel 3 set Schildknöpfe=2
if errorlevel 2 set Schildknöpfe=1
if errorlevel 1 set Schildknöpfe=0

set /a Summe=%Schildericon%+%Schildknöpfe%

:: Normales Schild (Einzelner Trichter reicht hier)
echo msgbox "%Schildinhalt%", %Summe%, "%Schildername%" > "%temp%\Test.vbs"
start /wait "" "%temp%\Test.vbs"
del "%temp%\Test.vbs"
goto BOX

:PRO
set Schildknöpfe=4
set /a Summe=%Schildericon%+%Schildknöpfe%

echo.
echo Was soll passieren, wenn auf JA gedrueckt wurde?
set /p BefehlJA="(Befehl fuer Batch): "
echo Was soll passieren, wenn auf NEIN gedrueckt wurde?
set /p BefehlNEIN="(Befehl fuer Batch): "

:: DIE ANDERE WEISE: Jede Zeile bekommt ihren eigenen Trichter! [cite: 2025-12-31]
:: Wir nutzen ">" für die erste Zeile (neu erstellen) und ">>" für den Rest (anhängen)
echo antwort = msgbox("%Schildinhalt%", %Summe%, "%Schildername%") > "%temp%\Test.vbs"
echo if antwort = 6 Then >> "%temp%\Test.vbs"
echo WScript.Quit(6) >> "%temp%\Test.vbs"
echo else >> "%temp%\Test.vbs"
echo WScript.Quit(7) >> "%temp%\Test.vbs"
echo end if >> "%temp%\Test.vbs"

:: Jetzt starten wir die Datei aus dem Temp-Ordner [cite: 2025-12-31]
start /wait "" "%temp%\Test.vbs"

if %errorlevel% equ 6 %BefehlJA%
if %errorlevel% equ 7 %BefehlNEIN%

del "%temp%\Test.vbs"
pause
goto BOX
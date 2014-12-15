@echo off

rem LICENSE
rem  Copyright © 2013 Alberto Dietze "DoctorD90"
rem 
rem     This program is free software: you can redistribute it and/or modify
rem     it under the terms of the GNU General Public License as published by
rem     the Free Software Foundation, either version 3 of the License, or
rem     (at your option) any later version.
rem 
rem     This program is distributed in the hope that it will be useful,
rem     but WITHOUT ANY WARRANTY; without even the implied warranty of
rem     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
rem     GNU General Public License for more details.
rem 
rem     You should have received a copy of the GNU General Public License
rem     along with this program.  If not, see <http://www.gnu.org/licenses/>.
rem 
rem  Full GPLv3 Text: http://www.gnu.org/licenses/gpl.txt


SetLocal
set tit=TeamSpeak 3 UserInfo
set TS3BAKVER=2.0
title %tit% MANAGER

REM LOGO
set logo1================================================================================
set logo2=			%tit% v.%TS3BAKVER% :
set logo3================================================================================
set logo4=                                                        \\ Credit to DoctorD90
set logo5=                                                          \====================

rem Cartella Dati Applicazioni
if exist "%APPDATA%\TS3Client\" (
  set TS3DIR=%APPDATA%\TS3Client
) else if exist "C:\Program Files\TeamSpeak 3 Client\config" (
  set TS3DIR=%APPDATA%\TS3Client
) else (
  goto ERROR
)


:MAN
cls
echo %logo1%
echo %logo2% Manager
echo %logo3%
echo %logo4%
echo %logo5%
echo.
echo Questo e' un Tool per Sistemi Operativi Microsoft XP/Vista/7 per il
echo Backup/Ripristino del Vostro account TeamSpeak 3 Client
echo.
echo Selezionare l'operazione che si desidera eseguire e premere INVIO
echo.
echo 1.Backup
echo 2.Rispristino
echo 3.Uscire
echo.
set /p man=
if d"%man%"b == d"1"b goto BACKUP
if d"%man%"b == d"2"b goto RESTORE
if d"%man%"b == d"3"b goto EXIT
goto MAN

:BACKUP
cls
if exist "%USERPROFILE%\Desktop\TS3Backup.zip" goto ERROR
color 0a
cls
echo %logo1%
echo %logo2% Backup
echo %logo3%
echo %logo4%
echo %logo5%
echo.
xcopy /E /V /I /H /K /Y %TS3DIR% %TEMP%\TS3Backup
if d"%errorlevel%"b == d"1"b goto ERROR
7za920 a -y -bd -tzip %USERPROFILE%\Desktop\TS3Backup %TEMP%\TS3Backup
if d"%errorlevel%"b == d"1"b goto ERROR
7za920 t -bd %USERPROFILE%\Desktop\TS3Backup.zip
if d"%errorlevel%"b == d"1"b goto ERROR
rd /S /Q %TEMP%\TS3Backup
if d"%errorlevel%"b == d"1"b goto ERROR
echo.
echo ======================================
echo      OPERAZIONE          ::   %%%%%%%%  ::
echo ======================================
echo  Esecuzione Backup       ::   100%%  ::
echo  Controllo dati Backup   ::   100%%  ::
echo ======================================
echo.
echo Backup riuscito con SUCCESSO!
goto END

:RESTORE
color 0b
cls
echo %logo1%
echo %logo2% Restore
echo %logo3%
echo %logo4%
echo %logo5%
echo.
echo !!!WARNING!!!
echo Il ripristino verra' posizinato nella seguente cartella:
echo.
echo 	%TS3DIR%
echo.
echo.
echo Prima di continuare, assicurarsi che sul proprio Desktop
echo sia presente il file di Backup prodotto con questo stesso programma.
echo.
echo Cliccare sul file di backup con il tasto destro del mouse
echo e selezionare "Proprieta'" per accertarsi che:
echo.
echo Il Nome del file sia:         TS3Backup.zip
echo Il Tipo di file sia:          Cartella Compressa (.zip)
echo.
echo Una volta eseguita tale procedura,
pause
cls
if not exist "%USERPROFILE%\Desktop\TS3Backup.zip" goto ERROR
echo %logo1%
echo %logo2% Restore
echo %logo3%
echo %logo4%
echo %logo5%
echo.
7za920 x -y -bd -o%TEMP% %USERPROFILE%\Desktop\TS3Backup.zip
if d"%errorlevel%"b == d"1"b goto ERROR
xcopy /E /V /I /H /K /Y %TEMP%\TS3Backup\* %TS3DIR%
if d"%errorlevel%"b == d"1"b goto ERROR
rd /S /Q %TEMP%\TS3Backup
if d"%errorlevel%"b == d"1"b goto ERROR
echo.
echo ======================================
echo      OPERAZIONE          ::   %%%%%%%%  ::
echo ======================================
echo  Ripristino Backup       ::   100%%  ::
echo ======================================
echo.
echo Ripristino riuscito con SUCCESSO!
goto END

:ERROR
rd /S /Q %TEMP%\TS3Backup
rd /S /Q %USERPROFILE%\Desktop\TS3Backup.zip
color 0c
cls
echo %logo1%
echo %logo2% ERROR
echo %logo3%
echo %logo4%
echo %logo5%
echo.
echo                           !!!OPERAZIONE  ANNULLATA!!!
echo.
echo E' stato riscontrato un errore durante l'operazione.
echo.
echo Prego riavviare il programma dopo aver effettuato i seguenti controlli:
echo  -Accettarsi di aver installato TS3 Client;
echo  -Accettarsi di aver chiuso TS3 Client;
echo  -Possedere i permessi di lettura\scrittura del Disco di destinazione;
echo  -I dati riguardanti il ripristino siano corretti;
echo  -Non sia gia' presente un TS3Backup.zip sul proprio Desktop;
echo.
echo   Se il problema persiste, contattare il ServerAdmin.
:END
echo.
pause

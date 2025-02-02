@ECHO off

::--------------------------------------------JUST REQUESTING ADMIN PRIVILIGES--------------------------------------------
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

::------------------------------------------------ ADVANCED WINDOWS TWEAKS ----------------------------------------------
MODE CON: COLS=135 LINES=44
TITLE Advanced Windows Tweaker
COLOR 0A


SET pathToAssets=".\Assets (Don't Move, Delete or Rename)"

IF EXIST %pathToAssets% (
	GOTO MainMenu
) ELSE (
	ECHO :( ASSETS FOLDER WAS NOT FOUND! REMEMBER THAT THIS FOLDER CANNOT BE MOVED, RENAMED OR DELETED...
	PAUSE
	EXIT
)


:MainMenu
	CLS
	ECHO ---------------------------------------------------------------MAIN MENU---------------------------------------------------------------
	ECHO.
	ECHO.
	ECHO (1) WINDOWS TWEAKS     [TELEMETRY ~ ADS ~ REMOVAL OF PREINSTALLED BLOAT ~ EFFECTS ~ ANIMATIONS ~ WINDOWS UPDATE ~ COPILOT ~ RECALL]
	ECHO.
	ECHO.
	ECHO.
	ECHO (2) WINDOWS UI CHANGER     [OLD RIGHT-CLICK CONTEXT MENU ~ OLD VOLUME MIXER ~ ADVANCED TASKBAR SETTINGS]
	ECHO.
	ECHO.
	ECHO.
	ECHO (3) WINDOWS PREINSTALLED BLOAT UNINSTALLER     [ASKS FOR REMOVAL OF PREINSTALLED MICROSOFT'S JUNK APPS ON YOUR SYSTEM]
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO                                        TIP: USE [CTRL + MOUSE WHEEL UP] TO ZOOM IN THE CMD WINDOW
	ECHO.
	ECHO                                                     =========== ======= ===========
	ECHO                                                     -    PROCEED WITH CAUTION     -
	ECHO                                                     =========== ======= ===========
	ECHO                                                     -           V 2.0.0           -
	ECHO                                                     =========== ======= ===========
	ECHO.
	ECHO.
	SET userChoice="0"
	SET /P userChoice=ENTER YOUR CHOICE (number)-(exit): 
	
	CLS
	ECHO %userChoice% | FIND /I "exit" > NUL && (
		EXIT
	)
	ECHO %userChoice% | FIND /I "1" > NUL && (
		GOTO TweaksMenu
	)
	ECHO %userChoice% | FIND /I "2" > NUL && (
		GOTO UIChangerMenu
	)
	ECHO %userChoice% | FIND /I "3" > NUL && (
		
		CALL ".\Assets (Don't Move, Delete or Rename)\Preinstalled Bloat Uninstaller.bat"
		CD /D "%~dp0"
		
		ECHO.
	)
	PAUSE
	GOTO MainMenu

:TweaksMenu
	CLS
	ECHO ----------------------------------------------------------------TWEAKS-----------------------------------------------------------------
	ECHO.
	ECHO.
	ECHO                                                     =========== PRIVACY ===========
	ECHO.
	ECHO (A) DISABLE TELEMETRY AND TRACKING [RECOMENDATIONS ~ ADS ~ SUGGESTIONS ~ ACTIVITY HISTORY ~ CORTANA ~ WEBSEARCH IN SEARCHBOX ~ FEEDS]
	ECHO.
	ECHO (B) DISABLE LOCATION TRACKING [REMOVES LOCATION ACCESS TO WINDOWS AND APPS]
	ECHO.
	ECHO.
	ECHO                                                     =========== DEBLOAT ===========
	ECHO.
	ECHO (C) DISABLE AI [COPILOT ~ RECALL]
	ECHO.
	ECHO (D) DISABLE GAMEDVR AND BROADCASTING [GAMEDVR ~ IN-GAME CAPTURES ~ GAMEPLAY RECORDER]
	ECHO.
	ECHO (E) DEBLOAT MICROSOFT EDGE [MICROSOFT EDGE AT STARTUP ~ MICROSOFT EDGE TRACKING ~ MICROSOFT EDGE SECURITY ~ TAB PRELOADING]
	ECHO.
	ECHO.
	ECHO                                                     ========= PERFORMANCE =========
	ECHO.
	ECHO (F) DISABLE ALL VISUAL EFFECTS AND ANIMATIONS [ANIMATIONS ~ SIGN-IN SCREEN BACKGROUND ~ TRANSPARENCY]
	ECHO.
	ECHO (G) DISABLE BACKGROUND APPS [BACKGROUND APPS]
	ECHO.
	ECHO (H) SET SERVICES TO MANUAL [SET A BUNCH OF WINDOWS SERVICES TO MANUAL SO THEY RUN ONLY WHEN THEY ARE NEEDED]
	ECHO.
	ECHO.
	ECHO                                                     =========== FEATURES ==========
	ECHO.
	ECHO (I) ENABLE WINDOWS PHOTO VIEWER APP [ENABLES WINDOWS PHOTO VIEWER APP TO OPEN ANY IMAGE FORMAT]
	ECHO.
	ECHO (J) DECREASE STARTUP TIME [ELIMINATE DEAD TIME AT STARTUP ADDED BY WINDOWS]
	ECHO.
	ECHO.
	ECHO                                                     ============ UPDATES ===========
	ECHO.
	ECHO (K) SECURITY UPDATES ONLY [DELAYS FEATURE UPDATES BY APPROXIMATELY ONE YEAR AND SECURITY UPDATES BY AROUND FOUR DAYS]
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	SET userChoice="0"
	SET /P userChoice=ENTER YOUR CHOICE (letter)-(letter, letter, letter)-(all)-(back): 
	
	CLS
	ECHO %userChoice% | FIND /I "all" > NUL && (
		SET userChoice="abcdefghijklmnopqrstuvwxyz"
	)
	ECHO %userChoice% | FIND /I "back" > NUL && (
		GOTO MainMenu
	)
	ECHO %userChoice% | FIND /I "A" > NUL && (
		ECHO STARTING...
		
		ECHO DISABLING TELEMETRY SERVICES...
		cmd.exe /C "SC STOP DiagTrack" > NUL
		cmd.exe /C "SC CONFIG DiagTrack START= disabled" > NUL
		cmd.exe /C "SC STOP dmwappushservice" > NUL
		cmd.exe /C "SC CONFIG dmwappushservice START= disabled" > NUL
		
		ECHO DISABLING SCHEDULED TELEMETRY...
		SCHTASKS /CHANGE /TN "\Microsoft\Windows\Application Experience\StartupAppTask" /DISABLE > NUL
		SCHTASKS /CHANGE /TN "\Microsoft\Windows\Application Experience\PcaPatchDbTask" /DISABLE > NUL
		SCHTASKS /CHANGE /TN "\Microsoft\Windows\Application Experience\MareBackup" /DISABLE > NUL
		SCHTASKS /CHANGE /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /DISABLE > NUL
		SCHTASKS /CHANGE /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /DISABLE > NUL
		SCHTASKS /CHANGE /TN "\Microsoft\Windows\Application Experience\PcaWallpaperAppDetect" /DISABLE > NUL
		SCHTASKS /CHANGE /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /DISABLE > NUL
		SCHTASKS /CHANGE /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /DISABLE > NUL
		SCHTASKS /CHANGE /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /DISABLE > NUL
		SCHTASKS /CHANGE /TN "\Microsoft\Windows\Feedback\Siuf\DmClient" /DISABLE > NUL
		SCHTASKS /CHANGE /TN "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /DISABLE > NUL
		SCHTASKS /CHANGE /TN "\Microsoft\Windows\Autochk\Proxy" /DISABLE > NUL
		SCHTASKS /CHANGE /TN "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /DISABLE > NUL
		
		ECHO DISABLING TELEMETRY THROUGH THE REGISTRY EDITOR...
		REG IMPORT ".\Assets (Don't Move, Delete or Rename)\Disable Telemetry & Tracking.reg" > NUL
		
		ECHO UNINSTALLING WINDOWS FEEDS...
		PowerShell -Command "Get-AppxPackage | Where-Object {$_.Name -like '*WebExperience*'} | Remove-AppxPackage" > NUL
		
		ECHO DONE!
		ECHO.
	)
	ECHO %userChoice% | FIND /I "B" > NUL && (
		ECHO STARTING...
		
		ECHO DISABLING LOCATION THROUGH THE REGISTRY EDITOR...
		REG IMPORT ".\Assets (Don't Move, Delete or Rename)\Disable Location Tracking.reg" > NUL
		
		ECHO DONE!
		ECHO.
	)
	ECHO %userChoice% | FIND /I "C" > NUL && (
		ECHO STARTING...
		
		ECHO DISABLING WINDOWS COPILOT AND WINDOWS RECALL THROUGH THE REGISTRY EDITOR...
		REG IMPORT ".\Assets (Don't Move, Delete or Rename)\Disable Copilot & Recall.reg" > NUL
		
		ECHO DONE!
		ECHO.
	)
	ECHO %userChoice% | FIND /I "D" > NUL && (
		ECHO STARTING...
		
		ECHO DISABLING GAMEDVR THROUGH THE REGISTRY EDITOR...
		REG IMPORT ".\Assets (Don't Move, Delete or Rename)\Disable GameDVR.reg" > NUL
		
		ECHO DONE!
		ECHO.
	)
	ECHO %userChoice% | FIND /I "E" > NUL && (
		ECHO STARTING...
		
		ECHO SETTING MICROSOFT EDGE SERVICES TO MANUAL...
		cmd.exe /C "SC CONFIG edgeupdate START= manual" > NUL
		cmd.exe /C "SC CONFIG edgeupdatem START= manual" > NUL
		cmd.exe /C "SC CONFIG MicrosoftEdgeElevationService START= MANUAL" > NUL
		
		ECHO DEBLOATING MICROSOFT EDGE THROUGH THE REGISTRY EDITOR...
		REG IMPORT ".\Assets (Don't Move, Delete or Rename)\Debloat Microsoft Edge.reg" > NUL
		
		ECHO DONE!
		ECHO.
	)
	ECHO %userChoice% | FIND /I "F" > NUL && (
		ECHO STARTING...
		
		ECHO DISABLING ANIMATIONS AND EFFECTS THROUGH THE REGISTRY EDITOR...
		REG IMPORT ".\Assets (Don't Move, Delete or Rename)\Disable Visual Effects & Animations.reg" > NUL
		
		ECHO DONE!
		ECHO.
	)
	ECHO %userChoice% | FIND /I "G" > NUL && (
		ECHO STARTING...
		
		ECHO DISABLING BACKGROUND APPS THROUGH THE REGISTRY EDITOR...
		REG IMPORT ".\Assets (Don't Move, Delete or Rename)\Disable Background Apps.reg" > NUL
		
		ECHO DONE!
		ECHO.
	)
	ECHO %userChoice% | FIND /I "H" > NUL && (
		ECHO STARTING...
		
		ECHO SETTING A BUNCH OF SERVICES TO MANUAL...
		CALL ".\Assets (Don't Move, Delete or Rename)\Set Services to Manual.bat"
		CD /D "%~dp0"
		
		ECHO DONE!
		ECHO.
	)
	ECHO %userChoice% | FIND /I "I" > NUL && (
		ECHO STARTING...
		
		ECHO RESTORING WINDOWS PHOTO VIEWER THROUGH THE REGISTRY EDITOR...
		REG IMPORT ".\Assets (Don't Move, Delete or Rename)\Enable Windows Photo Viewer.reg" > NUL
		
		ECHO DONE!
		ECHO.
	)
	ECHO %userChoice% | FIND /I "J" > NUL && (
		ECHO STARTING...
		
		ECHO DECREASING STARTUP TIME THROUGH THE REGISTRY EDITOR...
		REG IMPORT ".\Assets (Don't Move, Delete or Rename)\Decrease Startup Time.reg" > NUL
		
		ECHO DONE!
		ECHO.
	)
	ECHO %userChoice% | FIND /I "K" > NUL && (
		ECHO STARTING...
		
		ECHO SETTING SECURITY UPDATES ONLY THROUGH THE REGISTRY EDITOR...
		REG IMPORT ".\Assets (Don't Move, Delete or Rename)\Security Updates Only.reg" > NUL
		
		ECHO DONE!
		ECHO.
	)
	PAUSE
	GOTO TweaksMenu
	
:UIChangerMenu
	CLS
	ECHO --------------------------------------------------------------UI CHANGER---------------------------------------------------------------
	ECHO.
	ECHO.
	ECHO                                                  ============== GLOBAL =============
	ECHO.
	ECHO (A) DISPLAY HIGHLY DETAILED MESSAGES [SHOW MESSAGES WITH INFO DURING STARTUP AND SHUTDOWN]
	ECHO.
	ECHO.
	ECHO                                                  ============ WINDOWS 10 ===========
	ECHO.
	ECHO (B) ADVANCED TASKBAR SETTINGS [CHANGE SYSTEM TRAY ICONS' LOCATION AND SYSTEM TRAY WIDGETS SUCH AS VOLUME, CLOCK, NOTIFICATION CENTER]
	ECHO.
	ECHO (C) OLD VOLUME MIXER [ENABLES THE OLD VOLUME MIXER WHEN CLICKING ON THE VOLUME ICON]
	ECHO.
	ECHO.
	ECHO                                                  ============ WINDOWS 11 ===========
	ECHO.
	ECHO (D) OLD RIGHT-CLICK CONTEXT MENU [ENABLES THE OLD CONTEXT MENU BY DEFAULT WHEN RIGHT CLICKING ON FILE EXPLORER OR THE DESKTOP]
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	ECHO.
	SET userChoice="0"
	SET /P userChoice=ENTER YOUR CHOICE (letter)-(letter, letter, letter)-(back): 
	
	CLS
	ECHO %userChoice% | FIND /I "back" > NUL && (
		GOTO MainMenu
	)
	ECHO %userChoice% | FIND /I "a" > NUL && (
		ECHO STARTING...
		
		ECHO ENABLING HIGHLY DETAILED MESSAGES THROUGH THE REGISTRY EDITOR...
		REG IMPORT ".\Assets (Don't Move, Delete or Rename)\Enable Verbose Messages.reg" > NUL
		
		ECHO DONE!
		ECHO.
	)
	ECHO %userChoice% | FIND /I "b" > NUL && (
		ECHO STARTING...
		
		EXPLORER shell:::{05d7b0f4-2121-4eff-bf6b-ed3f69b894d9}
		ECHO TO HIDE/SHOW SYSTEM TRAY WIDGETS PRESS THE BLUE LINK LOCATED ON THE LOWER LEFT PART OF THE WINDOW THAT SAYS "Turn system icons on or off".
		
		ECHO DONE!
		ECHO.
	)
	ECHO %userChoice% | FIND /I "c" > NUL && (
		ECHO STARTING...
		
		ECHO SETTING THE OLD VOLUME MIXER THROUGH THE REGISTRY EDITOR...
		REG IMPORT ".\Assets (Don't Move, Delete or Rename)\Enable Old Volume Mixer.reg" > NUL
		
		ECHO DONE!
		ECHO.
	)
	ECHO %userChoice% | FIND /I "d" > NUL && (
		ECHO STARTING...
		
		ECHO SETTING THE OLD RIGHT-CLICK CONTEXT MENU BY DEFAULT THROUGH THE REGISTRY EDITOR...
		REG IMPORT ".\Assets (Don't Move, Delete or Rename)\Enable Old Right-Click Context Menu.reg" > NUL
		
		ECHO DONE!
		ECHO.
	)
	PAUSE
	GOTO UIChangerMenu
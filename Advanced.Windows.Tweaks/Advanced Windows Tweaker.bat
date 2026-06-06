@ECHO OFF



REM Requesting Admin Privilages
%1 %WINDIR%\System32\MSHTA.EXE vbscript:CreateObject("Shell.Application").ShellExecute("%WINDIR%\System32\CMD.EXE","/c %~s0 ::","","runas",1)(window.close) && EXIT
CD /D "%~dp0"



REM Window Properties
%WINDIR%\System32\MODE.COM 70, 20
TITLE Advanced Windows Tweaker



REM Variables
SET "userInput=0"
SET "menuToLoadIndex=0"

SET "privacyDir=.\Assets (Don't Move, Delete or Rename)\PrivacyMenu"
SET "FeaturesDir=.\Assets (Don't Move, Delete or Rename)\FeaturesMenu"
SET "UIDir=.\Assets (Don't Move, Delete or Rename)\UIMenu"
SET "PreinstalledProgramsUninstallerDir=.\Assets (Don't Move, Delete or Rename)\PreinstalledProgramsUninstallerMenu"



REM Main
:MainLoop
	CALL :MenusManager
	CALL :AskUserInput
	CALL :InputManager
	GOTO MainLoop



REM User Interface Functions
:MenusManager
	IF "%menuToLoadIndex%" EQU "0" (
		CALL :ShowMainMenu
	) ELSE IF "%menuToLoadIndex%" EQU "1" (
		CALL :ShowPrivacyMenu
	) ELSE IF "%menuToLoadIndex%" EQU "2" (
		CALL :ShowFeaturesMenu
	) ELSE IF "%menuToLoadIndex%" EQU "3" (
		CALL :ShowUIMenu
	)
	EXIT /B

:ShowMainMenu
	CALL :ShowMenu "MAIN MENU" "1. PRIVACY [Menu]" "2. FEATURES [Menu]" "3. UI [Menu]" "4. PREINSTALLED PROGRAMS UNINSTALLER [Menu]"
	EXIT /B

:ShowPrivacyMenu
	CALL :ShowMenu "PRIVACY" "1. DISABLE DATA COLLECTION [Tweak]" "2. DISABLE RECOMMENDATIONS, ADS AND SUGGESTIONS [Tweak]" "3. DISABLE SEARCHBOX SUGGESTIONS AND SEARCHBOX INTERNET SEARCH [Tweak]" "4. DISABLE LOCATION PERMISSIONS TO WINDOWS AND APPS [Tweak]"
	EXIT /B

:ShowFeaturesMenu
	CALL :ShowMenu "FEATURES" "1. ENABLE WINDOWS PHOTO VIEWER [Tweak]" "2. DISABLE GAMEDVR [Tweak]" "3. DISABLE COPILOT AND RECALL [Tweak]" "4. DISABLE WINDOWS FEEDS / NEWS AND INTERESTS [Tweak]" "5. DISABLE CORTANA [Tweak]" "6. DISABLE PREINSTALLED APPS AUTO-INSTALL [Tweak]" "7. DISABLE MICROSOFT STORE APPS IN THE BACKGROUND [Tweak]" "8. OPEN ADDITIONAL FEATURES MENU [Menu]"
	EXIT /B

:ShowUIMenu
	CALL :ShowMenu "UI" "1. ENABLE OLD VOLUME FLYOUT [Tweak][Windows10]" "2. ENABLE OLD RIGHT CLICK CONTEXT MENU [Tweak][Windows11]" "3. CREATE OLD FILEEXPLORER SHORTCUT [Tweak][Windows11]" "4. ENABLE VERBOSE STARTUP AND SHUTDOWN [Tweak]" "5. ENABLE VERBOSE BSOD [Tweak]" "6. DISABLE ANIMATIONS, TRANSPARENCY AND BACKGROUND IMAGE [Tweak]" "7. DECREASE BOOT TIME [Tweak]"
	EXIT /B



REM Input Functions
:InputManager
	IF "%menuToLoadIndex%" EQU "0" (
		CALL :HandleMainMenuInput
	) ELSE IF "%menuToLoadIndex%" EQU "1" (
		CALL :HandlePrivacyInput
	) ELSE IF "%menuToLoadIndex%" EQU "2" (
		CALL :HandleFeaturesInput
	) ELSE IF "%menuToLoadIndex%" EQU "3" (
		CALL :HandleUIInput
	)
	EXIT /B
	
:AskUserInput
	SET /P "userInput=>>> "
	EXIT /B

:HandleMainMenuInput
	IF /I "%userInput%" EQU "E" (
		EXIT
	) ELSE IF "%userInput%" EQU "1" (
		SET "menuToLoadIndex=1"
	) ELSE IF "%userInput%" EQU "2" (
		SET "menuToLoadIndex=2"
	) ELSE IF "%userInput%" EQU "3" (
		SET "menuToLoadIndex=3"
	) ELSE IF "%userInput%" EQU "4" (
		CALL :RunBatchScript "PreinstalledProgramsUninstaller.bat" "%PreinstalledProgramsUninstallerDir%"
	)
	EXIT /B

:HandlePrivacyInput
	IF /I "%userInput%" EQU "B" (
		SET "menuToLoadIndex=0"
	) ELSE IF "%userInput%" EQU "1" (
		CALL :RunBatchScript "DisableDataCollection.bat" "%privacyDir%"
	) ELSE IF "%userInput%" EQU "2" (
		CALL :MergeRegFile "DisableRecommendationsAdsAndSuggestions.reg" "%privacyDir%"
	) ELSE IF "%userInput%" EQU "3" (
		CALL :MergeRegFile "DisableSearchBoxSuggestionsAndSearchBoxInternetSearch.reg" "%privacyDir%"
	) ELSE IF "%userInput%" EQU "4" (
		CALL :MergeRegFile "DisableLocationPermissionsToWindowsAndApps.reg" "%privacyDir%"
	)
	EXIT /B

:HandleFeaturesInput
	IF /I "%userInput%" EQU "B" (
		SET "menuToLoadIndex=0"
	) ELSE IF "%userInput%" EQU "1" (
		CALL :MergeRegFile "EnableWindowsPhotoViewer.reg" "%featuresDir%"
	) ELSE IF "%userInput%" EQU "2" (
		CALL :MergeRegFile "DisableGameDVR.reg" "%featuresDir%"
	) ELSE IF "%userInput%" EQU "3" (
		CALL :MergeRegFile "DisableCopilotAndRecall.reg" "%featuresDir%"
	) ELSE IF "%userInput%" EQU "4" (
		CALL :MergeRegFile "DisableWindowsFeeds.reg" "%featuresDir%"
	) ELSE IF "%userInput%" EQU "5" (
		CALL :MergeRegFile "DisableCortana.reg" "%featuresDir%"
	) ELSE IF "%userInput%" EQU "6" (
		CALL :MergeRegFile "DisablePreinstalledAppsAutoInstall.reg" "%featuresDir%"
	) ELSE IF "%userInput%" EQU "7" (
		CALL :MergeRegFile "DisableMicrosoftStoreAppsInTheBackground.reg" "%featuresDir%"
	) ELSE IF "%userInput%" EQU "8" (
		CALL :RunSystem32App "OPTIONALFEATURES.EXE"
	)
	EXIT /B

:HandleUIInput
	IF /I "%userInput%" EQU "B" (
		SET "menuToLoadIndex=0"
	) ELSE IF "%userInput%" EQU "1" (
		CALL :MergeRegFile "EnableOldVolumeFlyout.reg" "%UIDir%"
	) ELSE IF "%userInput%" EQU "2" (
		CALL :MergeRegFile "EnableOldRightClickContextMenu.reg" "%UIDir%"
	) ELSE IF "%userInput%" EQU "3" (
		CALL :RunVbsScript "CreateOldFileExplorerShortcut.vbs" "%UIDir%"
	) ELSE IF "%userInput%" EQU "4" (
		CALL :MergeRegFile "EnableVerboseStartupAndShutdown.reg" "%UIDir%"
	) ELSE IF "%userInput%" EQU "5" (
		CALL :MergeRegFile "EnableVerboseBSOD.reg" "%UIDir%"
	) ELSE IF "%userInput%" EQU "6" (
		CALL :MergeRegFile "DisableAnimationsTransparencyAndBackgroundImage.reg" "%UIDir%"
	) ELSE IF "%userInput%" EQU "7" (
		CALL :MergeRegFile "DecreaseBootTime.reg" "%UIDir%"
	)
	EXIT /B



REM Userful Functions
:ShowMenu
	SETLOCAL ENABLEDELAYEDEXPANSION
	
	SET "availableRowsForUse=16"
	SET "rowsThatCanBeMenuItems=1 3 5 7 9 11 13 15 17"
	CLS
	
	ECHO                          ^>^>^> %~1 ^<^<^<
	
	SET "menuItemIndex=1"
	FOR /L %%i IN (0, 1, %availableRowsForUse%) DO (
		SET "rowIsMenuItem=0"
	
		FOR %%j IN (%rowsThatCanBeMenuItems%) DO (
			IF "%%i" EQU "%%j" (
				SET "rowIsMenuItem=1"
			)
		)
		
		IF "!rowIsMenuItem!" EQU "1" (
			SET /A "menuItemIndex=menuItemIndex+1"
			CALL SET "menuItem=%%~!menuItemIndex!%%"
			IF DEFINED menuItem (
				ECHO !menuItem!
			) ELSE (
				ECHO.
			)
		) ELSE (
			ECHO.
		)
	)
	
	IF /I "%~1" EQU "MAIN MENU" (
		ECHO ---- USE {CONTROL ^+ MOUSE WHEEL} TO ZOOM IN/OUT ^| TYPE {E} TO EXIT ---
	) ELSE (
		ECHO ------------------ TYPE {B} TO GO TO THE MAIN MENU -------------------
	)
	
	ENDLOCAL
	EXIT /B



REM Run Functions
:RunBatchScript
	CLS
	
	ECHO Running %~1 Script...
	ECHO.
	CALL "%~2\%~1"
	CD /D "%~dp0"
	ECHO.
	PAUSE
	
	EXIT /B

:RunPowershellScript
	CLS
	
	ECHO Running %~1 Script...
	ECHO.
	%WINDIR%\System32\WindowsPowerShell\v1.0\POWERSHELL.EXE -NoProfile -ExecutionPolicy Bypass -File "%~2\%~1"
	ECHO.
	PAUSE
	
	EXIT /B

:RunSystem32App
	CLS
	
	ECHO Running %~1 App...
	ECHO.
	START "" %WINDIR%\System32\%~1 %~2
	ECHO.
	PAUSE
	
	EXIT /B

:RunVbsScript
	CLS
	
	ECHO Running %~1 Script...
	ECHO.
	%WINDIR%\System32\CSCRIPT.EXE //nologo "%~2\%~1"
	ECHO.
	PAUSE
	
	EXIT /B

:MergeRegFile
	CLS
	
	ECHO Running %~1 file...
	ECHO.
	%WINDIR%\System32\REG.EXE IMPORT "%~2\%~1" > NUL
	ECHO.
	PAUSE
	
	EXIT /B
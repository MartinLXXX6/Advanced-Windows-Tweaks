REM Setting up Variables
SET "userInput=N"



REM Main
ECHO                 ^>^>^> PreinstalledProgramsUninstaller ^<^<^<
ECHO.

CALL :UninstallSection "GARBAGE" "Microsoft.BingNews Microsoft.BingFinance Microsoft.MicrosoftSolitaireCollection Microsoft.Getstarted Microsoft.MicrosoftNews Microsoft.People Microsoft.GetHelp Microsoft.WindowsFeedbackHub Microsoft.BingSports Microsoft.BingWeather Microsoft.MixedReality Clipchamp.Clipchamp Microsoft.Todos"
CALL :UninstallSection "MOSTLY USELESS" "Microsoft.WindowsSoundRecorder Microsoft.MicrosoftStickyNotes Microsoft.549981C3F5F10 Microsoft.windowscommunicationsapps Microsoft.SkypeApp Microsoft.BingMaps Microsoft.WindowsMaps"
CALL :UninstallSection "OFFICE" "Microsoft.MicrosoftOfficeHub Microsoft.Office.OneNote"
CALL :UninstallSection "POSSIBLY USEFUL" "Microsoft.OneDrive Microsoft.OneDriveSync Microsoft.YourPhone Microsoft.WindowsPhone"
CALL :UninstallSection "COMPONENT" "DevHome.DevHome Microsoft.DevHome Windows.DevHome MicrosoftWindows.CrossDevice"
CALL :UninstallSection "XBOX" "Microsoft.XboxSpeechToTextOverlay Microsoft.XboxIdentityProvider Microsoft.XboxGameOverlay Microsoft.XboxGamingOverlay Microsoft.XboxApp Microsoft.Xbox.TCUI"

ECHO Done, remember you can re-install them through the Microsoft Store.
EXIT /B


REM Menu Functions
:UninstallSection
	CALL :ShowUninstallMenu "%~1" "%~2"
	
	IF /I "%userInput%"=="Y" (
		ECHO.
		ECHO Begining process of uninstalling %~1 apps...
		CALL :RunUninstallPowershellCommand %~2
		ECHO Done!
	)
	
	ECHO.
	ECHO ----------------------------------------------------------------------
	ECHO.
	
	EXIT /B



REM Useful Functions
:ShowUninstallMenu
	SETLOCAL
	
	ECHO Do you want to uninstall the following %~1 apps?
	ECHO [ %~2 ]

	ECHO.
	
	ENDLOCAL & SET /P "userInput={Y/N}>>> "
	EXIT /B
	
:RunUninstallPowershellCommand
	FOR %%i IN (%*) DO (
		ECHO Attempting to uninstall %%i
		POWERSHELL.EXE -NoProfile -ExecutionPolicy Bypass -Command "Get-AppxPackage -Name '*%%i*' | Remove-AppxPackage"
	)
	
	EXIT /B
@echo off
title Windows Bloat Uninstaller
color 0A

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



ECHO -------------------------------------------------PREINSTALLED BLOAT UNINSTALLER SCRIPT-------------------------------------------------
ECHO.
ECHO.

:MainMenuGarbage
	ECHO DO YOU WANT TO UNINSTALL THE FOLLOWING GARBAGE APPS?
	ECHO.

	ECHO [ TIPS ! SOLITAIRE COLLECTION ! BING FINANCE ! BING NEWS ! MICROSOFT NEWS ! PEOPLE ! TO DO ! GET HELP ! FEEDBACK HUB ! BING SPORTS ! BING WEATHER ! MIXED REALITY ! CLIPCHAMP ]

	ECHO.
	ECHO.
	SET /P userInput="YOUR CHOICE [Y]-[N]: "
	IF /I "%userInput%"=="Y" (
		ECHO.
		ECHO BEGINING PROCESS OF UNINSTALLING GARBAGE APPS...
		GOTO GarbageApps
	)

:MainMenuUseless
	ECHO.
	ECHO ---------------------------------------------------------
	ECHO.
	ECHO DO YOU WANT TO UNINSTALL THE FOLLOWING MOSTLY USELESS APPS? - (Y/N)
	ECHO.

	ECHO [ CALENDAR AND MAIL ! SKYPE ! MAPS ! SOUND RECORDER ! STICKY NOTES ! CORTANA ]

	ECHO.
	ECHO.
	SET /P userInput="YOUR CHOICE [Y]-[N]: "
	IF /I "%userInput%"=="Y" (
		ECHO.
		ECHO BEGINING PROCESS OF UNINSTALLING MOSTLY USELESS APPS...
		GOTO MostlyUselessApps
	)

:MainMenuOffice
	ECHO.
	ECHO ---------------------------------------------------------
	ECHO.
	ECHO DO YOU WANT TO UNINSTALL THE FOLLOWING OFFICE APPS? - (Y/N)
	ECHO.

	ECHO [ MICROSOFT OFFICE ! ONENOTE FOR WINDOWS 10 ]

	ECHO.
	ECHO.
	SET /P userInput="YOUR CHOICE [Y]-[N]: "
	IF /I "%userInput%"=="Y" (
		ECHO.
		ECHO BEGINING PROCESS OF UNINSTALLING OFFICE APPS...
		GOTO OfficeApps
	)

:MainMenuUseful
	ECHO.
	ECHO ---------------------------------------------------------
	ECHO.
	ECHO DO YOU WANT TO UNINSTALL THE FOLLOWING POSSIBLY USEFUL APPS? - (Y/N)
	ECHO.

	ECHO [ MICROSOFT ONEDRIVE ! PHONE LINK / PHONE COMPANION / YOUR PHONE ]

	ECHO.
	ECHO.
	SET /P userInput="YOUR CHOICE [Y]-[N]: "
	IF /I "%userInput%"=="Y" (
		ECHO.
		ECHO BEGINING PROCESS OF UNINSTALLING POSSIBLY USEFUL APPS...
		GOTO PossiblyUsefulApps
	)
	
:MainMenuComponents
	ECHO.
	ECHO ---------------------------------------------------------
	ECHO.
	ECHO DO YOU WANT TO UNINSTALL THE FOLLOWING COMPONENTS APPS? - (Y/N)
	ECHO.

	ECHO [ DEVHOME ! CROSS DEVICE EXPERIENCE HOST ]

	ECHO.
	ECHO.
	SET /P userInput="YOUR CHOICE [Y]-[N]: "
	IF /I "%userInput%"=="Y" (
		ECHO.
		ECHO BEGINING PROCESS OF UNINSTALLING COMPONENT APPS...
		GOTO InstalledComponents
	)

:MainMenuXbox
	ECHO.
	ECHO ---------------------------------------------------------
	ECHO.
	ECHO DO YOU WANT TO UNINSTALL THE FOLLOWING XBOX APPS? - (Y/N)
	ECHO.

	ECHO [ XBOX ! GAMEBAR ! XBOXIDENTITYPROVIDER ! XBOXSPEECHTOTEXTOVERLAY ]

	ECHO.
	ECHO.
	SET /P userInput="YOUR CHOICE [Y]-[N]: "
	IF /I "%userInput%"=="Y" (
		ECHO.
		ECHO BEGINING PROCESS OF UNINSTALLING XBOX APPS...
		GOTO XboxApps
	) ELSE (
		GOTO EndScreen
	)
	
	

:GarbageApps
	PowerShell -Command "Get-AppxPackage *Microsoft.Getstarted* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.BingFinance* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.BingNews* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.MicrosoftNews* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.People* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.GetHelp* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.BingSports* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.BingWeather* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.MixedReality* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Clipchamp.Clipchamp* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.Todos* | Remove-AppxPackage"
	ECHO Finished!
	GOTO MainMenuUseless
	
:MostlyUselessApps
	PowerShell -Command "Get-AppxPackage *Microsoft.windowscommunicationsapps* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.SkypeApp* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.BingMaps* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.WindowsMaps* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.WindowsSoundRecorder* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.MicrosoftStickyNotes* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.549981C3F5F10* | Remove-AppxPackage"
	ECHO Finished!
	GOTO MainMenuOffice
	
:OfficeApps
	PowerShell -Command "Get-AppxPackage *Microsoft.MicrosoftOfficeHub* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.Office.OneNote* | Remove-AppxPackage"
	ECHO Finished!
	GOTO MainMenuUseful
	
:PossiblyUsefulApps
	PowerShell -Command "Get-AppxPackage *Microsoft.OneDrive* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.OneDriveSync* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.YourPhone* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.WindowsPhone* | Remove-AppxPackage"
	ECHO Finished!
	GOTO MainMenuComponents
	
:InstalledComponents
	PowerShell -Command "Get-AppxPackage *MicrosoftWindows.CrossDevice* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Windows.DevHome* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.DevHome* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *DevHome.DevHome* | Remove-AppxPackage"
	echo Finished!
	goto MainMenuXbox
	
:XboxApps
	PowerShell -Command "Get-AppxPackage *Microsoft.Xbox.TCUI* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.XboxApp* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.XboxGamingOverlay* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.XboxGameOverlay* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.XboxIdentityProvider* | Remove-AppxPackage"
	PowerShell -Command "Get-AppxPackage *Microsoft.XboxSpeechToTextOverlay* | Remove-AppxPackage"
	ECHO Finished!
	GOTO EndScreen

:EndScreen
	ECHO ---------------------------------------------------------
	ECHO.
	ECHO.
	ECHO YOU ARE DONE!. REMEMBER THAT YOU CAN RE-INSTALL THEM THROUGH THE MICROSOFT STORE IF NECESSARY.
	ECHO TO KNOW WHAT WAS UNINSTALLED, JUST CLICK EDIT ON THIS SCRIPT AND SCROLL ALL THE WAY DOWN TO THE COMMANDS.
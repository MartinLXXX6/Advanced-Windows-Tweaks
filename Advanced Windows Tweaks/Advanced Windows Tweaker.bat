@ECHO off

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
	ECHO (1) WINDOWS TWEAKS [TELEMETRY ~ ADS ~ REMOVAL OF PREINSTALLED BLOAT ~ EFFECTS ~ ANIMATIONS ~ WINDOWS UPDATE ~ COPILOT ~ RECALL]
	ECHO.
	ECHO (2) WINDOWS UI CHANGER [OLD RIGHT-CLICK CONTEXT MENU ~ OLD VOLUME MIXER ~ ADVANCED TASKBAR SETTINGS]
	ECHO.
	ECHO (3) ENABLE WINDOWS FEATURES [COMING SOON]
	ECHO.
	ECHO.
	ECHO.
	SET userChoice="0"
	SET /P userChoice=ENTER YOUR CHOICE (1)-(exit): 
	
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
		ECHO Coming Soon...
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
	ECHO (C) RUN PREINSTALLED BLOAT UNINSTALLER [ASKS FOR REMOVAL OF PREINSTALLED MICROSOFT'S JUNK APPS ON YOUR SYSTEM]
	ECHO.
	ECHO (D) DISABLE AI [COPILOT ~ RECALL]
	ECHO.
	ECHO (E) DISABLE GAMEDVR AND BROADCASTING [GAMEDVR ~ IN-GAME CAPTURES ~ GAMEPLAY RECORDER]
	ECHO.
	ECHO (F) DEBLOAT MICROSOFT EDGE [MICROSOFT EDGE AT STARTUP ~ MICROSOFT EDGE TRACKING ~ MICROSOFT EDGE SECURITY ~ TAB PRELOADING]
	ECHO.
	ECHO.
	ECHO                                                     ========= PERFORMANCE =========
	ECHO.
	ECHO (G) DISABLE ALL VISUAL EFFECTS AND ANIMATIONS [ANIMATIONS ~ SIGN-IN SCREEN BACKGROUND ~ TRANSPARENCY]
	ECHO.
	ECHO (H) DISABLE BACKGROUND APPS [BACKGROUND APPS]
	ECHO.
	ECHO (I) SET SERVICES TO MANUAL [SET A BUNCH OF WINDOWS SERVICES TO MANUAL SO THEY RUN ONLY WHEN THEY ARE NEEDED]
	ECHO.
	ECHO.
	ECHO                                                     =========== FEATURES ==========
	ECHO.
	ECHO (J) ENABLE WINDOWS PHOTO VIEWER APP [ENABLES WINDOWS PHOTO VIEWER APP TO OPEN ANY IMAGE FORMAT]
	ECHO.
	ECHO (K) ENABLE USEFUL FEATURES [VERBOSE MESSAGES ~ DECREASE STARTUP TIME ~ SYSTEM RESPONSIVENESS ~ NETWORK THROTTLING ~ END TASK]
	ECHO.
	ECHO.
	ECHO                                                     ============ UPDATES ===========
	ECHO.
	ECHO (L) SECURITY UPDATES ONLY [DELAYS FEATURE UPDATES BY APPROXIMATELY ONE YEAR AND SECURITY UPDATES BY AROUND FOUR DAYS]
	ECHO.
	ECHO.
	ECHO.
	SET userChoice="0"
	SET /P userChoice=ENTER YOUR CHOICE (a)-(a, b, e)-(all)-(back): 
	
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
		
		CALL ".\Assets (Don't Move, Delete or Rename)\Preinstalled Bloat Uninstaller.bat"
		CD /D "%~dp0"
		
		ECHO.
	)
	ECHO %userChoice% | FIND /I "D" > NUL && (
		ECHO STARTING...
		
		ECHO DISABLING WINDOWS COPILOT AND WINDOWS RECALL THROUGH THE REGISTRY EDITOR...
		REG IMPORT ".\Assets (Don't Move, Delete or Rename)\Disable Copilot & Recall.reg" > NUL
		
		ECHO DONE!
		ECHO.
	)
	ECHO %userChoice% | FIND /I "E" > NUL && (
		ECHO STARTING...
		
		ECHO DISABLING GAMEDVR THROUGH THE REGISTRY EDITOR...
		REG IMPORT ".\Assets (Don't Move, Delete or Rename)\Disable GameDVR.reg" > NUL
		
		ECHO DONE!
		ECHO.
	)
	ECHO %userChoice% | FIND /I "F" > NUL && (
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
	ECHO %userChoice% | FIND /I "G" > NUL && (
		ECHO STARTING...
		
		ECHO DISABLING ANIMATIONS AND EFFECTS THROUGH THE REGISTRY EDITOR...
		REG IMPORT ".\Assets (Don't Move, Delete or Rename)\Disable Visual Effects & Animations.reg" > NUL
		
		ECHO DONE!
		ECHO.
	)
	ECHO %userChoice% | FIND /I "H" > NUL && (
		ECHO STARTING...
		
		ECHO DISABLING BACKGROUND APPS THROUGH THE REGISTRY EDITOR...
		REG IMPORT ".\Assets (Don't Move, Delete or Rename)\Disable Background Apps.reg" > NUL
		
		ECHO DONE!
		ECHO.
	)
	ECHO %userChoice% | FIND /I "I" > NUL && (
		ECHO STARTING...
		
		ECHO SETTING A BUNCH OF SERVICES TO MANUAL...
		cmd.exe /C "SC CONFIG AJRouter START= DISABLED" > NUL
		cmd.exe /C "SC CONFIG ALG START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG AppIDSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG AppMgmt START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG AppReadiness START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG AppVClient START= DISABLED" > NUL
		cmd.exe /C "SC CONFIG AppXSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG Appinfo START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG AssignedAccessManagerSvc START= DISABLED" > NUL
		cmd.exe /C "SC CONFIG AudioEndpointBuilder START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG AudioSrv START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG Audiosrv START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG AxInstSV START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG BDESVC START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG BFE START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG BITS START= AUTOMATICDELSTART" > NUL
		cmd.exe /C "SC CONFIG BTAGService START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG BcastDVRUserService_* START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG BluetoothUserService_* START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG BrokerInfrastructure START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG Browser START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG BthAvctpSvc START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG BthHFSrv START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG CDPSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG CDPUserSvc_* START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG COMSysApp START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG CaptureService_* START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG CertPropSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG ClipSVC START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG ConsentUxUserSvc_* START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG CoreMessagingRegistrar START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG CredentialEnrollmentManagerUserSvc_* START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG CryptSvc START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG CscService START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG DPS START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG DcomLaunch START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG DcpSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG DevQueryBroker START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG DeviceAssociationBrokerSvc_* START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG DeviceAssociationService START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG DeviceInstall START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG DevicePickerUserSvc_* START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG DevicesFlowUserSvc_* START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG Dhcp START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG DialogBlockingService START= DISABLED" > NUL
		cmd.exe /C "SC CONFIG DispBrokerDesktopSvc START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG DisplayEnhancementService START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG DmEnrollmentSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG Dnscache START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG DoSvc START= AUTOMATICDELSTART" > NUL
		cmd.exe /C "SC CONFIG DsSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG DsmSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG DusmSvc START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG EFS START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG EapHost START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG EntAppSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG EventLog START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG EventSystem START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG FDResPub START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG Fax START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG FontCache START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG FrameServer START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG FrameServerMonitor START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG GraphicsPerfSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG HomeGroupListener START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG HomeGroupProvider START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG HvHost START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG IEEtwCollectorService START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG IKEEXT START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG InstallService START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG InventorySvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG IpxlatCfgSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG KeyIso START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG KtmRm START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG LSM START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG LanmanServer START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG LanmanWorkstation START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG LicenseManager START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG LxpSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG MSDTC START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG MSiSCSI START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG MapsBroker START= AUTOMATICDELSTART" > NUL
		cmd.exe /C "SC CONFIG McpManagementService START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG MessagingService_* START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG MixedRealityOpenXRSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG MpsSvc START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG MsKeyboardFilter START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG NPSMSvc_* START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG NaturalAuthentication START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG NcaSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG NcbService START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG NcdAutoSetup START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG NetSetupSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG NetTcpPortSharing START= DISABLED" > NUL
		cmd.exe /C "SC CONFIG Netlogon START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG Netman START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG NgcCtnrSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG NgcSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG NlaSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG OneSyncSvc_* START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG P9RdrService_* START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG PNRPAutoReg START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG PNRPsvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG PcaSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG PeerDistSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG PenService_* START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG PerfHost START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG PhoneSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG PimIndexMaintenanceSvc_* START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG PlugPlay START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG PolicyAgent START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG Power START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG PrintNotify START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG PrintWorkflowUserSvc_* START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG ProfSvc START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG PushToInstall START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG QWAVE START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG RasAuto START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG RasMan START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG RemoteAccess START= DISABLED" > NUL
		cmd.exe /C "SC CONFIG RemoteRegistry START= DISABLED" > NUL
		cmd.exe /C "SC CONFIG RetailDemo START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG RmSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG RpcEptMapper START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG RpcLocator START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG RpcSs START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG SCPolicySvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG SCardSvr START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG SDRSVC START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG SEMgrSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG SENS START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG SNMPTRAP START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG SNMPTrap START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG SSDPSRV START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG SamSs START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG ScDeviceEnum START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG Schedule START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG SecurityHealthService START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG Sense START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG SensorDataService START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG SensorService START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG SensrSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG SessionEnv START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG SgrmBroker START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG SharedAccess START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG SharedRealitySvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG ShellHWDetection START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG SmsRouter START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG Spooler START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG SstpSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG StateRepository START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG StiSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG StorSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG SysMain START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG SystemEventsBroker START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG TabletInputService START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG TapiSrv START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG TermService START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG TextInputManagementService START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG Themes START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG TieringEngineService START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG TimeBroker START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG TimeBrokerSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG TokenBroker START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG TrkWks START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG TroubleshootingSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG TrustedInstaller START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG UI0Detect START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG UdkUserSvc_* START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG UevAgentService START= DISABLED" > NUL
		cmd.exe /C "SC CONFIG UmRdpService START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG UnistoreSvc_* START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG UserDataSvc_* START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG UserManager START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG UsoSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG VGAuthService START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG VMTools START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG VSS START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG VacSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG VaultSvc START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG W32Time START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG WEPHOSTSVC START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG WFDSConMgrSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG WMPNetworkSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG WManSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG WPDBusEnum START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG WSService START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG WSearch START= AUTOMATICDELSTART" > NUL
		cmd.exe /C "SC CONFIG WaaSMedicSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG WalletService START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG WarpJITSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG WbioSrvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG Wcmsvc START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG WcsPlugInService START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG WdNisSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG WdiServiceHost START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG WdiSystemHost START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG WebClient START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG Wecsvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG WerSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG WiaRpc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG WinDefend START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG WinHttpAutoProxySvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG WinRM START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG Winmgmt START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG WlanSvc START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG WpcMonSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG WpnService START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG WpnUserService_* START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG XblAuthManager START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG XblGameSave START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG XboxGipSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG XboxNetApiSvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG autotimesvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG bthserv START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG camsvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG cbdhsvc_* START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG cloudidsvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG dcsvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG defragsvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG diagnosticshub.standardcollector.service START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG diagsvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG dot3svc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG embeddedmode START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG fdPHost START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG fhsvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG gpsvc START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG hidserv START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG icssvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG iphlpsvc START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG lfsvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG lltdsvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG lmhosts START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG mpssvc START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG msiserver START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG netprofm START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG nsi START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG p2pimsvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG p2psvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG perceptionsimulation START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG pla START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG seclogon START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG shpamsvc START= DISABLED" > NUL
		cmd.exe /C "SC CONFIG smphost START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG spectrum START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG sppsvc START= AUTOMATICDELSTART" > NUL
		cmd.exe /C "SC CONFIG ssh-agent START= DISABLED" > NUL
		cmd.exe /C "SC CONFIG svsvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG swprv START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG tiledatamodelsvc START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG tzautoupdate START= DISABLED" > NUL
		cmd.exe /C "SC CONFIG uhssvc START= DISABLED" > NUL
		cmd.exe /C "SC CONFIG upnphost START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG vds START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG vm3dservice START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG vmicguestinterface START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG vmicheartbeat START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG vmickvpexchange START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG vmicrdv START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG vmicshutdown START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG vmictimesync START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG vmicvmsession START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG vmicvss START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG vmvss START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG wbengine START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG wcncsvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG webthreatdefsvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG webthreatdefusersvc_* START= AUTOMATIC" > NUL
		cmd.exe /C "SC CONFIG wercplsupport START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG wisvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG wlidsvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG wlpasvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG wmiApSrv START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG workfolderssvc START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG wscsvc START= AUTOMATICDELSTART" > NUL
		cmd.exe /C "SC CONFIG wuauserv START= MANUAL" > NUL
		cmd.exe /C "SC CONFIG wudfsvc START= MANUAL" > NUL
		
		ECHO DONE!
		ECHO.
	)
	ECHO %userChoice% | FIND /I "J" > NUL && (
		ECHO STARTING...
		
		ECHO RESTORING WINDOWS PHOTO VIEWER THROUGH THE REGISTRY EDITOR...
		REG IMPORT ".\Assets (Don't Move, Delete or Rename)\Enable Windows Photo Viewer.reg" > NUL
		
		ECHO DONE!
		ECHO.
	)
	ECHO %userChoice% | FIND /I "K" > NUL && (
		ECHO STARTING...
		
		ECHO APPLYING USEFUL FEATURES THROUGH THE REGISTRY EDITOR...
		REG IMPORT ".\Assets (Don't Move, Delete or Rename)\Enable Useful Features.reg" > NUL
		
		ECHO DONE!
		ECHO.
	)
	ECHO %userChoice% | FIND /I "L" > NUL && (
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
	ECHO                                                  ============ WINDOWS 10 ===========
	ECHO.
	ECHO (A) ADVANCED TASKBAR SETTINGS [CHANGE SYSTEM TRAY ICONS' LOCATION AND SYSTEM TRAY WIDGETS SUCH AS VOLUME, CLOCK, NOTIFICATION CENTER]
	ECHO.
	ECHO.
	ECHO                                                  ============ WINDOWS 11 ===========
	ECHO.
	ECHO (B) OLD RIGHT-CLICK CONTEXT MENU [ENABLES THE OLD CONTEXT MENU BY DEFAULT WHEN RIGHT CLICKING ON FILE EXPLORER OR THE DESKTOP]
	ECHO.
	ECHO.
	ECHO.
	SET userChoice="0"
	SET /P userChoice=ENTER YOUR CHOICE (a)-(b, c, e)-(back): 
	
	CLS
	ECHO %userChoice% | FIND /I "back" > NUL && (
		GOTO MainMenu
	)
	ECHO %userChoice% | FIND /I "a" > NUL && (
		ECHO AUODWOD
	)
	ECHO %userChoice% | FIND /I "b" > NUL && (
		ECHO BDWADA
	)
	PAUSE
	GOTO UIChangerMenu
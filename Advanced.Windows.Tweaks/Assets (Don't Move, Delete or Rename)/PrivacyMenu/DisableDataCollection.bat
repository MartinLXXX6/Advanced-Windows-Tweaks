REM Main
CALL :DisableService "DiagTrack"
CALL :DisableService "dmwappushservice"


CALL :DisableTask "\Microsoft\Windows\Application Experience\StartupAppTask"
CALL :DisableTask "\Microsoft\Windows\Application Experience\PcaPatchDbTask"
CALL :DisableTask "\Microsoft\Windows\Application Experience\MareBackup"
CALL :DisableTask "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
CALL :DisableTask "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
CALL :DisableTask "\Microsoft\Windows\Application Experience\PcaWallpaperAppDetect"
CALL :DisableTask "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
CALL :DisableTask "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
CALL :DisableTask "\Microsoft\Windows\Feedback\Siuf\DmClient"
CALL :DisableTask "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
CALL :DisableTask "\Microsoft\Windows\Windows Error Reporting\QueueReporting"


CALL :ModifyRegistryValue "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" AllowTelemetry REG_DWORD 0
CALL :ModifyRegistryValue "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" AllowTelemetry REG_DWORD 0
CALL :ModifyRegistryValue "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" DisableOneSettingsDownloads REG_DWORD 1
CALL :ModifyRegistryValue "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" AllowDesktopAnalyticsProcessing REG_DWORD 0
CALL :ModifyRegistryValue "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" LimitEnhancedDiagnosticDataWindowsAnalytics REG_DWORD 1
CALL :ModifyRegistryValue "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" AllowDeviceNameInTelemetry REG_DWORD 0
CALL :ModifyRegistryValue "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" DisableTelemetryOptInChangeNotification REG_DWORD 1
CALL :ModifyRegistryValue "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" DisableTelemetryOptInSettingsUx REG_DWORD 1
CALL :ModifyRegistryValue "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" AllowWUfBCloudProcessing REG_DWORD 0
CALL :ModifyRegistryValue "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" AllowUpdateComplianceProcessing REG_DWORD 0
CALL :ModifyRegistryValue "HKCU\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics" Value REG_SZ "Deny"
CALL :ModifyRegistryValue "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" AITEnable REG_DWORD 0
CALL :ModifyRegistryValue "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" DisableInventory REG_DWORD 1
CALL :ModifyRegistryValue "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" EnableActivityFeed REG_DWORD 0
CALL :ModifyRegistryValue "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" PublishUserActivities REG_DWORD 0
CALL :ModifyRegistryValue "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" UploadUserActivities REG_DWORD 0
CALL :ModifyRegistryValue "HKLM\SOFTWARE\Microsoft\SQMClient\Windows" CEIPEnable REG_DWORD 0
CALL :ModifyRegistryValue "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" TailoredExperiencesWithDiagnosticDataEnabled REG_DWORD 0
CALL :ModifyRegistryValue "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" Enabled REG_DWORD 0
CALL :ModifyRegistryValue "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" DisabledByGroupPolicy REG_DWORD 1
CALL :ModifyRegistryValue "HKCU\Software\Microsoft\InputPersonalization" RestrictImplicitInkCollection REG_DWORD 1
CALL :ModifyRegistryValue "HKCU\Software\Microsoft\InputPersonalization" RestrictImplicitTextCollection REG_DWORD 1
CALL :ModifyRegistryValue "HKCU\Software\Microsoft\InputPersonalization\TrainedDataStore" HarvestContacts REG_DWORD 0
CALL :ModifyRegistryValue "HKCU\Software\Microsoft\Personalization\Settings" AcceptedPrivacyPolicy REG_DWORD 0
CALL :ModifyRegistryValue "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" Disabled REG_DWORD 1
CALL :ModifyRegistryValue "HKCU\SOFTWARE\Microsoft\Siuf\Rules" NumberOfSIUFInPeriod REG_DWORD 0
CALL :ModifyRegistryValue "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" IRPStackSize REG_DWORD 30
CALL :ModifyRegistryValue "HKCU\Control Panel\International\User Profile" HttpAcceptLanguageOptOut REG_DWORD 1
CALL :ModifyRegistryValue "HKCU\Software\Policies\Microsoft\Windows\EdgeUI" DisableMFUTracking REG_DWORD 1
CALL :ModifyRegistryValue "HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings" IsDeviceSearchHistoryEnabled REG_DWORD 0

CALL :ModifyRegistryValue "HKLM\SOFTWARE\Policies\Microsoft\Edge" PersonalizationReportingEnabled REG_DWORD 0
CALL :ModifyRegistryValue "HKLM\SOFTWARE\Policies\Microsoft\Edge" UserFeedbackAllowed REG_DWORD 0
CALL :ModifyRegistryValue "HKLM\SOFTWARE\Policies\Microsoft\Edge" MicrosoftEdgeInsiderPromotionEnabled REG_DWORD 0
CALL :ModifyRegistryValue "HKLM\SOFTWARE\Policies\Microsoft\Edge" DiagnosticData REG_DWORD 0
CALL :ModifyRegistryValue "HKLM\SOFTWARE\Policies\Microsoft\Edge" Edge3PSerpTelemetryEnabled REG_DWORD 0
CALL :ModifyRegistryValue "HKLM\SOFTWARE\Policies\Microsoft\Edge" BingAdsSuppression REG_DWORD 1
CALL :ModifyRegistryValue "HKLM\SOFTWARE\Policies\Microsoft\Edge" SafeBrowsingSurveysEnabled REG_DWORD 0



REM Functions
:DisableService
	SC.EXE STOP %~1 > NUL
	SC.EXE CONFIG %~1 START= disabled > NUL
	EXIT /B

:DisableTask
	SCHTASKS.EXE /CHANGE /TN "%~1" /DISABLE > NUL
	EXIT /B

:ModifyRegistryValue
	REG.EXE ADD "%~1" /V "%~2" /T %~3 /D %~4 /F > NUL
	EXIT /B
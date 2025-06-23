@echo off
echo Stopping Windows Update Service...
net stop wuauserv
sc config wuauserv start= disabled

echo Disabling Windows Update Medic Service...
net stop WaaSMedicSvc
sc config WaaSMedicSvc start= disabled

echo Disabling Delivery Optimization...
sc stop DoSvc
sc config DoSvc start= disabled

echo Disabling SmartScreen and Telemetry...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableSmartScreen /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f

echo Disabling Location Service...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v Status /t REG_DWORD /d 0 /f

echo Disabling Suggested Content and Ads...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338393Enabled /t REG_DWORD /d 0 /f

echo Uninstalling OneDrive...
taskkill /f /im OneDrive.exe
%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall

echo Done! Don’t forget to restart your computer for changes to take effect.
pause
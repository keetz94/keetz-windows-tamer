@echo off
echo Enabling Windows Update Service...
sc config wuauserv start= auto
net start wuauserv

echo Enabling Windows Update Medic Service...
sc config WaaSMedicSvc start= demand
net start WaaSMedicSvc

echo Enabling Delivery Optimization Service...
sc config DoSvc start= auto
net start DoSvc

echo Resetting SmartScreen and Telemetry settings...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableSmartScreen /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /f

echo Enabling Location Service...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v Status /t REG_DWORD /d 1 /f

echo Re-enabling Suggested Content and Recommendations...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338393Enabled /t REG_DWORD /d 1 /f

echo OneDrive is now allowed again. (Manual reinstallation may be required)
echo Done! Don’t forget to restart your computer.
pause

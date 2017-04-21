
Param(
  [string]$SharedFolderUser = 'Administrator',
  [string]$SharedFolderPassword = '7fMTKtvR',
  [string]$ComputerRepository = "10.246.20.39",
  [string]$DirSoftwareToInstall = "SoftwareToInstall",
  [string]$DirDrivers = "drivers",
  [string]$DirPrograms = "programs",
  [string]$DirDestination = "C:\ToolChainPrograms",
  [string]$Proxy = "proxy.volvocars.net",
  [string]$ProxyPort = "83",
  [string]$ProxyUser = "acafiero",
  [string]$ProxyPassword = "Simone01",
  [string]$HUBADDRESS = "10.244.181.145",
  [string]$HUBPORT = "7575",
  [string]$DEVICEADDRESS = "GOT100BQCZPF2.50"
  )


net use l: \\$($ComputerRepository)\$($DirSoftwareToInstall) /user:$($SharedFolderUser) $($SharedFolderPassword)
pnputil /a l:\$($DirDrivers)\Arduino\arduino.inf
pnputil /a l:\$($DirDrivers)\FTDI\ftdiport.inf
pnputil /a l:\$($DirDrivers)\CH341SER\CH341SER.INF
pnputil /a l:\$($DirDrivers)\vh41\vhhub.INF
pnputil /a l:\$($DirDrivers)\vh41\vhhcd.INF
echo $DirDestination
#Copy-Item -Path l:\$DirPrograms\vhui64.exe -Destination $DirDestination –Recurse -Force
xcopy l:\$DirPrograms\vhui64.exe $DirDestination\ /E /Y /I
& "$($DirDestination)\vhui64.exe" "-d"
& "$($DirDestination)\vhui64.exe" "-b"
& "$($DirDestination)\vhui64.exe" "-t MANUAL HUB ADD,$($HUBADDRESS):$($HUBPORT)"
& "$($DirDestination)\vhui64.exe" "-t AUTO USE DEVICE,$($DEVICEADDRESS)"
xcopy l:\$DirPrograms\node-v6.10.0-x64.msi $DirDestination\ /E /Y /I
echo "installing node-v6.10.0-x64.msi"
Start-Process -FilePath $DirDestination\node-v6.10.0-x64.msi -ArgumentList "/quiet" -Wait
npm config set proxy "http://$($ProxyUser):$($ProxyPassword)@$($Proxy):$($ProxyPort)"
npm config set https-proxy "http://$($ProxyUser):$($ProxyPassword)@$($Proxy):$($ProxyPort)"
XCOPY l:\$DirPrograms\DongleSimulator-master\* $DirDestination\DongleSimulator-master /E /Y /I
XCOPY l:\$DirPrograms\HILTestSimulator-develop\* $DirDestination\HILTestSimulator-develop /E /Y /I
cd $DirDestination\DongleSimulator-master
npm install
cd $DirDestination\HILTestSimulator-develop
npm install


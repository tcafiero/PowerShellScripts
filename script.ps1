Param(
  [string]$ComputerRepository,
  [string]$PHUBADDRESS,
  [string]$PHUBPORT,
  [string]$PDEVICEADDRESS
)

net use l: \\$ComputerRepository\SoftwareToInstall /user:Administrator 7fMTKtvR
dir l:
pnputil /a l:\drivers\Arduino\arduino.inf
pnputil /a l:\drivers\FTDI\ftdiport.inf
pnputil /a l:\drivers\CH341SER\CH341SER.INF
pnputil /a l:\drivers\vh41\vhhub.INF
pnputil /a l:\drivers\vh41\vhhcd.INF
xcopy l:\programs\vhui64.exe C:\ToolChainPrograms\ /E /Y /I
C:\ToolChainPrograms\vhui64.exe -d
C:\ToolChainPrograms\vhui64.exe -b
C:\ToolChainPrograms\vhui64.exe -t "MANUAL HUB ADD,$($PHUBADDRESS):$($PHUBPORT)"
C:\ToolChainPrograms\vhui64.exe -t "AUTO USE DEVICE,$($PDEVICEADDRESS)"
xcopy l:\programs\node-v6.10.0-x64.msi C:\ToolChainPrograms\ /E /Y /I
echo "installing node-v6.10.0-x64.msi"
Start-Process -FilePath C:\ToolChainPrograms\node-v6.10.0-x64.msi -ArgumentList "/quiet" -Wait
npm config set proxy http://acafiero:Simone01@proxy.volvocars.net:83
npm config set https-proxy http://acafiero:Simone01@proxy.volvocars.net:83
XCOPY l:\programs\DongleSimulator-master\* C:\ToolChainPrograms\DongleSimulator-master /E /Y /I
XCOPY l:\programs\HILTestSimulator-develop\* C:\ToolChainPrograms\HILTestSimulator-develop /E /Y /I
cd C:\ToolChainPrograms\DongleSimulator-master
npm install
cd C:\ToolChainPrograms\HILTestSimulator-develop
npm install


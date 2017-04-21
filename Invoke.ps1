param(
  [string]$VMUsername = 'Administrator',
  [string]$VMPassword = '7fMTKtvR',
  [string]$VMName = "10.246.20.41",
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


$p = @{
SharedFolderUser = $SharedFolderUser
SharedFolderPassword = $SharedFolderPassword
ComputerRepository = $ComputerRepository
DirSoftwareToInstall = $DirSoftwareToInstall
DirDrivers = $DirDrivers
DirPrograms = $DirPrograms
DirDestination = $DirDestination
Proxy = $Proxy
ProxyPort = $ProxyPort
ProxyUser = $ProxyUser
ProxyPassword = $ProxyPassword 
HUBADDRESS = $HUBADDRESS
HUBPORT = $HUBPORT
DEVICEADDRESS = $DEVICEADDRESS
}

$ScriptPath = '.\script.ps1'
$sb = [scriptblock]::create(".{$(get-content $ScriptPath -Raw)} $(&{$args} @p)")


$pass = ConvertTo-SecureString -AsPlainText $VMPassword -Force
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $VMUsername,$pass
$s = New-PSSession -ComputerName ($VMName) -Credential $Cred
#Invoke-Command -Session $s -FilePath .\script.ps1
Invoke-Command -Session $s -ScriptBlock $sb

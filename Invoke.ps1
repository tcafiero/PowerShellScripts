param(
  [string]$Username = 'Administrator',
  [string]$Password = '7fMTKtvR',
  [string]$ComputerName = "10.246.20.41",
  [string]$Repository = "10.246.20.39",
  [string]$HUBADDRESS = "10.246.40.179",
  [string]$HUBPORT = "7575",
  [string]$DEVICEADDRESS = "GOT100BQCZPF2.50"
)

$p = @{
ComputerRepository=$Repository
PHUBADDRESS=$HUBADDRESS
PHUBPORT=$HUBPORT
PDEVICEADDRESS=$DEVICEADDRESS
}

$ScriptPath = '.\script.ps1'
$sb = [scriptblock]::create(".{$(get-content $ScriptPath -Raw)} $(&{$args} @p)")


$pass = ConvertTo-SecureString -AsPlainText $Password -Force
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass
$s = New-PSSession -ComputerName ($ComputerName) -Credential $Cred
#Invoke-Command -Session $s -FilePath .\script.ps1
Invoke-Command -Session $s -ScriptBlock $sb

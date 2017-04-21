param(
  [string]$VMUsername = 'Administrator',
  [string]$VMPassword = '7fMTKtvR',
  [string]$VMName = "10.246.20.41",
  [string]$Script = '.\script.ps1'
)


$p = @{
}

#$ScriptPath = '.\script.ps1'
$sb = [scriptblock]::create(".{$(get-content $Script -Raw)} $(&{$args} @p)")


$pass = ConvertTo-SecureString -AsPlainText $VMPassword -Force
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $VMUsername,$pass
$s = New-PSSession -ComputerName ($VMName) -Credential $Cred
#Invoke-Command -Session $s -FilePath .\script.ps1
Invoke-Command -Session $s -ScriptBlock $sb

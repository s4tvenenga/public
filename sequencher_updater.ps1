<#PSScriptInfo
​
.VERSION 1.0
​
.GUID 
​
.AUTHOR Christopher Gallahan
​
.COMPANYNAME GeneDx
​
.COPYRIGHT
​
.TAGS
​
.LICENSEURI
​
.PROJECTURI
​
.ICONURI
​
.EXTERNALMODULEDEPENDENCIES
​
.REQUIREDSCRIPTS
​
.EXTERNALSCRIPTDEPENDENCIES
​
.RELEASENOTES
Sequencher_license_updater script now supports the following features:
​
Version 1.0
Install Sequencher license data
​
.PRIVATEDATA
​
#>
​
<#
​
.DESCRIPTION
Install Sequencher GeneDx license data
​
#>
​
#If running in 32bit convert to 64bit powershell
If ($ENV:PROCESSOR_ARCHITEW6432 -eq "AMD64") {
    Try {
        &"$ENV:WINDIR\SysNative\WindowsPowershell\v1.0\PowerShell.exe" -File $PSCOMMANDPATH
    }#end try
    Catch {
        Throw "Failed to start $PSCOMMANDPATH"
    }#end catch
    Exit
}#end if
​
#check if Log folder exist, if not, then create the folder for the logs to be saved too
If(!(Test-Path -Path "C:\ProgramData\GeneDx")){
    New-Item -Path "C:\ProgramData\" -Name "GeneDx" -ItemType "directory" -Force
}#endif
​
#Ensure Transcript is not already running
try{
    Stop-Transcript | out-null
}#end try
catch [System.InvalidOperationException]{}#end catch
​
#Start Logging of Script
Start-Transcript -Path "C:\ProgramData\GeneDx\Install-Sequencherlicense.txt" -Force
​
#Create Path for Sequencher license
$registryPath = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components"
New-Item -Path $registryPath -Name "sequencherlicense" -ErrorAction SilentlyContinue
$registryPath = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\sequencherlicense"
​
#Set Sequencher License
try{
    if(Test-Path $registryPath){
        $Version = "1"
        $StubPath = "reg add HKEY_CURRENT_USER\SOFTWARE\Sassafras\KeyAccess\logon /v host /d sequencher.genedx.com /t REG_SZ /f"
        New-ItemProperty -Path $registryPath -Name "Version" -Value $Version -PropertyType string -Force | Out-Null
        New-ItemProperty -Path $registryPath -Name "StubPath" -Value $StubPath -PropertyType string -Force | Out-Null
    }#end if
    else{
        $errorMessage = "`rCould not find registry path: $registryPath"
        throw $errorMessage
    }#end else
}#end try
catch{
    Write-Host $errorMessage
    Write-Host "An Error Occurred, See line above for more details."
    Return 1
}#end catch
​
#Create New Sequencher host path
$registryPath = "HKLM:\SYSTEM\ControlSet001\Services"
New-Item -Path $registryPath -Name "KeyAccess" -Force
$registryPath = "HKLM:\SYSTEM\ControlSet001\Services\KeyAccess"
New-Item -Path $registryPath -Name "Settings" -Force
$registryPath = "HKLM:\SYSTEM\ControlSet001\Services\KeyAccess\Settings"
New-Item -Path $registryPath -Name "logon" -Force
$registryPath = "HKLM:\SYSTEM\ControlSet001\Services\KeyAccess\Settings\logon"
​
#Set Sequencher License
try{
    
    New-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Services\KeyAccess\Settings\logon" -Name "host" -Value "sequencher.genedx.com" -PropertyType string -Force | Out-Null
​
    Bitsadmin.exe /transfer "keyacc_INI_download" https://raw.githubusercontent.com/s4tvenenga/public/main/keyacc.ini C:\Windows\keyacc.ini
​
    Write-Host "Script completed Successfully"
    Return 0
​
}#end try
catch{
    Write-Host $errorMessage
    Write-Host "An Error Occurred, See line above for more details."
    Return 1
}#end catch
finally{
    $Error.Clear()
    Stop-Transcript
}#end finally

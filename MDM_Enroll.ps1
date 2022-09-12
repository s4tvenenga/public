#set registry keys
if(test-path -Path Registry::HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\CurrentVersion\MDM){
new-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\CurrentVersion\MDM -Name "AutoEnrollMDM" -Value 1 -ErrorAction SilentlyContinue
new-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\CurrentVersion\MDM -Name "UseAADCredentialType" -Value 1 -ErrorAction SilentlyContinue 
}
else{
new-item -path Registry::HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\CurrentVersion\MDM
new-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\CurrentVersion\MDM -Name "AutoEnrollMDM" -Value 1
new-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\CurrentVersion\MDM -Name "UseAADCredentialType" -Value 1
}
#do the thing that makes the work!
Invoke-WebRequest -URI "https://raw.githubusercontent.com/s4tvenenga/XML/main/MDMAutoEnroll.xml" -OutFile "C:\MDMAutoEnroll.xml"
Register-ScheduledTask -TaskName "Schedule created by enrollment client for automatically enrolling in MDM from AAD" -XML (Get-Content "C:\MDMAutoEnroll.xml" | Out-String) -TaskPath "\Microsoft\Windows\EnterpriseMgmt" -Force -user system

@ECHO OFF
REG add "HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\MDM" /v "AutoEnrollMDM" /t REG_DWORD /d 1 /f
REG add "HKLM\Software\Policies\Microsoft\Windows\CurrentVersion\MDM" /v "UseAADCredentialType" /t REG_DWORD /d 1 /f
Bitsadmin.exe /transfer "xml" https://raw.githubusercontent.com/s4tvenenga/XML/main/MDMAutoEnroll.xml C:\MDMAutoEnroll.xml
schtasks.exe /create /TN "\Microsoft\Windows\EnterpriseMgmt\Schedule created by enrollment client for automatically enrolling in MDM from AAD" /xml "C:\MDMAutoEnroll.xml"
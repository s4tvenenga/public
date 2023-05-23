@ECHO OFF

REM -- adding routine to Active setup to create registry key the first time a new user logs in --
REG add "HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\sequencherlicense" /v "Version" /d "1" /t REG_SZ /f
REG add "HKLM\SOFTWARE\Microsoft\Active Setup\Installed Components\sequencherlicense" /v "StubPath" /d "reg add HKEY_CURRENT_USER\SOFTWARE\Sassafras\KeyAccess\logon /v host /d sequencher.genedx.com /t REG_SZ /f"

REM -- add key to HKLM --
REG add "HKLM\SYSTEM\ControlSet001\Services\KeyAccess\Settings\logon" /v host /t REG_SZ /d sequencher.genedx.com /f

REM -- replace keyacc.ini file --
Bitsadmin.exe /transfer "keyacc_INI_download" https://raw.githubusercontent.com/s4tvenenga/public/main/keyacc.ini C:\Windows\keyacc.ini

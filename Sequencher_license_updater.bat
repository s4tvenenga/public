@ECHO OFF
REG add "HKLM\SYSTEM\ControlSet001\Services\KeyAccess\Settings\logon" /v host /t REG_SZ /d sequencher.genedx.com /f
Bitsadmin.exe /transfer "keyacc_INI_download" https://raw.githubusercontent.com/s4tvenenga/public/main/keyacc.ini C:\Windows\keyacc.ini
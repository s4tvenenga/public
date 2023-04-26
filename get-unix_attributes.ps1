﻿$users_name = read-host -prompt "Enter the username"
Get-ADUser -Filter "Name -like '$users_name'" -Properties * |select SamAccountName,uidNumber,gidNumber,loginShell,unixhomeDirectory, @{Label='PrimaryGroupDN';Expression={(Get-ADGroup -Filter {GIDNUMBER -eq $_.gidnumber}).DistinguishedName}}
Write-Host "
{}}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}}
{}                                                {}
{}         Welcome to the Motherload              {}
{}                                                {}
{}                   By                           {}
{}                                                {}
{}            Joshua Montgomery                   {}
{}                                                {}
{}                                                {}
{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{} "

Write-Host " ~(:Stay Tuned More to Come :)~"

Do {
Write-Host "
----------Active Directory Options----------
1 = AD Pwassword Randomizer
2 = AD Users Disabled
3 = AD Computers inactive for 120 days
4 = AD Users Inactive for 120 days
5 = AD Search Manager
6 = IPconfig
7 = Tracert -j <IP HERE>
8 = AD Computers Active
9 = AD Users Active
10 = AD Group Members #Detailed list of users within a group
11 = AD User Removal
12 = AD User Disable
13 = AD User Enable
14 = AD User Creation
--------------------------"
$choice1 = read-host -prompt "Select number & press enter
Or Press Q to quit"
} until ($choice1 -eq "1" -or $choice1 -eq "2" -or $choice1 -eq "3" -or $choice1 -eq "4" -or $choice1 -eq "5" -or $choice1 -eq "6" -or $choice1 -eq "7" -or $choice1 -eq "8" -or $choice1 -eq "9" -or $choice1 -eq "10" -or $choice -eq "11" -or $choice1 -eq "12" -or $choice1 -eq "13" -or $choice1 -eq "14")


Switch ($choice1) {
"1" {Write-Host "Randomizing Passwords ......."
    $chars = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvXxYyZz!#%&?@$^*()".toCharArray()
    $newPassword=""
    1..12 | ForEach {  $newPassword += $chars | Get-Random }
    Write-Host $newPassword -ForegroundColor 'Yellow'
    pause}

"2" {Get-ADUser -Filter {Enabled -eq $false} | FT samAccountName
pause}
"3" {$COMPAREDATE=GET-DATE
Search-ADAccount -AccountInactive -TimeSpan 120 -ComputersOnly | Where-Object { $_.Enabled -eq $True } | Format-Table Name, UserPrincipalName
pause}
"4"{$COMPAREDATE=GET-DATE
$NumberDays=120
$CSVFileLocation='C:\TEMP\OldComps.CSV'
Search-ADAccount -AccountInactive -TimeSpan 120 -UsersOnly | Where-Object { $_.Enabled -eq $True } | Format-Table Name, UserPrincipalName
pause}
"5"{Get-ADUser -Id <User here> -properties Manager | Select Manager
pause}
"6"{IPconfig /all
pause}
"7"{Tracert -j 192.168.1.1 
pause}
"8"{Get-ADComputer -Filter {Enabled -eq $True}| FT samAccountName
pause}
"9"{Get-ADUser -Filter {Enabled -eq $True}| FT samAccountName
pause}
"10"{Get-ADGroupMember -identity group input here |Select SamAccountName
pause}
"11"{Remove-ADUser -Identity USER HERE
pause}
"12"{Disable-ADAccount -Identity USER HERE
pause}
"13"{Enable-ADAccount -Identity USER HERE
pause}
"14"{New-ADUser -Name Test -AccountPassword (Read-Host -AsSecureString "AccountPassword") -Manager "Tester" -EmailAddress "Test@contoso.com" -DisplayName "Test" -UserPrincipalName "Test"
pause}
}



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
15 = Remote File Transfer
16 = Remote File Transfer to Multiple Machines
17 = Remote File Transfer from Remote Machine to Remote Machine
18 = Local File Path Creation
--------------------------"
$choice1 = read-host -prompt "Select number & press enter
Or Press Q to quit"
} until ($choice1 -eq "Q" -or $choice1 -eq "1" -or $choice1 -eq "2" -or $choice1 -eq "3" -or $choice1 -eq "4" -or $choice1 -eq "5" -or $choice1 -eq "6" -or $choice1 -eq "7" -or $choice1 -eq "8" -or $choice1 -eq "9" -or $choice1 -eq "10" -or $choice -eq "11" -or $choice1 -eq "12" -or $choice1 -eq "13" -or $choice1 -eq "14" -or $choice1 -eq "15" -or $choice1 -eq "16" -or $choice1 -eq "17" -or $choice1 -eq "18")


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
"5"{Get-ADUser -Id User here -properties Manager | Select Manager
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
"14"{New-ADUser -Name Test -AccountPassword (Read-Host -AsSecureString "AccountPassword") -Manager "Manager Name" -EmailAddress "Test@contoso.com" -DisplayName "Test" -GivenName Joshua -Surname Montgomery -Description IT -Office AuburnOps -ho -UserPrincipalName "Test" -CannotChangePassword $False -ChangePasswordAtLogon $True -Title Clerck -Department IT -Company UCB -Enabled $True 
pause}
"15"{$Session = New-PSSession -ComputerName Name Here -Credential $cred
Copy-Item -Path File Path here -Destination Destination here -ToSession $Session -Verbose
pause}
"16"{$computers = Get-Content "C:\Temp\servers.txt"

$source = "C:\TEMP\oldComps.csv"

$destination = "C$\Windows\Temp\"

foreach ($computer in $computers) {
if ((Test-Path -Path \\$computer\$destination)) 
{Copy-Item $source -Destination "\\$computer\$destination" -Recurse -verbose
} else {
"\\$computer\$destination is not reachable or does not exist"
    Write-Host "Copy Complete"
}
}
Pause}

"17"{Copy-Item -Path source -Destination -verbose 
pause}

"18"{New-Item -Path Path here -Value $env:COMPUTERNAME -Verbose
pause}
}



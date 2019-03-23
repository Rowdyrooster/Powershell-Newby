Get-Module -Name ActiveDirectory

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
{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{}{} 
►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄
 ____________    ________     ___      ___       ______ _________ _     _______ _______ _        ________          __
/___ //___///    /______/    / / \    / / \     /     //__ //___///    / _____//  _   ///       /      /\\         ||
    //    //    //          / / \ \  / / \ \   /  _  /    //    //    //      /  / / ///       /  _   /  \\        ||
   //    //___ //_____     / /   \ \/ /   \ \ / /_/ /    //    //____//_____ /______///       /  /_/ /____\\   ____|| 
  //    //_ ///______/    / /     \__/     \ \     /    //    //__ //______/// \\   //       /      /______\\ | __  |
 //    //  ////_______   / /       ^        \ \   /    //    //   ///______//   \\ //_______/      /        \\||__| |
//    //  ////_______/  / /      <( )>     /_\ \_/    //    //   //________/     \\________/______/          \\_____|
►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄►◄

"
Write-Host " ~(:Stay Tuned More to Come :)~"

Do {
Write-Host "
----------General Script Commands-----------
 Q = Exit
--------------------------------------------

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
-------------------------------------------

-------------------Tools-------------------
15 = GPUpdate Force
16 = AD User Unlock #Requires DOMAIN ADMIN 
17 = Remote Desktop #Opens RDP Window
18 = Bitlocker 6 Pin Randomizer
19 = Enable Bitlocker on Drive C: #Servers
20 = Bitlocker Status
21 = Disk Space Report 
22 = Application Logs
23 = System Logs
24 = Security Logs
25 = ADUser Accounts Enabled in Gridview
26 = ADUser Accounts Disabled in Gridview
-------------------------------------------

---------------Exchange Tools--------------
27 = Get-Mailbox 




"


$choice1 = read-host -prompt "Select number & press enter
Or Press Q to quit"
} until ($choice1 -eq "Q" -or $choice1 -eq "1" -or $choice1 -eq "2" -or $choice1 -eq "3" -or $choice1 -eq "4" -or $choice1 -eq "5" -or $choice1 -eq "6" -or $choice1 -eq "7" -or $choice1 -eq "8" -or $choice1 -eq "9" -or $choice1 -eq "10" -or $choice -eq "11" -or $choice1 -eq "12" -or $choice1 -eq "13" -or $choice1 -eq "14" -or $choice1 -eq "15" -or $choice1 -eq "16" -or $choice1 -eq "17" -or $choice1 -eq "18" -or $choice1 -eq "19" -or $choice1 -eq "20" -or $choice1 -eq "21" -or $choice1 -eq "22" -or $choice1 -eq "23" -or $choice1 -eq "24" -or $choice1 -eq "25"-or $choice1 -eq "27" -or $choice1 -eq "26")


Switch ($choice1) {

"Q"{exit}

"1" {Write-Host "Randomizing Passwords ......."
    $chars = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvXxYyZz!#%&?@$^*()".toCharArray()
    $newPassword=""
    1..12 | ForEach {  $newPassword += $chars | Get-Random }
    Write-Host $newPassword -ForegroundColor 'Yellow'
    Send-MailMessage -To Emailaddress@email.com -From Emailaddress@email.com -Subject "New Password" -Body ($newPassword | Out-String) -SmtpServer Server.com
    pause}

"2" {Get-ADUser -Filter {Enabled -eq $false} | FT samAccountName
pause}

"3" {$COMPAREDATE = GET-DATE
$NoContact = Search-ADAccount -AccountInactive -TimeSpan 120 -ComputersOnly | Where-Object { $_.Enabled -eq $True } | Format-Table Name, UserPrincipalName
Send-MailMessage -To Emailaddress@email.com -from Emailaddress@email.com -Subject "120 day PC No Domain Contact" -Body ($NoContact | Out-String) -SmtpServer Server.com
pause}

"4"{$COMPAREDATE = GET-DATE
$NumberDays=120
$CSVFileLocation='C:\TEMP\OldComps.CSV'
$output = Search-ADAccount -AccountInactive -TimeSpan 120 -UsersOnly | Where-Object { $_.Enabled -eq $True } | Format-Table Name, UserPrincipalName
Send-MailMessage -To Emailaddress@email.com -From Emailaddress@email.com -Subject "Disabled AD Accounts" -Body ($output|Out-String) -SmtpServer Server.com
pause}

"5"{Get-ADUser -Id User here -properties Manager | Select Manager
pause}

"6"{IPconfig /all
pause}

"7"{Tracert -j 192.168.1.1 
pause}

"8"{$EnabledPCs = Get-ADComputer -Filter {Enabled -eq $True}| FT Name 
Send-MailMessage -To Emailaddress@email.com -From Emailaddress@email.com -Subject "Enabled AD Computers" -Body ($EnabledPCs | Out-String) -SmtpServer Server.com
pause}

"9"{Get-ADUser -Filter {Enabled -eq $True}| FT SamAccountName
pause}

"10"{Get-ADGroupMember -identity Administrators |Select SamAccountName
pause}

"11"{Remove-ADUser -Identity USER HERE
pause}

"12"{Disable-ADAccount -Identity USER HERE
pause}

"13"{Enable-ADAccount -Identity USER HERE
pause}

"14"{New-ADUser -Name Test -AccountPassword (Read-Host -AsSecureString "AccountPassword") -Manager "Name" -EmailAddress "Emailaddress@email.com" -DisplayName "Test" -GivenName Name -Surname Last Name -Description IT -Office OfficeName -ho -UserPrincipalName "Test" -CannotChangePassword $False -ChangePasswordAtLogon $True -Title Name -Department IT -Company Name -Enabled $True 
pause}

"15"{gpupdate /force
pause} 

"16"{Unlock-ADAccount -verbose
pause}

"17"{mstsc.exe}

"18"{Write-Host "Randomizing Passwords ......."
    $chars = "0123456789".toCharArray()
    $newPassword=""
    1..6 | ForEach {  $newPassword += $chars | Get-Random }
    Write-Host $newPassword -ForegroundColor 'Yellow'
Send-MailMessage -To admin@digitalinves.com -From jmontgomery@digitalinves.com -Subject "Bitlocker Pin" -Body ($newPassword | Out-String) -SmtpServer dis-ex.digitalinves.com
    pause}

"19"{$TPMKey = Manage-bde -Protectors -add C: -TPMandPIN
Send-MailMessage -To Emailaddress@email.com -From Emailaddress@email.com -subject "TPM Pin Setup on System" -Body ($TPMKey | Out-String) -SmtpServer Server.com
Pause}

"20"{$BitStatus = Manage-BDE -Status
Send-MailMessage -To Emailaddress@email.com -From Emailaddress@email.com -subject "Bitlocker Status" -Body ($BitStatus | Out-String) -SmtpServer Server.com
}

# You can hash out the send message line and use the second line of this for a list of drives instead of sending and email #  

"21"{$DiskSpace = Get-WmiObject Win32_logicalDisk -computerName dis-lab-2 | Format-List DeviceID,{$_.FreeSpace /1GB}
$DiskSpace | Out-String
#Send-MailMessage -to Emailaddress@email.com -From Emailaddress@email.com -subject "Disk Space" -Body ($DiskSpace | Out-String) -SmtpServer Server.com
}

"22"{$Application = Get-EventLog -LogName Application
$Application | Out-GridView
}

"23"{$System = Get-EventLog -LogName System
$System | Out-GridView
}

"24"{$Security = Get-EventLog -LogName Security
$Security | Out-GridView
}

"25"{$showmethegrid = Get-ADUser -Filter {Enabled -eq $True} | Out-GridView
$showmethegrid | Out-GridView
}

"26"{$showmethegrid = Get-ADUser -Filter {Enabled -eq $False} | Out-GridView
$showmethegrid | Out-GridView
}

}



Do {
Write-Host "
----------Active Directory Options----------
1 = AD Pwassword reset
2 = AD User disabled
3 = AD Computer Disabled
--------------------------"
$choice1 = read-host -prompt "Select number & press enter"
} until ($choice1 -eq "1" -or $choice1 -eq "2" -or $choice1 -eq "3")

Switch ($choice1) {
"1" {write next sub-menu here}
"2" {write next sub-menu here}
"3" {Write next sub-menu here}
}
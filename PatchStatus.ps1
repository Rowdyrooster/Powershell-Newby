﻿$output = Get-WsusUpdate -Status Needed, FailedOrNeeded, Failed, NoStatus  | Format-List -Expand EnumOnly
Send-MailMessage -From "WSUS New Patches <jmontgomery@digitalinves.com>" -to "admin@digitalinves.com" -Subject "WSUS Test" -Body ($output | Out-String) -SmtpServer dis-ex.digitalinves.com
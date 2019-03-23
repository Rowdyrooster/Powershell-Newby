Param (
[string]$UpdateServer = 'dis-wsus', # This is the WSUS server name.
[int]$Port = 8530, # This is the TCP port that use WSUS.
[bool]$Secure = $False # Set this to TRUE if you use HTTPS to access WSUS service.
)
$smtp = "dis-ex.digitalinves.com" # This is your SMTP Server
$to1 = "admin@digitalinves.com" # This is the recipient smtp address 1
$from = $UpdateServer + "<" + $UpdateServer + "admin@digitalinves.com>" # This will be the sender´s address identifying the WSUS server

$MsgBody = "<HTML>"
$MsgBody = $MsgBody + "<HEAD>"
$MsgBody = $MsgBody + "<title>All`s computers report on server:" + $UpdateServer + "</title>"
$MsgBody = $MsgBody + "</HEAD>"
$MsgBody = $MsgBody + "<BODY style=""font-family:'Courier New', Courier, monospace"">"

$MsgBody= $MsgBody + "<h1>All`s computers report on server: " + $UpdateServer + "</h1>"
$intLineCounter = 0 # To count computers.

Remove-Item -force PcStatusReport.txt # This is a small log file to keep track of the last run results. It needs to be removed before start reading the list.

If (-Not (Import-Module UpdateServices -PassThru)) {
Add-Type -Path "$Env:ProgramFiles\Update Services\Api\Microsoft.UpdateServices.Administration.dll" -PassThru
}

$Wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer($UpdateServer,$Secure,$Port) # With this we get connected to the WSUS server.

$CTScope = New-Object Microsoft.UpdateServices.Administration.ComputerTargetScope #This will the our scope, it includes all computers registered in the WSUS server.


# Now, lets write the HTML table headers.
$MsgBody = $MsgBody + "<table border=""1"" cellspacing=""2"" cellpadding=""2"" style=""font-family:'Courier New', Courier, monospace"">"
$MsgBody = $MsgBody + "<tr>"
$MsgBody = $MsgBody + "<th>Index</th>"
$MsgBody = $MsgBody + "<th>Status</th>"
$MsgBody = $MsgBody + "<th>Computer Name</th>"
$MsgBody = $MsgBody + "<th>IP Address</th>"
$MsgBody = $MsgBody + "<th>Last Contact</th>"
$MsgBody = $MsgBody + "<th>Total updates</th>"
$MsgBody = $MsgBody + "<th bgcolor=""LightSalmon "">Awaiting reboot</th>"
$MsgBody = $MsgBody + "<th bgcolor=""Cyan"">Ready to install</th>"
$MsgBody = $MsgBody + "<th bgcolor=""Yellow"">Download pending</th>"
$MsgBody = $MsgBody + "<th bgcolor=""IndianRed"">Failed</th>"
$MsgBody = $MsgBody + "<th bgcolor=""Silver"">Unknown State</th>"
$MsgBody = $MsgBody + "</tr>"


# This is the main part: Here we will sort the list of computers by name, and get details for each one of them.

$wsus.GetComputerTargets($CTScope) | Sort -Property FullDomainName | ForEach {

$objSummary = $_.GetUpdateInstallationSummary() # This is an intermediate object that contains the details.
$Down = $objSummary.DownloadedCount # This is the amount of updates that has been downloaded already.
$Fail = $objSummary.FailedCount # This is the count for the failed updates.
$Pend = $objSummary.InstalledPendingRebootCount # This is the number of updates that need to reboot to complete installation.
$NotI = $objSummary.NotInstalledCount # These are the needed updates for this computer.
$Unkn = $objSummary.UnknownCount # These are the updates that are waiting for detection on the first search.
$Total = $Down + $Fail + $Pend + $NotI + $Unkn # Total amount of updates for this computer.

$intLineCounter = $intLineCounter + 1 # Increase the table line counter.
$IntStr = [Convert]::ToString($intLineCounter) # convert it to string to put it on the HTML code.

if ($Total -eq 0) {$Estado="OK"; $bgcolor="LightGreen"}
elseif ($Pend -ne 0) {$Estado="Reboot needed"; $bgcolor="LightSalmon"}
elseif ($Down -ne 0) {$Estado="Ready to install"; $bgcolor="Cyan"}
elseif ($NotI -ne 0) {$Estado="Pending"; $bgcolor="Yellow"}
elseif ($Fail -ne 0) {$Estado="Error"; $bgcolor="IndianRed"}
elseif ($Unkn -ne 0) {$Estado="Not reported yet"; $bgcolor="Silver"}
else {$Estado=""; $bgcolor="White"}

Write-Verbose ($IntStr + " : " + $_.FullDomainName) -Verbose # Show task progress on screen.

$LastContact = $_.LastReportedStatusTime # This is the last time when the computer reported to the wsus.
$days = [Math]::Ceiling((New-TimeSpan -Start $LastContact).TotalDays) # This is the number of days since last time.

if ($days -gt 14) {$Color="Red"} # Computer is away for too long.
elseif ($days -gt 7) {$Color="Orange"} # Computer may be in trouble.
elseif ($days -gt 2) {$Color="Yellow"} # Computer may be off.
else {$Color="White"} # Computer is ok.

# Reformat days to a more human-readable form.
if ($days -eq 0) {$Dias="Today"}
elseif ($days -eq 1) {$Dias="Yesterday"}
else {$Dias="Since " + $days + " days."}

if ($LastContact -eq [DateTime]::MinValue) {$Dias="Never"; $Color="Silver"}

# Now write the table row with all the info.
$MsgBody = $MsgBody + " <tr>"
$MsgBody = $MsgBody + "<td align=""center"" valign=""middle""> " + $IntStr +" </td>"
$MsgBody = $MsgBody + "<td align=""center"" valign=""middle"" bgcolor=""" + $bgcolor + """> " + $Estado + " </td>"
$MsgBody = $MsgBody + "<td align=""center"" valign=""middle""> " + $_.FullDomainName+ " </td>"
$MsgBody = $MsgBody + "<td align=""center"" valign=""middle""> " + $_.IPAddress + " </td>"
$MsgBody = $MsgBody + "<td align=""center"" valign=""middle"" bgcolor=""" + $Color + """> " + $Dias +"</td>"
$MsgBody = $MsgBody + "<td align=""center"" valign=""middle"">" + $Total + "</td>"
$MsgBody = $MsgBody + "<td align=""center"" valign=""middle"">" + $Pend + "</td>"
$MsgBody = $MsgBody + "<td align=""center"" valign=""middle"">" + $Down + "</td>"
$MsgBody = $MsgBody + "<td align=""center"" valign=""middle"">" + $NotI + "</td>"
$MsgBody = $MsgBody + "<td align=""center"" valign=""middle"">" + $Fail + "</td>"
$MsgBody = $MsgBody + "<td align=""center"" valign=""middle"">" + $Unkn + "</td>"
$MsgBody = $MsgBody + "</tr>"

$_.FullDomainName >> PcStatusReport.txt # And append a new line on the log file.
}

$MsgBody = $MsgBody + "</table><br>" # Finish the HTML table.

if ($intLineCounter -eq 0) {
Write-Verbose ("You must run this script from as administrator to read WSUS database.") -Verbose # Display a warning if not run with admin privileges.
$MsgBody = $MsgBody + " You must run this script from as administrator to read WSUS database. <hr>"
} else {
$MsgBody = $MsgBody + "<hr>"
}

#This is a footnote for the report readers.
$MsgBody = $MsgBody + "<p><h2>Note: </h2>The updates are applied in a sequential three-steps process: Search, Download and Install.<br> Each computer has to go through these three stages to be updated.<ul>"
$MsgBody = $MsgBody + "<li>Before the first time a search is run, it is unknown whether the computer will need some updating, thats why in this case all updates appear in <strong>Unknown State</strong>.</li>"
$MsgBody = $MsgBody + "<li>Once the search is complete, the updates appear as <strong>Download pending</strong>, which are the updates that the computer specifically needs.</li>"
$MsgBody = $MsgBody + "<li>When the computer has downloaded pending updates, these are counted as <strong>Ready to install</strong>.</li>"
$MsgBody = $MsgBody + "<li>At the end of the installation stage you can get one of these results:</li><ul>"
$MsgBody = $MsgBody + "<li><strong>OK</strong>: All necessary updates were installed correctly.</li>"
$MsgBody = $MsgBody + "<li><strong>ERROR</strong>: One or more required updates were not installed correctly.</li>"
$MsgBody = $MsgBody + "<li><strong>Reboot needed</strong>: The installation ended the first part, but you must restart the computer to complete the second part.</li>"
$MsgBody = $MsgBody + "</ul></ul></p>"
$MsgBody = $MsgBody + "If a computer is not connected to the server for more than 14 days is highlighted with color <font style=""background-color:red"">red</font>.<br>"
$MsgBody = $MsgBody + "If a computer is not connected to the server from 7 to 14 days is highlighted with color <font style=""background-color:orange"">orange</font>.<br>"
$MsgBody = $MsgBody + "If a computer is not connected to the server from 2 to 6 days is highlighted with color <font style=""background-color:yellow"">yellow</font>.<br>"
$MsgBody = $MsgBody + "<hr>"

$MsgBody = $MsgBody + "<center><strong>" + [System.DateTime]::Now + "</strong></center>" # This is a timestamp at the end of the message, taking into account the SMTP delivery delay.

$IntStr = [Convert]::ToString($intLineCounter) # convert the line counter to string
$subject = $IntStr + " computers registered on the server " + $UpdateServer # This will be the subject of the message.

# Closing Body and HTML tags
$MsgBody = $MsgBody + "</BODY>"
$MsgBody = $MsgBody + "</HTML>"

# Now send the email message and thats all.
send-MailMessage -SmtpServer $smtp -To $to1 -From $from -Subject $subject -Body $MsgBody -BodyAsHtml -Priority high
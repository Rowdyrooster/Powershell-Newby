
Write-Host "Pin Generator..........."
$chars = "0123456789".ToCharArray()
$newpin = ""
1..6 | ForEach { $newpin += $chars | Get-Random}
Write-host $newpin -ForegroundColor "yellow"

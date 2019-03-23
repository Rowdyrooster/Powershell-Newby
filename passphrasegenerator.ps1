While($true){
Write host - 'Randomizing PassPhrase....'
$rand = new-object System.Random
$conjunction = "the","my","we","our","and","but","+"
$words = import-csv c:\dict.csv
$word1 = ($words[$rand.Next(0,$words.Count)]).Word
$con = ($conjunction[$rand.Next(0,$conjunction.Count)])
$word2 = ($words[$rand.Next(0,$words.Count)]).Word
return $word1 + " " + $con + " " + $word2
Write-Host $word1,$con,$word2 -ForegroundColor Red
}
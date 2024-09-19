#Changes title of Command Line window
$host.ui.RawUI.WindowTitle = “Google Translate Blender”
while ($true ) {
cls
$Text = Read-Host -Prompt 'Whats the original sentence? (Write in any language you want)'
$TextOriginal = $Text

function Is-Numeric ($Value) {
    return $Value -match "^[\d\.]+$"
}

$repitionIsNumber = 0
while ($repitionIsNumber -eq 0){
$repitition = Read-Host -Prompt 'How many layers of translation do you want? (Has to be an number)'
$repitionNumber = Is-Numeric $repitition
if ($repitionNumber -ne $true){
    Write-Host "Invalid number."
    }
if ($repitionNumber -eq $true){
    $repitionIsNumber = 1
    }
}


$repititionOriginal = $repitition

$LanguageList = "af", "sq", "ar", "hy", "az", "eu", "be", "bg", "ca", "zh-CN", "zh-TW", "hr", "cs", "da", "nl", "en", "et", "tl", "fi", "fr", "gl", "ka", "de", "el", "ht", "iw", "hi", "hu", "is", "id", "ga", "it", "ja", "ko", "lv", "lt", "mk", "ms", "mt", "no", "fa", "pl", "pt", "ro", "ru", "sr", "sk", "sl", "es", "sw", "sv", "th", "tr", "uk", "ur", "vi", "cy", "yi", "so"

# Sends typed in text to Google Translate with random language
$TargetLanguage = $LanguageList | Get-Random
$Uri = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=$($TargetLanguage)&dt=t&q=$Text"
$Response = Invoke-RestMethod -Uri $Uri -Method Get

$Translation = $Response[0].SyncRoot | foreach { $_[0] }

#Loops get requests to Google Tranlate and keeps translating the returned value
while ( $repitition -gt 0 ) {
$Text = $Translation
$TargetLanguage = $LanguageList | Get-Random
$Uri = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=$($TargetLanguage)&dt=t&q=$Text"
$Response = Invoke-RestMethod -Uri $Uri -Method Get

$Translation = $Response[0].SyncRoot | foreach { $_[0] }

$repitition = $repitition - 1
Write-Host $Translation
Write-Host $repitition
}

#Translates one final time to English
$Text = $Translation
$TargetLanguage = "en"
$Uri = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=$($TargetLanguage)&dt=t&q=$Text"
$Response = Invoke-RestMethod -Uri $Uri -Method Get

$Translation = $Response[0].SyncRoot | foreach { $_[0] }
Write-Host "------------------------"
Write-Host "Original text is:"  $TextOriginal
Write-Host "------------------------"
Write-Host "Translated text is:"  $Translation
Write-Host "------------------------"
Write-Host "Amount of layers:" $repititionOriginal
Write-Host "------------------------"
Read-Host -Prompt 'Click Enter to start over'
}

 
#Script to install Google Translate Blender to system and add a Desktop shortcut
$cd = Get-Location
$GTBdir = Test-Path -Path C:\GTB
if ($GTBdir -eq $false){
    mkdir C:\GTB
}
$desktopFolder = [Environment]::GetFolderPath("Desktop")

Copy-Item -Path $cd\GoogleTranslateBlender.ps1 -Destination C:\GTB
Copy-Item -Path $cd\GoogleTranslateBlender.bat -Destination C:\GTB
Copy-Item -Path $cd\Google_Translate_Blender_Icon.ico -Destination C:\GTB

Copy-Item -Path $cd\GoogleTranslateBlender.lnk -Destination $desktopFolder

Start-Process -FilePath C:\GTB\GoogleTranslateBlender.bat
exit


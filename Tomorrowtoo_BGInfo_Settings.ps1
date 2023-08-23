<#
Please test before deploying to your production environment.  

.DESCRIPTION
    Install the Tomorrowtoo BGInfo Template.
.LANGUAGE
    PowerShell
.TIMEOUT
    100
.LINK
#>

#Check if bgi file is already uploaded
$BGITemplateName = "Tomorrowtoo.bgi"
$BGILocation = "C:\ProgramData\chocolatey\lib\bginfo\tools"

if (Test-Path -Path "$BGILocation\$BGITemplateName") {
    Write-Host "$BGITemplateName exists."
    exit 1
}
else {
    Write-Host "$BGITemplateName not found. Installing template."
}

$Installer = "$BGILocation\$BGITemplateName"
iwr -uri https://github.com/danielmedlie/BGI/raw/main/tomorrowtoo.bgi -OutFile $Installer


$Shell = New-Object –ComObject ("WScript.Shell")
$ShortCut = $Shell.CreateShortcut("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\BGInfo.lnk")
$ShortCut.TargetPath="$BGILocation\Bginfo64.exe"
$ShortCut.Arguments="$BGILocation\$BGITemplateName.bgi /timer:0 /silent /nolicprompt"
$ShortCut.IconLocation = "Bginfo64.exe, 0";
$ShortCut.Save()



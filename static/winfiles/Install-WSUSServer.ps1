Install-WindowsFeature -Name UpdateServices -IncludeManagementTools
New-Item -Path C:\ -Name WSUS -ItemType Directory
cd "$env:programfiles"
'.\Update Services\Tools\WsusUtil.exe' postinstall CONTENT_DIR=C:\WSUS

Install-WindowsFeature -Name UpdateServices -IncludeManagementTools
New-Item -Path C:\ -Name WSUS -ItemType Directory
C:\Program Files\Update Services\Tools\WsusUtil.exe postinstall CONTENT_DIR=C:\WSUS
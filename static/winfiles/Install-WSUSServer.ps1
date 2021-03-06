
#Install WSUS Server role
Install-WindowsFeature -Name UpdateServices -IncludeManagementTools
New-Item -Path C:\ -Name WSUS -ItemType Directory

#Make Postinstall for wsus role
cd $env:ProgramFiles
dir
& '.\Update Services\Tools\WsusUtil.exe' postinstall CONTENT_DIR=C:\WSUS 

#Set winrm configuration to Basic Authentication required for Carteiro WinRM Client
winrm set winrm/config/client/auth '@{Basic="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'

#Install CarteiroWin Files
"Install CarteiroWin.msi"
msiexec /quiet /i "C:\vagrant\static\winfiles\carteiro_win\CarteiroWinInstall\CarteiroWinInstall-SetupFiles\CarteiroWinInstall.msi"

#Create new SSL Cert and bind it to the WSUS IIS Site
"Generating new SSL Cert"
$cert = New-SelfSignedCertificate -CertStoreLocation Cert:\localmachine\My -DnsName $env:COMPUTERNAME
$cert.Thumbprint

"Importing..."
$store = Get-Item Cert:\localmachine\AuthRoot
$store.Open([System.Security.Cryptography.X509Certificates.OpenFlags]"ReadWrite")
$store.add($cert)
$store.Close()

"Binding to Port 8531"
Get-WebBinding "WSUS Administration"
New-Item -Path "IIS:\SslBindings\0.0.0.0!8531!$env:COMPUTERNAME" -Value $cert -SSLFlag 1

#Setting up Trust Relationship for Local Publishing
#https://msdn.microsoft.com/en-us/library/bb902479%28v=vs.85%29.aspx
"Configure Wsus to use self-signed certificate"
#CarteiroWin Set-Cert


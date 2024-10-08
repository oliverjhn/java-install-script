# Download and install the latest LTS version of Azul's Zulu OpenJDK

# Get the latest LTS version of Zulu OpenJDK (without JavaFX)
$url = "https://api.azul.com/zulu/download/community/v1.0/bundles/latest/?jdk_version=21&bundle_type=jdk&features=&ext=msi&os=windows&arch=x86&hw_bitness=64&release_status=ga&javafx=false"
$response = Invoke-WebRequest -Uri $url -UseBasicParsing
$downloadUrl = ($response.Content | ConvertFrom-Json).url

# Download the MSI installer
$downloadPath = "$env:USERPROFILE\Downloads\zulu_openjdk_latest.msi"
Write-Host "Downloading Zulu OpenJDK..."
$webClient = New-Object System.Net.WebClient
$webClient.DownloadFile($downloadUrl, $downloadPath)
Write-Host "Download completed."

# Change directory to Downloads
Set-Location -Path "$env:USERPROFILE\Downloads"

# Install Zulu OpenJDK
$installCommand = "msiexec /i $downloadPath INSTALLDIR=$env:LOCALAPPDATA\Programs\Zulu\zulu-21\ MSIINSTALLPERUSER=1 ADDLOCAL=ZuluInstallation REMOVE=FeatureEnvironment,FeatureJavaHome,FeatureOracleJavaSoft"
Invoke-Expression -Command $installCommand

# Set the path of javaw.exe to clipboard
$javawPath = "$env:LOCALAPPDATA\Programs\Zulu\zulu-21\bin\javaw.exe"
$javawPath | Set-Clipboard
Write-Host "$javawPath copied to clipboard"

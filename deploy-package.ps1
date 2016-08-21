# This script publishes applications for release.
Param(
	[string] [Parameter(Mandatory=$true)] $ResourceGroupName,
	[string] [Parameter(Mandatory=$true)] $AppName,
	[string] [Parameter(Mandatory=$true)] $PackagePath,
	[string] [Parameter(Mandatory=$true)] $PackageName,
    [switch] $CD
)

# Login to Azure Management unless CD
if ($CD -eq $false)
{
    Login-AzureRmAccount
}

Add-Type -AssemblyName "System.IO.Compression.FileSystem"

# Unzips WAWS Deploy tool
$source = "$PackagePath\WAWSDeploy.zip"
$destination = "$PackagePath\WAWSDeploy"

[IO.Compression.ZipFile]::ExtractToDirectory($source, $destination)

# Retrieves publish settings from web app
Write-Host "Downloading publish settings ..." -ForegroundColor Green

$publishSettings = "$PackagePath\$AppName.PublishSettings" 

$result = Get-AzureRmWebAppPublishingProfile -ResourceGroupName $ResourceGroupName -Name $AppName -OutputFile $publishSettings -Format WebDeploy

Write-Host "Publish settings downloaded" -ForegroundColor Green

# Deployes application
Write-Host "Deploying $PackageName ..." -ForegroundColor Green

$waws = "$PackagePath\WAWSDeploy\WAWSDeploy.exe"

& $waws "$PackagePath\$PackageName.zip" $publishSettings

Write-Host "$PackageName deployed" -ForegroundColor Green

# Resets publish settings
Write-Host "Resetting publish settings ..." -ForegroundColor Green

$result = Reset-AzureRmWebAppPublishingProfile -ResourceGroupName $ResourceGroupName -Name $AppName

Write-Host "Publish settings reset" -ForegroundColor Green

Remove-Variable source
Remove-Variable destination
Remove-Variable publishSettings
Remove-Variable result
Remove-Variable waws

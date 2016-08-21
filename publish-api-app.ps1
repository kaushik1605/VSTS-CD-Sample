# This script publishes applications for release.
Param(
	[string] [Parameter(Mandatory=$false)] $Configuration = "Release",
	[string] [Parameter(Mandatory=$true)] $BuildStagingDirectory,
	[string] [Parameter(Mandatory=$true)] $AppName
)

Add-Type -AssemblyName "System.IO.Compression.FileSystem"

# Gets the API app
$project = Get-ChildItem .\src | ?{ $_.PsIsContainer } | ?{ $_.Name -eq $AppName }
$projectPath = $project.FullName
$projectName = $project.Name

# Publishes API app
Write-Host "Publishing $projectName with $Configuration settings ..." -ForegroundColor Green

dotnet publish $projectPath --configuration $Configuration --output $BuildStagingDirectory\$projectName

# Zips API app
$source = "$BuildStagingDirectory\$projectName"
$destination = "$BuildStagingDirectory\$projectName.zip"

[IO.Compression.ZipFile]::CreateFromDirectory($source, $destination)

# Zips WAWS Deploy tool
$cwd = pwd
$source = "$cwd\tools\WAWSDeploy.zip"
$destination = $BuildStagingDirectory

Copy-Item $source $destination -Force

# Copies deploy script
$source = "$cwd\deploy-package.ps1";

Copy-Item $source $destination -Force

if ($LASTEXITCODE -ne 0)
{
	Write-Host "Publishing $projectName failure" -ForegroundColor Red
	return
}

Write-Host "Publishing $projectName success" -ForegroundColor Green

Remove-Variable cwd
Remove-Variable project
Remove-Variable projectPath
Remove-Variable projectName
Remove-Variable source
Remove-Variable destination

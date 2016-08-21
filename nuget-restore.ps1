# This script runs solution build.
Param(
	[string] [Parameter(Mandatory=$false)] $Configuration = "Debug"
)

# NuGet restore
Write-Host "Restoring NuGet packages ..." -ForegroundColor Green

dotnet restore

Write-Host "NuGet packages restored" -ForegroundColor Green

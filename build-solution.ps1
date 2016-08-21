# This script runs solution build.
Param(
	[string] [Parameter(Mandatory=$false)] $Configuration = "Debug"
)

$exitCode = 0

# Projects build - .NET Core projects only
$projects = Get-ChildItem .\src, .\test | ?{ $_.PsIsContainer } | `
	?{ Test-Path -Path (Join-Path $_.FullName "project.json") } | `
	?{ (Test-Path -Path (Join-Path $_.FullName "package.json")) -eq $false }
foreach($project in $projects)
{
	$projectPath = $project.FullName
	$projectName = $project.Name

	# Builds each .NET Core project
	Write-Host "Building $projectName with $Configuration settings ..." -ForegroundColor Green

	dotnet build $projectPath --configuration $Configuration

	if ($LASTEXITCODE -ne 0)
	{
		Write-Host "Building $projectName failure" -ForegroundColor Red
	}
	else
	{
		Write-Host "Building $projectName success" -ForegroundColor Green
	}

	$exitCode += $LASTEXITCODE
}

if($exitCode -ne 0)
{
	$host.SetShouldExit($exitCode)
}

Remove-Variable exitCode
Remove-Variable projects
Remove-Variable project
Remove-Variable projectPath
Remove-Variable projectName

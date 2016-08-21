# This script runs tests.
Param(
	[string] [Parameter(Mandatory=$false)] $Configuration = "Debug"
)

# Tests each project
$exitCode = 0
$projects = Get-ChildItem .\test | ?{ $_.PsIsContainer } | ?{ Test-Path -Path (Join-Path $_.FullName "project.json") }
foreach($project in $projects)
{
	$projectPath = $project.FullName
	$projectName = $project.Name

	# Tests projects
	Write-Host "Testing $projectName  with $Configuration settings ..." -ForegroundColor Green

	dotnet test $projectPath --configuration $Configuration

	if ($LASTEXITCODE -ne 0)
	{
		Write-Host "Test $projectName failure" -ForegroundColor Red
	}
	else
	{
		Write-Host "Test $projectName success" -ForegroundColor Green
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

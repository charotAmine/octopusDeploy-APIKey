Install-Package NewtonSoft.Json -source https://www.nuget.org/api/v2 -SkipDependencies -Force
$path = Join-Path (Get-Item ((Get-Package NewtonSoft.Json).source)).Directory.FullName "lib/netstandard2.0/NewtonSoft.Json.dll"
Add-Type -Path $path

Add-Type -Path "${env:ProgramFiles}\Octopus Deploy\Octopus\Octopus.Client.dll"

$server = ''
$endpoint = New-Object Octopus.Client.OctopusServerEndpoint $server
$repository = New-Object Octopus.Client.OctopusRepository $endpoint

$LoginObj = New-Object Octopus.Client.Model.LoginCommand 

$LoginObj.Username = ""
$LoginObj.Password = ""
$repository.Users.SignIn($LoginObj)

[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"

$UserObj = $repository.Users.GetCurrent()

$ApiObj = $repository.Users.CreateApiKey($UserObj, "To keyVault")

Set-OctopusVariable -name "apiKey" -value $ApiObj.ApiKey

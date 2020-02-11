$ApiKey = $OctopusParameters["Octopus.Action[Generate API Key].Output.apiKey"]
$secretvalue = ConvertTo-SecureString $ApiKey -AsPlainText -Force
Set-AzureKeyVaultSecret -VaultName 'kvoctopusdeploy' -Name 'OctopusApiKey' -SecretValue $secretvalue

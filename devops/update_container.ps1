Write-Output "Updating container"

$folderPath = Get-Location | Select-Object | ForEach-Object{$_.ProviderPath}
$filePath = Join-Path $folderPath -ChildPath "devops" | Join-Path -ChildPath "container_app_config.yml"
Write-Output "Deploying from: $filePath"

az container create -g InternalRG-Testing -f $filePath

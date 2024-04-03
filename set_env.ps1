$data = Import-Csv -Path .env -Header "key","value" -Delimiter "="

foreach ($item in $data) {
    $key = $item.key
    $value = $item.value
    Write-Output "Setting $key"
    Set-Item -Path "Env:$key" -Value $value
}

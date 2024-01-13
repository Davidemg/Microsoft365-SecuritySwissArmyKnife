$ExportPath = Join-Path -Path $PSScriptRoot -ChildPath "mailboxpermissions.csv"

# Ask the user if they want to view in Out-GridView
$choiceGridView = Read-Host "Do you want to view mailbox permissions in Out-GridView? (Y/N)"

if ($choiceGridView -eq 'Y' -or $choiceGridView -eq 'y') {
    Get-Mailbox -ResultSize Unlimited | Get-MailboxPermission | Select-Object Identity, User, Deny, AccessRights, IsInherited | Out-GridView -Title "Mailbox Permissions"
}

# Ask the user if they want to export to CSV
$choiceExportCSV = Read-Host "Do you want to export mailbox permissions to CSV? (Y/N)"

if ($choiceExportCSV -eq 'Y' -or $choiceExportCSV -eq 'y') {
    Get-Mailbox -ResultSize Unlimited | Get-MailboxPermission | Select-Object Identity, User, Deny, AccessRights, IsInherited | Export-Csv -Path $ExportPath -NoTypeInformation
    Write-Host "Mailbox permissions exported to: $ExportPath"
}

# Ask the user if they want to check for users with "FullAccess" permissions
$confirmCheckFullAccess = Read-Host "Do you want to check for users with 'FullAccess' permissions on mailboxes? (Y/N)"

if ($confirmCheckFullAccess -eq 'Y' -or $confirmCheckFullAccess -eq 'y') {
    # Get mailboxes with "FullAccess" permissions and store the results
    $fullAccessUsers = Get-Mailbox -ResultSize Unlimited | Get-MailboxPermission | Where-Object { $_.AccessRights -contains "FullAccess" } | Select-Object Identity, User

    # Output results to the terminal
    $fullAccessUsers | Format-Table -AutoSize

    # Ask if the user wants to display the results in Out-GridView
    $displayGridView = Read-Host "Do you want to display the results in Out-GridView? (Y/N)"

    if ($displayGridView -eq 'Y' -or $displayGridView -eq 'y') {
        $fullAccessUsers | Out-GridView -Title "Users with FullAccess Permissions"
    }

    # Ask if the user wants to export the results to a CSV file
    $exportToCSV = Read-Host "Do you want to export the results to a CSV file? (Y/N)"

    if ($exportToCSV -eq 'Y' -or $exportToCSV -eq 'y') {
        $csvPath = ".\fullaccess_users.csv"  # CSV file in the current directory
        $fullAccessUsers | Export-Csv -Path $csvPath -NoTypeInformation
        Write-Host "Users with 'FullAccess' permissions are exported to $csvPath" -ForegroundColor Green
    }
}

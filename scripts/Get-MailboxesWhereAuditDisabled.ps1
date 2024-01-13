function CheckMailboxWhereAuditDisabled {
    try {
        # Retrieve all user and shared mailboxes
        $allMailboxes = Get-Mailbox -RecipientTypeDetails UserMailbox, SharedMailbox

        # Manually filter mailboxes where auditing is not enabled
        $mailboxesWithoutAudit = $allMailboxes | Where-Object { -not $_.AuditEnabled }

        # Count the number of mailboxes where auditing is not enabled
        $countMailboxesWithoutAudit = $mailboxesWithoutAudit.Count

        # Check if any mailboxes were found
        if ($countMailboxesWithoutAudit -gt 0) {
            Write-Host "$countMailboxesWithoutAudit mailboxes without audit enabled:" -ForegroundColor Yellow
            $mailboxesWithoutAudit | Select-Object DisplayName, UserPrincipalName, RecipientTypeDetails, AuditEnabled | Format-Table -AutoSize
        } else {
            Write-Host "All mailboxes have audit enabled." -ForegroundColor Green
        }
    }
    catch {
        Write-Error "An error occurred: $_"
    }
}

# To run the function
CheckMailboxWhereAuditDisabled 

function Show-MailboxAuditInfo {
    try {
        # Retrieve mailbox audit information
        $mailboxAuditInfo = Get-Mailbox | Select-Object UserPrincipalName, AuditEnabled, AuditDelegate, AuditAdmin, AuditLogAgeLimit

        # Display the information in a grid view
        $mailboxAuditInfo | Out-GridView -Title "Mailbox Audit Information"
    }
    catch {
        Write-Error "An error occurred: $_"
    }
}

# To run the function
Show-MailboxAuditInfo

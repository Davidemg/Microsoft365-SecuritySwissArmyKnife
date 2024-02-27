# https://gcits.com/knowledge-base/find-inbox-rules-forward-mail-externally-office-365-powershell/

$domains = Get-AcceptedDomain
$mailboxes = Get-Mailbox -ResultSize Unlimited
$ruleCount = 0

foreach ($mailbox in $mailboxes) {
    $forwardingRules = $null
    Write-Host "Checking rules for $($mailbox.displayname) - $($mailbox.primarysmtpaddress)" -ForegroundColor Green
    $rules = Get-InboxRule -Mailbox $mailbox.primarysmtpaddress

    $forwardingRules = $rules | Where-Object { $_.forwardto -or $_.forwardasattachmentto }

    foreach ($rule in $forwardingRules) {
        $recipients = @()
        $recipients = $rule.ForwardTo | Where-Object { $_ -match "SMTP" }
        $recipients += $rule.ForwardAsAttachmentTo | Where-Object { $_ -match "SMTP" }

        $externalRecipients = @()

        foreach ($recipient in $recipients) {
            $email = ($recipient -split "SMTP:")[1].Trim("]")
            $domain = ($email -split "@")[1]

            if ($domains.DomainName -notcontains $domain) {
                $externalRecipients += $email
            }
        }

        if ($externalRecipients) {
            $extRecString = $externalRecipients -join ", "
            Write-Host "$($rule.Name) forwards to $extRecString" -ForegroundColor Yellow
            $ruleCount++

            # Ask the user if they want to export the results to a CSV file
            $exportToCSV = Read-Host "Do you want to export the results to a CSV file for this rule? (Y/N)"

            # Export to CSV if selected
            if ($exportToCSV -eq 'Y' -or $exportToCSV -eq 'y') {
                $csvPath = "externalrules.csv"
                $ruleHash = [ordered]@{
                    PrimarySmtpAddress = $mailbox.PrimarySmtpAddress
                    DisplayName        = $mailbox.DisplayName
                    RuleId             = $rule.Identity
                    RuleName           = $rule.Name
                    RuleDescription    = $rule.Description
                    ExternalRecipients = $extRecString
                }
                $ruleObject = New-Object PSObject -Property $ruleHash
                $ruleObject | Export-Csv -Path $csvPath -NoTypeInformation -Append
                Write-Host "Exported results to $csvPath" -ForegroundColor Green
            }
        }
    }
}

Write-Host "Found $ruleCount rules." -ForegroundColor Cyan

# Ask the user if they want to display the results in Out-GridView
$displayGridView = Read-Host "Do you want to display the results in Out-GridView? (Y/N)"
if ($displayGridView -eq 'Y' -or $displayGridView -eq 'y') {
    # You can add the Out-GridView code here to display the results
}

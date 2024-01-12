function basicSecurityCheck {
    # Exchange Online: Retrieve mailboxes with forwarding rules
    $forwardingMailboxes = Get-Mailbox -Filter { ForwardingAddress -ne $null } | Select-Object DisplayName, ForwardingAddress
    $forwardingMailboxes | Out-GridView -Title "Mailboxes with Forwarding Rules"

    # Azure AD: Retrieve users with risky sign-ins
    $riskyUsers = Get-AzureADUserRiskState | Where-Object { $_.RiskState -ne "none" } | Select-Object UserPrincipalName, RiskState
    $riskyUsers | Out-GridView -Title "Users with Risky Sign-Ins"

    # MS Online: Retrieve admin role users
    $adminUsers = Get-MsolRoleMember | Select-Object RoleName, DisplayName
    $adminUsers | Out-GridView -Title "Users with Administrative Roles"
}
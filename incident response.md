# O365 Incident Response

Kill all sessions by using the Revoke-AzureADUserAllRefreshToken cmdlet
```
Connect-AzureAD

Get-AzureADUser

Get-AzureADUser -SearchString user@user.com | Revoke-AzureADUserAllRefreshToken 
```
If you are investigating an incident and you believe a user’s token has been captured, you can invalidate a token with this AAD PowerShell cmdlet
```
$date =get-date; Set-Msoluser -UserPrincipalName (UPN) -StsRefreshTokensValidFrom $date

## Connecting: #
### Check for auditBypass
```
Get-MailboxAuditBypassAssociation | ? {$_.AuditBypassEnabled -eq $True} | Format-Table Name, WhenCreated, AuditBypassEnabled 

Get-MailboxAuditBypassAssociation | Format-Table Name, WhenCreated, AuditBypassEnabled 

```


### Check pwd last changed 
```
Get-MsolUser -All | select DisplayName, LastPasswordChangeTimeStamp

```


### Check for forwarding rules and delegates
```
\GitHub\O365-InvestigationTooling\DumpDelegatesandForwardingRules.ps1
Get-AllTenantRulesAndForms.ps1
```


### Check roles
```
\dump-roles-and-administrators.ps1
```


### If you are investigating an incident and you believe a user’s token has been captured, you can invalidate a token with this AAD PowerShell cmdlet
```
$date =get-date; Set-Msoluser -UserPrincipalName (UPN) -StsRefreshTokensValidFrom $date
```


### Here is an example client access rule targeting a test account.
```
new-ClientAccessRule -name “Allow InternalIP Only” -Action DenyAccess -ExceptAnyOfClientIPAddressesOrRanges [enter your public IP addresses here] -UsernameMatchesAnyOfPatterns *TestUserName
```


Creating a complete `COMMANDS.md` file with the provided PowerShell commands for Office 365 management:

```markdown
# Office 365 PowerShell Command Guide

## Connecting
Commands for installing and connecting to various Office 365 services.

### Install Modules
```powershell
Install-Module -Name ExchangeOnlineManagement
Install-Module MSOnline
Install-Module AzureAD
```

### Import Modules
```powershell
Import-Module ExchangeOnlineManagement
Import-Module MSOnline
Import-Module AzureAD
```

### Configure PowerShell Execution Policy
```powershell
Set-ExecutionPolicy RemoteSigned
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

### Connect to Exchange Online
```powershell
Connect-ExchangeOnline
```

### Connect to Security & Compliance Center
```powershell
Connect-IPPSSession
```

### Connect to Microsoft Online
```powershell
Connect-MsolService
```

### Connect to Azure AD
```powershell
Connect-AzureAD
Get-AzureADUser
```

### Exchange Online with PowerShell
```powershell
$UserCredential = Get-Credential
$Session = New-PSSession –ConfigurationName Microsoft.Exchange –ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential –Authentication Basic –AllowRedirection
Import-PSSession $Session
```

### Exchange Online with PowerShell + MFA
```powershell
Connect-EXOPSSession -UserPrincipalName <UPN>
```

### Close Exchange Sessions
```powershell
Disconnect-ExchangeOnline
```

### Close PowerShell Sessions (deprecated)
```powershell
Remove-PSSession $Session
Get-PSSession | Remove-PSSession
```

### Revoke Azure AD User Tokens
```powershell
Connect-AzureAD
Get-AzureADUser
Get-AzureADUser -SearchString user@user.com | Revoke-AzureADUserAllRefreshToken 
```

### Invalidate User Token in AAD PowerShell
```powershell
$date =get-date; Set-Msoluser -UserPrincipalName (UPN) -StsRefreshTokensValidFrom $date
```

## Summary
Commands for managing Multi-Factor Authentication (MFA) status.

```powershell
Get-MsolUser | ForEach-Object { .\Get-MFAStatus.ps1 $_.UserPrincipalName } | Out-GridView
.\Get-MFAStatus.ps1 | Out-GridView
Get-MFAStatus.ps1 -withOutMFAOnly 
```

## Auditing
Commands for auditing users, mailboxes, and mobile devices in Office 365.

### Mailbox Auditing
```powershell
Get-OrganizationConfig | Format-List AuditDisabled
Get-Mailbox | Select-Object DisplayName, PrimarySMTPAddress, TotalItemSize | Out-GridView
Get-Mailbox -SoftDeletedMailbox | Select-Object Name, ExchangeGuid
Get-mailbox | select UserPrincipalName, auditenabled, AuditDelegate, AuditAdmin, AuditLogAgeLimit | Out-gridview
Get-Mailbox | FL name, audit*
```

### Mobile Device Auditing
```powershell
Get-MobileDevice -Mailbox "User Test" | Select DeviceModel, DeviceUserAgent, DeviceAccessState, ClientType
```


Continuing from the "Mailbox Permissions" section:

```markdown
### Mailbox Permissions
Commands to retrieve permissions assigned to mailboxes in Office 365.

```powershell
Get-Mailbox -RecipientType 'UserMailbox' -ResultSize Unlimited | Get-MailboxPermission
Get-Mailbox | Get-MailboxPermission | where {$_.user.tostring() -ne "NT AUTHORITY\SELF"}
Get-Mailbox | Get-MailboxPermission | where {$_.User.tostring() -Match "Disc*"}
Get-Mailbox | Get-MailboxPermission | where {$_.user.tostring() -ne "NT AUTHORITY\SELF" -and $_.IsInherited -eq $false} | Select Identity,User,@{Name='Access Rights';Expression={[string]::join(', ', $_.AccessRights)}} | Export-Csv -NoTypeInformation mailboxpermissions.csv
```

### User Password Change Dates
List all users and the date of their last password change.

```powershell
Get-MsolUser -All | select DisplayName, LastPasswordChangeTimeStamp | Out-GridView
Get-MsolUser -All | select DisplayName, LastPasswordChangeTimeStamp | Export-CSV LastPasswordChange.csv -NoTypeInformation
```

## Authentication Protocols
Commands related to mailbox services, remote PowerShell access, and authentication policies.

### Mailbox Services
Show mailbox services for a user.

```powershell
Get-CASMailbox -identity <username@domain.com> | fl Name,OwaEnabled,MapiEnabled,EwsEnabled,ActiveSyncEnabled,PopEnabled,ImapEnabled
```

### Mailbox EWS Access
Get mailbox EWS Access.

```powershell
Get-CASMailbox "Ann Test" | Select *EWS*
```

### Modify Mailbox Services in Bulk
Modify mailbox services in bulk.

```powershell
Get-Mailbox | Set-CasMailbox -PopEnabled $false -ImapEnabled $false -SmtpClientAuthenticationDisabled $true
```

### Modify Default Mailbox Services
Modify default mailbox services.

```powershell
Get-CASMailboxPlan | Set-CASMailboxPlan -ImapEnabled $false -PopEnabled $false
```

### Remote PowerShell Access Status
Show the remote PowerShell access status for all users.

```powershell
Get-User -ResultSize unlimited | Format-Table -Auto Name,DisplayName,RemotePowerShellEnabled
```

### Show Only Users Without Remote PowerShell Access
Show only users who don't have access to remote PowerShell.

```powershell
Get-User -ResultSize unlimited -Filter {RemotePowerShellEnabled -eq $false}
```

### User Authentication Policy
Get user with a specific authentication policy.

```powershell
Get-User -Filter {AuthenticationPolicy -eq 'No Basic Auth'}
```

### Authentication Policy Details
Get details of authentication policies.

```powershell
Get-AuthenticationPolicy | Format-List Name,DistinguishedName
```

### Checking Applied Policies to Accounts
Checking applied policies to accounts and outputting to a file.

```powershell
Get-Recipient -RecipientTypeDetails UserMailbox -ResultSize Unlimited | Get-User | Format-Table DisplayName, AuthenticationPolicy, Sts* > D:\output.txt
```

### Set Authentication Policy for Basic Authentication
Set authentication policy to allow basic authentication for a protocol.

```powershell
Set-AuthenticationPolicy -Identity "No Basic Auth" -AllowBasicAuthPop:$True
```

### Set Authentication Policy for All Users
Set authentication policy for all users.

```powershell
Get-User -ResultSize unlimited | Set-User -AuthenticationPolicy “Block Basic Auth”
```

### Set Authentication Policy for a User
Set authentication policy for a user and reset its token enforcing the policy.

```powershell
get-user RandomUser |  Set-User -AuthenticationPolicy "No Basic Auth" -STSRefreshTokensValidFrom $([System.DateTime]::UtcNow)
```

Continuing from "Collecting Data" in your `COMMANDS.md` file:

```markdown
## Collecting Data
Commands for exporting user and mailbox data, and for audit log retrieval.

### Export Users and Mailboxes to CSV
Export user and mailbox data to CSV files for further analysis.

```powershell
# Export users
Foreach-Object ($mailbox in (Get-Mailbox)) {
    Get-MsolUser –UserPrincipalName $mailbox.userprincipalname
}
Get-MsolUser -All | Export-Clixml .\MsolUser.XML
Get-Mailbox –ResultSize Unlimited | Export-CliXML .\Mailboxes.XML
```

### Import Data from XML
Use `Import-CliXML` to import data from the XML file.

```powershell
Import-CliXML .\Mailboxes.XML
```

### Get Audit Log Data by Email
Retrieve audit log data for a specific mailbox.

```powershell
New-MailboxAuditLogSearch –Mailboxes “TestUser1” –LogonTypes admin, Delegate –StartDate 07/12/2017 –EndDate 11/12/2017 –StatusMailRecipients administrator@domain.com –ShowDetails
```

### Search the Unified Audit Log
Search the Unified Audit Log for specific operations.

```powershell
Search-UnifiedAuditLog -Operations New-Mailbox -UserIds mail@mail.nl -ShowDetails -StartDate 07/01/2023 -EndDate 09/27/2023
Search-UnifiedAuditLog -Operations Set-MailboxPermission -ObjectIds mail@mail.nl -StartDate 07/01/2023 -EndDate 09/27/2023
Search-UnifiedAuditLog -Operations Set-MailboxPermission -StartDate 07/01/2023 -EndDate 09/27/2023
```

## Mailbox Auditing 
Commands for enabling mailbox audit logging and searching mailbox audit logs.

### Enable Mailbox Audit Logging
Enable auditing for all user mailboxes in your organization.

```powershell
Get-Mailbox -ResultSize Unlimited -Filter {RecipientTypeDetails -eq "UserMailbox"} | Set-Mailbox -AuditEnabled $true
Get-Mailbox -Filter {AuditEnabled -eq $False} -RecipientTypeDetails UserMailbox, SharedMailbox | Set-Mailbox -AuditEnabled $True –AuditDelegate Create, FolderBind, SendAs, SendOnBehalf, SoftDelete, HardDelete, Update, Move, MoveToDeletedItems, UpdateFolderPermissions
```

### Search Mailbox Audit Log
Search the mailbox audit log for specific users and date ranges.

```powershell
Search-MailboxAuditLog -Identity "Dimitri Schmitz" -LogonTypes Admin,Delegate -StartDate 06/01/2018 -EndDate 07/20/2018 -ResultSize 2000
```

### Verify Mailbox Auditing Status
Check if mailbox auditing is enabled by default in your organization.

```powershell
Get-OrganizationConfig | Format-List AuditDisabled
```

### Audit Bypass Account Check
Identify accounts with mailbox audit logging bypassed.

```powershell
Get-MailboxAuditBypassAssociation | ? {$_.AuditBypassEnabled -eq $True} | Format-Table Name, WhenCreated, AuditBypassEnabled 
```
```


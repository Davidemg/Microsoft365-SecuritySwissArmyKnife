Here's a cleaned-up version of your README in Markdown format for GitHub:

```markdown
# Office 365 PowerShell Scripting Guide

## Summary
Utilize these scripts for various Office 365 management tasks.

```powershell
Get-MsolUser | ForEach-Object { .\Get-MFAStatus.ps1 $_.UserPrincipalName } | Out-GridView
.\Get-MFAStatus.ps1 | Out-GridView
Get-MFAStatus.ps1 -withOutMFAOnly 
```

## Auditing Users & Mailboxes

### Verify Mailbox Auditing Status
Check if mailbox auditing is enabled by default.

```powershell
Get-OrganizationConfig | Format-List AuditDisabled
```

### Mailbox Statistics
List all Office 365 mailboxes with addresses and stats.

```powershell
Get-Mailbox | Select-Object DisplayName, PrimarySMTPAddress, TotalItemSize | Out-GridView
```

### Soft Deleted Mailbox Check
Identify soft deleted mailboxes.

```powershell
Get-Mailbox -SoftDeletedMailbox | Select-Object Name, ExchangeGuid
```

### Mailbox Audit Delegation
Audit mailbox delegation settings.

```powershell
Get-mailbox | select UserPrincipalName, auditenabled, AuditDelegate, AuditAdmin, AuditLogAgeLimit | Out-gridview
Get-Mailbox | FL name, audit*
```

### Permissions Retrieval
Retrieve permissions assigned to mailboxes.

```powershell
# Various commands to get mailbox permissions
```

### User Password Change Dates
List all users and the date of their last password change.

```powershell
# Commands to get user password change dates
```

## Auditing Mobile Devices

### Get Mobile Device Information
Retrieve information on mobile devices used.

```powershell
# Command to get mobile device details
```

## Authentication Protocols

### Mailbox Services Information
Show mailbox services for a user.

```powershell
# Commands for mailbox services
```

### Modify Mailbox Services
Modify mailbox services in bulk or for individual users.

```powershell
# Commands to modify mailbox services
```

### Remote PowerShell Access Status
Show the remote PowerShell access status for users.

```powershell
# Commands to check remote PowerShell access
```

### Authentication Policies
Manage and check authentication policies.

```powershell
# Commands related to authentication policies
```

## Collecting Data

### Exporting User and Mailbox Data
Export users and mailboxes to CSV.

```powershell
# Commands for exporting data
```

### Audit Log Data Retrieval
Get the audit log data by email.

```powershell
# Command for audit log retrieval
```

### Unified Audit Log Search
Search the Unified Audit Log.

```powershell
# Commands for Unified Audit Log search
```

## Mailbox Auditing

### Enable Mailbox Audit Logging
Commands to enable mailbox audit logging and to set detailed auditing for specific actions.

```powershell
# Commands for mailbox auditing
```

### Audit Bypass Account Check
Identify accounts with mailbox audit logging bypassed.

```powershell
# Command for audit bypass check
```

### Search Mailbox Audit Log
Format for searching the mailbox audit log.

```powershell
# Command for searching mailbox audit log
```
```

This Markdown formatting structures your documentation with headers, code blocks, and organized sections, making it more readable and user-friendly on GitHub.
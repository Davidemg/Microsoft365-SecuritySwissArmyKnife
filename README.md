# Microsoft Services Command Line Scripting Guide (ms-commands)
This repository contains scripts and commands for managing Microsoft services via the command line. It's designed to assist administrators and users in efficiently handling various tasks related to Microsoft 365 and related services.

## Getting Started
### Prerequisites
Before running the scripts, ensure you have the following modules installed:

Exchange Online Management (EXO V2) Module
MSOnline Module
AzureAD Module

## Installation Instructions
To install the required modules, execute the following PowerShell commands



### Connecting: #
/.GetConnected.ps1 
-----------------------------
## Summary #
```
Get-MsolUser | ForEach-Object { .\Get-MFAStatus.ps1 $_.UserPrincipalName } | Out-GridView

.\Get-MFAStatus.ps1 | Out-GridView
 
Get-MFAStatus.ps1 -withOutMFAOnly 
```
-----------------------------
## Auditing users & mailboxes #
Verify mailbox auditing is on by default
```
Get-OrganizationConfig | Format-List AuditDisabled
```

List all Office 365 mailboxes with mail addresses and stats 
```
Get-Mailbox | Select-Object DisplayName, PrimarySMTPAddress,TotalItemSize | Out-GridView
```
Check for soft deleted mailbox
```
Get-Mailbox -SoftDeletedMailbox | Select-Object Name,ExchangeGuid
```
Check mailbox audit delegation
```
Get-mailbox | select UserPrincipalName, auditenabled, AuditDelegate, AuditAdmin, AuditLogAgeLimit | Out-gridview
Get-Mailbox | FL name, audit*
```

Retrieve the permissions assigned  
https://practical365.com/exchange-server/list-users-access-exchange-mailboxes/
```
Get-Mailbox -RecipientType 'UserMailbox' -ResultSize Unlimited | Get-MailboxPermission
Get-Mailbox | Get-MailboxPermission | where {$_.user.tostring() -ne "NT AUTHORITY\SELF"}
Get-Mailbox | Get-MailboxPermission | where {$_.User.tostring() -Match "Disc*"}
Get-Mailbox | Get-MailboxPermission | where {$_.user.tostring() -ne "NT AUTHORITY\SELF" -and $_.IsInherited -eq $false} | Select Identity,User,@{Name='Access Rights';Expression={[string]::join(', ', $_.AccessRights)}} | Export-Csv -NoTypeInformation mailboxpermissions.csv
```
List all users and date of last password change
https://www.quadrotech-it.com/blog/list-all-users-and-date-of-last-password-change-in-office-365/
```
Get-MsolUser -All | select DisplayName, LastPasswordChangeTimeStamp | Out-GridView
Get-MsolUser -All | select DisplayName, LastPasswordChangeTimeStamp | Export-CSV LastPasswordChange.csv -NoTypeInformation
```
## Auditing mobiles devices #
Get mobile devices used 
```
 Get-MobileDevice -Mailbox "User Test" |  Select DeviceModel,DeviceUserAgent,DeviceAccessState,ClientType
```
-----------------------------

## Authentication Protocols #
https://www.itpromentor.com/block-basic-auth/
Show mailbox services for a user
```
Get-CASMailbox -identity <username@domain.com> | fl Name,OwaEnabled,MapiEnabled,EwsEnabled,ActiveSyncEnabled,PopEnabled,ImapEnabled
```
Get mailbox EWS Access
```
 Get-CASMailbox "Ann Test" | Select *EWS*
```
Modify mailbox services in bulk
```
Get-Mailbox | Set-CasMailbox -PopEnabled $false -ImapEnabled $false 
-SmtpClientAuthenticationDisabled $true
```
Modify default mailbox services
```
Get-CASMailboxPlan | Set-CASMailboxPlan -ImapEnabled $false -PopEnabled $false
```
Show the remote PowerShell access status for all users
```
Get-User -ResultSize unlimited | Format-Table -Auto Name,DisplayName,RemotePowerShellEnabled
```
Show only users who don't have access to remote PowerShell
```
Get-User -ResultSize unlimited -Filter {RemotePowerShellEnabled -eq $false}
```
Get user with auth policy
```
Get-User -Filter {AuthenticationPolicy -eq 'No Basic Auth'}
```
Get authentication policy
```
Get-AuthenticationPolicy | Format-List Name,DistinguishedName
```
Checking Applied Policies to Accounts and output to file 
```
Get-Recipient -RecipientTypeDetails UserMailbox -ResultSize Unlimited | Get-User | Format-Table DisplayName, AuthenticationPolicy, Sts* > D:\output.txt
```
Set authentication policy to allow basic authentication for a protocol
```
Set-AuthenticationPolicy -Identity "No Basic Auth" -AllowBasicAuthPop:$True
```
Set authentication policy for all users  
```
Get-User -ResultSize unlimited | Set-User -AuthenticationPolicy “Block Basic Auth”
```
Set authentication policy for a user and reset it's token enforcing the policy 
```
get-user RandomUser |  Set-User -AuthenticationPolicy "No Basic Auth" -STSRefreshTokensValidFrom $([System.DateTime]::UtcNow)
```

-----------------------------

## Collecing #
Export users  and mailboxes to csv 
```
Foreach-Object ($mailbox in (Get-Mailbox))
{
	Get-MsolUser –UserPrincipalName $mailbox.userprincipalname
}
Get-MsolUser -All | Export-Clixml .\MsolUser.XML
Get-Mailbox –ResultSize Unlimited | Export-CliXML .\Mailboxes.XML
```
use Import-CliXML to import the Mailboxes.XML file
```
Import-CliXML .\Mailboxes.XML
```
Get the audit log data by email (for TestUser1 mailbox)
```
New-MailboxAuditLogSearch –Mailboxes “TestUser1” –LogonTypes admin, Delegate –StartDate 07/12/2017 –EndDate 11/12/2017 –StatusMailRecipientsadministrator@www.domain.com –ShowDetails
```
Search the Unified Audit log

```
Search-UnifiedAuditLog -Operations New-Mailbox -UserIds mail@mail.nl -ShowDetails -StartDate 07/01/2023 -EndDate 09/27/2023

Search-UnifiedAuditLog -Operations Set-MailboxPermission -ObjectIds mail@mail.nl -StartDate 07/01/2023 -EndDate 09/27/2023

Search-UnifiedAuditLog -Operations Set-MailboxPermission -StartDate 07/01/2023 -EndDate 09/27/2023
```
-----------------------------
## Mailbox Auditing 

Enable Mailbox Audit Logging

Command to Enable Audit for All User Mailboxes:
```
Get-Mailbox -ResultSize Unlimited -Filter {RecipientTypeDetails -eq "UserMailbox"} | Set-Mailbox -AuditEnabled $true
```
Command to Set Detailed Auditing for Specific Mailbox Actions:
```
Get-Mailbox -Filter {AuditEnabled -eq $False} -RecipientTypeDetails UserMailbox, SharedMailbox | Set-Mailbox -AuditEnabled $True –AuditDelegate Create, FolderBind, SendAs, SendOnBehalf, SoftDelete, HardDelete, Update, Move, MoveToDeletedItems, UpdateFolderPermissions
```
Audit Bypass Account Check
To identify accounts with mailbox audit logging bypassed, use this command:
```
Get-MailboxAuditBypassAssociation | ? {$_.AuditBypassEnabled -eq $True} | Format-Table Name, WhenCreated, AuditBypassEnabled 
```

Search Mailbox Audit Log
For searching the mailbox audit log, use the following format:
```
Search-MailboxAuditLog -Identity "firstname lastname" -LogonTypes Admin,Delegate -StartDate MM/DD/YYYY -EndDate MM/DD/YYYY -ResultSize 2000
```

Verify Mailbox Auditing Status
To check if mailbox auditing is enabled by default, execute:
```
Get-OrganizationConfig | Format-List AuditDisabled
```



```
Get-Mailbox -ResultSize Unlimited -Filter {RecipientTypeDetails -eq "UserMailbox"} | Set-Mailbox -AuditEnabled $true
Get-Mailbox -Filter {AuditEnabled -eq $False} -RecipientTypeDetails UserMailbox, SharedMailbox | Set-Mailbox -AuditEnabled $True –AuditDelegate Create, FolderBind, SendAs, SendOnBehalf, SoftDelete, HardDelete, Update, Move, MoveToDeletedItems, UpdateFolderPermissions
```
Run the Get-MailboxAuditBypassAssociation cmdlet and filter for accounts with a bypass
```
Get-MailboxAuditBypassAssociation | ? {$_.AuditBypassEnabled -eq $True} | Format-Table Name, WhenCreated, AuditBypassEnabled 
```
Search MailboxAuditlog
```
Search-MailboxAuditLog -Identity firstname lastname -LogonTypes Admin,Delegate -StartDate 06/01/2018 -EndDate 07/20/2018 -ResultSize 2000
```
Verify mailbox auditing on by default is turned on
```
Get-OrganizationConfig | Format-List AuditDisabled
```
-----------------------------

## GitHub Repositories for Microsoft 365 Scripts and Tools  

## Condensed References:

1. [vanvfields](https://github.com/vanvfields): Scripts for configuring Microsoft 365.
2. [Brute-Email.ps1](https://github.com/rvrsh3ll/Misc-Powershell-Scripts/blob/master/Brute-Email.ps1): PowerShell script for brute-forcing email.
3. [o365recon](https://github.com/nyxgeek/o365recon): Script for information retrieval from O365 and AzureAD using valid credentials.
4. [M365SATReports](https://github.com/mparlakyigit/M365SATReports): PowerShell script for Microsoft 365 Security Assessment Reports.
5. [ScubaGear](https://github.com/cisagov/ScubaGear): Tool for verifying Microsoft 365 configuration against SCuBA Security Baseline.
6. [MFASweep](https://github.com/dafthack/MFASweep): Script to test Microsoft services logins and MFA status.
7. [hornerit](https://github.com/hornerit/powershell): Scripts for Office 365, Azure, Active Directory, and SharePoint.
8. [DCToolbox](https://github.com/DanielChronlund/DCToolbox): PowerShell toolbox for Microsoft 365 security.
9. [Office365 best practices](https://github.com/directorcia/Office365/blob/master/best-practices.txt): A guide on best practices for Office 365.



## Script Usage
To utilize the scripts in this repository, follow these steps:
1. **Select the Script**: Choose the script that meets your needs from the list.
2. **Download and Preparation**: Download the script file. Some scripts may require modifications before use, such as adding your specific parameters or credentials.
3. **Execution**: Run the script using PowerShell or your preferred command-line interface. Ensure you have the necessary permissions and environment setup.
4. **Understanding Results**: After execution, interpret the output as per the script's documentation. 

For detailed usage examples, refer to the README or documentation section of each script.

## Contributing
We welcome contributions to this repository. If you have a script or command that can benefit others in managing Microsoft services, please consider submitting a pull request. To contribute:
1. **Fork the Repository**: Create a fork of this repository.
2. **Make Your Changes**: Add or modify scripts in your fork.
3. **Submit a Pull Request**: Once you're happy with your changes, submit a pull request for review.

Guidelines for contributions, including coding standards and commit message formatting, can be found in the 'CONTRIBUTING.md' file.

## License
This repository and its contents are licensed under [Specify License Type]. This license allows for the reuse and modification of the scripts under certain conditions. Please refer to the 'LICENSE' file in the repository for detailed licensing terms.

## Contact and Support
For support or queries regarding the scripts, you can reach out via contact@cyberplate.be or [LinkedIn](https://linkedin.com/in/davide-m-guglielmi/). Additionally, for reporting issues or suggesting enhancements, please use the 'Issues' section of this GitHub repository. Your feedback and questions are valuable in improving these scripts and helping the community.
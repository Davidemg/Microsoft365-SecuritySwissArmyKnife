Connect-ExchangeOnline

Get-Mailbox -resultsize unlimited | Get-MailboxPermission | Select Identity, User, Deny, AccessRights, IsInherited| Export-Csv -Path "c:\temp\mailboxpermissions.csv" –NoTypeInformation




#https://www.netwrix.com/how_to_get_exchange_online_mailbox_permissions_report.html
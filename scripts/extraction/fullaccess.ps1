Connect-ExchangeOnline

Get-Mailbox -resultsize unlimited | Get-MailboxPermission| where {($_.accessrights -contains "Fullaccess")}  | Select AccessRights,Deny,InheritanceType,User,Identity,IsInherited  | Export-Csv -Path "c:\temp\fullaccess.csv" -NoTypeInformation



#https://www.netwrix.com/how_to_get_exchange_online_mailbox_permissions_report.html
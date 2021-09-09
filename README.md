# ms-commands
Repository of command line scripting for Microsoft services 




## Connecting: #

#### Windows PowerShell needs to be configured to run scripts
```
Set-ExecutionPolicy RemoteSigned
```
### Connect to Microsoft Online 
```
Connect-MsolService
Get-MSOLUser
```
### Connect to Azure AD 
```
Connect-AzureAD
Get-AzureADUser
```
### Connect to Exchange Online using Windows PowerShell
```
$UserCredential = Get-Credential

$Session = New-PSSession –ConfigurationName Microsoft.Exchange –ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential –Authentication Basic –AllowRedirection

Import-PSSession $Session

```
### Connect to Exchange Online using Windows PowerShell + MFA 
```
Connect-EXOPSSession -UserPrincipalName <UPN>
```
### Closes one or more PowerShell session
```
Remove-PSSession $Session
Get-PSSession | Remove-PSSession
```
### Kill all sessions by using the Revoke-AzureADUserAllRefreshToken cmdlet
```
Connect-AzureAD

Get-AzureADUser

Get-AzureADUser -SearchString user@user.com | Revoke-AzureADUserAllRefreshToken 
```


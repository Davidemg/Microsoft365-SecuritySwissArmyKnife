#source: https://github.com/OfficeDev/O365-InvestigationTooling/blob/master/InactiveUsersLast90Days.ps1

import-module MSOnline

#Let's get us an admin cred!

#This connects to Azure Active Directory
Connect-MsolService -Credential $userCredential

$startDate = (Get-Date).AddDays(-90).ToString('MM/dd/yyyy')
$endDate = (Get-Date).ToString('MM/dd/yyyy')

$allUsers = @()
$allUsers = Get-MsolUser -All -EnabledFilter EnabledOnly | Select UserPrincipalName

$loggedOnUsers = @()
$loggedOnUsers = Search-UnifiedAuditLog -StartDate $startDate -EndDate $endDate -Operations UserLoggedIn, PasswordLogonInitialAuthUsingPassword, UserLoginFailed -ResultSize 5000

$inactiveInLastThreeMonthsUsers = @()
$inactiveInLastThreeMonthsUsers = $allUsers.UserPrincipalName | where {$loggedOnUsers.UserIds -NotContains $_}

Write-Output "The following users have no logged in for the last 90 days:"
Write-Output $inactiveInLastThreeMonthsUsers

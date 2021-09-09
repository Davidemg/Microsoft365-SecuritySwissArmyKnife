foreach($line in Get-Content .\roles.txt)
{
    $role = Get-MsolRole -RoleName $line
    Get-MsolRoleMember -RoleObjectId $role.ObjectId | Export-CSV C:\Users\dguglielmi\Desktop\GitHub\dump-roles.csv -Append
}

#TODO
#Write / group roles in output 
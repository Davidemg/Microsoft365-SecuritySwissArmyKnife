

function Get-PasswordLastChanged {
    try {
        # Get all users and select required properties
        $users = Get-MsolUser -All | Select-Object DisplayName, LastPasswordChangeTimeStamp | Sort-Object LastPasswordChangeTimeStamp -Descending


        # Define file path with a unique timestamp
        $timestamp = Get-Date -Format "yyyyMMddHHmmss"
        $filePath = "LastPasswordChange_$timestamp.csv"

       # Check if the file already exists
        if (Test-Path $filePath) {
            Write-Warning "File already exists. Creating a new file with a unique timestamp."
        }


        # Export the data to a CSV file
        $users | Export-CSV "LastPasswordChange.csv" -NoTypeInformation
        # Output the data in the terminal
        $users | Format-Table -AutoSize
        
        $users | Out-GridView
        Write-Host "Exported password last changed data to LastPasswordChange.csv"

    }
    catch {
        Write-Error "An error occurred: $_"
    }
}

Get-PasswordLastChanged
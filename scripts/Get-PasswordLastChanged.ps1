function Get-PasswordLastChanged {
    try {
        # Attempt to retrieve all users
        Write-Host "Retrieving user data..." -ForegroundColor Cyan
        $users = Get-MsolUser -All | Select-Object DisplayName, LastPasswordChangeTimeStamp | Sort-Object LastPasswordChangeTimeStamp -Descending

        # Check if users data is retrieved
        if ($users -eq $null -or $users.Count -eq 0) {
            Write-Host "No user data found." -ForegroundColor Yellow
            return
        }

        # Output the data in the terminal
        $users | Format-Table -AutoSize

        # Ask the user if they want to view the results in Out-GridView
        $viewInGridView = Read-Host "Do you want to view the results in a grid view? (Y/N)"
        if ($viewInGridView -eq "Y" -or $viewInGridView -eq "y") {
            $users | Out-GridView
        }

        # Ask the user if they want to export the data to CSV
        $exportToCSV = Read-Host "Do you want to export the results to CSV? (Y/N)"
        if ($exportToCSV -eq "Y" -or $exportToCSV -eq "y") {
            # Define file path with a unique timestamp
            $timestamp = Get-Date -Format "yyyyMMddHHmmss"
            $filePath = "LastPasswordChange_$timestamp.csv"

            # Export the data to a CSV file
            $users | Export-CSV $filePath -NoTypeInformation
            Write-Host "Exported password last changed data to $filePath" -ForegroundColor Green
        }

    } catch {
        Write-Host "An error occurred while processing: $_" -ForegroundColor Red
    }
}

# Invoke the function
Get-PasswordLastChanged

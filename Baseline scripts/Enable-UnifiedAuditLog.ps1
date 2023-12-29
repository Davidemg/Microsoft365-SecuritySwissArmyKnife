function Enable-UnifiedAuditLog {
    try {

        # Check current Unified Audit Log configuration
        $currentConfig = Get-AdminAuditLogConfig
        if ($currentConfig.UnifiedAuditLogIngestionEnabled) {
            Write-Host "Unified Audit Log is already enabled." -ForegroundColor Green
        } else {
            # Ask for confirmation to enable Unified Audit Log
            $confirmation = Read-Host "Unified Audit Log is not enabled. Do you want to enable it? (Y/N)"
            if ($confirmation -eq 'Y' -or $confirmation -eq 'y') {
                # Enable Unified Audit Log
                Set-AdminAuditLogConfig -UnifiedAuditLogIngestionEnabled $true
                Write-Host "Unified Audit Log has been enabled." -ForegroundColor Green
            } else {
                Write-Host "Unified Audit Log enabling was cancelled." -ForegroundColor Yellow
            }
        }
    }
    catch {
        Write-Error "An error occurred: $_"
    }
    finally {
        # Disconnect from Exchange Online
        Disconnect-ExchangeOnline -Confirm:$false
    }
}

# To run the function
Enable-UnifiedAuditLog

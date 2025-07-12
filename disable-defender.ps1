function Disable-Defender {
    # Disable core Defender features
    Write-Host "Disabling core Defender features..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 1 -Type DWord
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableRealtimeMonitoring" -Value 1 -Type DWord
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiVirus" -Value 1 -Type DWord
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableSpecialRunningModes" -Value 1 -Type DWord
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisabledRoutinelyTakingAction" -Value 1 -Type DWord
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "ServiceKeepAlive" -Value 1 -Type DWord

    # Create and configure Real-Time Protection key
    Write-Host "Disabling Real-Time Protection settings..."
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "Real-Time Protection" -Force
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisabledBehaviorMonitoring" -Value 1 -Type DWord
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableOnAccessProtection" -Value 1 -Type DWord
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableRealtimeMonitoring" -Value 1 -Type DWord
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableScanOnRealTimeEnable" -Value 1 -Type DWord

    # Disable SpyNet reporting
    Write-Host "Disabling SpyNet reporting..."
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "SpyNet" -Force
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\SpyNet" -Name "DisableBlockAtFirstSeen" -Value 1 -Type DWord

    # Disable forced updates
    Write-Host "Disabling force update from Microsoft Update..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "ForceUpdateFromMU" -Value 1 -Type DWord

    # Final message
    Write-Host ""
    Write-Host "All changes applied. Restart your computer to completely disable Microsoft Defender."
    
    # Open Registry Editor
    Write-Host "Opening Registry Editor to verify changes..."
    Start-Process "regedit.exe"
    
    Pause
}

function Enable-Defender {
    Write-Host "Re-enabling Windows Defender..."
    
    # Remove all the registry values we set
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableRealtimeMonitoring" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiVirus" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableSpecialRunningModes" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisabledRoutinelyTakingAction" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "ServiceKeepAlive" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "ForceUpdateFromMU" -ErrorAction SilentlyContinue

    # Remove Real-Time Protection settings
    Remove-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Recurse -Force -ErrorAction SilentlyContinue

    # Remove SpyNet settings  
    Remove-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\SpyNet" -Recurse -Force -ErrorAction SilentlyContinue

    Write-Host ""
    Write-Host "Defender re-enabled. A restart is recommended."
    
    # Open Registry Editor
    Write-Host "Opening Registry Editor to verify changes..."
    Start-Process "regedit.exe"
    
    Pause
}

function Show-Menu {
    Clear-Host
    Write-Host "=== Windows Defender Control ==="
    Write-Host "[1] Disable Defender"
    Write-Host "[2] Enable Defender (Undo)"
    Write-Host "[3] Exit"
}

# Check if running as administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "This script requires administrator privileges. Restarting as administrator..."
    Start-Sleep -Seconds 2
    
    # Get the current script path
    $scriptPath = $MyInvocation.MyCommand.Path
    
    # Restart as administrator
    Start-Process PowerShell -Verb RunAs -ArgumentList "-ExecutionPolicy Bypass -File `"$scriptPath`""
    exit
}

Write-Host "Running with administrator privileges..."
Write-Host ""

# Main execution loop
do {
    Show-Menu
    $choice = Read-Host "`nSelect an option (1-3)"

    switch ($choice) {
        "1" {
            Disable-Defender
        }
        "2" {
            Enable-Defender
        }
        "3" {
            Write-Host "Exiting..."
        }
        default {
            Write-Host "Invalid option. Please select 1, 2, or 3."
            Start-Sleep -Seconds 2
        }
    }
} while ($choice -ne "3")
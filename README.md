# Windows Defender Control

Simple PowerShell script to temporarily disable/enable Windows Defender for testing purposes.

## Features

- Interactive menu interface
- Auto-elevation to admin privileges
- Registry verification via regedit
- Full undo functionality
- Clean registry modifications

## Usage

1. Download `Disable-Defender.ps1`
2. Double-click or run: `.\Disable-Defender.ps1`
3. Choose option:
   - **1** - Disable Defender
   - **2** - Enable Defender (undo)
   - **3** - Exit

Script automatically handles admin elevation and opens Registry Editor for verification.

## How It Works

Modifies registry keys under:
```
HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender
```

Disables real-time protection, behavior monitoring, and SpyNet reporting.

## Requirements

- Windows 10/11
- PowerShell 5.0+
- Administrator privileges (handled automatically)

## Important Notes

⚠️ **For testing/development only** - Disabling antivirus reduces system security  
⚠️ **Restart recommended** after changes  
⚠️ **Use undo function** to cleanly restore settings  

## Troubleshooting

If execution policy blocks the script:
```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
```

## Disclaimer

Educational/testing purposes only. Use responsibly and restore settings when done.

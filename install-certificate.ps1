# Spartan Wallet - Certificate Installation Script
# This script extracts and installs the certificate from the MSIX package

param(
    [string]$MsixPath
)

# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "Error: This script must be run as Administrator" -ForegroundColor Red
    Write-Host "Right-click PowerShell and select 'Run as Administrator', then run this script again." -ForegroundColor Yellow
    exit 1
}

# If no path provided, prompt user to select MSIX file
if (-not $MsixPath) {
    Add-Type -AssemblyName System.Windows.Forms
    $openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $openFileDialog.Filter = "MSIX files (*.msix)|*.msix"
    $openFileDialog.Title = "Select Spartan MSIX file"

    if ($openFileDialog.ShowDialog() -eq 'OK') {
        $MsixPath = $openFileDialog.FileName
    } else {
        Write-Host "No file selected. Exiting." -ForegroundColor Yellow
        exit 1
    }
}

# Check if file exists
if (-not (Test-Path $MsixPath)) {
    Write-Host "Error: File not found: $MsixPath" -ForegroundColor Red
    exit 1
}

Write-Host "Installing certificate from: $MsixPath" -ForegroundColor Green

try {
    # Extract certificate from MSIX
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $zip = [System.IO.Compression.ZipFile]::OpenRead($MsixPath)
    $certEntry = $zip.Entries | Where-Object { $_.Name -eq "AppxSignature.p7x" }

    if (-not $certEntry) {
        Write-Host "Error: Certificate not found in MSIX package" -ForegroundColor Red
        $zip.Dispose()
        exit 1
    }

    $certStream = $certEntry.Open()
    $certBytes = New-Object byte[] $certEntry.Length
    $certStream.Read($certBytes, 0, $certEntry.Length) | Out-Null
    $certPath = "$env:TEMP\spartan-cert.p7x"
    [System.IO.File]::WriteAllBytes($certPath, $certBytes)
    $certStream.Close()
    $zip.Dispose()

    # Install certificate to Trusted Root
    Write-Host "Installing certificate to Trusted Root Certification Authorities..." -ForegroundColor Yellow
    $cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($certPath)
    $store = New-Object System.Security.Cryptography.X509Certificates.X509Store("Root", "LocalMachine")
    $store.Open("ReadWrite")
    $store.Add($cert)
    $store.Close()

    # Clean up temporary certificate file
    Remove-Item $certPath -ErrorAction SilentlyContinue

    Write-Host "`nSuccess! Certificate installed successfully." -ForegroundColor Green
    Write-Host "You can now install the Spartan MSIX package by double-clicking it." -ForegroundColor Cyan

} catch {
    Write-Host "`nError: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

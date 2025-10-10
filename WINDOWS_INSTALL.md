# Windows Installation Guide

## Installing Spartan Wallet on Windows

There are **two methods** to install Spartan Wallet on Windows:

---

## Method 1: Automatic Certificate Installation (Recommended) ⭐

### Step 1: Download Files
Download both files from the [latest release](https://github.com/tos-network/spartan/releases/latest):
- `spartan-x.x.x-windows.msix` - The application package
- `install-certificate.ps1` - Certificate installation script

### Step 2: Install Certificate
1. Right-click on **PowerShell** and select **"Run as Administrator"**
2. Navigate to the folder where you downloaded the files:
   ```powershell
   cd Downloads
   ```
3. Run the installation script:
   ```powershell
   .\install-certificate.ps1
   ```
4. When prompted, select the downloaded MSIX file
5. Wait for the success message

### Step 3: Install Application
Double-click the `spartan-x.x.x-windows.msix` file to install Spartan Wallet.

---

## Method 2: Enable Developer Mode

### Option A: Via Settings
1. Open **Settings** → **Privacy & Security** → **For developers**
2. Enable **Developer Mode**
3. Double-click the MSIX file to install

### Option B: Via PowerShell (Administrator)
```powershell
# Enable Developer Mode
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" -Name "AllowDevelopmentWithoutDevLicense" -Value 1
```

After enabling Developer Mode, you can install the MSIX file directly.

---

## Troubleshooting

### Error: "This app package's publisher certificate could not be verified" (0x800B010A)

This error means the certificate is not trusted. Use **Method 1** above to install the certificate.

### Error: "This script must be run as Administrator"

Right-click PowerShell and select **"Run as Administrator"** before running the script.

### Error: "Execution of scripts is disabled on this system"

Run this command in PowerShell (as Administrator):
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## Why is this needed?

Spartan Wallet is signed with a self-signed certificate for development releases. Windows requires either:
- Installing the certificate to your trusted store, or
- Enabling Developer Mode

For production releases, we plan to use a trusted code signing certificate to eliminate this step.

---

## Need Help?

If you encounter any issues, please [open an issue](https://github.com/tos-network/spartan/issues) on GitHub.

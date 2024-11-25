@echo off
REM This script will download and run gibMacOS and use it to download a Catalina BaseSystem.dmg file.

REM Created by Jens Depuydt
REM https://www.jensd.be
REM https://github.com/jensdepuydt

echo ================================
echo == Step 2) Convert the recovery image to a VMDK-file using qemu-img
echo ================================

echo "Downloading QEMU for Windows"
powershell.exe -command "$progressPreference = 'silentlyContinue'; Invoke-WebRequest  https://qemu.weilnetz.de/w64/2024/qemu-w64-setup-20241124.exe -OutFile qemu-w64-setup.exe"

echo:
echo "Installing QEMU for Windows"
echo "Please choose 'Yes' in the UAC dialog"
qemu-w64-setup.exe /S

echo:
echo "Converting BaseSystem_Catalina.dmg to VMDK-file"
"C:\Program Files\qemu\qemu-img.exe" convert -O vmdk -o compat6 BaseSystem_Catalina.dmg BaseSystem_Catalina.vmdk

echo:
cd ..
echo ================================
echo == Step 2 complete
echo == File should be in %cd%\BaseSystem_Catalina.vmdk
echo == You can now proceed with step 3...
echo ================================
pause
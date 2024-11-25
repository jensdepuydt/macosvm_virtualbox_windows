@echo off
REM This script will download and run gibMacOS and use it to download a Catalina BaseSystem.dmg file.

REM Created by Jens Depuydt
REM https://www.jensd.be
REM https://github.com/jensdepuydt

echo ================================
echo == Step 3) Install VirtualBox and the extension pack
echo ================================

echo "Downloading Visual C++ Redistributable"
powershell.exe -command Invoke-WebRequest https://aka.ms/vs/17/release/vc_redist.x64.exe -OutFile vc_redist.x64.exe

echo:
echo "Installing Visual C++ Redistributable"
echo "Please choose 'Yes' in the UAC dialog"
vc_redist.x64.exe /install /passive /norestart

echo:
echo "Downloading VirtualBox"
powershell.exe -command "$progressPreference = 'silentlyContinue'; Invoke-WebRequest  https://download.virtualbox.org/virtualbox/7.1.4/VirtualBox-7.1.4-165100-Win.exe -OutFile VirtualBox-7.1.4-165100-Win.exe"

echo:
echo "Installing VirtualBox"
echo "Please choose 'Yes' in the UAC dialog"
VirtualBox-7.1.4-165100-Win.exe -silent

echo:
echo "Downloading VirtualBox Extension Pack"
powershell.exe -command Invoke-WebRequest https://download.virtualbox.org/virtualbox/7.1.4/Oracle_VirtualBox_Extension_Pack-7.1.4.vbox-extpack -OutFile Oracle_VirtualBox_Extension_Pack-7.1.4.vbox-extpack

echo:
echo "Instaling VirtualBox Extension Pack"
echo y | "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" extpack install --replace "Oracle_VirtualBox_Extension_Pack-7.1.4.vbox-extpack"

echo:
cd ..
echo ================================
echo == Step 3 complete
echo == VirtualBox and VirtualBox Extension pack are now installed
echo == You can now proceed with step 4...
echo ================================
pause
@echo off
REM This script will download and run gibMacOS and use it to download a Catalina BaseSystem.dmg file.

REM Created by Jens Depuydt
REM https://www.jensd.be
REM https://github.com/jensdepuydt

echo ================================
echo == Step 4) Create a VM and set all required parameters for your CPU-type
echo ================================

echo "Create VM for macOS Catalina in VirtualBox"
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" createvm --name macOS1 --ostype MacOS_64 --default --register --basefolder %cd%

echo:
echo "Change CPU, Memory and Video memory allocations for VM"
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" modifyvm "macOS1" --memory 4096 --vram 128 --cpus 2

echo:
echo "Create Virtual Drive for Catalina installation"
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" createhd --filename %cd%/macOS1/macOS1_disk.vdi --size 40000 --format VDI

echo:
echo "Add SATA controller to VM"
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" storagectl "macOS1" --name "SATA Controller" --add sata --controller IntelAhci

echo:
echo "Attach new virtual drive to VM"           
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" storageattach "macOS1" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium  %cd%/macOS1/macOS1_disk.vdi

echo:
echo "Attach BaseSystem_Catalina VMDK to VM"
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" internalcommands sethduuid %cd%/BaseSystem_Catalina.vmdk
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" storageattach "macOS1" --storagectl "SATA Controller" --port 1 --device 0 --type hdd --medium  %cd%/BaseSystem_Catalina.vmdk --setuuid ""

echo:
echo "Check if this machine is Intel or AMD-based"
FOR /F "skip=1 tokens=1" %%i IN ('wmic cpu get name') DO (
    SET "chip=%%i"
    GOTO Testcpuarch
)

:Testcpuarch
IF "%chip%" == "Intel(R)" (GOTO Intel) ELSE (GOTO AMD)

:Intel
echo:
echo "CPU vendor is Intel"
echo "Changing VM properties for Intel-based CPU"
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" modifyvm "macOS1" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" setextradata "macOS1" VBoxInternal/Devices/efi/0/Config/DmiSystemProduct “MacBookPro15,1”
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" setextradata "macOS1" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Mac-551B86E5744E2388"
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" setextradata "macOS1" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" setextradata "macOS1" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1

GOTO endscript

:AMD
echo:
echo "CPU vendor is AMD"
echo "Changing VM properties for AMD-based CPU"
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"e modifyvm "macOS1" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" setextradata "macOS1" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac11,3"
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" setextradata "macOS1" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" setextradata "macOS1" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Iloveapple"
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" setextradata "macOS1" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" setextradata "macOS1" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" modifyvm "macOS1" --cpu-profile "Intel Core i7-6700K"
GOTO endscript

:endscript
echo:
cd ..
echo ================================
echo == Step 4 complete
echo == macOS1 VM created and registered in VirtualBox
echo == Start this VM and complete the macOS Catalina installation, opening VirtualBox GUI...
echo ================================
pause
"C:\Program Files\Oracle\VirtualBox\VirtualBox.exe"
# macosvm_virtualbox_windows
Scripts to create macOS Catalina VM from scratch in Windows

Purpose
=======
These four batch scripts will go automatically through all steps required in order to create a macOS Catalina VM in VirtualBox on Windows.
- Step 1) Download a macOS Catalina recovery image using gibMacOS (https://github.com/corpnewt/gibMacOS)
- Step 2) Convert the recovery image to a VMDK-file using qemu-img
- Step 3) Install VirtualBox and the extension pack
- Step 4) Create a VM and set all required parameters for your CPU-type

Once these scripts were ran in sequential order, you can start the VM in VirtualBox and complete the installation of macOS Catalina.

Prerequisites
=============
This was tested on several Windows 11 Intel-based systems.

More information
================
I created a blogpost where I elaborate on the whole process and explain how you can use this VM to create a bootable macOS installater USB-drive from Windows.
This can be found here:

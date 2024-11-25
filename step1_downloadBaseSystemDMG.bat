@echo off
REM This script will download and run gibMacOS and use it to download a Catalina BaseSystem.dmg file.

REM Created by Jens Depuydt
REM https://www.jensd.be
REM https://github.com/jensdepuydt

echo ================================
echo == Step 1) Download a macOS Catalina recovery image using gibMacOS
echo ================================

echo "Downloading gibMacOS"
powershell -Command "Invoke-WebRequest https://github.com/corpnewt/gibMacOS/archive/refs/heads/master.zip -OutFile gibmacos.zip"

echo:
echo "Extracting gibMacOS"
powershell -command "Expand-Archive gibmacos.zip ."

echo:
echo "Install Python if needed"
cd gibMacOS-master
cmd /C gibMacOS.bat --install-python

echo:
echo "Find download URL for latest Catalina image"
cmd /C gibMacOS.bat -i -v Catalina | findstr \/BaseSystem.dmg > tmp.txt
set /p url= < tmp.txt
del tmp.txt
for /f "tokens=2" %%G IN ("%url%") DO set cleanurl=%%G 

echo:
echo "Found URL for download: %cleanurl%"

echo:
echo "Downloading BaseSystem.dmg"
powershell.exe -command "$progressPreference = 'silentlyContinue'; Invoke-WebRequest %cleanurl% -OutFile %cd%\..\BaseSystem_Catalina.dmg"

echo:
cd ..
echo ================================
echo == Step 1 complete
echo == File should be in %cd%\BaseSystem_Catalina.dmg
echo == You can now proceed with step 2...
echo ================================
pause


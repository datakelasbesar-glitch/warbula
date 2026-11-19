@echo off
setlocal
cd /d "%~dp0"
if not exist "index.html" (
 echo index.html tidak ditemukan. Ekstrak seluruh paket terlebih dahulu.
 pause
 exit /b 1
)
if not exist "server-local.ps1" (
 echo server-local.ps1 tidak ditemukan. Ekstrak seluruh paket terlebih dahulu.
 pause
 exit /b 1
)
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0server-local.ps1"
echo.
echo Server sudah berhenti.
pause

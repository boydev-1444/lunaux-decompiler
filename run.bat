@echo off
cd /d "%~dp0"

start "" "%LOCALAPPDATA%\Microsoft\WindowsApps\wt.exe" -d . powershell -NoExit python main.py
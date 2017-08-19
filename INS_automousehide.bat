@taskkill /f /im "AutoMouseHide.exe"
@echo ----------------------------------------------------------
cd "%~dp0"
copy "*.exe" "C:\Program Files"
copy "*.ico" "C:\Program Files"
if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\WMC" goto skip
md "%appdata%\Microsoft\Windows\Start Menu\Programs\WMC"
:skip
copy "*.lnk" "%appdata%\Microsoft\Windows\Start Menu\Programs\WMC\"
copy "*.lnk" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\"
@echo ----------------------------------------------------------
@echo You can close this windows.
"C:\Program Files\AutoMouseHide.exe"
@exit
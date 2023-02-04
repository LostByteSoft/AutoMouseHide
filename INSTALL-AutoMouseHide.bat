echo off
pushd "%~dp0
@echo -------------------------------------
echo LostByteSoft
echo Install version 2023-02-04
echo Architecture: x64
echo Compatibility : w7 w8 w8.1 w10 w11

echo Software: AutoMouseHide
echo Ico file location: C:\Users\YOURNAMEHERE\AppData\Roaming
echo Ico file location: %A_AppData%
@echo -------------------------------------

taskkill /im "AutoMouseHide.exe"

copy "AutoMouseHide.exe" "C:\Program Files\"
copy "AutoMouseHide.lnk" "C:\Users\Public\Desktop\"

echo "You must close this command windows"
"C:\Program Files\AutoMouseHide.exe"
exit

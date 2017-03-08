;;--- Head (informations) ---
;;	AHK script
;;	Auto hide mouse cursor after 5 seconds (default) of inactivity.
;;	Compatibility: Windows
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode

	SetEnv, title, Move Mouse
	SetEnv, mode, Auto Move Hide Mouse
	SetEnv, version, Version 2017-03-07
	SetEnv, Author, LostByteSoft

;;--- Softwares options ---

	#SingleInstance Force
	#Persistent
	SetWorkingDir %A_ScriptDir%
	SetEnv, sleep, 5
	SetEnv, speed, 10

;;--- Tray options ---

	Menu, tray, add, +-------, about		; About version, create line
	Menu, tray, add, Change Time, changesleep	; Change wait time
	Menu, tray, add, Change Speed, changespeed	; Change move speed
	Menu, tray, add, Show Time && Speed, showinfo	; Show infos
	Menu, tray, add, ++------, about		; About version, create line
	Menu, tray, add, About, about			; Creates a new menu item
	Menu, tray, add, Version, version		; About version

;;--- Software start here ---

	TrayTip, %title%, %mode% : %sleep% Sec. %speed% Spd., 2, 1

loop:
	SysGet, Mon1, Monitor, 1		; sysget here, just in case resolution change
	MouseGetPos, MouseX1, MouseY1
	sleep, %sleep%000
	MouseGetPos, MouseX2, MouseY2

x:
	sleep, 500
	if ("" MouseX1 = MouseX2)
	goto, y
	else
	goto, loop

y:
	sleep, 500
	if ("" MouseY1 = MouseY2)
	goto, hide
	else
	goto, loop

hide:
	CoordMode, Mouse, Screen
	MouseMove, %Mon1Right%, 19, %speed%	; 19 is under the X button , is you specify lower value some info can by appear
	sleep, %sleep%000
	goto, loop

sleep:
	InputBox, newtime, WMC Mouse Hide, Change the time to auto-move the mouse ? Between 3 to 240 seconds (Now sleep is %sleep%), , , , , , , 10, Enter number
		if ErrorLevel
			goto, loop
	IfEqual, newtime, , Goto, sleep
	IfEqual, newtime, Enter number, Goto, sleep
	IfLess, newtime, 3, Goto, sleep
	IfGreater, newtime, 240, Goto, sleep
	SetEnv, sleep, %newtime%
	goto, loop

speed:
	InputBox, newspeed, WMC Mouse Hide, Change the speed to auto-move the mouse ? Between 2 to 100 : 2 is fast and 100 is slow (Now speed is %speed%), , , , , , , 10, Enter number
		if ErrorLevel
			goto, loop
	IfEqual, newspeed, , Goto, speed
	IfEqual, newspeed, Enter number, Goto, speed
	IfLess, newspeed, 2, Goto, speed
	IfGreater, newspeed, 100, Goto, speed
	SetEnv, speed, %newspeed%
	goto, loop

;;--- Quit ---

Exit:
	ExitApp

;;--- Tray Bar (must be at end of file) ---

changesleep:
	goto, sleep

changespeed:
	goto, speed

about:
	TrayTip, %title%, %mode% : Time: %sleep% Speed: %speed%, 2, 1
	Return

version:
	TrayTip, %title%, %version% by %author%, 2, 2
	Return

showinfo:
	TrayTip, %title%, Time: %sleep% Speed: %speed%, 2, 3
	Return

;;--- End of script ---
;
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   Version 3.14159265358979323846264338327950288419716939937510582
;                          March 2017
;
; Everyone is permitted to copy and distribute verbatim or modified
; copies of this license document, and changing it is allowed as long
; as the name is changed.
;
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
;
;              You just DO WHAT THE FUCK YOU WANT TO.
;
;              LostByteSoft no copyright or copyleft.
;
;;--- End of file ---
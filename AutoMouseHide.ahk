;;--- Head (informations) ---
;;	AHK script
;;	Auto hide mouse cursor after 10 seconds (default) of inactivity and reappear at the last place when you move the mouse.
;;	Compatibility: Windows
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode

	SetEnv, title, Move Mouse
	SetEnv, mode, Auto Move Hide Mouse
	SetEnv, version, Version 2017-08-19-1658
	SetEnv, Author, LostByteSoft

;;--- Softwares options ---

	#NoEnv
	#SingleInstance Force
	#Persistent
	SetWorkingDir %A_ScriptDir%
	SetEnv, sleep, 10
	SetEnv, speed, 10

	FileInstall, ico_AutoMouseHide.ico, ico_AutoMouseHide.ico, 0
	FileInstall, ico_shut.ico, ico_shut.ico, 0
	FileInstall, ico_pause.ico, ico_pause.ico, 0

;;--- Tray options ---

	Menu, Tray, NoStandard
	Menu, tray, add, --= %title% =--, about1
	Menu, Tray, Icon, --= %title% =--, ico_AutoMouseHide.ico
	Menu, tray, add, Exit %title%, Exit
	Menu, Tray, Icon, Exit %title%, ico_shut.ico
	Menu, tray, add, Show logo, GuiLogo
	Menu, tray, add,				; About version, create line
	Menu, tray, add, Change Time, sleep		; Change wait time
	Menu, tray, add, Change Speed, speed		; Change move speed
	Menu, tray, add, Show Time && Speed, showinfo	; Show infos
	Menu, tray, add,				; About version, create line
	Menu, tray, add, About, about2			; Creates a new menu item
	Menu, tray, add, Version, version		; About version
	Menu, tray, add,
	Menu, tray, add, Pause script, pause
	Menu, Tray, Icon, Pause script, ico_pause.ico
	Menu, Tray, Tip, %title% - sleep=%sleep% - speed=%speed%

;;--- Software start here ---

	; TrayTip, %title%, %mode% : %sleep% Sec. %speed% Spd., 2, 1

loop:
	Menu, Tray, Icon, ico_AutoMouseHide.ico
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

; --- Options ---

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

pause:
	Menu, Tray, Icon, ico_pause.ico, , 1
	Pause, Toggle
	;Menu, Tray, Icon, ico_pause.ico
	Return

GuiLogo:
	Gui, Add, Picture, x25 y25 w400 h400 , ico_AutoMouseHide.ico
	Gui, Show, w450 h450, %title% Logo
	Gui, Color, 000000
	return

;;--- Quit ---

Exit:
	ExitApp

;;--- Tray Bar (must be at end of file) ---

;changesleep:
;	goto, sleep

;changespeed:
;	goto, speed

about1:
about2:
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
;		     NO FUCKING WARRANTY AT ALL
;
;	As is customary and in compliance with current global and
;	interplanetary regulations, the author of these pages disclaims
;	all liability for the consequences of the advice given here,
;	in particular in the event of partial or total destruction of
;	the material, Loss of rights to the manufacturer's warranty,
;	electrocution, drowning, divorce, civil war, the effects of
;	radiation due to atomic fission, unexpected tax recalls or
;	    encounters with extraterrestrial beings 'elsewhere.
;
;              LostByteSoft no copyright or copyleft.
;
;	If you are unhappy with this software i do not care.
;
;;--- End of file ---
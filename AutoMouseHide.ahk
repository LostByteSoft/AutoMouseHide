;;--- Head (informations) ---

;;	AHK script
;;	Auto hide mouse cursor after 10 seconds (default) of inactivity and reappear at the last place when you move the mouse.
;;	Compatibility: Windows
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode
;;
;;	There a way here to HIDE cursor: https://autohotkey.com/docs/commands/DllCall.htm#HideCursor

;;--- Softwares options ---

	SetWorkingDir %A_ScriptDir%
	#NoEnv
	#SingleInstance Force
	#Persistent

	SetEnv, title, Move Mouse
	SetEnv, mode, Auto Move Hide Mouse
	SetEnv, version, Version 2017-10-04-1602
	SetEnv, Author, LostByteSoft
	SetEnv, logoicon, ico_AutoMouseHide.ico
	SetEnv, sleep, 10
	SetEnv, speed, 5
	SetEnv, pause, 0
	SetEnv, pixel, 22					; 19 is under the X button , is you specify lower value info appear, 19 is not enough some times so i put 22.

	FileInstall, ico_AutoMouseHide.ico, ico_AutoMouseHide.ico, 0
	FileInstall, ico_shut.ico, ico_shut.ico, 0
	FileInstall, ico_pause.ico, ico_pause.ico, 0
	FileInstall, ico_lock.ico, ico_lock.ico, 0

	SysGet, Mon1, Monitor, 1				; sysget here, just in case resolution change

;;--- Tray options ---

	Menu, Tray, NoStandard
	Menu, tray, add, ---=== %title% ===---, about
	Menu, Tray, Icon, ---=== %title% ===---, %logoicon%
	Menu, tray, add, Show logo, GuiLogo
	Menu, tray, add, Secret MsgBox, secret			; Secret MsgBox, just show all options and variables of the program
	Menu, Tray, Icon, Secret MsgBox, ico_lock.ico
	Menu, tray, add, About && ReadMe, author
	Menu, Tray, Icon, About && ReadMe, ico_about.ico
	Menu, tray, add, Author %author%, about
	menu, tray, disable, Author %author%
	Menu, tray, add, %version%, about
	menu, tray, disable, %version%
	Menu, tray, add,
	Menu, tray, add, Exit, Close				; Close exit program
	Menu, Tray, Icon, Exit, ico_shut.ico
	Menu, tray, add,
	Menu, tray, add, --== Option(s) ==--, about
	Menu, tray, add, Change Time, sleep			; Change wait time
	Menu, tray, add, Change Speed, speed			; Change move speed
	Menu, tray, add, Change Pixel, pixel
	Menu, tray, add,
	Menu, tray, add, Show Time && Speed && Pixel, showinfo		; Show infos
	Menu, tray, add, Pause script (Toggle), pause
	Menu, Tray, Icon, Pause script (Toggle), ico_pause.ico
	Menu, tray, add,

;;--- Software start here ---

loop:
	Menu, Tray, Tip, %title% - sleep=%sleep% - speed=%speed% - pixel=%pixel%
	IfEqual, pause, 1, Goto, skipicon
	Menu, Tray, Icon, ico_AutoMouseHide.ico
	skipicon:
	MouseGetPos, MouseX1, MouseY1
	sleep, %sleep%000
	MouseGetPos, MouseX2, MouseY2

x:
	sleep, 250
	if ("" MouseX1 = MouseX2)
		goto, y
	else
		goto, loop

y:
	sleep, 250
	if ("" MouseY1 = MouseY2)
		goto, hide
	else
		goto, loop

hide:
	IfEqual, pause, 1, Goto, loop
	CoordMode, Mouse, Screen
	MouseMove, %Mon1Right%, %pixel%, %speed%		; 19 is under the X button , is you specify lower value some info can by appear, 19 is not enough some times.
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
	Ifequal, pause, 0, goto, paused
	Ifequal, pause, 1, goto, unpaused
	Goto, pause

	paused:
	Menu, Tray, Icon, ico_pause.ico
	SetEnv, pause, 1
	goto, loop

	unpaused:	
	Menu, Tray, Icon, ico_time.ico
	SetEnv, pause, 0
	Goto, loop

pixel:
	InputBox, newpixel, WMC Mouse Hide, Change the pixel to up to screen ? Between 0 to %Mon1Bottom% pixels (Now pixel is %pixel%), , , , , , , 20, Enter number
		if ErrorLevel
			goto, loop
	IfEqual, newpixel, , Goto, pixel
	IfEqual, newpixel, Enter number, Goto, pixel
	IfLess, newpixel, 0, Goto, pixel
	IfGreater, newpixel, %Mon1Bottom%, Goto, pixel
	SetEnv, pixel, %newpixel%
	goto, loop

;;--- Quit & Reload ---

doReload:
	Reload

Close:
	ExitApp

; Escape::		; Debug purpose or quit when press esc
	ExitApp

;;--- Tray Bar (must be at end of file) ---

secret:
	MouseGetPos, MouseX1, MouseY1
	MsgBox, 48, %title%,All variables is shown here.`n`nTitle=%title% mode=%mode% version=%version% author=%author% A_WorkingDir=%A_WorkingDir%`n`nSleep=%sleep% speed=%speed% pause=%pause% pixel=%pixel%`n`nMouse is MouseX1=%MouseX1% MouseY1=%MouseY1%
	Return

about:
	TrayTip, %title%, %mode% : Time: %sleep% Speed: %speed%, 2, 1
	Return

author:
	MsgBox, 64, %title%, %title% %mode% %version% %author%. This software is usefull to auto move the mouse somewhere is not visible (Right top corner -%pixel% px).`n`n`tGo to https://github.com/LostByteSoft
	Return

version:
	TrayTip, %title%, %version% by %author%, 2, 2
	Return

showinfo:
	TrayTip, %title%, Time: %sleep% Speed: %speed% Pixel: %pixel%, 2, 3
	Return

GuiLogo:
	Gui, Add, Picture, x25 y25 w400 h400 , %logoicon%
	Gui, Show, w450 h450, %title% Logo
	; Gui, Color, 000000
	return

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
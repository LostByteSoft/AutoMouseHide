;; --- Head (informations) ---

;;	AHK script
;;	Auto move to hide mouse cursor, in the top right corner, after 10 seconds (default) of inactivity.
;;	Compatibility: Windows
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode

;; --- Softwares options ---

	SetWorkingDir %A_ScriptDir%
	#NoEnv
	#SingleInstance Force
	#Persistent

	SetEnv, title, Move Mouse
	SetEnv, mode, Auto Move Hide Mouse
	SetEnv, version, Version 2017-10-23-0810
	SetEnv, Author, LostByteSoft
	SetEnv, logoicon, ico_AutoMouseHide.ico
	SetEnv, hidetray, 0
	SetEnv, debug, 0
	SetEnv, sleep, 10
	SetEnv, sleep2, 10
	SetEnv, speed, 10
	SetEnv, pause, 0
	SetEnv, pixel, 22	;; 19 is under the X button , is you specify lower value info may be appear, 19 is not enough some times so i put 22.
	Sleep -= 3

	FileInstall, ico_AutoMouseHide.ico, ico_AutoMouseHide.ico, 0
	FileInstall, ico_debug.ico, ico_debug.ico, 0
	FileInstall, ico_lock.ico, ico_lock.ico, 0
	FileInstall, ico_options.ico, ico_options.ico, 0
	FileInstall, ico_pause.ico, ico_pause.ico, 0
	FileInstall, ico_reboot.ico, ico_reboot.ico, 0
	FileInstall, ico_shut.ico, ico_shut.ico, 0

;; --- Tray options ---

	Menu, Tray, NoStandard
	Menu, tray, add, ---=== %title% ===---, about
	Menu, Tray, Icon, ---=== %title% ===---, %logoicon%
	Menu, tray, add, Show logo, GuiLogo
	Menu, tray, add, Secret MsgBox, secret				; Secret MsgBox, just show all options and variables of the program
	Menu, Tray, Icon, Secret MsgBox, ico_lock.ico
	Menu, tray, add, About && ReadMe, author
	Menu, Tray, Icon, About && ReadMe, ico_about.ico
	Menu, tray, add, Author %author%, about
	menu, tray, disable, Author %author%
	Menu, tray, add, %version%, about
	menu, tray, disable, %version%
	Menu, tray, add,
	Menu, tray, add, --== Control ==--, about
	Menu, Tray, Icon, --== Control ==--, ico_options.ico
	Menu, tray, add, Exit %title%, Close				; Close exit program
	Menu, Tray, Icon, Exit %title%, ico_shut.ico
	Menu, tray, add, Refresh (ini mod), doReload 			; Reload the script.
	Menu, Tray, Icon, Refresh (ini mod), ico_reboot.ico
	Menu, tray, add, Set Debug (Toggle), debug
	Menu, Tray, Icon, Set Debug (Toggle), ico_debug.ico
	Menu, tray, add, Pause (Toggle), pause
	Menu, Tray, Icon, Pause (Toggle), ico_pause.ico
	Menu, tray, add,
	Menu, tray, add, --== Options ==--, about
	Menu, Tray, Icon, --== Options ==--, ico_options.ico
	Menu, tray, add, Change Time, sleep				; Change wait time
	Menu, tray, add, Change Speed, speed				; Change move speed
	Menu, tray, add, Change Pixel, pixel
	Menu, tray, add, Hide the mouse, hidetray
	Menu, Tray, Icon, Hide the mouse, %logoicon%
	Menu, tray, add, Show Time && Speed && Pixel, showinfo		; Show infos
	Menu, tray, add, Pause script (Toggle), pause
	Menu, Tray, Icon, Pause script (Toggle), ico_pause.ico
	Menu, tray, add,

;; --- Software start here ---

loop:
	SetEnv, hidetray, 0
	IfEqual, debug, 1
			MsgBox, 0, %title%, Loop sleep=%sleep% (default is 10 but Sleep is -3 because timer in script)`n`nVar exist if hide one time`n`tMouseX5=%MouseX5% MouseY5=%MouseY5%, 5
	SysGet, Mon1, Monitor, 1				; sysget here, just in case resolution change
	Menu, Tray, Tip, %title% - sleep=%sleep2% - speed=%speed% - pixel=%pixel%
	IfEqual, pause, 1, Goto, skipicon
	Menu, Tray, Icon, ico_AutoMouseHide.ico
	skipicon:
	MouseGetPos, MouseX4, MouseY4
	sleep, 1000
	if ("" MouseX5 = MouseX4)
		goto, loop
	else
		goto, Detection

Detection:
	MouseGetPos, MouseX1, MouseY1
	IfEqual, debug, 1
			MsgBox, 0, %title%, Detection`n`tMouseX1=%MouseX1% MouseY1=%MouseY1%, 5
	sleep, %sleep%000
	MouseGetPos, MouseX2, MouseY2
	sleep, 1000
	if ("" MouseX1 = MouseX2)
		goto, double
	else
		goto, loop

double:
	IfEqual, debug, 1
			MsgBox, 0, %title%, Double`n`tMouseX2=%MouseX2% MouseY2=%MouseY2%, 5
	sleep, 1000
	MouseGetPos, MouseX2, MouseY3
	if ("" MouseY1 = MouseY3)
		goto, hide
	else
		goto, loop

hidetray:
	SetEnv, hidetray, 1

hide:
	;; Before it hide it check if the mouse is on 0x0 y0 (no mouse) return to loop if no mouse NOT IMPLEMENTED
	IfEqual, debug, 1
			MsgBox, 0, %title%, Hide`n`tMouseX1=%MouseX1% MouseY1=%MouseY1% = MouseX2=%MouseX2% MouseY2=%MouseY2% = MouseX2=%MouseX2% MouseY3=%MouseY3%,5
	;; Go to right side before go to up. (Some bugs caused by the mouse passing by text in wmc)
	;; MsgBox, Ecran 1 Left: %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom%...
	CoordMode, Mouse, Screen
	SetEnv, RightCenter, %Mon1bottom%
	RightCenter /=  2
	SetEnv, sleep2, speed
	Sleep2 /= 2
	;; msgbox, Mon1bottom=%Mon1bottom% - rightcenter=%RightCenter% - speed=%speed% - sleep2=%sleep2%
	IfEqual, pause, 1, Goto, loop
	IfEqual, debug, 1, tooltip, The mouse move. Follow Me., % mx+25, % my-25, 19
	MouseMove, %Mon1Right%, %RightCenter%, %speed%		; 19 is under the X button , is you specify lower value some info can by appear, 19 is not enough some times.
	sleep, %sleep2%000
	IfEqual, debug, 1, tooltip, The mouse move. Right center., % mx+25, % my-25, 19
	MouseMove, %Mon1Right%, %pixel%, 2
	sleep, 2000
	MouseGetPos, MouseX5, MouseY5
	IfEqual, debug, 1, tooltip, The mouse move. Top right - %pixel%., % mx+25, % my-25, 19
	;;IfEqual, hidetray, 1, tooltip, I'm here - %pixel%., % mx+25, % my-25, 19
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
	SetEnv, sleep2, %newtime%
	Sleep -= 3
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

;; --- Pause & debug ---

pause:
	Ifequal, pause, 0, goto, paused
	Ifequal, pause, 1, goto, unpaused
	Goto, pause

	paused:
	Menu, Tray, Icon, ico_pause.ico
	SetEnv, pause, 1
	goto, loop

	unpaused:
	SetEnv, pause, 0
	Goto, loop

Debug:
	IfEqual, debug, 0, goto, enable
	IfEqual, debug, 1, goto, disable

	enable:
	SetEnv, debug, 1
	TrayTip, %title%, Debug mode = 1, 2, 3
	Goto, loop

	disable:
	SetEnv, debug, 0
	Goto, loop

;; --- Quit & Reload ---

Close:
	ExitApp

; Escape::					; Debug purpose or quit when press esc.
	ExitApp

doReload:
	Reload
	sleep, 100
	goto, Close

;; --- Tray Bar (must be at end of file) ---

secret:
	SysGet, Mon1, Monitor, 1		; sysget here, just in case resolution change
	MouseGetPos, MouseX1, MouseY1
	MsgBox, 48, %title%,All variables is shown here.`n`nTitle=%title% mode=%mode% version=%version% author=%author% A_WorkingDir=%A_WorkingDir%`n`nSleep=%sleep% speed=%speed% pause=%pause% pixel=%pixel%`n`nMouse is MouseX1=%MouseX1% MouseY1=%MouseY1% and move to %Mon1Right% %pixel%.
	Return

about:
	TrayTip, %title%, %mode% : Time: %sleep% Speed: %speed%, 2, 1
	Return

author:
	MsgBox, 64, %title%, %title% %mode% %version% %author%. This software is usefull to auto move the mouse somewhere is not visible (Right top corner -%pixel% px).In pause mode all the script is running exect doesn't move the mouse.`n`n`tGo to https://github.com/LostByteSoft
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

;; --- End of script ---
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
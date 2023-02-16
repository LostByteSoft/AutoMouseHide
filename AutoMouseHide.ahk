;; --- Head (informations) ---

;;	AHK script
;;	Auto move to hide mouse cursor, in the top right corner, after 10 seconds (default) of inactivity.
;;	Compatibility: Windows
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode
;;	THis thimg have A LOT of detection mouse cursor move for reliability
;;	and if the mouse mouve somewhere in the processus it will not move again.

;; --- Softwares options ---

	SetWorkingDir %A_ScriptDir%
	#NoEnv
	#SingleInstance Force
	#Persistent
	SysGet, Mon1, Monitor, 1

	SetEnv, title, Move Mouse
	SetEnv, mode, Auto Move Hide Mouse
	SetEnv, version, Version 2023-02-04
	SetEnv, Author, LostByteSoft
	SetEnv, hidetray, 0
	SetEnv, debug, 0
	SetEnv, sleep, 10
	SetEnv, sleep2, 1		;; time between the two moves.
	SetEnv, speed, 20
	SetEnv, pause, 0
	SetEnv, pixel, 22		;; 19 is under the X button , is you specify lower value info may be appear, 19 is not enough some times so i put 22.
	Sleep -= 3
	SetEnv, icofolder, %A_AppData%
	SetEnv, logoicon, ico_AutoMouseHide.ico
	SetEnv, comp, w7 w8 w8.1 w10 w11 (x64)

	;; specific files

	FileInstall, ico_AutoMouseHide.ico, %icofolder%\ico_AutoMouseHide.ico, 0

	;; Common ico

	FileInstall, ico_about.ico, %icofolder%\ico_about.ico, 0
	FileInstall, ico_lock.ico, %icofolder%\ico_lock.ico, 0
	FileInstall, ico_pause.ico, %icofolder%\ico_pause.ico, 0
	FileInstall, ico_shut.ico, %icofolder%\ico_shut.ico, 0
	FileInstall, ico_options.ico, %icofolder%\ico_options.ico, 0
	FileInstall, ico_reboot.ico, %icofolder%\ico_reboot.ico, 0
	FileInstall, ico_shut.ico, %icofolder%\ico_shut.ico, 0
	FileInstall, ico_debug.ico, %icofolder%\ico_debug.ico, 0
	FileInstall, ico_HotKeys.ico, %icofolder%\ico_HotKeys.ico, 0

;; --- Tray options ---

	Menu, Tray, NoStandard
	Menu, tray, add, ---=== %title% ===---, about
	Menu, Tray, Icon, ---=== %title% ===---, %icofolder%\%logoicon%
	Menu, tray, add, Show logo, GuiLogo
	Menu, tray, add, Secret MsgBox, secret				; Secret MsgBox, just show all options and variables of the program
	Menu, Tray, Icon, Secret MsgBox, %icofolder%\ico_lock.ico
	Menu, tray, add, About && ReadMe, author
	Menu, Tray, Icon, About && ReadMe, %icofolder%\ico_about.ico
	Menu, tray, add, Author %author%, about
	menu, tray, disable, Author %author%
	Menu, tray, add, %version%, about
	menu, tray, disable, %version%
	Menu, tray, add,
	Menu, tray, add, --== Control ==--, about
	Menu, Tray, Icon, --== Control ==--, %icofolder%\ico_options.ico
	Menu, tray, add, Exit %title%, Close				; Close exit program
	Menu, Tray, Icon, Exit %title%, %icofolder%\ico_shut.ico
	Menu, tray, add, Refresh (ini mod), doReload 			; Reload the script.
	Menu, Tray, Icon, Refresh (ini mod), %icofolder%\ico_reboot.ico
	Menu, tray, add, Set Debug (Toggle), debug
	Menu, Tray, Icon, Set Debug (Toggle), %icofolder%\ico_debug.ico
	Menu, tray, add, Pause (Toggle), pause
	Menu, Tray, Icon, Pause (Toggle), %icofolder%\ico_pause.ico
	Menu, tray, add,
	Menu, tray, add, --== Options ==--, about
	Menu, Tray, Icon, --== Options ==--, %icofolder%\ico_options.ico
	Menu, tray, add, Change Time, sleep					; Change wait time
	Menu, tray, add, Change Speed, speed				; Change move speed
	Menu, tray, add, Change Pixel, pixel
	Menu, tray, add, Show Time && Speed && Pixel, showinfo	; Show infos
	Menu, tray, add,
	Menu, tray, add, Hide the mouse, hidetray
	Menu, Tray, Icon, Hide the mouse, %icofolder%\%logoicon%

;; --- Software start here ---

loop:
	SetEnv, hidetray, 0
	IfEqual, debug, 1
			MsgBox, 0, %title%, Loop :`n`nsleep=%sleep% (default is 10 but Sleep is -3 because timer in script)`n`nVar exist if hide one time`n`n`tMouseX5=%MouseX5% MouseY5=%MouseY5%, 3
	SysGet, Mon1, Monitor, 1				; sysget here, just in case resolution change
	Menu, Tray, Tip, %title% - sleep=%sleep2% - speed=%speed% - pixel=%pixel%
	IfEqual, pause, 1, Goto, skipicon
	Menu, Tray, Icon, %icofolder%\ico_AutoMouseHide.ico
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
			MsgBox, 0, %title%, Detection :`n`n`tMouseX1=%MouseX1% MouseY1=%MouseY1%, 3
	sleep, %sleep%000
	MouseGetPos, MouseX2, MouseY2
	sleep, 1000
	if ("" MouseX1 = MouseX2)
		goto, double
	else
		goto, loop

double:
	IfEqual, debug, 1
			MsgBox, 0, %title%, Double :`n`tMouseX2=%MouseX2% MouseY2=%MouseY2%, 3
	sleep, 1000
	MouseGetPos, MouseX2, MouseY3
	if ("" MouseY1 = MouseY3)
		goto, hide
	else
		goto, loop

hidetray:
	SetEnv, hidetray, 1
	tooltip, The mouse is right (msg 6). Right - %Mon1Right%, % mx+25, % my-25
	goto, hide

hide:
	IfEqual, debug, 1
		MsgBox, 0, %title%, Hide :`n`tMouseX1=%MouseX1% MouseY1=%MouseY1%`n`nMouseX2=%MouseX2% MouseY2=%MouseY2%`n`nMouseX2=%MouseX2% MouseY3=%MouseY3%`n`nEcran 1 Left: %Mon1Left% -- Top: %Mon1Top% -- Right: %Mon1Right% -- Bottom %Mon1Bottom%...,3

	;; Go to right side before go to up. (Some bugs caused by the mouse passing by text in wmc)
	CoordMode, Mouse, Screen
	SetEnv, RightCenter, %Mon1bottom%
	RightCenter /=  3
	IfEqual, pause, 1, Goto, loop
	IfEqual, debug, 1, tooltip, The mouse will move (msg 1). Follow Me., % mx+25, % my-25, 19
	SetEnv, Mon1Right1, %Mon1Right%
	Mon1Right1 -= 15
	IfEqual, debug, 1, tooltip, The mouse move (msg 1). tMon1Right=%Mon1Right%., % mx+25, % my-25, 19
	MouseMove, %Mon1Right1%, %RightCenter%, %speed%
	IfEqual, debug, 1, tooltip, The mouse has move (msg 3). Right center minus 15 px., % mx+25, % my-25, 19
Triple:
	MouseGetPos, MouseX10, MouseY10
	IfEqual, debug, 1, tooltip, The mouse is right (msg 4). Right - %Mon1Right1%., % mx+25, % my-25, 19
	sleep, %sleep2%000			;; time to wait between moves
	MouseGetPos, MouseX20, MouseY20
	if ("" MouseX10 = MouseX20)
		goto, MovetoHide
	else
		goto, loop

MovetoHide:
	MouseMove, %Mon1Right%, %pixel%, 15			; 19 (var pixel) is under the X button , is you specify lower value some info can by appear, 19 is not enough some times.
	sleep, 3000
	IfEqual, debug, 1, tooltip, The mouse stop moving (msg 5). Top right - %pixel%., % mx+25, % my-25, 19
	MouseGetPos, MouseX5, MouseY5
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
	;;SetEnv, sleep2, %newtime%
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
	Menu, Tray, Icon, %icofolder%\ico_pause.ico
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
	MsgBox, 48, %title%,All variables is shown here.`n`nTitle=%title% mode=%mode% version=%version% author=%author% A_WorkingDir=%A_WorkingDir%`n`nSleep=%sleep% speed=%speed% pause=%pause% pixel=%pixel%`n`nMouse is MouseX1=%MouseX1% MouseY1=%MouseY1% and move to %Mon1Right% x %pixel%.
	Return

about:
	TrayTip, %title%, %mode% : Time: %sleep% Speed: %speed%, 2, 1
	Return

author:
	MsgBox, 64, %title%, %title% %mode% %version% %author%. This software is usefull to auto move the mouse somewhere is not visible (Right top corner -%pixel% px). Is usefull for use with WMC with no mouse, WMC with no mouse the mouse is resting in center screen. In pause mode all the script is running exect doesn't move the mouse.`n`n`tGo to https://github.com/LostByteSoft
	Return

version:
	TrayTip, %title%, %version% by %author%, 2, 2
	Return

showinfo:
	MsgBox, 64, %title%, Time: %sleep% Speed: %speed% Pixel: %pixel% ;;; , 2, 2
	Return

GuiLogo:
	Gui, 4:Add, Picture, x25 y25 w400 h400, %icofolder%\%logoicon%
	Gui, 4:Show, w450 h450, %title% Logo
	;;Gui, 4:Color, 000000
	Sleep, 500
	Return

	4GuiClose:
	Gui 4:Cancel
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
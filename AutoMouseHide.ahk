;;--- Head (informations) ---
;;	AHK script
;;	Auto hide mouse cursor after 10 seconds (default) of inactivity and reappear at the last place when you move the mouse.
;;	Compatibility: Windows
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode

;;--- Softwares options ---

	#NoEnv
	#SingleInstance Force
	#Persistent
	SetWorkingDir %A_ScriptDir%

	SetEnv, title, Move Mouse
	SetEnv, mode, Auto Move Hide Mouse
	SetEnv, version, Version 2017-09-21-0831
	SetEnv, Author, LostByteSoft
	SetEnv, sleep, 10
	SetEnv, speed, 10
	SetEnv, pause, 0

	FileInstall, ico_AutoMouseHide.ico, ico_AutoMouseHide.ico, 0
	FileInstall, ico_shut.ico, ico_shut.ico, 0
	FileInstall, ico_pause.ico, ico_pause.ico, 0
	FileInstall, ico_lock.ico, ico_lock.ico, 0

;;--- Tray options ---

	Menu, Tray, NoStandard
	Menu, tray, add, --= %title% =--, about1
	Menu, Tray, Icon, --= %title% =--, ico_AutoMouseHide.ico
	Menu, tray, add, Show logo, GuiLogo
	Menu, tray, add, Secret MsgBox, secret			; Secret MsgBox, just show all options and variables of the program
	Menu, Tray, Icon, Secret MsgBox, ico_lock.ico
	Menu, tray, add, About %author%, about2			; about author
	Menu, Tray, Icon, About %author%, ico_about.ico
	Menu, tray, add, %Version%, about3			; About version
	Menu, Tray, Icon, %Version%, ico_about.ico
	Menu, tray, add,
	Menu, tray, add, Exit %title%, Exit
	Menu, Tray, Icon, Exit %title%, ico_shut.ico
	Menu, tray, add,
	Menu, tray, add, Change Time, sleep			; Change wait time
	Menu, Tray, Icon, Change Time, ico_time.ico
	Menu, tray, add, Change Speed, speed			; Change move speed
	Menu, Tray, Icon, Change Speed, ico_about.ico
	Menu, tray, add, Show Time && Speed, showinfo		; Show infos
	Menu, tray, add,
	Menu, tray, add, Pause script (Toggle), pause
	Menu, Tray, Icon, Pause script (Toggle), ico_pause.ico
	Menu, tray, add,
	;; Menu, Tray, Tip, %title% - sleep=%sleep% - speed=%speed%

;;--- Software start here ---

	; TrayTip, %title%, %mode% : %sleep% Sec. %speed% Spd., 2, 1

loop:
	Menu, Tray, Tip, %title% - sleep=%sleep% - speed=%speed%
	IfEqual, pause, 1, Goto, skipicon
	Menu, Tray, Icon, ico_AutoMouseHide.ico
	skipicon:
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
	IfEqual, pause, 1, Goto, loop
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

;;--- Quit ---

Exit:
	ExitApp

;;--- Tray Bar (must be at end of file) ---

secret:
	MouseGetPos, MouseX1, MouseY1
	MsgBox, 64, %title%,All variables is shown here.`n`nTitle=%title% mode=%mode% version=%version% author=%author% A_WorkingDir=%A_WorkingDir%`n`nSleep=%sleep% speed=%speed% pause=%pause%`n`nMouse is MouseX1=%MouseX1% MouseY1=%MouseY1%
	Return

about1:
about2:
about3:
	TrayTip, %title%, %mode% : Time: %sleep% Speed: %speed%, 2, 1
	Return

version:
	TrayTip, %title%, %version% by %author%, 2, 2
	Return

showinfo:
	TrayTip, %title%, Time: %sleep% Speed: %speed%, 2, 3
	Return

GuiLogo:
	Gui, Add, Picture, x25 y25 w400 h400 , ico_AutoMouseHide.ico
	Gui, Show, w450 h450, %title% Logo
	;Gui, Color, 000000
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
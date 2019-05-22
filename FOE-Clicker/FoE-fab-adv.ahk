/*TODO:
- enable PAUSE not exit whole script ...
- move helper out of loop
- init loop action: jump to first
- get rid of cnp and absolute values --> global variables, exportable to ini ...
- bigger loop for frinds, guil, neighbors --> only friends have tavern
- optical recognition of needed actions to prevent unneccesary clicks and adjustments needed to random waiting times in case loading takes longer
- GUI???
	- count BP
	- count other stuff (people helped/taverns visited --> ultimately export to csv to have statistics)

*/
;####################################################################
;#####global constants###############################################
;####################################################################
co_image_correction := 30



^!F::
WinWait, Forge of Empires - Google Chrome, 
IfWinNotActive, Forge of Empires - Google Chrome, , WinActivate, Forge of Empires - Google Chrome, 
WinWaitActive, Forge of Empires - Google Chrome, 


Loop
{
RandSleep(300,400)
MouseClick, left,  324,  1035
RandSleep(350,450)
MouseClick, left,  324,  1035
RandSleep(350,450)
MouseClick, left,  358,  1006
RandSleep(650,750)
MouseClick, left,  358,  1006
RandSleep(350,450)
WinWaitActive, Forge of Empires - Google Chrome, 
MouseClick, left,  426,  1039
RandSleep(350,450)
MouseClick, left,  426,  1039
RandSleep(350,450)
MouseClick, left,  463,  1014
RandSleep(650,750)
MouseClick, left,  463,  1014
RandSleep(350,450)
WinWaitActive, Forge of Empires - Google Chrome, 
MouseClick, left,  531,  1036
RandSleep(350,450)
MouseClick, left,  531,  1036
RandSleep(350,450)
MouseClick, left,  574,  1015
RandSleep(650,750)
MouseClick, left,  576,  1013
RandSleep(350,450)
WinWaitActive, Forge of Empires - Google Chrome, 
MouseClick, left,  648,  1039
RandSleep(350,450)
MouseClick, left,  648,  1039
RandSleep(350,450)
MouseClick, left,  683,  1016
RandSleep(650,750)
MouseClick, left,  682,  1013
RandSleep(350,450)
WinWaitActive, Forge of Empires - Google Chrome, 
MouseClick, left,  755,  1037
RandSleep(350,450)
MouseClick, left,  755,  1037
RandSleep(350,450)
MouseClick, left,  783,  1010
RandSleep(650,750)
MouseClick, left,  783,  1010
RandSleep(350,451)
WinWaitActive, Forge of Empires - Google Chrome, 

RandSleep(650,750)
WinWaitActive, Forge of Empires - Google Chrome, 
MouseClick, left,  922,  985
RandSleep(350,450)

}

return

/* Versuch 1 auf Bilder Klicken
Loop
{MsgBox, schleife
	t0 := A_TickCount ;aktueller zeitpunkt
	Loop
	{MsgBox, bildersuche
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, C:\Users\fabian.coldewey\OneDrive - ITARICON\Desktop\Privat\helfen.png
		If ErrorLevel = 0 ;Wenn Bild gefunden
		{
			MouseClick, left, %FoundX%, %FoundY%
			MsgBox, gefunden
		}
		
		
		If (A_TickCount > t0+5000) ; Wenn das Bild jetzt seit 10 Sekunden nicht gefunden wurde
		{
			Sleep, 100
			Loop
			{MsgBox, nicht gefunden
				ImageSearch, FoundX2, FoundY2, 0, 0, A_ScreenWidth, A_ScreenHeight, C:\Users\fabian.coldewey\OneDrive - ITARICON\Desktop\Privat\freunde5weiter.png
				If ErrorLevel = 0 ;Wenn Bild gefunden
				{
					MouseClick, left, %FoundX2%, %FoundY2%
					MsgBox, 5 weiter
					Break
				}
			}
		}
		Break
	}
	
}
*/

/* Versuch 2 bilderkennung. Scheinbar sind die Bilder nicht gleichbleibend
t0 := 0
Loop
{
	t0 := A_TickCount ;aktueller zeitpunkt
	Loop
	{
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, helfen1.png
		If ErrorLevel = 0 ;Wenn Bild gefunden
		{
			MouseClick, left, %FoundX%, %FoundY%
			MsgBox, gefunden
		}
		
		
		If (A_TickCount > t0+5000) ; Wenn das Bild jetzt seit 10 Sekunden nicht gefunden wurde
		{
			Sleep, 100
			
			MsgBox, nicht gefunden
			Break
			
		}
		
	}
	Break
	
}
*/




return

; image search test
^#s::
	;ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *100 %A_ScriptDir%\img\tavernReady.jpg ; * is allowed variation
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *30 tavernReady.jpg
	;ret = findImage(tavernReady.jpg, FoundX, FoundY)
		;If ret = 0 ;Wenn Bild gefunden
		if ErrorLevel = 0 ;Wenn Bild gefunden
		{
			WinWaitActive, Forge of Empires - Google Chrome, ; best to always check the active window before firing controls
			ToolTip, gefunden %FoundX% %FoundY% ; just visualisation for testing
			SetTimer, RemoveToolTip, -5000 ; just visualisation for testing
			MouseClick, left, %FoundX%, %FoundY% ; actual click on the target
			RandSleep(350,450)
			MouseClick, left, %FoundX%, %FoundY% ; click to close (possibly) opened window
			
			foundCount = foundCount + 1 ; to determine when to return to outer loop
		}
		else
		{
			ToolTip, nicht gefunden %FoundX% %FoundY% ; just visualisation for testing
			SetTimer, RemoveToolTip, -5000 ; just visualisation for testing
		}
return

; image search test with function
^#q::

	ret := findImage("tavernReady.jpg", FoundX, FoundY)
		If ret = 0 ;Wenn Bild gefunden
		{
			WinWaitActive, Forge of Empires - Google Chrome, ; best to always check the active window before firing controls
			ToolTip, gefunden %FoundX% %FoundY% ; just visualisation for testing
			SetTimer, RemoveToolTip, -5000 ; just visualisation for testing
			MouseClick, left, %FoundX%, %FoundY% ; actual click on the target
			RandSleep(550,650)
			MouseClick, left, %FoundX%, %FoundY% ; click to close (possibly) opened window
			
			foundCount = foundCount + 1 ; to determine when to return to outer loop
		}
		else
		{
			ToolTip, nicht gefunden %ret% ; just visualisation for testing
			SetTimer, RemoveToolTip, -5000 ; just visualisation for testing
		}
return
;######
;teststuff
^#t::
	ret := clickImage("tavernReady.jpg")
		If ret = 0 
		{
			cToolTip("gefunden")
		}
		else
		{
			cToolTip("nicht gefunden %ret%")
		}
return

;#####

#z::ExitApp
return
;####################################################################
;#####FUNCTIONS######################################################
;####################################################################
RandSleep(RandSleepX,RandSleepY) {
	Random, randSleep, %RandSleepX%, %RandSleepY%
	Sleep %randSleep%
}

clickImage(image) {
	ret := findImage(image, FoundX, FoundY)
		If ret = 0 ;Wenn Bild gefunden
		{
			WinWaitActive, Forge of Empires - Google Chrome, ; best to always check the active window before firing controls TODO set global variable
			MouseClick, left, %FoundX%, %FoundY% ; actual click on the target
			RandSleep(550,650)
			MouseClick, left, %FoundX%, %FoundY% ; click to close (possibly) opened window
		}
	return ret
	}



findImage(image, ByRef found_x, ByRef found_y) {
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *30 %image%
		If ErrorLevel = 0 ;Success
		{
			found_x := FoundX
			found_y := FoundY
		}
		return ErrorLevel ; set to 0 if the image was found in the specified region, 1 if it was not found, or 2 if there was a problem that prevented the command from conducting the search (such as failure to open the image file or a badly formatted option).
	}


cToolTip(msg) {
			ToolTip, %msg%
			SetTimer, RemoveToolTip, -5000 ; just visualisation for testing
	}

RemoveToolTip:
ToolTip
return

















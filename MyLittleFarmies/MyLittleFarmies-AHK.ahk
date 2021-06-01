	;TODO may set option for coordmode
	;TODO save settings

;###############################
;### GLOABLS
;###############################
CoordMode Pixel
CoordMode Mouse

global windowTitles:=["My Little Farmies","Forge of Empires - Mozilla Firefox","Forge of Empires - Google Chrome"]

global randSleepMin:=550
global randSleepMax:=650

global toolTipTimeout:=5000

;###############################
;### GUI
;###############################

OnExit handle_exit

	autoHelp:=0
	helpTimeOutNormal:=2500
	
	xhelpAdjust:=10
	yhelpAdjust:=10

	buttonImages:={"feedButton":"feed.png","feedButton2":"feed2.png","waterButton":"water.png","waterButton2":"water2.png","waterButton3":"water3.png","harvestButton":"harvest.png","harvestButton2":"harvest2.png","harvestButton3":"harvest3.png","harvestButton4":"harvest4.png","harvestButton5":"harvest5.png"}
	
	
  
  Gui,  +AlwaysOnTop  +Owner +Resize +ToolWindow ; window for the dock
  Gui, Show, NoActivate w400 h400 x1450 y150 , FOE-Auto-Functions
  Gui, Add, Edit, x15 y5 R1 vNeighborsCount Number , 77
  Gui, Add, Text, x50 y8  , number of neigbors
  Gui, Add, Checkbox,  x150 y8 vdoNeighbors, use?
  Gui, Add, Edit, x15 y25 R1 vGuildiesCount Number , 73
  Gui, Add, Text, x50 y28  , number of guildies
  Gui, Add, Checkbox,  x150 y28 vdoGuildies, use?
  Gui, Add, Edit, x15 y45 R1 vFriendsCount Number , 13
  Gui, Add, Text, x50 y48  , number of friends
  Gui, Add, Checkbox,  x150 y48 vdoFriends, use?
  ;Gui, Add, Edit, x15 y66 R1 vTabTitle Text , Forge of Empires - Google Chrome
  ;Gui, Add, Text, x225 y69, (window title of browser)
  Gui, Add, Text, x25 y95, to start auto Help use WIN+S
  Gui, Add, Text,, to stop auto functions use WIN+Q
  Gui, Add, Text,, to suspend script use PAUSE
  Gui, Add, Text,, to check color and coord under cursor(relative to active window) use WIN+C
  Gui, Add, Text, x25 y250 w80 vautoHelpState
  Gui, Add, Text, x25 y275 w400 vHelpedBluePrints
  Gui, Add, Text, x25 y300 w400 vcouldNotHelp
  Gui, Add, Text, x25 y325 w400 verrors cred
  ;init gui variables
  GuiControl,, autoHelpState , autoHelp OFF
  GuiControl,, doNeighbors , 1
  GuiControl,, doGuildies , 1
  GuiControl,, doFriends , 1
    
  hotkey , #s           	, startAutoHelp					;# is win-key
  hotkey , #q           	, endAutoHelp
  hotkey , ~LButton        	, pauseAutohelp					;pause srcipt while dragging
  hotkey , ~LButton UP		, activateAutohelp					;unpause script after drag
  hotkey , ~RButton        	, pauseScript
  hotkey , Pause        	, pauseScript
  ;following functions for debugging
  hotkey , #c        	  	, colortest
  hotkey , #t        	  	, testTest
  hotkey , #i        	  	, checkImages
return



testTest:
	test:=clickImage(buttonImages["waterButton"])
	;cLog(test)
	counter := 0
	while(autoHelp=1){
	 counter = %counter% + 1;
			sleep 1
			cLog(counter)
		}

return


checkImages:
for key,value in buttonImages
{
  IfNotExist, %value%
    MsgBox Error: %value% either doesn't exist or isn't in this location.
}
return


startAutoHelp:
if checkWindowActive()
{
	ToolTip, starting autoHelp
	SetTimer, RemoveToolTip, %toolTipTimeout%
	autoHelp:=1
	GuiControl,, autoHelpState , autoHelp ON
	
	GuiControlGet, NeighborsCount
	GuiControlGet, GuildiesCount
	GuiControlGet, FriendsCount
	GuiControlGet, doNeighbors
	GuiControlGet, doGuildies
	GuiControlGet, doFriends

		while(autoHelp=1){
			clickImage(buttonImages["waterButton"])
			clickImage(buttonImages["waterButton2"])
			clickImage(buttonImages["waterButton3"])
			clickImage(buttonImages["harvestButton"])
			clickImage(buttonImages["harvestButton2"])
			clickImage(buttonImages["harvestButton3"])
			clickImage(buttonImages["harvestButton4"])
			clickImage(buttonImages["harvestButton5"])
			clickImage(buttonImages["feedButton"])
			clickImage(buttonImages["feedButton2"])
		}
	autoHelp:=0
	GuiControl,, autoHelpState , autoHelp OFF

}
else
    cLog(%title% . "not active window")
return

checkWindowActive()
	{
	for i, title in windowTitles
		{
		if WinActive(title)
			{
			return 1 ; "true"
			}
		}
	return 0 ; "false" or simply not "1"
	}


RandSleep(RandSleepX,RandSleepY) {
	Random, randSleep, %RandSleepX%, %RandSleepY%
	Sleep %randSleep%
}

clickImage(image) {
	ret := findImage(image, FoundX, FoundY)
	cLog(testText)
		If ret = 0 ;Found image
		{
			if checkWindowActive() ; best to always check the active window before firing controls
			{			
			MouseMove, %FoundX%, %FoundY%
			MouseClick, left, %FoundX%, %FoundY% ; actual click on the target
			}
		}
	return ret
	}

findImage(image, ByRef found_x, ByRef found_y) {
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *90 %image%
		If ErrorLevel = 0 ;Success
		{
			found_x := FoundX
			found_y := FoundY
		}
		return ErrorLevel ; set to 0 if the image was found in the specified region, 1 if it was not found, or 2 if there was a problem that prevented the command from conducting the search (such as failure to open the image file or a badly formatted option).
	}

cLog(text)
	{
	;log in gui
	GuiControl,, errors , %text%
	;log on screen
	;cToolTip(%text%)
	}


colortest:
MouseGetPos, xpos, ypos 
PixelGetColor, posCol, %xpos%, %ypos%
GuiControl,, errors , color %posCol% at %xpos%, %ypos%
return 
  
endAutoHelp:
	autoHelp:=0
	GuiControl,, autoHelpState , autoHelp OFF
	ToolTip, ending autoHelp
	SetTimer, RemoveToolTip, %toolTipTimeout%
return

pauseAutohelp:
	autoHelp:=0
	GuiControl,, autoHelpState , autoHelp OFF
return

activateAutohelp:
	autoHelp:=1
	GuiControl,, autoHelpState , autoHelp ON
return

pauseScript:
	Suspend
return

cToolTip(msg) {
			ToolTip, %msg%
			SetTimer, RemoveToolTip, %toolTipTimeout%
	}

RemoveToolTip:
ToolTip
return

findAndClick(image,x1,y1,x2,y2,shade,xAdjust,yAdjust){
ImageSearch, FoundX, FoundY, %x1%, %y1%, %x2%, %y2%, *%shade% %image%
if ErrorLevel = 0
{
	Xadjusted:=FoundX+xAdjust
	Yadjusted:=FoundY+yAdjust
	Click left %Xadjusted%, %Yadjusted%
	MouseMove 0,0
}else if ErrorLevel = 2
	SetTimer endAutoHelp,0
	GuiControl,, errors , error in imageSearch : ending autofunctions 'n %image%
} 

GuiClose:
handle_exit:
   ToolTip
ExitApp
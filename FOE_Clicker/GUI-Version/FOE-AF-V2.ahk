	;TODO may set option for coordmode
	;TODO save settings
	;TODO set region(s) with gui
	;TODO PERSITENT ckeck shade/region/adjustvalues to correspond to right values

;###############################
;### GLOABLS
;###############################
CoordMode Pixel
CoordMode Mouse

global windowTitles:=["Forge of Empires - Mozilla Firefox","Forge of Empires - Google Chrome"]

global randSleepMin:=550
global randSleepMax:=650

global toolTipTimeout:=5000

;###############################
;### GUI
;###############################

OnExit handle_exit

	autoHelp:=0
	helpTimeOutNormal:=2500
	helpedBluePrintsCount:=0
	couldNotHelpCount:=0
	cnhFound:=0
	safeCountMax:=85
	
	allowedShadeNGF:=80
	helpShade:=10
	closeShade:=10
	noHelpShade:=10
	
	xhelpAdjust:=10
	yhelpAdjust:=10
	
	x1HelpRegion:=220
	y1HelpRegion:=820
	x2HelpRegion:=940
	y2HelpRegion:=990
	
	x1CloseRegion:=680
	y1CloseRegion:=710
	x2CloseRegion:=820
	y2CloseRegion:=750
	
	;buttonImages:={"nextButton":"nextButton.png","helpButton":"helpButton.png","closeButton":"closeButton.png","FriendButtonSelected":"FriendButtonSelected.png","guildButtonUnselected":"guildButtonUnselected.png","neighborButtonUnselected":"neighborButtonUnselected.png","firstLeftButton":"firstLeftButton.png"}
	buttonImages:={"nextButton":"nextButton.png","helpButton":"helpButton.png","closeButton":"closeButton.png","FriendButtonSelected":"FriendButtonSelected.png","guildButtonUnselected":"guildButtonUnselected.png","neighborButtonUnselected":"neighborButtonUnselected.png","firstLeftButton":"firstLeftButton.png"}
	
	
  
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
    
  hotkey , #s           , startAutoHelp					;# is win-key
  hotkey , #q           , endAutoHelp					;# is win-key
  hotkey , Pause        , pauseScript
  hotkey , #c        	  , colortest
  ;following functions for debugging
  hotkey , #t        	  , testTest
  hotkey , #i        	  , checkImages
return



testTest:
test:=clickImage(buttonImages["nextButton"])
cLog(test)
/*
autoHelp:=1
while autoHelp=1
{
MouseMove x1HelpRegion, y1HelpRegion
Sleep helpTimeOutNormal
MouseMove x2HelpRegion, y2HelpRegion
Sleep helpTimeOutNormal
findAndClick(buttonImages["firstLeftButton"], x1HelpRegion, y1HelpRegion, x2HelpRegion, y2HelpRegion, allowedShadeNGF, xhelpAdjust, yhelpAdjust)
Sleep helpTimeOutNormal
findAndClick(buttonImages["FriendButtonSelected"], x1HelpRegion, y1HelpRegion, x2HelpRegion, y2HelpRegion, allowedShadeNGF, xhelpAdjust, yhelpAdjust)
Sleep helpTimeOutNormal

/*

/*
findAndClick(buttonImages["neighborButtonUnselected"], x1HelpRegion, y1HelpRegion, x2HelpRegion, y2HelpRegion, allowedShadeNGF, xhelpAdjust, yhelpAdjust)
Sleep helpTimeOutNormal
volatileTooltip("1")
findAndClick(buttonImages["guildButtonUnselected"], x1HelpRegion, y1HelpRegion, x2HelpRegion, y2HelpRegion, allowedShadeNGF, xhelpAdjust, yhelpAdjust)
Sleep helpTimeOutNormal
volatileTooltip("2")


volatileTooltip("3")
if ErrorLevel = 2
    MsgBox Could not conduct the search.
else if ErrorLevel = 1
    MsgBox could not be found in the region
	
}
*/
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
checkImages:
for key,value in buttonImages
{
  IfNotExist, %value%
    MsgBox Error: %value% either doesn't exist or isn't in this location.
}
return


startAutoHelp:
IfWinActive, %title%
{
	ToolTip, starting autoHelp
	SetTimer, RemoveToolTip, %toolTipTimeout%
	autoHelp:=1
	cnhFound:=0
	GuiControl,, autoHelpState , autoHelp ON
	
	GuiControlGet, NeighborsCount
	GuiControlGet, GuildiesCount
	GuiControlGet, FriendsCount
	GuiControlGet, doNeighbors
	GuiControlGet, doGuildies
	GuiControlGet, doFriends
	if (doNeighbors=1){
		helped:=0
		safeCount:=0
		findAndClick(buttonImages["neighborButtonUnselected"], x1HelpRegion, y1HelpRegion, x2HelpRegion, y2HelpRegion, allowedShadeNGF, xhelpAdjust, yhelpAdjust)
		Sleep helpTimeOutNormal
		findAndClick(buttonImages["firstLeftButton"], x1HelpRegion, y1HelpRegion, x2HelpRegion, y2HelpRegion, allowedShadeNGF, xhelpAdjust, yhelpAdjust)
		Sleep helpTimeOutNormal
		while(helped<NeighborsCount && autoHelp=1 && safeCount<safeCountMax){
			safeCount++
			findAndClick(buttonImages["helpButton"], x1HelpRegion, y1HelpRegion, x2HelpRegion, y2HelpRegion, helpShade, xhelpAdjust, yhelpAdjust)
			Sleep helpTimeOutNormal
			if ErrorLevel = 0
			{	
				helped++
			}else if ErrorLevel = 1
			{	
				SetTimer, closeCheck, 0
				if (ErrorLevel = 0 && cnhFound=1)
				{	
					;to not stay in endless loop when somone got no helpclick --- 
					MsgBox, cnh found - helped: %helped%
					helped++
				}else if ErrorLevel = 1
				{
					findAndClick(buttonImages["nextButton"], x1HelpRegion, y1HelpRegion, x2HelpRegion, y2HelpRegion, allowedShadeNGF, xhelpAdjust, yhelpAdjust)
					Sleep helpTimeOutNormal
				}
			}
		
		}
	}
	MsgBox, helped %helped% safeCount %safeCount%
	
	
	
	
	findAndClick(buttonImages["guildButtonUnselected"], x1HelpRegion, y1HelpRegion, x2HelpRegion, y2HelpRegion, allowedShadeNGF, xhelpAdjust, yhelpAdjust)
Sleep helpTimeOutNormal

findAndClick(buttonImages["FriendButtonSelected"], x1HelpRegion, y1HelpRegion, x2HelpRegion, y2HelpRegion, allowedShadeNGF, xhelpAdjust, yhelpAdjust)
Sleep helpTimeOutNormal
}
else
    GuiControl,, errors , %title% not active window
return

checkBrowser()
	{
	for i, title in windowTitles
		{
		if WinActive(title)
			{
			return 1
			}
		}
	}

closeCheck:
;check for blueprint window		
		findAndClick(buttonImages["closeButton"], x1CloseRegion, y1CloseRegion, x2CloseRegion, y2CloseRegion, helpShade, xhelpAdjust, yhelpAdjust)
		if ErrorLevel = 0
		{
		Click left %xCloseExact%, %yCloseExact%
		helpedBluePrintsCount++
		GuiControl,, HelpedBluePrints , Helped BluePrints %helpedBluePrintsCount%
		Sleep %helpTimeOutNormal%
		}
; check for cant help
		;TODO make/include image
		findAndClick(buttonImages["closeButton"], x1CloseRegion, y1CloseRegion, x2CloseRegion, y2CloseRegion, helpShade, xhelpAdjust, yhelpAdjust)
		if ErrorLevel = 0
		{
		cnhFound:=1
		Click left %xHelpExact%, %yHelpExact%
		couldNotHelpCount++
		GuiControl,, couldNotHelp , people you could not help: %couldNotHelpCount%
		Sleep %helpTimeOutNormal%
		}
return

RandSleep(RandSleepX,RandSleepY) {
	Random, randSleep, %RandSleepX%, %RandSleepY%
	Sleep %randSleep%
}

clickImage(image) {
	ret := findImage(image, FoundX, FoundY)
		If ret = 0 ;Found image
		{
			if checkBrowser() ; best to always check the active window before firing controls
			{
			MouseClick, left, %FoundX%, %FoundY% ; actual click on the target
			cLog(%randSleepMin%)
			RandSleep(%randSleepMin%,%randSleepMax%)
			MouseClick, left, %FoundX%, %FoundY% ; click to close (possibly) opened window
			}
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

cLog(text)
	{
	;log in gui
	GuiControl,, errors , %text%
	;log on screen
	cToolTip(%text%)
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

GuiClose:
handle_exit:
   ToolTip
ExitApp
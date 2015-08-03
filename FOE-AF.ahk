OnExit handle_exit
	;set variables until and including neighborClickAddition for every system
	;TODO maybe implement some gui-stuff and save for variables
	;TODO implement lopplength for different guild/frinedNeighbor
  title:="Forge of Empires - Mozilla Firefox"
  xNeighborGuildFriend:=750
  yNeighborGuildFriend:=850
  xNeighborGuildFriendClickAddition:=65
  xNeigborReset:=250
  yNeigborReset:=960
  xNeighborStart:=220
  yNeighborStart:=980
  xNeighborNext:=920
  yNeighborNext:=925
  xCloseExact:=744
  yCloseExact:=743
  closeColor:=0xCCFDE4
  xHelpExact:=625
  yHelpExact:=578
  helpColor:=0x205092
  neighborClickAddition:=100
  
  
  autoCollect:=0
  toolTipTimeout:=1000
  collectTimeOutNormal:=2500
  innerClickCountFinal:=5
  collectedBluePrintsCount:=0
  couldNotHelpCount:=0
  
  Gui,  +AlwaysOnTop  +Owner +Resize +ToolWindow ; window for the dock
  Gui, Show, NoActivate w400 h400 x300 y50 , FOE-Auto-Functions
  Gui, Add, Edit, x15 y5 R1 vNeighborCount Number , 80
  Gui, Add, Text, x50 y10  , number of neigbors
  Gui, Add, Edit, x15 y25 R1 vGuildiesCount Number , 80
  Gui, Add, Text, x50 y30  , number of guildies
  Gui, Add, Edit, x15 y45 R1 vFriendsCount Number , 13
  Gui, Add, Text, x50 y50  , number of friends
  Gui, Add, Text, x25 y75, to start auto collect use WIN+S
  Gui, Add, Text,, to end auto collect use WIN+Q
  Gui, Add, Text,, to suspend script use PAUSE
  Gui, Add, Text,, to check color and coord under cursor(relative to active window) use WIN+C
  Gui, Add, Text, x25 y250 w80 vautoCollectState
  Gui, Add, Text, x25 y275 w80 vcollectedBluePrints
  Gui, Add, Text, x25 y300 w80 vcouldNotHelp
  Gui, Add, Text, x25 y325 w400 verrors cred
  GuiControl,, autoCollectState , autocollect OFF
    
  hotkey , #s           , startAutoCollect					;# is win-key
  hotkey , #q           , endAutoCollect					;# is win-key
  hotkey , Pause        , pauseScript
  hotkey , #c        	  , colortest
  hotkey , #t        	  , testTest
  
return
testTest:
autoCollect:=1
while autoCollect=1
{
IfNotExist, C:\FOE-Stuff\helpButton.png
    MsgBox Error: Your file either doesn't exist or isn't in this location.
Sleep 1000
CoordMode Pixel  ; Interprets the coordinates below as relative to the screen rather than the active window.
ImageSearch, FoundX, FoundY, 80, 130, 1000, 990, *5 C:\FOE-Stuff\closeButton.png
if ErrorLevel = 2
    MsgBox Could not conduct the search.
else if ErrorLevel = 1
    MsgBox Icon could not be found on the screen.
else
    MsgBox The icon was found at %FoundX%x%FoundY%
}
return

startAutoCollect:
IfWinActive, %title%
{
	ToolTip, starting autocollect
	SetTimer, RemoveToolTip, %toolTipTimeout%
	autoCollect:=1
	GuiControl,, autoCollectState , autocollect ON
	GuiControlGet, NeighborCount
	outerClickCount:=Floor(NeighborCount/5) + 1
	innerClickCount:=innerClickCountFinal
	loop 3
	{
		xPosCalc:=xNeighborGuildFriend+((A_Index-1) * xNeighborGuildFriendClickAddition)
		Click left %xPosCalc%, %yNeighborGuildFriend%
		Sleep %collectTimeOutNormal%
		
		Click left %xNeigborReset%, %yNeigborReset%
		Sleep %collectTimeOutNormal%
		while outerClickCount >= 1
		{	
			if autoCollect = 0 
			{	
				GuiControl,, autoCollectState , autocollect OFF
				break
			}	
			while innerClickCount >= 1
			{	
				if autoCollect = 0  
				{
					GuiControl,, autoCollectState , autocollect OFF
					break
				}
				SetTimer, closeCheck, 0
				xPosCalc:=xNeighborStart+(innerClickCount*neighborClickAddition)
				Sleep %collectTimeOutNormal%
				Click left %xPosCalc%, %yNeighborStart%
				MouseMove, 0, 0			
				innerClickCount:=innerClickCount-1
			}	
			Sleep %collectTimeOutNormal%
			Click left %xNeighborNext%, %yNeighborNext%
			innerClickCount:=innerClickCountFinal
			outerClickCount:=outerClickCount-1
		}	
	}
}
else
    GuiControl,, errors , %title% not active window
return

closeCheck:
;check for blueprint window
		PixelGetColor, OutputVar, %xCloseExact%, %yCloseExact%
		if OutputVar=%closeColor%
		{
		Click left %xCloseExact%, %yCloseExact%
		collectedBluePrintsCount++
		GuiControl,, collectedBluePrints , collected BluePrints %collectedBluePrintsCount%
		Sleep %collectTimeOutNormal%
		}
;first check for cant help
		PixelGetColor, OutputVar, %xHelpExact%, %yHelpExact%
		if OutputVar=%helpColor%
		{
		Click left %xHelpExact%, %yHelpExact%
		couldNotHelpCount++
		GuiControl,, couldNotHelp , people you could not help: %couldNotHelpCount%
		Sleep %collectTimeOutNormal%
		}
return

colortest:
MouseGetPos, xpos, ypos 
PixelGetColor, posCol, %xpos%, %ypos%
GuiControl,, errors , color %posCol% at %xpos%, %ypos%
return 
  
endAutoCollect:
	autoCollect:=0
	GuiControl,, autoCollectState , autocollect OFF
	ToolTip, ending autocollect
	SetTimer, RemoveToolTip, %toolTipTimeout%
return

pauseScript:
	Suspend
return

RemoveToolTip:
	SetTimer, RemoveToolTip, Off
	ToolTip
return

GuiClose:
handle_exit:
   ToolTip
ExitApp
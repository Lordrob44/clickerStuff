clickRotationAktive:=1
toolTipTimeout:=1000
CoordMode pixel
CoordMode Mouse
Pause::Suspend

clicker:
if clickRotationAktive=1
	{
		Click 1
	}
return

RButton::
	Click right
	#Persistent
SetTimer, clicker, 1
return

MButton::
	Click middle
	if clickRotationAktive=1
	{
		clickRotationAktive:=0
		ToolTip, ClickRotation 0
		SetTimer, RemoveToolTip, %toolTipTimeout%
		SetTimer, clicker, Off
	}
	else
	{
		clickRotationAktive:=1
		ToolTip, ClickRotation 1
		SetTimer, RemoveToolTip, %toolTipTimeout%
	}
return

#a::
	clickRotationAktive=1
	ToolTip, autocollecting
	while clickRotationAktive=1
	{
	IfWinActive, Time Clickers
	 {
		ImageSearch, FoundX, FoundY, 350, 170, 950, 950, *5 yellow.png
		if ErrorLevel = 0
		{
			Xadjusted:=FoundX+5
			Yadjusted:=FoundY+5
			loop 10
			Click left %Xadjusted%, %Yadjusted%
		}else if ErrorLevel = 1
		{		
			ImageSearch, FoundX, FoundY, 350, 170, 950, 950, *5 red.png
			if ErrorLevel = 0
			{
				Xadjusted:=FoundX+5
				Yadjusted:=FoundY+5			
				loop 10
				Click left %Xadjusted%, %Yadjusted%
			}
			if ErrorLevel = 1
			{
			ImageSearch, FoundX, FoundY, 350, 170, 950, 950, *5 white.png
			if ErrorLevel = 0
				{
					Xadjusted:=FoundX+5
					Yadjusted:=FoundY+5
					loop 10
					Click left %Xadjusted%, %Yadjusted%
				}
			}
		}		
	 send 1
	 send 2
	 send 3
	 send 4
	 send 5
	 send 6
	 send 7
	 send 8
	 send 9
	 send 0
	 send s
	 send d
	 send a
	 send f
	 send g
	}
	}
	
return
#e:: ExitApp

;########functions
RemoveToolTip:
	SetTimer, RemoveToolTip, Off
	ToolTip
return
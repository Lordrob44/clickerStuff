Suspend
clickRotationAktive:=1
toolTipTimeout:=1000


Pause::Suspend


RButton::
	Click right
	while clickRotationAktive=1
	{
		ToolTip, Clicking 1 times every 1 ms
		Click 1
		sleep 1
	}
return
MButton::
	Click middle
	if clickRotationAktive=1
	{
		clickRotationAktive:=0
		ToolTip, ClickRotation 0
		SetTimer, RemoveToolTip, %toolTipTimeout%
	}
	else
	{
		clickRotationAktive:=1
		ToolTip, ClickRotation 1
		SetTimer, RemoveToolTip, %toolTipTimeout%
	}
return



;########functions
RemoveToolTip:
	SetTimer, RemoveToolTip, Off
	ToolTip
return
#include<GuiButton.au3>
#include<GuiToolBar.au3>
#include<GuiConstantsEx.au3>
#include <Misc.au3>
#include <Array.au3>
#include <File.au3>
#include <GDIPlus.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

HotKeySet("{ESC}", "stop")
Opt('MouseCoordMode', 0)
Opt("GUIOnEventMode",1)

dim $ml[16][16]
dim $path[16][16]
dim $pos[2]
dim $oldpos[2]
$oldpos[0]=0
$oldpos[1]=0
$posx=0
$posy=0
$oldposx=0
$oldposy=0
$state=0
$prevm=0
$prevback=0
$prevb=0
$exit=0
dim $p[2]

$hGUI=GUICreate("gazepath", 640,480,(@DesktopWidth-640)/3,(@DesktopHeight-480)/3)
GUISetFont(22,400,0,"MS Sans Serif")
GUISetOnEvent($GUI_EVENT_CLOSE, "stop")

Global $hImage, $hGraphic, $hImage1
; Load PNG image
_GDIPlus_Startup()
$hippol = _GDIPlus_ImageLoadFromFile(@WorkingDir &"\pic\hippo-l.png")
$hippor = _GDIPlus_ImageLoadFromFile(@WorkingDir &"\pic\hippo-r.png")
$well = _GDIPlus_ImageLoadFromFile(@WorkingDir &"\pic\well.png")
$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)

$pic = guictrlcreatepic(@WorkingDir &"\pic\menu.jpg", 0, 0,640,480)
$back = guictrlcreatepic(@WorkingDir &"\pic\brownback.jpg", 10, 420,47,50)
$right = guictrlcreatepic(@WorkingDir &"\pic\r1.jpg", 480, 0,160,480)
$b = guictrlcreatepic(@WorkingDir &"\pic\b1.jpg", 485, 432,66,48)
GUICtrlSetState($back,$GUI_HIDE)
GUICtrlSetState($right,$GUI_HIDE)
GUICtrlSetState($b,$GUI_HIDE)
GUISetState(@SW_SHOW)

While 1
	$p=MouseGetPos()
	If $state=0 Then
		$m=getP()
		if $m<>$prevm Then
			$prevm=$m
			if $m=0 Then
				GUICtrlSetImage($pic,@WorkingDir &"\pic\menu.jpg")
			ElseIf $m=1 Then
				GUICtrlSetImage($pic,@WorkingDir &"\pic\menu-1.jpg")
			ElseIf $m=2 Then
				GUICtrlSetImage($pic,@WorkingDir &"\pic\menu-2.jpg")
			ElseIf $m=3 Then
				GUICtrlSetImage($pic,@WorkingDir &"\pic\menu-3.jpg")
			ElseIf $m=4 Then
				GUICtrlSetImage($pic,@WorkingDir &"\pic\menu-4.jpg")
			EndIf
		EndIf
		If _IsPressed("01") Then
			If $m=1 Then
				$state=1
				GUICtrlSetImage($pic,@WorkingDir &"\pic\menu.jpg")
			ElseIf $m=3 Then
				$state=3
				GUICtrlSetImage($pic,@WorkingDir &"\pic\menu.jpg")
			ElseIf $m=2 Then
				$state=2
				GUICtrlSetImage($pic,@WorkingDir &"\pic\help1.jpg")
				GUICtrlSetState($back,$GUI_SHOW)
			ElseIf $m=4 Then
				$state=4
				GUICtrlSetImage($pic,@WorkingDir &"\pic\credit.jpg")
				GUICtrlSetState($back,$GUI_SHOW)
			EndIf
		EndIf
	ElseIf $state=1 Then
		GUICtrlSetState($pic,$GUI_HIDE)
		$exit=0
		play(1)
	ElseIf $state=2 Then
		If $p[0]>14 And $p[0]<59 And $p[1]>449 And $p[1]<487 And $prevback=0 Then
			GUICtrlSetImage($back,@WorkingDir &"\pic\greenback.jpg")
			$prevback=1
		ElseIf $prevback=1 And Not ($p[0]>14 And $p[0]<59 And $p[1]>449 And $p[1]<487) Then
			GUICtrlSetImage($back,@WorkingDir &"\pic\brownback.jpg")
			$prevback=0
		EndIf
		If $p[0]>14 And $p[0]<59 And $p[1]>449 And $p[1]<487 And _IsPressed("01") Then
			$state=0
			GUICtrlSetState($back,$GUI_HIDE)
			GUICtrlSetImage($back,@WorkingDir &"\pic\brownback.jpg")
			$prevback=0
			GUICtrlSetImage($pic,@WorkingDir &"\pic\menu.jpg")
		EndIf
	ElseIf $state=3 Then
		GUICtrlSetState($pic,$GUI_HIDE)
		$exit=0
		play(0)
	ElseIf $state=4 Then
		If $p[0]>14 And $p[0]<59 And $p[1]>449 And $p[1]<487 And $prevback=0 Then
			GUICtrlSetImage($back,@WorkingDir &"\pic\greenback.jpg")
			$prevback=1
		ElseIf $prevback=1 And Not ($p[0]>14 And $p[0]<59 And $p[1]>449 And $p[1]<487) Then
			GUICtrlSetImage($back,@WorkingDir &"\pic\brownback.jpg")
			$prevback=0
		EndIf
		If $p[0]>14 And $p[0]<59 And $p[1]>449 And $p[1]<487 And _IsPressed("01") Then
			$state=0
			GUICtrlSetState($back,$GUI_HIDE)
			GUICtrlSetImage($back,@WorkingDir &"\pic\brownback.jpg")
			$prevback=0
			GUICtrlSetImage($pic,@WorkingDir &"\pic\menu.jpg")
		EndIf
	EndIf
WEnd

Func getP()
	If $state=0 Then
		If $p[0]>56 And $p[0]<297 And $p[1]>221 And $p[1]<279 Then
			return 1
		ElseIf $p[0]>56 And $p[0]<297 And $p[1]>328 And $p[1]<383 Then
			return 2
		ElseIf $p[0]>340 And $p[0]<583 And $p[1]>221 And $p[1]<279 Then
			return 3
		ElseIf $p[0]>340 And $p[0]<583 And $p[1]>328 And $p[1]<383 Then
			return 4
		EndIf
	EndIf
	return 0
EndFunc

Func play($mode)
	generator($mode)
	buildMaze($mode)
	$oldpos[0]=0
	$oldpos[1]=0
	$posx=0
	$posy=0
	$oldposx=0
	$oldposy=0
	$state=0
	$prevback=0
	$exit=0
	$prevb=0
	_GDIPlus_GraphicsDrawImageRect($hGraphic, $hippor, $posx,$posy,30,30)
	MouseMove(20,50,0)
	While 1
		walk(0,$mode)
		walk(1,$mode)
		if $exit=1 Then
			GUICtrlSetImage($right,@WorkingDir &"\pic\r2.jpg")
			walk(0,$mode)
			walk(1,$mode)
			walk(0,$mode)
			walk(1,$mode)
			walk(0,$mode)
			walk(1,$mode)
			walk(0,$mode)
			walk(1,$mode)
			walk(0,$mode)
			walk(1,$mode)
			walk(0,$mode)
			walk(1,$mode)
			walk(0,$mode)
			walk(1,$mode)
			hideMaze($mode)
			GUICtrlSetState($pic,$GUI_SHOW)
			$state=0
			GUICtrlSetImage($b,@WorkingDir &"\pic\b1.jpg")
			ExitLoop
		ElseIf $exit=2 Then
			hideMaze($mode)
			GUICtrlSetState($pic,$GUI_SHOW)
			$state=0
			GUICtrlSetImage($b,@WorkingDir &"\pic\b1.jpg")
			ExitLoop
		EndIf
	WEnd
EndFunc

Func resetBlock($maze_size)
	If $maze_size=0 Then
		$size=15
	Else
		$size=7
	EndIf
		redraw($pos[0],$pos[1],$maze_size)
		If $pos[1]>0 Then
			redraw($pos[0],$pos[1]-1,$maze_size)
		EndIf
		If $pos[1]<$size Then
			redraw($pos[0],$pos[1]+1,$maze_size)
		EndIf
		If $pos[0]>0 Then
			redraw($pos[0]-1,$pos[1],$maze_size)
		EndIf
		If $pos[0]<$size Then
			redraw($pos[0]+1,$pos[1],$maze_size)
		EndIf
		If $pos[0]<$size And $pos[1]<$size Then
			redraw($pos[0]+1,$pos[1]+1,$maze_size)
		EndIf
		If $pos[0]<$size And $pos[1]>0 Then
			redraw($pos[0]+1,$pos[1]-1,$maze_size)
		EndIf
		If $pos[0]>0 And $pos[1]<$size Then
			redraw($pos[0]-1,$pos[1]+1,$maze_size)
		EndIf
		If $pos[0]>0 And $pos[1]>0 Then
			redraw($pos[0]-1,$pos[1]-1,$maze_size)
		EndIf
EndFunc

Func redraw($i,$j,$maze_size)
	If $maze_size=0 Then
		if $ml[$j][$i]=0 Then
			GUICtrlSetImage($path[$j][$i],@WorkingDir &"\pic\wall_s.jpg")
		Else
			GUICtrlSetImage($path[$j][$i],@WorkingDir &"\pic\path_s.jpg")
		EndIf
	Else
		if $ml[$j][$i]=0 Then
			GUICtrlSetImage($path[$j][$i],@WorkingDir &"\pic\wall_l.jpg")
		Else
			GUICtrlSetImage($path[$j][$i],@WorkingDir &"\pic\path_l.jpg")
		EndIf
	EndIf
	if ($j=15 And $i=15 And $maze_size=0) Or ($j=7 And $i=7 And $maze_size=1) Or ($i=0 And $j=0) Then
		_GDIPlus_GraphicsDrawImageRect($hGraphic, $well, 450,450,30,30)
	EndIf
EndFunc

Func region($x,$y,$maze_size)
	$size=7
	$xsize=60
	If $maze_size=0 Then
		$size=15
		$xsize=30
	EndIf
		$pos[0]=Int(($x+18)/$xsize)
		$pos[1]=Int(($y+26)/$xsize)
		if $pos[0]<0 Then
			$pos[0]=0
		EndIf
		if $pos[1]<0 Then
			$pos[1]=0
		EndIf
		if $pos[0]>$size Then
			$pos[0]=$size
		EndIf
		if $pos[1]>$size Then
			$pos[1]=$size
		EndIf
EndFunc

Func walk($direction,$size)
	$p=MouseGetPos()
	If $p[0]>497 And $p[0]<542 And $p[1]>469 And $p[1]<491 And $prevb=0 Then
		GUICtrlSetImage($b,@WorkingDir &"\pic\b2.jpg")
		$prevb=1
	ElseIf Not($p[0]>497 And $p[0]<542 And $p[1]>469 And $p[1]<491) And $prevb=1 Then
		GUICtrlSetImage($b,@WorkingDir &"\pic\b1.jpg")
		$prevb=0
	EndIf
	If $p[0]>497 And $p[0]<542 And $p[1]>469 And $p[1]<491 And _IsPressed("01") Then
		$exit=2
	EndIf
	resetBlock($size)
	$posx=MouseGetPos(0)-20
	$posy=MouseGetPos(1)-50
	region($posx,$posy,$size)
	If $size=0 And $pos[0]=15 And $pos[1]=15 And $oldpos[0]>=14 And $oldpos[1]>=14 Then
		$exit=1
	ElseIf $size=1 And $pos[0]=7 And $pos[1]=7 And $oldpos[0]>=6 And $oldpos[1]>=6 Then
		$exit=1
	EndIf
	If $ml[$pos[1]][$pos[0]]=1 And Abs($oldpos[0]-$pos[0])<=2 And  Abs($oldpos[1]-$pos[1])<=2 And $posx<454 Then
		if $direction=0 Then
			_GDIPlus_GraphicsDrawImageRect($hGraphic, $hippol, $posx,$posy,30,30)
		Else
			_GDIPlus_GraphicsDrawImageRect($hGraphic, $hippor, $posx,$posy,30,30)
		EndIf
		$oldposx=$posx
		$oldposy=$posy
		$oldpos[0]=$pos[0]
		$oldpos[1]=$pos[1]
	Else
		if $direction=0 Then
			_GDIPlus_GraphicsDrawImageRect($hGraphic, $hippol, $oldposx,$oldposy,30,30)
		Else
			_GDIPlus_GraphicsDrawImageRect($hGraphic, $hippor, $oldposx,$oldposy,30,30)
		EndIf
		$pos[0]=$oldpos[0]
		$pos[1]=$oldpos[1]
	EndIf
	sleep(100)
EndFunc

Func generator($maze_size)
	$x=16
	$y=16
	if $maze_size=1 Then
		$x=8
		$y=8
	EndIf
	$prev=0
	For $i=0 to $x-3 Step 1
		if Abs($prev<20 And $prev>=0) Then	;straight
			$rand=Random (0,$y-1,1)
			$prev=color($i,$prev,$rand,$y)
		ElseIf $prev>=20 Then	;down
			$prev=$prev-20
			If $prev=$y-1 Then
				$rand=$y-1
			Else
				$rand=Random($prev,$y-1,1)
			EndIf
			$prev=color($i,$prev,$rand,$y)
		Else										;up
			$prev=(-1)*($prev+20)
			If $prev=0 Then
				$rand=0
			Else
				$rand=Random(0,$prev,1)
			EndIf
			$prev=color($i,$prev,$rand,$y)
		EndIf
	Next
	If $prev>=20 Then
		$prev=$prev-20
	ElseIf $prev<0 Then
		$prev=(-1)*($prev+20)
	EndIf
	$prev=color($i,$prev,$prev,$y)
	color($i+1,$prev,$y-1,$y)
EndFunc

Func color($i,$prev,$rand,$y)
	$flag=0
	if $prev>$rand Then
		$tmp=$rand
		$rand=$prev
		$prev=$tmp
		$flag=1
	EndIf
	For $j=0 to $prev-1 Step 1
		$ml[$j][$i]=0
	Next
	For $j=$prev to $rand Step 1
		$ml[$j][$i]=1
	Next
	For $j=$rand+1 to $y-1 Step 1
		$ml[$j][$i]=0
	Next
	If $rand<$prev  Then
		If $flag=0 Then
			$prev=(-1)*$rand-20
		Else
			$prev=$prev+20
		EndIf
	ElseIf $rand>$prev Then
		If $flag=0 Then
			$prev=$rand+20
		Else
			$prev=(-1)*$prev-20
		EndIf
	EndIf
	return $prev
EndFunc

Func buildMaze($maze_size)
	$x=16
	$y=16
	if $maze_size=1 Then
		$x=8
		$y=8
	EndIf
	For $i=0 to $y-1 Step 1
		For $j=0 to $x-1 Step 1
			If $ml[$i][$j]=0 Then
				If $maze_size=0 Then
					$path[$i][$j]=guictrlcreatepic(@WorkingDir &"\pic\wall_s.jpg", $j*30,$i*30,30,30)
				ElseIf $maze_size=1 Then
					$path[$i][$j]=guictrlcreatepic(@WorkingDir &"\pic\wall_l.jpg", $j*60,$i*60,60,60)
				EndIf
			ElseIf $ml[$i][$j]=1 Then
				If $maze_size=0 Then
					$path[$i][$j]=guictrlcreatepic(@WorkingDir &"\pic\path_s.jpg", $j*30,$i*30,30,30)
				ElseIf $maze_size=1 Then
					$path[$i][$j]=guictrlcreatepic(@WorkingDir &"\pic\path_l.jpg", $j*60,$i*60,60,60)
				EndIf
			EndIf
			GUICtrlSetState($path[$i][$j],$GUI_SHOW)
		Next
	Next
	GUICtrlSetImage($right,@WorkingDir &"\pic\r1.jpg")
	GUICtrlSetState($right,$GUI_SHOW)
	GUICtrlSetState($b,$GUI_SHOW)
	_GDIPlus_GraphicsDrawImageRect($hGraphic, $well, 450,450,30,30)
EndFunc

Func hideMaze($maze_size)
	$x=16
	$y=16
	if $maze_size=1 Then
		$x=8
		$y=8
	EndIf
	For $i=0 to $y-1 Step 1
		For $j=0 to $x-1 Step 1
			GUICtrlSetState($path[$i][$j],$GUI_HIDE)
		Next
	Next
	GUICtrlSetState($right,$GUI_HIDE)
	GUICtrlSetState($b,$GUI_HIDE)
EndFunc

Func stop()
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_ImageDispose($hippor)
	_GDIPlus_ImageDispose($hippol)
	_GDIPlus_ImageDispose($well)
	_GDIPlus_Shutdown()
    Exit
EndFunc
#include<GuiButton.au3>
#include<GuiToolBar.au3>
#include<GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>
#include <Array.au3>
#include <File.au3>
#include <WinAPI.au3>
#include <GDIPlus.au3>
;HotKeySet("{ESC}", "stop")
;layout 449x101, buttons 14x5
$file = FileOpen("inputOther.txt", 0)
$other = FileReadLine($file)
FileClose($file)
$px=(char($other,1)-4)*40
$py=(char($other,0)-4)*30
$hwnd=WinGetHandle("[ACTIVE]")
$setting=3
$kbwidth=449
$kbheight=101
$button_sizex=33
$button_sizey=21
$button_posx=32
$button_posy=20
if $setting=1 then
   $kbwidth=309
   $kbheight=71
   $button_sizex=23
   $button_sizey=15
   $button_posx=22
   $button_posy=14
elseif $setting=2 then
   $kbwidth=449
   $kbheight=101
   $button_sizex=33
   $button_sizey=21
   $button_posx=32
   $button_posy=20
elseif $setting=3 Then
   $kbwidth=589
   $kbheight=131
   $button_sizex=43
   $button_sizey=27
   $button_posx=42
   $button_posy=26
EndIf
$inputx=MouseGetPos(0)+$px
$inputy=MouseGetPos(1)+$py
;generate gui
if($inputx<0) Then
   $inputx=0
EndIf
if($inputy<0) Then
   $inputx=0
EndIf
if($inputx>@DesktopWidth-$kbwidth) Then
   $inputx=@DesktopWidth-$kbwidth
EndIf
if($inputy>@DesktopHeight-$kbheight) Then
   $inputy=@DesktopHeight-$kbheight
EndIf
$hGUI=GuiCreate("osk_nsc", $kbwidth,$kbheight,$inputx,$inputy,0x80000000,BitOR($WS_EX_TOOLWINDOW, $WS_EX_TOPMOST, 0x08000000))
WinSetOnTop("osk_nsc", "", 1)
GUISetState(@SW_SHOW)
;generate gdi
_GDIPlus_Startup()
$h11=0
$h12=0
$h13=0
$h21=0
$h22=0
$h23=0
$h31=0
$h32=0
$h33=0
if $setting=1 Then
   $h11=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\s11.jpg")
   $h12=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\s12.jpg")
   $h13=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\s13.jpg")
   $h14=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\s14.jpg")
   $h21=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\s21.jpg")
   $h22=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\s22.jpg")
   $h23=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\s23.jpg")
   $h24=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\s24.jpg")
   $h31=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\s31.jpg")
   $h32=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\s32.jpg")
   $h33=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\s33.jpg")
   $h34=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\s34.jpg")
ElseIf $setting=2 Then
   $h11=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\m11.jpg")
   $h12=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\m12.jpg")
   $h13=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\m13.jpg")
   $h14=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\m14.jpg")
   $h21=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\m21.jpg")
   $h22=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\m22.jpg")
   $h23=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\m23.jpg")
   $h24=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\m24.jpg")
   $h31=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\m31.jpg")
   $h32=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\m32.jpg")
   $h33=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\m33.jpg")
   $h34=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\m34.jpg")
ElseIf $setting=3 Then
   $h11=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\l11.jpg")
   $h12=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\l12.jpg")
   $h13=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\l13.jpg")
   $h14=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\l14.jpg")
   $h21=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\l21.jpg")
   $h22=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\l22.jpg")
   $h23=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\l23.jpg")
   $h24=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\l24.jpg")
   $h31=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\l31.jpg")
   $h32=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\l32.jpg")
   $h33=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\l33.jpg")
   $h34=_GDIPlus_BitmapCreateFromFile(@WorkingDir &"\kb_layout\l34.jpg")
EndIf
$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hGUI)
_GDIPlus_GraphicsDrawImage($hGraphic, $h21, 0, 0)
$hClone = 0
WinActivate($hwnd)
;main
$prevx=-1
$prevy=-1
$language=1
$shift_state=0
$ctrl_state=0
$alt_state=0
while 1
   $x=Int((MouseGetPos(0)-$inputx)/$button_posx)
   $y=Int((MouseGetPos(1)-$inputy)/$button_posy)
   if ($x=12 And $y=2) Or ($x=13 And $y=2) Then
	  $x=12
   ElseIf ($x>=3 And $x<=7) And $y=4 Then
	  $x=3
   EndIf
   if $prevx<>$x Or $prevy<>$y Then
	  draw_part(3,$x,$y)
	  if $prevx<>-1 And Not ((($prevx=0 And $prevy=3) Or ($prevx=11 And $prevy=3)) And $shift_state=1) And Not ((($prevx=0 And $prevy=4) Or ($prevx=10 And $prevy=4)) And $ctrl_state=1) And Not ((($prevx=2 And $prevy=4) Or ($prevx=8 And $prevy=4)) And $alt_state=1)  Then
		 draw_part(2,$prevx,$prevy)
	  EndIf
	  $prevx=$x
	  $prevy=$y
   EndIf
   if _IsPressed(01) Then
	   type($x,$y)
	   draw_part(1,$x,$y)
	   sleep(120)
	   draw_part(3,$x,$y)
	  if $shift_state=0 Then
		  draw_part(2,0,3)
		  draw_part(2,11,3)
	  EndIf
	  If $alt_state=0 Then
		  draw_part(2,2,4)
		  draw_part(2,8,4)
	  EndIf
	  If $ctrl_state=0 Then
		  draw_part(2,0,4)
		  draw_part(2,10,4)
	  EndIf
	EndIf
   sleep(1)
WEnd

Func type($cx,$cy)
	;check ctrl,shift,alt
	$skip=0
	If $shift_state=1 Then
		if Not (($cx=0 And $cy=3) Or ($cx=11 And $cy=3) Or ($cx=0 And $cy=4) Or ($cx=10 And $cy=4) Or ($cx=2 And $cy=4) Or ($cx=8 And $cy=4)) Then
			$shift_state=0
			Send("{shiftup}")
		ElseIf ($cx=2 And $cy=4) Or ($cx=8 And $cy=4) Then
			$shift_state=0
			Send("{shiftup}")
			if $language=1 or $language=-1 Then
				$language=$language*2
			ElseIf $language=2 or $language=-2 Then
				$language=$language/2
			EndIf
			if $language=1 Then
				_GDIPlus_GraphicsDrawImage($hGraphic, $h21, 0, 0)
			ElseIf $language=-1 Then
				_GDIPlus_GraphicsDrawImage($hGraphic, $h22, 0, 0)
			ElseIf $language=2 Then
				_GDIPlus_GraphicsDrawImage($hGraphic, $h23, 0, 0)
			ElseIf $language=-2 Then
				_GDIPlus_GraphicsDrawImage($hGraphic, $h24, 0, 0)
			EndIf
			$alt_state=0
			Send("{altup}")
			sleep(100)
			$skip=1
		EndIf
	EndIf
	If $ctrl_state=1 Then
		If Not (($cx=0 And $cy=3) Or ($cx=11 And $cy=3) Or ($cx=0 And $cy=4) Or ($cx=10 And $cy=4) Or ($cx=2 And $cy=4) Or ($cx=8 And $cy=4)) Then
			$ctrl_state=0
			Send("{ctrlup}")
		EndIf
	EndIf
	If $alt_state=1 Then
		If Not (($cx=0 And $cy=3) Or ($cx=11 And $cy=3) Or ($cx=0 And $cy=4) Or ($cx=10 And $cy=4) Or ($cx=2 And $cy=4) Or ($cx=8 And $cy=4)) Then
			$alt_state=0
			Send("{altup}")
		EndIf
	EndIf
	;special keys
	if $skip=0 then
		if $cx=0 And $cy=0 Then
			Send("{ESC}")
		ElseIf $cx=0 And $cy=1 Then
			Send("{Tab}")
		ElseIf $cx=0 And $cy=2 Then
			$language=$language*(-1)
			if $language=1 Then
				_GDIPlus_GraphicsDrawImage($hGraphic, $h21, 0, 0)
			ElseIf $language=-1 Then
				_GDIPlus_GraphicsDrawImage($hGraphic, $h22, 0, 0)
			ElseIf $language=2 Then
				_GDIPlus_GraphicsDrawImage($hGraphic, $h23, 0, 0)
			ElseIf $language=-2 Then
				_GDIPlus_GraphicsDrawImage($hGraphic, $h24, 0, 0)
			EndIf
			sleep(100)
		ElseIf ($cx=0 Or $cx=11) And $cy=3 Then
			if $shift_state=0 Then
				Send("{shiftdown}")
				$shift_state=1
			Else
				Send("{shiftup}")
				$shift_state=0
			EndIf
		ElseIf ($cx=0 Or $cx=10) And $cy=4 Then
			if $ctrl_state=0 Then
				Send("{ctrldown}")
				$ctrl_state=1
			Else
				Send("{ctrlup}")
				$ctrl_state=0
			EndIf
		ElseIf ($cx=1 Or $cx=9) And $cy=4 Then
			Send("{lwin}")
		ElseIf ($cx=2 Or $cx=8) And $cy=4 Then
			if $alt_state=0 Then
				Send("{altdown}")
				$alt_state=1
			Else
				Send("{altup}")
				$alt_state=0
			EndIf
		ElseIf $cx=3 And $cy=4 Then
			Send("{Space}")
		ElseIf $cx=11 And $cy=4 Then
			Send("{Left}")
		ElseIf $cx=12 And $cy=4 Then
			Send("{Down}")
		ElseIf $cx=13 And $cy=4 Then
			Send("{Right}")
		ElseIf $cx=12 And $cy=3 Then
			Send("{Up}")
		ElseIf $cx=13 And $cy=2 Then
			Send("{Del}")
		ElseIf $cx=12 And $cy=2 Then
			Send("{Enter}")
		ElseIf $cx=13 And $cy=0 Then
			Send("{BS}")
		;normal keys
	   Elseif $language=1 Then
			if $cx=1 And $cy=0 Then
				Send("1")
			ElseIf $cx=2 And $cy=0 Then
				Send("2")
			ElseIf $cx=3 And $cy=0 Then
				Send("3")
			ElseIf $cx=4 And $cy=0 Then
				Send("4")
			ElseIf $cx=5 And $cy=0 Then
				Send("5")
			ElseIf $cx=6 And $cy=0 Then
				Send("6")
			ElseIf $cx=7 And $cy=0 Then
				Send("7")
			ElseIf $cx=8 And $cy=0 Then
				Send("8")
			ElseIf $cx=9 And $cy=0 Then
				Send("9")
			ElseIf $cx=10 And $cy=0 Then
				Send("0")
			ElseIf $cx=11 And $cy=0 Then
				Send("-")
			ElseIf $cx=12 And $cy=0 Then
				Send("=")
			ElseIf $cx=1 And $cy=1 Then
				Send("q")
			ElseIf $cx=2 And $cy=1 Then
				Send("w")
			ElseIf $cx=3 And $cy=1 Then
				Send("e")
			ElseIf $cx=4 And $cy=1 Then
				Send("r")
			ElseIf $cx=5 And $cy=1 Then
				Send("t")
			ElseIf $cx=6 And $cy=1 Then
				Send("y")
			ElseIf $cx=7 And $cy=1 Then
				Send("u")
			ElseIf $cx=8 And $cy=1 Then
				Send("i")
			ElseIf $cx=9 And $cy=1 Then
				Send("o")
			ElseIf $cx=10 And $cy=1 Then
				Send("p")
			ElseIf $cx=11 And $cy=1 Then
				Send("[")
			ElseIf $cx=12 And $cy=1 Then
				Send("]")
			ElseIf $cx=13 And $cy=1 Then
				Send("\")
			ElseIf $cx=1 And $cy=2 Then
				Send("a")
			ElseIf $cx=2 And $cy=2 Then
				Send("s")
			ElseIf $cx=3 And $cy=2 Then
				Send("d")
			ElseIf $cx=4 And $cy=2 Then
				Send("f")
			ElseIf $cx=5 And $cy=2 Then
				Send("g")
			ElseIf $cx=6 And $cy=2 Then
				Send("h")
			ElseIf $cx=7 And $cy=2 Then
				Send("j")
			ElseIf $cx=8 And $cy=2 Then
				Send("k")
			ElseIf $cx=9 And $cy=2 Then
				Send("l")
			ElseIf $cx=10 And $cy=2 Then
				Send(";")
			ElseIf $cx=11 And $cy=2 Then
				Send("'")
			ElseIf $cx=1 And $cy=3 Then
				Send("z")
			ElseIf $cx=2 And $cy=3 Then
				Send("x")
			ElseIf $cx=3 And $cy=3 Then
				Send("c")
			ElseIf $cx=4 And $cy=3 Then
				Send("v")
			ElseIf $cx=5 And $cy=3 Then
				Send("b")
			ElseIf $cx=6 And $cy=3 Then
				Send("n")
			ElseIf $cx=7 And $cy=3 Then
				Send("m")
			ElseIf $cx=8 And $cy=3 Then
				Send(",")
			ElseIf $cx=9 And $cy=3 Then
				Send(".")
			ElseIf $cx=10 And $cy=3 Then
				Send("/")
			EndIf
	   ElseIf $language=-1 Then
			if $cx=1 And $cy=0 Then
				Send("!")
			ElseIf $cx=2 And $cy=0 Then
				Send("@")
			ElseIf $cx=3 And $cy=0 Then
				Send("#")
			ElseIf $cx=4 And $cy=0 Then
				Send("$")
			ElseIf $cx=5 And $cy=0 Then
				Send("%")
			ElseIf $cx=6 And $cy=0 Then
				Send("^")
			ElseIf $cx=7 And $cy=0 Then
				Send("&")
			ElseIf $cx=8 And $cy=0 Then
				Send("*")
			ElseIf $cx=9 And $cy=0 Then
				Send("(")
			ElseIf $cx=10 And $cy=0 Then
				Send(")")
			ElseIf $cx=11 And $cy=0 Then
				Send("_")
			ElseIf $cx=12 And $cy=0 Then
				Send("+")
			ElseIf $cx=1 And $cy=1 Then
				Send("Q")
			ElseIf $cx=2 And $cy=1 Then
				Send("W")
			ElseIf $cx=3 And $cy=1 Then
				Send("E")
			ElseIf $cx=4 And $cy=1 Then
				Send("R")
			ElseIf $cx=5 And $cy=1 Then
				Send("T")
			ElseIf $cx=6 And $cy=1 Then
				Send("Y")
			ElseIf $cx=7 And $cy=1 Then
				Send("U")
			ElseIf $cx=8 And $cy=1 Then
				Send("I")
			ElseIf $cx=9 And $cy=1 Then
				Send("O")
			ElseIf $cx=10 And $cy=1 Then
				Send("P")
			ElseIf $cx=11 And $cy=1 Then
				Send("{")
			ElseIf $cx=12 And $cy=1 Then
				Send("}")
			ElseIf $cx=13 And $cy=1 Then
				Send("|")
			ElseIf $cx=1 And $cy=2 Then
				Send("A")
			ElseIf $cx=2 And $cy=2 Then
				Send("S")
			ElseIf $cx=3 And $cy=2 Then
				Send("D")
			ElseIf $cx=4 And $cy=2 Then
				Send("F")
			ElseIf $cx=5 And $cy=2 Then
				Send("G")
			ElseIf $cx=6 And $cy=2 Then
				Send("H")
			ElseIf $cx=7 And $cy=2 Then
				Send("J")
			ElseIf $cx=8 And $cy=2 Then
				Send("K")
			ElseIf $cx=9 And $cy=2 Then
				Send("L")
			ElseIf $cx=10 And $cy=2 Then
				Send(":")
			ElseIf $cx=11 And $cy=2 Then
				Send(chr(34))
			ElseIf $cx=1 And $cy=3 Then
				Send("Z")
			ElseIf $cx=2 And $cy=3 Then
				Send("X")
			ElseIf $cx=3 And $cy=3 Then
				Send("C")
			ElseIf $cx=4 And $cy=3 Then
				Send("V")
			ElseIf $cx=5 And $cy=3 Then
				Send("B")
			ElseIf $cx=6 And $cy=3 Then
				Send("N")
			ElseIf $cx=7 And $cy=3 Then
				Send("M")
			ElseIf $cx=8 And $cy=3 Then
				Send("<")
			ElseIf $cx=9 And $cy=3 Then
				Send(">")
			ElseIf $cx=10 And $cy=3 Then
				Send("?")
			EndIf
	   ElseIf $language=2 Then
			if $cx=1 And $cy=0 Then
				Send("å")
			ElseIf $cx=2 And $cy=0 Then
				Send("/")
			ElseIf $cx=3 And $cy=0 Then
				Send("-")
			ElseIf $cx=4 And $cy=0 Then
				Send("À")
			ElseIf $cx=5 And $cy=0 Then
				Send("¶")
			ElseIf $cx=6 And $cy=0 Then
				Send("Ø")
			ElseIf $cx=7 And $cy=0 Then
				Send("Ö")
			ElseIf $cx=8 And $cy=0 Then
				Send("¤")
			ElseIf $cx=9 And $cy=0 Then
				Send("µ")
			ElseIf $cx=10 And $cy=0 Then
				Send("¨")
			ElseIf $cx=11 And $cy=0 Then
				Send("¢")
			ElseIf $cx=12 And $cy=0 Then
				Send("ª")
			ElseIf $cx=1 And $cy=1 Then
				Send("æ")
			ElseIf $cx=2 And $cy=1 Then
				Send("ä")
			ElseIf $cx=3 And $cy=1 Then
				Send("Ó")
			ElseIf $cx=4 And $cy=1 Then
				Send("¾")
			ElseIf $cx=5 And $cy=1 Then
				Send("Ð")
			ElseIf $cx=6 And $cy=1 Then
				Send("Ñ")
			ElseIf $cx=7 And $cy=1 Then
				Send("Õ")
			ElseIf $cx=8 And $cy=1 Then
				Send("Ã")
			ElseIf $cx=9 And $cy=1 Then
				Send("¹")
			ElseIf $cx=10 And $cy=1 Then
				Send("Â")
			ElseIf $cx=11 And $cy=1 Then
				Send("º")
			ElseIf $cx=12 And $cy=1 Then
				Send("Å")
			ElseIf $cx=13 And $cy=1 Then
				Send("£")
			ElseIf $cx=1 And $cy=2 Then
				Send("¿")
			ElseIf $cx=2 And $cy=2 Then
				Send("Ë")
			ElseIf $cx=3 And $cy=2 Then
				Send("¡")
			ElseIf $cx=4 And $cy=2 Then
				Send("´")
			ElseIf $cx=5 And $cy=2 Then
				Send("à")
			ElseIf $cx=6 And $cy=2 Then
				Send("é")
			ElseIf $cx=7 And $cy=2 Then
				Send("è")
			ElseIf $cx=8 And $cy=2 Then
				Send("Ò")
			ElseIf $cx=9 And $cy=2 Then
				Send("Ê")
			ElseIf $cx=10 And $cy=2 Then
				Send("Ç")
			ElseIf $cx=11 And $cy=2 Then
				Send("§")
			ElseIf $cx=1 And $cy=3 Then
				Send("¼")
			ElseIf $cx=2 And $cy=3 Then
				Send("»")
			ElseIf $cx=3 And $cy=3 Then
				Send("á")
			ElseIf $cx=4 And $cy=3 Then
				Send("Í")
			ElseIf $cx=5 And $cy=3 Then
				Send("Ô")
			ElseIf $cx=6 And $cy=3 Then
				Send("×")
			ElseIf $cx=7 And $cy=3 Then
				Send("·")
			ElseIf $cx=8 And $cy=3 Then
				Send("Á")
			ElseIf $cx=9 And $cy=3 Then
				Send("ã")
			ElseIf $cx=10 And $cy=3 Then
				Send("½")
			EndIf
	   ElseIf $language=-2 Then
			if $cx=1 And $cy=0 Then
				Send("+")
			ElseIf $cx=2 And $cy=0 Then
				Send("ñ")
			ElseIf $cx=3 And $cy=0 Then
				Send("ò")
			ElseIf $cx=4 And $cy=0 Then
				Send("ó")
			ElseIf $cx=5 And $cy=0 Then
				Send("ô")
			ElseIf $cx=6 And $cy=0 Then
				Send("Ù")
			ElseIf $cx=7 And $cy=0 Then
				Send("ß")
			ElseIf $cx=8 And $cy=0 Then
				Send("õ")
			ElseIf $cx=9 And $cy=0 Then
				Send("ö")
			ElseIf $cx=10 And $cy=0 Then
				Send("÷")
			ElseIf $cx=11 And $cy=0 Then
				Send("ø")
			ElseIf $cx=12 And $cy=0 Then
				Send("ù")
			ElseIf $cx=1 And $cy=1 Then
				Send("ð")
			ElseIf $cx=2 And $cy=1 Then
				Send(chr(34))
			ElseIf $cx=3 And $cy=1 Then
				Send("®")
			ElseIf $cx=4 And $cy=1 Then
				Send("±")
			ElseIf $cx=5 And $cy=1 Then
				Send("¸")
			ElseIf $cx=6 And $cy=1 Then
				Send("í")
			ElseIf $cx=7 And $cy=1 Then
				Send("ê")
			ElseIf $cx=8 And $cy=1 Then
				Send("³")
			ElseIf $cx=9 And $cy=1 Then
				Send("Ï")
			ElseIf $cx=10 And $cy=1 Then
				Send("­")
			ElseIf $cx=11 And $cy=1 Then
				Send("°")
			ElseIf $cx=12 And $cy=1 Then
				Send(",")
			ElseIf $cx=13 And $cy=1 Then
				Send("¥")
			ElseIf $cx=1 And $cy=2 Then
				Send("Ä")
			ElseIf $cx=2 And $cy=2 Then
				Send("¦")
			ElseIf $cx=3 And $cy=2 Then
				Send("¯")
			ElseIf $cx=4 And $cy=2 Then
				Send("â")
			ElseIf $cx=5 And $cy=2 Then
				Send("¬")
			ElseIf $cx=6 And $cy=2 Then
				Send("ç")
			ElseIf $cx=7 And $cy=2 Then
				Send("ë")
			ElseIf $cx=8 And $cy=2 Then
				Send("É")
			ElseIf $cx=9 And $cy=2 Then
				Send("È")
			ElseIf $cx=10 And $cy=2 Then
				Send("«")
			ElseIf $cx=11 And $cy=2 Then
				Send(".")
			ElseIf $cx=1 And $cy=3 Then
				Send("(")
			ElseIf $cx=2 And $cy=3 Then
				Send(")")
			ElseIf $cx=3 And $cy=3 Then
				Send("©")
			ElseIf $cx=4 And $cy=3 Then
				Send("Î")
			ElseIf $cx=5 And $cy=3 Then
				Send("Ú")
			ElseIf $cx=6 And $cy=3 Then
				Send("ì")
			ElseIf $cx=7 And $cy=3 Then
				Send("?")
			ElseIf $cx=8 And $cy=3 Then
				Send("²")
			ElseIf $cx=9 And $cy=3 Then
				Send("Ì")
			ElseIf $cx=10 And $cy=3 Then
				Send("Æ")
			EndIf
		EndIf
	EndIf
EndFunc

Func draw_part($sstate,$cx,$cy)
	if $language=1 Then
		$state=1+$sstate*10
	ElseIf $language=-1 Then
		$state=2+$sstate*10
	ElseIf $language=2 Then
		$state=3+$sstate*10
	ElseIf $language=-2 Then
		$state=4+$sstate*10
	EndIf
   if $cx=12 And $cy=2 Then
	  $button_sizex=$button_sizex*2-2
   ElseIf $cx=3 And $cy=4 Then
	  $button_sizex=$button_sizex*5-5
   EndIf
   if $state=11 Then
	  $hClone = _GDIPlus_BitmapCloneArea($h11, $button_posx*$cx, $button_posy*$cy, $button_sizex, $button_sizey, $GDIP_PXF24RGB)
   ElseIf $state=12 Then
	  $hClone = _GDIPlus_BitmapCloneArea($h12, $button_posx*$cx, $button_posy*$cy, $button_sizex, $button_sizey, $GDIP_PXF24RGB)
   ElseIf $state=13 Then
	  $hClone = _GDIPlus_BitmapCloneArea($h13, $button_posx*$cx, $button_posy*$cy, $button_sizex, $button_sizey, $GDIP_PXF24RGB)
   ElseIf $state=14 Then
	  $hClone = _GDIPlus_BitmapCloneArea($h14, $button_posx*$cx, $button_posy*$cy, $button_sizex, $button_sizey, $GDIP_PXF24RGB)
   ElseIf $state=21 Then
	  $hClone = _GDIPlus_BitmapCloneArea($h21, $button_posx*$cx, $button_posy*$cy, $button_sizex, $button_sizey, $GDIP_PXF24RGB)
   ElseIf $state=22 Then
	  $hClone = _GDIPlus_BitmapCloneArea($h22, $button_posx*$cx, $button_posy*$cy, $button_sizex, $button_sizey, $GDIP_PXF24RGB)
   ElseIf $state=23 Then
	  $hClone = _GDIPlus_BitmapCloneArea($h23, $button_posx*$cx, $button_posy*$cy, $button_sizex, $button_sizey, $GDIP_PXF24RGB)
   ElseIf $state=24 Then
	  $hClone = _GDIPlus_BitmapCloneArea($h24, $button_posx*$cx, $button_posy*$cy, $button_sizex, $button_sizey, $GDIP_PXF24RGB)
   ElseIf $state=31 Then
	  $hClone = _GDIPlus_BitmapCloneArea($h31, $button_posx*$cx, $button_posy*$cy, $button_sizex, $button_sizey, $GDIP_PXF24RGB)
   ElseIf $state=32 Then
	  $hClone = _GDIPlus_BitmapCloneArea($h32, $button_posx*$cx, $button_posy*$cy, $button_sizex, $button_sizey, $GDIP_PXF24RGB)
   ElseIf $state=33 Then
	  $hClone = _GDIPlus_BitmapCloneArea($h33, $button_posx*$cx, $button_posy*$cy, $button_sizex, $button_sizey, $GDIP_PXF24RGB)
   ElseIf $state=34 Then
	  $hClone = _GDIPlus_BitmapCloneArea($h34, $button_posx*$cx, $button_posy*$cy, $button_sizex, $button_sizey, $GDIP_PXF24RGB)
   EndIf
   _GDIPlus_GraphicsDrawImage($hGraphic, $hClone, $button_posx*$cx, $button_posy*$cy)
   if $cx=12 And $cy=2 Then
	  $button_sizex=($button_sizex+2)/2
   ElseIf $cx=3 And $cy=4 Then
	  $button_sizex=($button_sizex+5)/5
   EndIf
EndFunc

Func Free()
   _GDIPlus_BitmapDispose($h11)
   _GDIPlus_BitmapDispose($h12)
   _GDIPlus_BitmapDispose($h13)
   _GDIPlus_BitmapDispose($h14)
   _GDIPlus_BitmapDispose($h21)
   _GDIPlus_BitmapDispose($h22)
   _GDIPlus_BitmapDispose($h23)
   _GDIPlus_BitmapDispose($h24)
   _GDIPlus_BitmapDispose($h31)
   _GDIPlus_BitmapDispose($h32)
   _GDIPlus_BitmapDispose($h33)
   _GDIPlus_BitmapDispose($h34)
   _GDIPlus_BitmapDispose($hClone)
   _GDIPlus_GraphicsDispose($hGraphic)
EndFunc

Func stop()
   Free()
   Exit
 EndFunc

 Func char($a,$n)
	if $n=0 Then
		$n=1
	ElseIf $n=1 Then
		$n=3
	ElseIf $n=2 Then
		$n=5
	ElseIf $n=3 Then
		$n=7
	ElseIf $n=4 Then
		$n=9
	ElseIf $n=5 Then
		$n=11
	EndIf
	return StringMid($a,$n,1)
EndFunc
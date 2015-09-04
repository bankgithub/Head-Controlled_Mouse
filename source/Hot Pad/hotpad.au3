#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Include <GuiButton.au3>

$kbwidth=205
$kbheight=176
$inputx=MouseGetPos(0)
$inputy=MouseGetPos(1)
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

$gui1 = GUICreate("gui1",$kbwidth,$kbheight,$inputx,$inputy,0x80000000,BitOR($WS_EX_TOOLWINDOW, $WS_EX_TOPMOST, 0x08000000))
$bSetting=GUICtrlCreateButton("setting",18,132,113,45,-1,-1)
GUICtrlSetBkColor($bsetting, 0x9bffcd)
$b1=GUICtrlCreateButton("",18,0,57,45,-1,-1)
$b2=GUICtrlCreateButton("",74,0,57,45,-1,-1)
$b3=GUICtrlCreateButton("",130,0,57,45,-1,-1)
$b4=GUICtrlCreateButton("",18,44,57,45,-1,-1)
$b5=GUICtrlCreateButton("",74,44,57,45,-1,-1)
$b6=GUICtrlCreateButton("",130,44,57,45,-1,-1)
$b7=GUICtrlCreateButton("",18,88,57,45,-1,-1)
$b8=GUICtrlCreateButton("",74,88,57,45,-1,-1)
$b9=GUICtrlCreateButton("",130,88,57,45,-1,-1)
$b0=GUICtrlCreateButton("",130,132,57,45,-1,-1)
$bLeft=GUICtrlCreateButton("<",0,0,19,177,-1,-1)
$bRight=GUICtrlCreateButton(">",186,0,20,177,-1,-1)
GUISetState(@SW_SHOW,$gui1)

$yellow=0xffff80
$pink=0xffaaaa
$orange=0xffb66c

$page=1
init()

While 1
   $msg = GUIGetMsg()
   Switch $Msg
	  Case $GUI_EVENT_CLOSE
		 Exit
	  Case $b1
		 local $path
		 if $page=1 Then
			$path=@WorkingDir & "\command\a1.txt"
		 ElseIf $page=2 Then
			$path=@WorkingDir & "\command\b1.txt"
		 ElseIf $page=3 Then
			$path=@WorkingDir & "\command\c1.txt"
		 EndIf
		 if(FileGetSize($path)>0) Then
			exec($path)
		 EndIf
	  Case $b2
		 local $path
		 if $page=1 Then
			$path=@WorkingDir & "\command\a2.txt"
		 ElseIf $page=2 Then
			$path=@WorkingDir & "\command\b2.txt"
		 ElseIf $page=3 Then
			$path=@WorkingDir & "\command\c2.txt"
		 EndIf
		 if(FileGetSize($path)>0) Then
			exec($path)
		 EndIf
	  Case $b3
		 local $path
		 if $page=1 Then
			$path=@WorkingDir & "\command\a3.txt"
		 ElseIf $page=2 Then
			$path=@WorkingDir & "\command\b3.txt"
		 ElseIf $page=3 Then
			$path=@WorkingDir & "\command\c3.txt"
		 EndIf
		 if(FileGetSize($path)>0) Then
			exec($path)
		 EndIf
	  Case $b4
		 local $path
		 if $page=1 Then
			$path=@WorkingDir & "\command\a4.txt"
		 ElseIf $page=2 Then
			$path=@WorkingDir & "\command\b4.txt"
		 ElseIf $page=3 Then
			$path=@WorkingDir & "\command\c4.txt"
		 EndIf
		 if(FileGetSize($path)>0) Then
			exec($path)
		 EndIf
	  Case $b5
		 local $path
		 if $page=1 Then
			$path=@WorkingDir & "\command\a5.txt"
		 ElseIf $page=2 Then
			$path=@WorkingDir & "\command\b5.txt"
		 ElseIf $page=3 Then
			$path=@WorkingDir & "\command\c5.txt"
		 EndIf
		 if(FileGetSize($path)>0) Then
			exec($path)
		 EndIf
	  Case $b6
		 local $path
		 if $page=1 Then
			$path=@WorkingDir & "\command\a6.txt"
		 ElseIf $page=2 Then
			$path=@WorkingDir & "\command\b6.txt"
		 ElseIf $page=3 Then
			$path=@WorkingDir & "\command\c6.txt"
		 EndIf
		 if(FileGetSize($path)>0) Then
			exec($path)
		 EndIf
	  Case $b7
		 local $path
		 if $page=1 Then
			$path=@WorkingDir & "\command\a7.txt"
		 ElseIf $page=2 Then
			$path=@WorkingDir & "\command\b7.txt"
		 ElseIf $page=3 Then
			$path=@WorkingDir & "\command\c7.txt"
		 EndIf
		 if(FileGetSize($path)>0) Then
			exec($path)
		 EndIf
	  Case $b8
		 local $path
		 if $page=1 Then
			$path=@WorkingDir & "\command\a8.txt"
		 ElseIf $page=2 Then
			$path=@WorkingDir & "\command\b8.txt"
		 ElseIf $page=3 Then
			$path=@WorkingDir & "\command\c8.txt"
		 EndIf
		 if(FileGetSize($path)>0) Then
			exec($path)
		 EndIf
	  Case $b9
		 local $path
		 if $page=1 Then
			$path=@WorkingDir & "\command\a9.txt"
		 ElseIf $page=2 Then
			$path=@WorkingDir & "\command\b9.txt"
		 ElseIf $page=3 Then
			$path=@WorkingDir & "\command\c9.txt"
		 EndIf
		 if(FileGetSize($path)>0) Then
			exec($path)
		 EndIf
	  Case $b0
		 local $path
		 if $page=1 Then
			$path=@WorkingDir & "\command\a10.txt"
		 ElseIf $page=2 Then
			$path=@WorkingDir & "\command\b10.txt"
		 ElseIf $page=3 Then
			$path=@WorkingDir & "\command\c10.txt"
		 EndIf
		 if(FileGetSize($path)>0) Then
			exec($path)
		 EndIf
	  Case $bSetting
		 Run("setting.exe")
		 Exit
	  Case $bRight
		 $page=$page+1
		 if $page>3 Then
			$page=3
		 Else
			init()
		 EndIf
	  Case $bLeft
		 $page=$page-1
		 if $page<1 Then
			$page=1
		 Else
			init()
		 EndIf
	EndSwitch
WEnd

Func init()
   GUIDelete($gui1)
   $gui1 = GUICreate("gui1",$kbwidth,$kbheight,$inputx,$inputy,0x80000000,BitOR($WS_EX_TOOLWINDOW, $WS_EX_TOPMOST, 0x08000000))

   $bSetting=GUICtrlCreateButton("setting",18,132,113,45,-1,-1)
   GUICtrlSetBkColor($bsetting, 0x9bffcd)

   $b1=GUICtrlCreateButton("",18,0,57,45,-1,-1)
   $b2=GUICtrlCreateButton("",74,0,57,45,-1,-1)
   $b3=GUICtrlCreateButton("",130,0,57,45,-1,-1)
   $b4=GUICtrlCreateButton("",18,44,57,45,-1,-1)
   $b5=GUICtrlCreateButton("",74,44,57,45,-1,-1)
   $b6=GUICtrlCreateButton("",130,44,57,45,-1,-1)
   $b7=GUICtrlCreateButton("",18,88,57,45,-1,-1)
   $b8=GUICtrlCreateButton("",74,88,57,45,-1,-1)
   $b9=GUICtrlCreateButton("",130,88,57,45,-1,-1)
   $b0=GUICtrlCreateButton("",130,132,57,45,-1,-1)
   $bLeft=GUICtrlCreateButton("<",0,0,19,177,-1,-1)
   $bRight=GUICtrlCreateButton(">",186,0,20,177,-1,-1)
   GUISetState(@SW_SHOW,$gui1)

   local $path
   if $page=1 Then
	  $path="\command\a"
   ElseIf $page=2 Then
	  $path="\command\b"
   ElseIf $page=3 Then
	  $path="\command\c"
   EndIf
   if(FileGetSize(@WorkingDir & $path & "1.txt")>0) Then
	  Local $file = FileOpen(@WorkingDir & $path & "1.txt", 0)
	  Local $read1 = FileReadLine($file)
	  Local $read2 = FileReadLine($file)
	  if $read1=1 Then
		 GUICtrlSetBkColor($b1, $yellow)
	  ElseIf $read1=2 Then
		 GUICtrlSetBkColor($b1, $orange)
	  ElseIf $read1=3 Then
		 GUICtrlSetBkColor($b1, $pink)
	  EndIf
	  GUICtrlSetData($b1,$read2)
	  FileClose($file)
   Else
	  $b1=GUICtrlCreateButton("",18,0,57,45,-1,-1)
   EndIf
   if(FileGetSize(@WorkingDir & $path & "2.txt")>0) Then
	  Local $file = FileOpen(@WorkingDir & $path & "2.txt", 0)
	  Local $read1 = FileReadLine($file)
	  Local $read2 = FileReadLine($file)
	  if $read1=1 Then
		 GUICtrlSetBkColor($b2, $yellow)
	  ElseIf $read1=2 Then
		 GUICtrlSetBkColor($b2, $orange)
	  ElseIf $read1=3 Then
		 GUICtrlSetBkColor($b2, $pink)
	  EndIf
	  GUICtrlSetData($b2,$read2)
	  FileClose($file)
   Else
	  $b2=GUICtrlCreateButton("",74,0,57,45,-1,-1)
   EndIf
   if(FileGetSize(@WorkingDir & $path & "3.txt")>0) Then
	  Local $file = FileOpen(@WorkingDir & $path & "3.txt", 0)
	  Local $read1 = FileReadLine($file)
	  Local $read2 = FileReadLine($file)
	  if $read1=1 Then
		 GUICtrlSetBkColor($b3, $yellow)
	  ElseIf $read1=2 Then
		 GUICtrlSetBkColor($b3, $orange)
	  ElseIf $read1=3 Then
		 GUICtrlSetBkColor($b3, $pink)
	  EndIf
	  GUICtrlSetData($b3,$read2)
	  FileClose($file)
   Else
	  $b3=GUICtrlCreateButton("",130,0,57,45,-1,-1)
   EndIf
   if(FileGetSize(@WorkingDir & $path & "4.txt")>0) Then
	  Local $file = FileOpen(@WorkingDir & $path & "4.txt", 0)
	  Local $read1 = FileReadLine($file)
	  Local $read2 = FileReadLine($file)
	  if $read1=1 Then
		 GUICtrlSetBkColor($b4, $yellow)
	  ElseIf $read1=2 Then
		 GUICtrlSetBkColor($b4, $orange)
	  ElseIf $read1=3 Then
		 GUICtrlSetBkColor($b4, $pink)
	  EndIf
	  GUICtrlSetData($b4,$read2)
	  FileClose($file)
   Else
	  $b4=GUICtrlCreateButton("",18,44,57,45,-1,-1)
   EndIf
   if(FileGetSize(@WorkingDir & $path & "5.txt")>0) Then
	  Local $file = FileOpen(@WorkingDir & $path & "5.txt", 0)
	  Local $read1 = FileReadLine($file)
	  Local $read2 = FileReadLine($file)
	  if $read1=1 Then
		 GUICtrlSetBkColor($b5, $yellow)
	  ElseIf $read1=2 Then
		 GUICtrlSetBkColor($b5, $orange)
	  ElseIf $read1=3 Then
		 GUICtrlSetBkColor($b5, $pink)
	  EndIf
	  GUICtrlSetData($b5,$read2)
	  FileClose($file)
   Else
	  $b5=GUICtrlCreateButton("",74,44,57,45,-1,-1)
   EndIf
   if(FileGetSize(@WorkingDir & $path & "6.txt")>0) Then
	  Local $file = FileOpen(@WorkingDir & $path & "6.txt", 0)
	  Local $read1 = FileReadLine($file)
	  Local $read2 = FileReadLine($file)
	  if $read1=1 Then
		 GUICtrlSetBkColor($b6, $yellow)
	  ElseIf $read1=2 Then
		 GUICtrlSetBkColor($b6, $orange)
	  ElseIf $read1=3 Then
		 GUICtrlSetBkColor($b6, $pink)
	  EndIf
	  GUICtrlSetData($b6,$read2)
	  FileClose($file)
   Else
	  $b6=GUICtrlCreateButton("",130,44,57,45,-1,-1)
   EndIf
   if(FileGetSize(@WorkingDir & $path & "7.txt")>0) Then
	  Local $file = FileOpen(@WorkingDir & $path & "7.txt", 0)
	  Local $read1 = FileReadLine($file)
	  Local $read2 = FileReadLine($file)
	  if $read1=1 Then
		 GUICtrlSetBkColor($b7, $yellow)
	  ElseIf $read1=2 Then
		 GUICtrlSetBkColor($b7, $orange)
	  ElseIf $read1=3 Then
		 GUICtrlSetBkColor($b7, $pink)
	  EndIf
	  GUICtrlSetData($b7,$read2)
	  FileClose($file)
   Else
	  $b7=GUICtrlCreateButton("",18,88,57,45,-1,-1)
   EndIf
   if(FileGetSize(@WorkingDir & $path & "8.txt")>0) Then
	  Local $file = FileOpen(@WorkingDir & $path & "8.txt", 0)
	  Local $read1 = FileReadLine($file)
	  Local $read2 = FileReadLine($file)
	  if $read1=1 Then
		 GUICtrlSetBkColor($b8, $yellow)
	  ElseIf $read1=2 Then
		 GUICtrlSetBkColor($b8, $orange)
	  ElseIf $read1=3 Then
		 GUICtrlSetBkColor($b8, $pink)
	  EndIf
	  GUICtrlSetData($b8,$read2)
	  FileClose($file)
   Else
	  $b8=GUICtrlCreateButton("",74,88,57,45,-1,-1)
   EndIf
   if(FileGetSize(@WorkingDir & $path & "9.txt")>0) Then
	  Local $file = FileOpen(@WorkingDir & $path & "9.txt", 0)
	  Local $read1 = FileReadLine($file)
	  Local $read2 = FileReadLine($file)
	  if $read1=1 Then
		 GUICtrlSetBkColor($b9, $yellow)
	  ElseIf $read1=2 Then
		 GUICtrlSetBkColor($b9, $orange)
	  ElseIf $read1=3 Then
		 GUICtrlSetBkColor($b9, $pink)
	  EndIf
	  GUICtrlSetData($b9,$read2)
	  FileClose($file)
   Else
	  $b9=GUICtrlCreateButton("",130,88,57,45,-1,-1)
   EndIf
   if(FileGetSize(@WorkingDir & $path & "10.txt")>0) Then
	  Local $file = FileOpen(@WorkingDir & $path & "10.txt", 0)
	  Local $read1 = FileReadLine($file)
	  Local $read2 = FileReadLine($file)
	  if $read1=1 Then
		 GUICtrlSetBkColor($b0, $yellow)
	  ElseIf $read1=2 Then
		 GUICtrlSetBkColor($b0, $orange)
	  ElseIf $read1=3 Then
		 GUICtrlSetBkColor($b0, $pink)
	  EndIf
	  GUICtrlSetData($b0,$read2)
	  FileClose($file)
   Else
	  $b0=GUICtrlCreateButton("",130,132,57,45,-1,-1)
   EndIf
EndFunc

Func exec($path)
   Local $file = FileOpen($path, 0)
   FileReadLine($file)
   FileReadLine($file)
   While 1
	  Local $line = FileReadLine($file)
	  If $line="" Then 
		 ExitLoop
	  ElseIf StringLeft($line,4)="left" Then
		 $line=StringTrimLeft($line,5)
		 Local $tmp=StringSplit($line," ")
		 MouseClick("left",Int($tmp[1]),Int($tmp[2]),Int($tmp[3]),0)
	  ElseIf StringLeft($line,5)="right" Then
		 $line=StringTrimLeft($line,6)
		 Local $tmp=StringSplit($line," ")
		 MouseClick("right",Int($tmp[1]),Int($tmp[2]),Int($tmp[3]),0)
	  ElseIf StringLeft($line,4)="wait" Then
		 $line=StringTrimLeft($line,5)
		 sleep(Int($line))
	  Else
		 Send($line)
	  EndIf
   WEnd
   FileClose($file)
EndFunc
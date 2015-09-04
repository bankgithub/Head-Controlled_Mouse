#include<GuiButton.au3>
#include<GuiToolBar.au3>
#include<GuiConstantsEx.au3>
#include <Misc.au3>
#include <Array.au3>
#include <File.au3>

HotKeySet("{ESC}", "stop")
Opt('MouseCoordMode', 0)
 Opt("GUIOnEventMode",1)
$submit=0
$hard=0
$countdown=0
$state=0
$old=""
$old2=""
$label=0
$count=-1
$line=0
$data=""
$word=0
dim $st[10]
dim $shufflest[10]
$d=0
$n=""
$ready=0
dim $p[2]
$file = FileOpen("test.txt",1)
$highscore = FileOpen("score.txt",1)
GuiCreate("lyreth", 640,480,(@DesktopWidth-640)/3,(@DesktopHeight-480)/3)
dim $input[10]
GUISetFont(22,400,0,"MS Sans Serif")
For $i=0 to 8 step 2
	$input[$i]=GuiCtrlCreateInput("",85,180+$i*24,130,35)
	$input[$i+1]=GuiCtrlCreateInput("",285,180+$i*24,130,35)
	GUICtrlSetState($input[$i],$GUI_HIDE)
	GUICtrlSetState($input[$i+1],$GUI_HIDE)
Next
dim $button[10]
$pic = guictrlcreatepic(@WorkingDir &"\pic\menu.jpg", 0, 0,640,480)
$back = guictrlcreatepic(@WorkingDir &"\pic\brownback.jpg", 10, 420,47,50)
For $i=0 to 4 step 1
	$button[$i] = guictrlcreatepic(@WorkingDir &"\pic\button1.jpg", 40+115*$i, 150,100,100)
	$button[$i+5] = guictrlcreatepic(@WorkingDir &"\pic\button1.jpg", 40+115*$i, 265,100,100)
	GUICtrlSetState($button[$i] ,$GUI_HIDE)
	GUICtrlSetState($button[$i+5] ,$GUI_HIDE)
Next
dim $mem[10]
dim $ans[10]
For $i=0 to 4 step 1
	$ans[$i]=GUICtrlCreateLabel("",40+115*$i, 185,100,100,0x01)
	GUICtrlSetBkColor($ans[$i],$GUI_BKCOLOR_TRANSPARENT )
	GUICtrlSetColor($ans[$i], 0x770000)
	GUICtrlSetState($ans[$i],$GUI_HIDE)
	$ans[$i+5]=GUICtrlCreateLabel("",40+115*$i, 300,100,100,0x01)
	GUICtrlSetBkColor($ans[$i+5],$GUI_BKCOLOR_TRANSPARENT )
	GUICtrlSetColor($ans[$i+5], 0x770000)
	GUICtrlSetState($ans[$i+5],$GUI_HIDE)
Next
$time=0
$score=0
dim $hname[10]
dim $hscore[10]
For $i=0 to 4 step 1
	$hname[$i]=GUICtrlCreateLabel("",70, 175+50*$i,160,35)
	GUICtrlSetBkColor($hname[$i],$GUI_BKCOLOR_TRANSPARENT )
	GUICtrlSetColor($hname[$i], 0x770000)
	GUICtrlSetState($hname[$i],$GUI_HIDE)
	$hname[$i+5]=GUICtrlCreateLabel("",330, 175+50*$i,160,35)
	GUICtrlSetBkColor($hname[$i+5],$GUI_BKCOLOR_TRANSPARENT )
	GUICtrlSetColor($hname[$i+5], 0x770000)
	GUICtrlSetState($hname[$i]+5,$GUI_HIDE)
	$hscore[$i]=GUICtrlCreateLabel("0",250, 175+50*$i,160,35)
	GUICtrlSetBkColor($hscore[$i],$GUI_BKCOLOR_TRANSPARENT )
	GUICtrlSetColor($hscore[$i], 0x770000)
	GUICtrlSetState($hscore[$i],$GUI_HIDE)
	$hscore[$i+5]=GUICtrlCreateLabel("0",510, 175+50*$i,160,35)
	GUICtrlSetBkColor($hscore[$i+5],$GUI_BKCOLOR_TRANSPARENT )
	GUICtrlSetColor($hscore[$i+5], 0x770000)
	GUICtrlSetState($hscore[$i+5],$GUI_HIDE)
Next
$help=1
GUISetOnEvent($GUI_EVENT_CLOSE, "stop")
GUISetCursor(1)
GUISetState(@SW_SHOW)
setstate(0,0)

While 1
	$p=MouseGetPos()
	;traytip("",$p[0]&","&$p[1],1000)
	$msg=GUIGetMsg()
    If $msg=-3 Then
	  stop()
	ElseIf($state=0) Then
		$m=getP(0)
		if $m=1 Then
			gset($pic,"menu-1.jpg")
			if _IsPressed(1) Then
				setstate(1,0)
			EndIf
		elseif $m=2 Then
			gset($pic,"menu-2.jpg")
			if _IsPressed(1) Then
				setstate(2,0)
			EndIf
		elseif $m=3 Then
			gset($pic,"menu-3.jpg")
			if _IsPressed(1) Then
				setstate(3,0)
			EndIf
		elseif $m=4 Then
			gset($pic,"menu-4.jpg")
			if _IsPressed(1) Then
				setstate(4,0)
			EndIf
		elseif $m=5 Then
			gset($pic,"menu-5.jpg")
			if _IsPressed(1) Then
				setstate(51,0)
			EndIf
		elseif $m=6 Then
			gset($pic,"menu-6.jpg")
			if _IsPressed(1) Then
				setstate(6,0)
			EndIf
		elseif $m=-1 Then
			gset($pic,"menu.jpg")
		EndIf
	ElseIf $state=1 Then
		$m=getP(1)
		think()
	ElseIf $state=2 Then
		$m=getP(2)
		if $m=0 then
			gback($back,"greenback.jpg")
			if _IsPressed(1) Then
				setstate(0,2)
			EndIf
		Else
			gback($back,"brownback.jpg")
		EndIf
	ElseIf $state=3 Then
		$m=getP(3)
		If $help=1 Then
			gset($pic,"help1.jpg")
		ElseIf $help=2 Then
			gset($pic,"help2.jpg")
		ElseIf $help=3 Then
			gset($pic,"help3.jpg")
		ElseIf $help=4 Then
			gset($pic,"help4.jpg")
		ElseIf $help=5 Then
			gset($pic,"help5.jpg")
		ElseIf $help=6 Then
			gset($pic,"help6.jpg")
		ElseIf $help=7 Then
			gset($pic,"help7.jpg")
		ElseIf $help=8 Then
			gset($pic,"help8.jpg")
		ElseIf $help=9 Then
			gset($pic,"help9.jpg")
		ElseIf $help=10 Then
			gset($pic,"help10.jpg")
		EndIf
		if $m=0 then
			gback($back,"greenback.jpg")
			if _IsPressed(1) Then
				setstate(0,3)
			EndIf
		ElseIf ($m=1 And _IsPressed(1)) Or _IsPressed("25") Then
			$help=$help+1
			if $help=11 Then
				$help=1
			EndIf
			sleep(100)
		ElseIf ($m=2 And _IsPressed(1)) Or _IsPressed("27") Then
			$help=$help-1
			if $help=0 Then
				$help=10
			EndIf
			sleep(100)
		Else
			gback($back,"brownback.jpg")
		EndIf
	ElseIf $state=4 Then
		$m=getP(4)
		think()
	ElseIf $state=51 Then
		$m=getP(51)
		if $m=0 then
			gback($back,"greenback.jpg")
			if _IsPressed(1) Then
				setstate(0,51)
			EndIf
		ElseIf $m=1 And _IsPressed(1) Then
			setstate(52,51)
		ElseIf ($m=2 And _IsPressed(1)) Or _IsPressed("0D")  Then
			$chk=0
			FileSetPos($file,0,2)
			For $i=0 to 9 step 1
				If GUICtrlRead($input[$i])<>"" Then
					FileWrite($file,GUICtrlRead($input[$i]) & " " )
					$chk=1
					GUICtrlSetData($input[$i],"")
				EndIf
			Next
			if $chk=1 Then
				FileWriteLine($file,"")
		EndIf
		ElseIf $m=3 And _IsPressed(1) Then
			For $i=0 to 9 step 1
				GUICtrlSetData($input[$i],"")
			Next
		Else
			gback($back,"brownback.jpg")
		EndIf
	ElseIf $state=52 Then
		$m=getP(52)
		if $m=0 then
			gback($back,"greenback.jpg")
			if _IsPressed(1) Then
				setstate(0,52)
			EndIf
		ElseIf $m=1 Then
			if _IsPressed(1) Then
				setstate(51,52)
			EndIf
		ElseIf (($m=2 And _IsPressed(1)) or _IsPressed("2E")) and $line>0 Then
			FileSetPos($file,0,0)
			if $count=-1 Then
				_FileWriteToLine("test.txt", $line,"",1)
			Else
				_FileWriteToLine("test.txt",$count,"",1)
			EndIf
			$line=$line-1
			FileClose($file)
			$file = FileOpen("test.txt",1)
			if $count>=$line And $line>1 Then
				$count=-1
			ElseIf $count=0 Or $line=1 Then
				$count=1
			ElseIf $line=0 Then
				$count=0
			EndIf
			if $count=-1 Then
				GUICtrlSetData($label, $line)
			Else
				GUICtrlSetData($label, $count)
			EndIf
			FileSetPos($file,0,0)
			$data=FileReadLine($file,$count)
			$data=StringReplace($data," ","")
			GUICtrlSetData($word,$data)
			sleep(150)
		ElseIf ($m=3 And _IsPressed(1)) Or  _IsPressed("25") Then
			$count=$count-1
			if $count<-1 Then
				$count=$line-1
			ElseIf $count=0 And $line>1 Then
				$count=-1
			ElseIf $count=0 And $line=1 Then
				$count=1
			ElseIf $line=0 Then
				$count=0
			EndIf
			if $count=-1 Then
				GUICtrlSetData($label, $line)
			Else
				GUICtrlSetData($label, $count)
			EndIf
			FileSetPos($file,0,0)
			$data=FileReadLine($file,$count)
			$data=StringReplace($data," ","")
			GUICtrlSetData($word,$data)
			sleep(150)
		ElseIf ($m=4 And _IsPressed(1)) Or  _IsPressed("27") Then
			$count=$count+1
			if $count>=$line And $line>1 Then
				$count=-1
			ElseIf $count=0 Or $line=1 Then
				$count=1
			ElseIf $line=0 Then
				$count=0
			EndIf
			if $count=-1 Then
				GUICtrlSetData($label, $line)
			Else
				GUICtrlSetData($label, $count)
			EndIf
			FileSetPos($file,0,0)
			$data=FileReadLine($file,$count)
			$data=StringReplace($data," ","")
			GUICtrlSetData($word,$data)
			sleep(150)
		Else
			gback($back,"brownback.jpg")
		EndIf
	ElseIf $state=6 Then
		$m=getP(6)
		if $m=0 then
			gback($back,"greenback.jpg")
			if _IsPressed(1) Then
				setstate(0,6)
			EndIf
		Else
			gback($back,"brownback.jpg")
		EndIf
	EndIf
WEnd

Func think()
	if TimerDiff($countdown)>1000 Then
		$tmp=GUICtrlRead($time)-1
		GUICtrlSetData($time,$tmp)
		if $tmp=0 Then
			$name = InputBox("คุณชื่อ?", " ","","",100,50,(@DesktopWidth-640)/3+230,(@DesktopHeight-480)/3+190)
			if $name="" Then
				$name="ไม่ระบุชื่อ"
			EndIf
			$sc=GUICtrlRead($score)
			for $i=2 to 10 step 2
				if $state=1 Then
					$tmp=$i
				Else
					$tmp=$i+10
				EndIf
				FileClose($highscore)
				$highscore = FileOpen("score.txt",1)
				FileSetPos($highscore,0,0)
				if $sc>FileReadLine($highscore,$tmp) Then
					for $j=10 to $i+1 step -1
						FileSetPos($highscore,0,0)
						if $state=1 Then
							_FileWriteToLine("score.txt", $j,FileReadLine($highscore,$j-2),1)
						Else
							_FileWriteToLine("score.txt", $j+10,FileReadLine($highscore,$j+8),1)
						EndIf
					Next
					_FileWriteToLine("score.txt", $tmp,$sc,1)
					_FileWriteToLine("score.txt", $tmp-1,$name,1)
					ExitLoop
				EndIf
			Next
		setstate(0,4)
		Else
			$countdown=TimerInit()
		EndIf
	EndIf
	if $state=4 And TimerDiff($hard)>($d+1)*3500 Then
		GUICtrlSetData($score,GUICtrlRead($score)-$d-1)
		genQuestion()
	EndIf
	if $m=0 then
		gback($back,"greenback.jpg")
		if _IsPressed(1) Then
			setstate(0,1)
		EndIf
	ElseIf _IsPressed("02" ) And $ready>0 Then
		gbutton($button[$ready-1],"button1.jpg")
		$ready=0
	ElseIf ($m=11 And _IsPressed("01")) Or _IsPressed("0D") And TimerDiff($submit)>500 Then
		$ok=1
		for $i=0 to $d step 1
			if GUICtrlRead($ans[$i])<>$st[$i] Then
				$ok=0
				ExitLoop
			EndIf
		Next
		if $ok=1 Then
			GUICtrlSetData($score,GUICtrlRead($score)+$d+1)
		ElseIf $ok=0 And $state=4 Then
			GUICtrlSetData($score,GUICtrlRead($score)-$d-1)
		EndIf
		genQuestion()
		$submit = TimerInit()
	ElseIf $ready>0 Then
		gbutton($button[$ready-1],"button2.jpg")
		If ($m=1 And $m<$d+2 And _IsPressed(1) And $ready<>$m) Or (_IsPressed("61") And 1<$d+2) Then
			swap($ready-1,0)
		ElseIf ($m=2 And $m<$d+2 And _IsPressed(1) And $ready<>$m) Or (_IsPressed("62") And 2<$d+2) Then
			swap($ready-1,1)
		ElseIf ($m=3 And $m<$d+2 And _IsPressed(1) And $ready<>$m) Or (_IsPressed("63") And 3<$d+2) Then
			swap($ready-1,2)
		ElseIf ($m=4 And $m<$d+2 And _IsPressed(1) And $ready<>$m) Or (_IsPressed("64") And 4<$d+2) Then
			swap($ready-1,3)
		ElseIf ($m=5 And $m<$d+2 And _IsPressed(1) And $ready<>$m) Or (_IsPressed("65") And 5<$d+2) Then
			swap($ready-1,4)
		ElseIf ($m=6 And $m<$d+2 And _IsPressed(1) And $ready<>$m) Or (_IsPressed("66") And 6<$d+2) Then
			swap($ready-1,5)
		ElseIf ($m=7 And $m<$d+2 And _IsPressed(1) And $ready<>$m) Or (_IsPressed("67") And 7<$d+2) Then
			swap($ready-1,6)
		ElseIf ($m=8 And $m<$d+2 And _IsPressed(1) And $ready<>$m) Or (_IsPressed("68") And 8<$d+2) Then
			swap($ready-1,7)
		ElseIf ($m=9 And $m<$d+2 And _IsPressed(1) And $ready<>$m) Or (_IsPressed("69") And 9<$d+2) Then
			swap($ready-1,8)
		ElseIf ($m=10 And $m<$d+2 And _IsPressed(1) And $ready<>$m) Or (_IsPressed("6B") And 10<$d+2) Then
			swap($ready-1,9)
		EndIf
	ElseIf $m=1 And $m<$d+2 And _IsPressed(1) Then
		$ready=1
	ElseIf $m=2 And $m<$d+2 And _IsPressed(1) Then
		$ready=2
	ElseIf $m=3 And $m<$d+2 And _IsPressed(1) Then
		$ready=3
	ElseIf $m=4 And $m<$d+2 And _IsPressed(1) Then
		$ready=4
	ElseIf $m=5 And $m<$d+2 And _IsPressed(1) Then
		$ready=5
	ElseIf $m=6 And $m<$d+2 And _IsPressed(1) Then
		$ready=6
	ElseIf $m=7 And $m<$d+2 And _IsPressed(1) Then
		$ready=7
	ElseIf $m=8 And $m<$d+2 And _IsPressed(1) Then
		$ready=8
	ElseIf $m=9 And $m<$d+2 And _IsPressed(1) Then
		$ready=9
	ElseIf $m=10 And $m<$d+2 And _IsPressed(1) Then
		$ready=10
	Else
		gback($back,"brownback.jpg")
	EndIf
	Sleep(1)
EndFunc

Func swap($m,$n)
	$tmp=GUICtrlRead ($ans[$m])
	GUICtrlSetData($ans[$m],GUICtrlRead ($ans[$n]))
	GUICtrlSetData($ans[$n],$tmp)
	gbutton($button[$ready-1],"button1.jpg")
	$ready=0
	sleep(100)
EndFunc

Func gset($m,$n)
	if $old<>$n then
		GUICtrlSetImage($m,@WorkingDir &"\pic\"&$n)
		$old=$n
	EndIf
EndFunc

Func gback($m,$n)
	if $old2<>$n then
		GUICtrlSetImage($m,@WorkingDir &"\pic\"&$n)
		$old2=$n
	EndIf
EndFunc

Func gbutton($m,$n)
	if $mem[$ready]<>$n then
		GUICtrlSetImage($m,@WorkingDir &"\pic\"&$n)
		$mem[$ready]=$n
	EndIf
EndFunc

Func setstate($m,$n)
	$state=$m
	if $n=0 Then
		GUICtrlSetState($back,$GUI_SHOW)
	ElseIf $n=1 Then
		For $i=0 to 9 Step 1
			GUICtrlSetState($button[$i] ,$GUI_HIDE)
			GUICtrlSetState($ans[$i],$GUI_HIDE)
		Next
		GUICtrlSetState($score ,$GUI_HIDE)
		GUICtrlSetState($time,$GUI_HIDE)
	ElseIf $n=2 Then
		for $i=0 to 9 step 1
			GUICtrlSetState($hname[$i],$GUI_HIDE)
			GUICtrlSetState($hscore[$i],$GUI_HIDE)
		Next
	ElseIf $n=4 Or $n=1 Then
		For $i=0 to 9 Step 1
			GUICtrlSetState($button[$i] ,$GUI_HIDE)
			GUICtrlSetState($ans[$i],$GUI_HIDE)
		Next
		GUICtrlSetState($score ,$GUI_HIDE)
		GUICtrlSetState($time,$GUI_HIDE)
	ElseIf $n=51 Then
		For $i=0 to 4 step 1
			GUICtrlSetState($input[$i],$GUI_HIDE)
			GUICtrlSetState($input[$i+5],$GUI_HIDE)
		Next
	elseif $n=52 Then
		GUICtrlSetState($label,$GUI_HIDE)
		GUICtrlSetState($word,$GUI_HIDE)
	EndIf
	If $m=0 Then
		gset($pic,"menu.jpg")
		GUICtrlSetState($back,$GUI_HIDE)
	elseIf $m=1 Then
		gset($pic,"play-easy3.jpg")
		sleep(1000)
		gset($pic,"play-easy2.jpg")
		sleep(1000)
		gset($pic,"play-easy1.jpg")
		sleep(1000)
		gset($pic,"play-easy.jpg")
		gen()
	elseIf $m=2 Then
		gset($pic,"highscore.jpg")
		FileClose($highscore)
		$highscore = FileOpen("score.txt",1)
		for $i=0 to 9 step 1
			FileSetPos($highscore,0,0)
			GUICtrlSetData($hname[$i],FileReadLine($highscore,$i*2+1))
			FileSetPos($highscore,0,0)
			GUICtrlSetData($hscore[$i],FileReadLine($highscore,$i*2+2))
			GUICtrlSetState($hname[$i],$GUI_SHOW)
			GUICtrlSetState($hscore[$i],$GUI_SHOW)
		Next
	elseIf $m=3 Then
		gset($pic,"help1.jpg")
		$help=1
	elseIf $m=4 Then
		gset($pic,"play-hard3.jpg")
		sleep(1000)
		gset($pic,"play-hard2.jpg")
		sleep(1000)
		gset($pic,"play-hard1.jpg")
		sleep(1000)
		gset($pic,"play-hard.jpg")
		gen()
	elseIf $m=51 Then
		gset($pic,"write.jpg")
		For $i=0 to 4 step 1
			GUICtrlSetState($input[$i],$GUI_SHOW)
			GUICtrlSetState($input[$i+5],$GUI_SHOW)
		Next
	elseIf $m=52 Then
		gset($pic,"read.jpg")
		$line=_FileCountLines("test.txt")
		FileSetPos($file,0,2)
		$label=GUICtrlCreateLabel($line,230,205,50,50)
		GUICtrlSetBkColor($label,$GUI_BKCOLOR_TRANSPARENT )
		GUICtrlSetColor($label, 0x770000)
		if $line>1 Then
			$count=-1
		Else
			$count=$line
		EndIf
		FileSetPos($file,0,0)
		$data=FileReadLine($file,$count)
		$data=StringReplace($data," ","")
		$word=GUICtrlCreateLabel($data,120,280,500,100)
		GUICtrlSetBkColor($word,$GUI_BKCOLOR_TRANSPARENT )
		GUICtrlSetColor($word, 0x770000)
	elseIf $m=6 Then
		gset($pic,"credit.jpg")
	EndIf
	sleep(1)
EndFunc

Func getP($m)
	if $m=0 Then
		if($p[0]>55 And $p[0]<297) Then
			if($p[1]>196 And $p[1]<254) Then
				return 1
			elseif($p[1]>292 And $p[1]<350) Then
				return 2
			elseif($p[1]>389 And $p[1]<447) Then
				return 3
			EndIf
		elseif($p[0]>337 And $p[0]<580) Then
			if($p[1]>196 And $p[1]<254) Then
				return 4
			elseif($p[1]>292 And $p[1]<350) Then
				return 5
			elseif($p[1]>389 And $p[1]<447) Then
				return 6
			EndIf
		EndIf
	elseif $m=1 Then
		if $p[1]>150 And $p[1]<250 Then
			if $p[0]>40 And $p[0]<140 Then
				return 1
			ElseIf $p[0]>155 And $p[0]<255 Then
				return 2
			ElseIf $p[0]>270 And $p[0]<370 Then
				return 3
			ElseIf $p[0]>385 And $p[0]<485 Then
				return 4
			ElseIf $p[0]>500 And $p[0]<600 Then
				return 5
			EndIf
		ElseIf $p[1]>265 And $p[1]<365 Then
			if $p[0]>40 And $p[0]<140 Then
				return 6
			ElseIf $p[0]>155 And $p[0]<255 Then
				return 7
			ElseIf $p[0]>270 And $p[0]<370 Then
				return 8
			ElseIf $p[0]>385 And $p[0]<485 Then
				return 9
			ElseIf $p[0]>500 And $p[0]<600 Then
				return 10
			EndIf
		ElseIf $p[0]>122 And $p[0]<404 And $p[1]>425 And $p[1]<478 Then
			return 11
		Else
			return chkBack()
		EndIf
	elseif $m=2 Then
		return chkBack()
	elseif $m=3 Then
		If($p[1]>394 And $p[1]<450) Then
			if($p[0]>193 and $p[0]<323) Then
				return 1
			ElseIf($p[0]>332 And $p[0]<455) Then
				return 2
			EndIf
		Else
			return chkBack()
		EndIf
	elseif $m=4 Then
		if $p[1]>150 And $p[1]<250 Then
			if $p[0]>40 And $p[0]<140 Then
				return 1
			ElseIf $p[0]>155 And $p[0]<255 Then
				return 2
			ElseIf $p[0]>270 And $p[0]<370 Then
				return 3
			ElseIf $p[0]>385 And $p[0]<485 Then
				return 4
			ElseIf $p[0]>500 And $p[0]<600 Then
				return 5
			EndIf
		ElseIf $p[1]>265 And $p[1]<365 Then
			if $p[0]>40 And $p[0]<140 Then
				return 6
			ElseIf $p[0]>155 And $p[0]<255 Then
				return 7
			ElseIf $p[0]>270 And $p[0]<370 Then
				return 8
			ElseIf $p[0]>385 And $p[0]<485 Then
				return 9
			ElseIf $p[0]>500 And $p[0]<600 Then
				return 10
			EndIf
		ElseIf $p[0]>122 And $p[0]<404 And $p[1]>425 And $p[1]<478 Then
			return 11
		Else
			return chkBack()
		EndIf
	elseif $m=51 Then
		if($p[1]>128 And $p[1]<175) Then
			If($p[0]>401 And $p[0]<568) Then
				return 1
			EndIf
		ElseIf($p[0]>482 And $p[0]<582) Then
			if($p[1]>290 And $p[1]<339) Then
				return 2
			ElseIf($p[1]>353 And $p[1]<403) Then
				return 3
			EndIf
		Else
			return chkBack()
		EndIf
	elseif $m=52 Then
		if($p[0]>79 And $p[0]<245 And $p[1]>128 And $p[1]<175) Then
			return 1
		ElseIf($p[0]>42 And $p[0]<96 And $p[1]>297 and $p[1]<348) Then
			return 2
		ElseIf($p[1]>394 And $p[1]<450) Then
			if($p[0]>193 and $p[0]<323) Then
				return 3
			ElseIf($p[0]>332 And $p[0]<455) Then
				return 4
			EndIf
		Else
			return chkBack()
		EndIf
	elseif $m=6 Then
		return chkBack()
	EndIf
	return -1
EndFunc

Func chkBack()
	if $p[0]>14 And $p[0]<58 And $p[1]>441 And $p[1]<490 Then
		return 0
	Else
		return -1
	endif
EndFunc

Func gen()
	$time=GUICtrlCreateLabel("60",553,62,50,50,0x01)
	GUICtrlSetBkColor($time,$GUI_BKCOLOR_TRANSPARENT )
	GUICtrlSetColor($time, 0x770000)
	GUICtrlSetState($time,$GUI_SHOW)
	$score=GUICtrlCreateLabel("0",547,415,50,50,0x01)
	GUICtrlSetBkColor($score,$GUI_BKCOLOR_TRANSPARENT )
	GUICtrlSetColor($score, 0x770000)
	GUICtrlSetState($score,$GUI_SHOW)
	genQuestion()
	For $i=0 to 9 step 1
		$mem[$i]="button1.jpg"
	Next
	$countdown=TimerInit()
EndFunc

Func genQuestion()
	if $ready>0 Then
		gbutton($button[$ready-1],"button1.jpg")
		$ready=0
	EndIf
	$line=_FileCountLines("test.txt")-1
	$rand=Random(-1,$line,1)
	While $rand=0
		$rand=Random(-1,$line,1)
	WEnd
	FileSetPos($file,0,0)
	$data=FileReadLine($file,$rand)
	$d=0
	$n=StringInStr($data," ")
	While $n<>0
		$st[$d]=StringTrimRight($data,StringLen($data)-$n)
		$shufflest[$d]=$st[$d]
		$data=StringTrimLeft($data,$n)
		$n=StringInStr($data," ")
		$d=$d+1
	WEnd
	$d=$d-1
	shuffle()
	For $i=0 to 9 Step 1
		GUICtrlSetState($button[$i] ,$GUI_HIDE)
		GUICtrlSetState($ans[$i],$GUI_HIDE)
	Next
	For $i=0 to $d Step 1
		GUICtrlSetData($ans[$i],$shufflest[$i])
		GUICtrlSetState($button[$i] ,$GUI_SHOW)
		GUICtrlSetState($ans[$i],$GUI_SHOW)
	Next
	$hard = TimerInit()
EndFunc

Func shuffle()
	For $i=0 to $d step 1
		$rand=Random(0,$d,1)
		$tmp=$shufflest[$i]
		$shufflest[$i]=$shufflest[$rand]
		$shufflest[$rand]=$tmp
	Next
EndFunc

Func stop()
	FileClose($file)
	FileClose($highscore)
    Exit
EndFunc
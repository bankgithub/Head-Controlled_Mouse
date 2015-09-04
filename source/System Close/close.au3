#include <WinAPI.au3>
#include <WindowsConstants.au3>
;run as admin
DllCall("kernel32.dll", "int", "Wow64DisableWow64FsRedirection", "int", 1)
;run cmd And convert PID to  hwnd
Global $PID2 = ""
$Amow = 500
$handle = ""
$aPID = Run("cmd",@WorkingDir,@SW_HIDE)
Sleep($Amow)
$theWinlist = Winlist()
    Do
        For $i = 1 To $theWinlist[0][0]
            If $theWinlist[$i][0] <> "" Then
                $iPID2 = WinGetProcess($theWinlist[$i][1])
                If $iPID2 = $aPID Then
                    $handle = $theWinlist[$i][1]
                    ExitLoop
                EndIf
            EndIf
        Next
    Until $handle <> 0
ControlSend($handle,"","","tskill osk-l" & "{ENTER}")
ControlSend($handle,"","","tskill osk-m" & "{ENTER}")
ControlSend($handle,"","","tskill osk-s" & "{ENTER}")
ControlSend($handle,"","","tskill zoom" & "{ENTER}")
Global Const $lciWM_SYSCommand = 274
Global Const $lciSC_MonitorPower = 61808
Global Const $lciPower_Off = 2
Global Const $lciPower_On = -1

Global $MonitorIsOff = False

_Monitor_OFF()
#cs
HotKeySet("{F11}", "_Monitor_OFF")
HotKeySet("{F10}", "_Monitor_ON")
HotKeySet("{Esc}", "_Quit")


MsgBox(64, "Monitor On/Off", "Press F11 to turn off the monitor." & @LF & _
                            "Press F10 to turn on the monitor back." & @LF & _
                            "Press ESC to turn on the monitor and exit program.")


While 1
    Sleep(10)
WEnd
#ce
Func _Monitor_ON()
    $MonitorIsOff = False
    Local $Progman_hwnd = WinGetHandle('[CLASS:Progman]')

    DllCall('user32.dll', 'int', 'SendMessage', _
                                                'hwnd', $Progman_hwnd, _
                                                'int', $lciWM_SYSCommand, _
                                                'int', $lciSC_MonitorPower, _
                                                'int', $lciPower_On)
EndFunc

Func _Monitor_OFF()
    $MonitorIsOff = True
    Local $Progman_hwnd = WinGetHandle('[CLASS:Progman]')

    ;While $MonitorIsOff = True
        DllCall('user32.dll', 'int', 'SendMessage', _
                                                    'hwnd', $Progman_hwnd, _
                                                    'int', $lciWM_SYSCommand, _
                                                    'int', $lciSC_MonitorPower, _
                                                    'int', $lciPower_Off)
    ;WEnd
EndFunc

Func _IdleWaitCommit($idlesec)
    Local $iSave, $LastInputInfo = DllStructCreate ("uint;dword")
    DllStructSetData ($LastInputInfo, 1, DllStructGetSize ($LastInputInfo))
    DllCall ("user32.dll", "int", "GetLastInputInfo", "ptr", DllStructGetPtr ($LastInputInfo))
    Do
        $iSave = DllStructGetData ($LastInputInfo, 2)
        Sleep(60)
        DllCall ("user32.dll", "int", "GetLastInputInfo", "ptr", DllStructGetPtr ($LastInputInfo))
    Until (DllStructGetData ($LastInputInfo, 2)-$iSave) > $idlesec Or $MonitorIsOff = False
    Return DllStructGetData ($LastInputInfo, 2)-$iSave
EndFunc

Func _Quit()
    _Monitor_ON()
    Exit
EndFunc
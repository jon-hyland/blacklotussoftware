Attribute VB_Name = "Code"
Const sSaveFileName = "blclock.dat"
Dim fAlarm As frmAlarm
Dim fError As frmError
Dim fSet As frmSet
Dim fAbout As frmInfo
Dim fBeep As frmBeep
Public iAlarmHour As Integer
Public iAlarmMin As Integer
Public sAlarmAMPM As String
Public bAlarmOn As Boolean

Public Sub Main()
    On Error GoTo ErrorHandler
    Load_Settings
    Set fAlarm = New frmAlarm
    Update_Time
    fAlarm.Show
    
    Exit Sub

ErrorHandler:
    Set fError = New frmError
    fError.lblMsg = "An error has occured in Sub Main.  " & Err.Description
    fError.Show vbModal
End Sub

Public Sub Load_Settings()
    On Error GoTo ErrorHandler
    If Right(App.Path, 1) <> "\" Then
        Open App.Path & "\" & sSaveFileName For Input As #1
    Else
        Open App.Path & sSaveFileName For Input As #1
    End If
    Input #1, iAlarmHour
    Input #1, iAlarmMin
    Input #1, sAlarmAMPM
    Input #1, bAlarmOn
    Close #1
    Exit Sub
    
ErrorHandler:
    Set fError = New frmError
    fError.lblMsg = "An error has occured in Sub Load_Settings.  " & Err.Description
    fError.Show vbModal
End Sub

Public Sub Save_Settings()
    On Error GoTo ErrorHandler
    
    If Right(App.Path, 1) <> "\" Then
        Open App.Path & "\" & sSaveFileName For Output As #1
    Else
        Open App.Path & sSaveFileName For Output As #1
    End If
    Write #1, iAlarmHour
    Write #1, iAlarmMin
    Write #1, sAlarmAMPM
    Write #1, bAlarmOn
    Close #1
    Exit Sub
    
ErrorHandler:
    Set fError = New frmError
    fError.lblMsg = "An error has occured in Sub Save_Settings.  " & Err.Description
    fError.Show vbModal
End Sub

Public Sub Update_Time()
    Dim sTime As String
    Dim sAlarm As String
    Dim iHour As Integer, iMin As Integer, iSec As Integer, sAMPM As String
    Static iOSec As Integer
            
    On Error GoTo ErrorHandler
    sTime = Time$
    iHour = Val(Mid(sTime, 1, 2))
    iMin = Val(Mid(sTime, 4, 2))
    iSec = Val(Mid(sTime, 7, 2))
    iOHour = iOHour + 1
    iOMin = iOMin + 1
    If iSec <> iOSec Then
        Select Case iHour
            Case 0
                iHour = 12
                sAMPM = "AM"
            Case 1 To 11
                sAMPM = "AM"
            Case 12
                sAMPM = "PM"
            Case 13 To 23
                iHour = iHour - 12
                sAMPM = "PM"
        End Select
        sTime = Str(iHour) & ":" & Format(iMin, "00") & "  " & sAMPM
        fAlarm.lblTime.Caption = sTime
        fAlarm.lblSec.Caption = Format(iSec, "00")
        If bAlarmOn Then
            fAlarm.shpAlarm.FillColor = &HC00000
        Else
            fAlarm.shpAlarm.FillColor = &H80&
        End If
    End If
    If bAlarmOn Then
        If (iHour = iAlarmHour) And (iMin = iAlarmMin) And (sAMPM = sAlarmAMPM) Then
            Set fBeep = New frmBeep
            fBeep.Show vbModal
            bAlarmOn = False
            fSet.cmdOnOff.Caption = "Alarm is OFF"
        End If
    End If
    sAlarm = Str(iAlarmHour) & ":" & Format(iAlarmMin, "00") & "  " & sAlarmAMPM
    fAlarm.lblAlarm.Caption = sAlarm
    Exit Sub
     
ErrorHandler:
    Set fError = New frmError
    fError.lblMsg = "An error has occured in Sub Update_Time.  " & Err.Description
    fError.Show vbModal
End Sub

Public Sub Show_Settings()
    Set fSet = New frmSet
    fSet.Show vbModal
End Sub

Public Sub Update_Settings()
    On Error GoTo ErrorHandler
    If bAlarmOn Then
        fSet.cmdOnOff.Caption = "Alarm is ON"
        fAlarm.shpAlarm.FillColor = &HC00000
    Else
        fSet.cmdOnOff.Caption = "Alarm is OFF"
        fAlarm.shpAlarm.FillColor = &H80&
    End If
    fSet.txtHour.Text = Str(iAlarmHour)
    fSet.txtMin.Text = Str(iAlarmMin)
    If sAlarmAMPM = "AM" Then
        fSet.optAM.Value = True
    Else
        fSet.optPM.Value = True
    End If
    Exit Sub
    
ErrorHandler:
    Set fError = New frmError
    fError.lblMsg = "An error has occured in Sub Update_Settings.  " & Err.Description
    fError.Show vbModal
End Sub

Public Sub Show_About()
    Set fAbout = New frmInfo
    fAbout.Show vbModal
End Sub

Public Sub Alarm_OnOff()
    On Error GoTo ErrorHandler
    If bAlarmOn Then
        bAlarmOn = False
        fSet.cmdOnOff.Caption = "Alarm is OFF"
        fAlarm.shpAlarm.FillColor = &H80&
    Else
        bAlarmOn = True
        fSet.cmdOnOff.Caption = "Alarm is ON"
        fAlarm.shpAlarm.FillColor = &HC00000
    End If
    Save_Settings
    Exit Sub
    
ErrorHandler:
    Set fError = New frmError
    fError.lblMsg = "An error has occured in Sub Alarm_OnOff.  " & Err.Description
    fError.Show vbModal
End Sub

Public Sub End_Prog()
    On Error GoTo ErrorHandler
    Set fError = Nothing
    Set fAlarm = Nothing
    End
    Exit Sub

ErrorHandler:
    Set fError = New frmError
    fError.lblMsg = "An error has occured in Sub End_Prog.  " & Err.Description
    fError.Show vbModal
End Sub

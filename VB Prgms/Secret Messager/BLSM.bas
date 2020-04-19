Attribute VB_Name = "BLSM"
Public fMsg As frmInterface
Public fSplash As frmSplash
Public fInfo As frmInfo
Public fFile As frmGetFile
Public fDisp As frmDisplay
Public fHelp As frmHelpFile
Public fTest As frmTest
Public sGetFileResult As String
Public bDisplayResult As Boolean
Public bMsgChanged As Boolean
Public bCancelQuit As Boolean

Public Sub Main()
    Set fMsg = New frmInterface
    fMsg.Show
    Clear_Msg
End Sub

Public Sub End_Prog()
    If bMsgChanged Then
        Set fDisp = New frmDisplay
        fDisp.cmdOK.Visible = False
        fDisp.Caption = "Warning!"
        fDisp.lblDisp.Caption = "You have not saved changes to your message.  Are you sure you want to exit the program?"
        fDisp.Show vbModal
        If bDisplayResult = True Then
            Set fInfo = Nothing
            Set fSplash = Nothing
            Set fMsg = Nothing
            End
        Else
            bCancelQuit = True
        End If
    Else
        Set fInfo = Nothing
        Set fSplash = Nothing
        Set fMsg = Nothing
        End
    End If
End Sub

Public Sub Show_Splash()
    Set fSplash = New frmSplash
    fSplash.Show vbModal
End Sub

Public Sub Show_Info()
    Set fInfo = New frmInfo
    fInfo.Show vbModal
End Sub

Public Sub Clear_Msg()
    If bMsgChanged Then
        Set fDisp = New frmDisplay
        fDisp.cmdOK.Visible = False
        fDisp.Caption = "Warning!"
        fDisp.lblDisp.Caption = "You have not saved changes to your message.  Are you sure you want to clear the current message?"
        fDisp.Show vbModal
        If bDisplayResult = True Then
            fMsg.txtMsg.Text = ""
            fMsg.txtMsg.SetFocus
            bMsgChanged = False
        End If
    Else
        fMsg.txtMsg.Text = ""
        fMsg.txtMsg.SetFocus
        bMsgChanged = False
    End If
End Sub

Public Sub Save_File()
    Dim sCode As String
        
    On Error GoTo ErrorHandler
    Set fFile = New frmGetFile
    fFile.Caption = "Save File"
    fFile.sWildcard = "*.blm"
    fFile.sReqExt = ".blm"
    fFile.Show vbModal
    Set fFile = Nothing
    If sGetFileResult <> "#CANCEL#" Then
        sCode = BLStrCrypt(fMsg.txtMsg.Text)
        Open sGetFileResult For Output As #1
            Write #1, sCode
        Close #1
    End If
    bMsgChanged = False
    Exit Sub

ErrorHandler:
    MsgBox "An error has occured in Sub Save_File. " & Err.Description & "."
End Sub

Public Sub Open_File()
    Dim sCode As String
    
    On Error GoTo ErrorHandler
    If bMsgChanged Then
        Set fDisp = New frmDisplay
        fDisp.cmdOK.Visible = False
        fDisp.Caption = "Warning!"
        fDisp.lblDisp.Caption = "You have not saved changes to your message.  Are you sure you want to open a new message?"
        fDisp.Show vbModal
        If bDisplayResult = True Then
            Set fFile = New frmGetFile
            fFile.Caption = "Open File"
            fFile.sWildcard = "*.blm"
            fFile.sReqExt = ".blm"
            fFile.Show vbModal
            Set fFile = Nothing
            If sGetFileResult <> "#CANCEL#" Then
                Open sGetFileResult For Input As #1
                    Input #1, sCode
                Close #1
                fMsg.txtMsg.Text = BLStrDecrypt(sCode)
            End If
            bMsgChanged = False
        End If
    Else
        Set fFile = New frmGetFile
        fFile.Caption = "Open File"
        fFile.sWildcard = "*.blm"
        fFile.sReqExt = ".blm"
        fFile.Show vbModal
        Set fFile = Nothing
        If sGetFileResult <> "#CANCEL#" Then
            Open sGetFileResult For Input As #1
                Input #1, sCode
            Close #1
            fMsg.txtMsg.Text = BLStrDecrypt(sCode)
        End If
        bMsgChanged = False
    End If
    Exit Sub
    
ErrorHandler:
    Select Case Err.Number
        Case 53, 76
            Set fDisp = New frmDisplay
            fDisp.cmdYes.Visible = False
            fDisp.cmdNo.Visible = False
            fDisp.Caption = "File Not Found"
            fDisp.lblDisp.Caption = "The file " & sGetFileResult & " not found.  Please recheck location and spelling and try again."
            fDisp.Show vbModal
        Case Else
            MsgBox "An error has occured in Sub Open_File. " & Err.Description & "." & "Error number " & Err.Number & "."
    End Select
End Sub

Public Sub Show_Help()
    Set fHelp = New frmHelpFile
    fHelp.Show vbModal
End Sub

Public Sub Msg_Changed()
    bMsgChanged = True
End Sub

Public Function BLStrCrypt(ByVal sInStr As String) As String
    Dim nSeed As Single
    Dim sSeed As String
    Dim sOutStr As String
    Dim iCount As Integer
    Dim sChar As String
    Dim iChar As Integer
    Dim iRot As Integer
    Dim iRotCount As Integer
    
    On Error GoTo ErrorHandler
    Do
        Randomize
        nSeed = Rnd
        sSeed = Str(nSeed)
        While Left(sSeed, 1) = " "
            sSeed = Right(sSeed, Len(sSeed) - 1)
        Wend
    Loop Until Len(sSeed) = 8
    nSeed = Val(sSeed)
    Rnd (-1)
    Randomize (nSeed)
    sOutStr = sSeed
    For iCount = 1 To Len(sInStr)
        sChar = Mid(sInStr, iCount, 1)
        iChar = Asc(sChar)
        If (iChar < 32) Or (iChar > 253) Then iChar = 32
        iRot = Int((Rnd * 222) + 1)
        For iRotCount = 1 To iRot
            iChar = iChar + 1
            If iChar > 253 Then iChar = 32
        Next iRotCount
        If iChar = 34 Then iChar = 254
        sChar = Chr(iChar)
        sOutStr = sOutStr & sChar
    Next iCount
    BLStrCrypt = sOutStr
    Exit Function
ErrorHandler:
    MsgBox "An error has occured in function BLStrCrypt."
End Function

Public Function BLStrDecrypt(ByVal sInStr As String) As String
    Dim nSeed As Single
    Dim sSeed As String
    Dim sOutStr As String
    Dim iCount As Integer
    Dim sChar As String
    Dim iChar As Integer
    Dim iRot As Integer
    Dim iRotCount As Integer
    
    On Error GoTo ErrorHandler
    sSeed = Left(sInStr, 8)
    sInStr = Right(sInStr, Len(sInStr) - 8)
    nSeed = Val(sSeed)
    Rnd (-1)
    Randomize (nSeed)
    sOutStr = ""
    For iCount = 1 To Len(sInStr)
        sChar = Mid(sInStr, iCount, 1)
        iChar = Asc(sChar)
        If iChar = 254 Then iChar = 34
        If (iChar < 32) Or (iChar > 253) Then iChar = 32
        iRot = Int((Rnd * 222) + 1)
        For iRotCount = 1 To iRot
            iChar = iChar - 1
            If iChar < 32 Then iChar = 253
        Next iRotCount
        sChar = Chr(iChar)
        sOutStr = sOutStr & sChar
    Next iCount
    BLStrDecrypt = sOutStr
    Exit Function
ErrorHandler:
    MsgBox "An error has occured in function BLStrDecrypt."
End Function

Public Sub Test_It()
    Dim sMsg1 As String
    Dim sCode1 As String
    Dim sCode2 As String
    Dim sMsg2 As String
    
    sMsg1 = fMsg.txtMsg.Text
    sCode1 = BLStrCrypt(sMsg1)
    If Right(App.Path, 1) <> "\" Then
        Open App.Path & "\" & "test.blm" For Output As #1
    Else
        Open App.Path & "test.blm" For Output As #1
    End If
    Write #1, sCode1
    Close #1
    If Right(App.Path, 1) <> "\" Then
        Open App.Path & "\" & "test.blm" For Input As #1
    Else
        Open App.Path & "test.blm" For Input As #1
    End If
    Input #1, sCode2
    Close #1
    sMsg2 = BLStrDecrypt(sCode2)
    Set fTest = New frmTest
    fTest.txt1.Text = sMsg1
    fTest.lbl1.Caption = "Original message. (" & Str(Len(sMsg1)) & " char)"
    fTest.txt2.Text = sCode1
    fTest.lbl2.Caption = "Coded message encrypted from original message. (" & Str(Len(sCode1)) & " char)"
    fTest.txt3.Text = sCode2
    fTest.lbl3.Caption = "Coded message taken from file. (" & Str(Len(sCode2)) & " char)"
    fTest.txt4.Text = sMsg2
    fTest.lbl4.Caption = "Decoded message taken from above. (" & Str(Len(sMsg2)) & " char)"
    fTest.Show vbModal
End Sub

Attribute VB_Name = "BLBC"
Option Explicit
Public fBinEnc As frmInterface
Public fSplash As frmSplash
Public fFile As frmGetFile
Public fDisp As frmDisplay
Public fHelp As frmHelpFile
Public fInfo As frmInfo
Public fPass As frmPassword
Public sGetFileResult As String
Public bDisplayResult As Boolean
Public bPassword As Boolean
Public sPassword As String
Public sInFile As String
Public sOutFile As String
Public nPassSeed As Single
Public iProcType As Integer
Public bCancelProc As Boolean

Public Sub Main()
    Randomize
    Set fBinEnc = New frmInterface
    fBinEnc.Show
End Sub

Public Sub End_Prog()
    Set fSplash = Nothing
    Set fFile = Nothing
    Set fDisp = Nothing
    Set fHelp = Nothing
    Set fInfo = Nothing
    Set fPass = Nothing
    Set fBinEnc = Nothing
    End
End Sub

Public Sub Get_InFile()
    Set fFile = New frmGetFile
    If fBinEnc.iMenu = 1 Then
        fFile.Caption = "Open File to Encrypt"
        fFile.sWildcard = "*.*"
        fFile.sReqExt = ""
    Else
        fFile.Caption = "Open File to Decrypt"
        fFile.sWildcard = "*.blc"
        fFile.sReqExt = ".blc"
    End If
    fFile.Show vbModal
    Set fFile = Nothing
    If sGetFileResult <> "#CANCEL#" Then
        fBinEnc.txtInFile.Text = sGetFileResult
    Else
        fBinEnc.txtInFile.Text = ""
    End If
End Sub

Public Sub Get_OutFile()
    Set fFile = New frmGetFile
    If fBinEnc.iMenu = 1 Then
        fFile.Caption = "Save Encrypted File As"
        fFile.sWildcard = "*.blc"
        fFile.sReqExt = ".blc"
    Else
        fFile.Caption = "Save Decrypted File As"
        fFile.sWildcard = "*.*"
        fFile.sReqExt = ""
    End If
    fFile.Show vbModal
    Set fFile = Nothing
    If sGetFileResult <> "#CANCEL#" Then
        fBinEnc.txtOutFile.Text = sGetFileResult
    Else
        fBinEnc.txtOutFile.Text = ""
    End If
End Sub

Public Sub Encrypt_Now()
    bCancelProc = False
    sInFile = fBinEnc.txtInFile.Text
    sOutFile = fBinEnc.txtOutFile.Text
    If bPassword Then
        Set fPass = New frmPassword
        fPass.Show vbModal
    Else
        nPassSeed = Rnd()
    End If
    If Not bCancelProc Then
        iProcType = 1
        Dim fProc As New frmProcess
        fProc.Show vbModal
    End If
End Sub

Public Sub Decrypt_Now()
    bCancelProc = False
    sInFile = fBinEnc.txtInFile.Text
    sOutFile = fBinEnc.txtOutFile.Text
    bPassword = Has_Password(sInFile)
    If bPassword Then
        Set fPass = New frmPassword
        fPass.Show vbModal
    End If
    If Not bCancelProc Then
        iProcType = 2
        Dim fProc As New frmProcess
        fProc.Show vbModal
    End If
End Sub

Public Sub Show_Help()
    Dim sHelp As String
    
    On Error GoTo ErrorHandler
    Set fHelp = New frmHelpFile
    If Right(App.Path, 1) <> "\" Then
        Open App.Path + "\" + "helpdoc.bct" For Input As #1
    Else
        Open App.Path + "helpdoc.bct" For Input As #1
    End If
    Input #1, sHelp
    Close #1
    fHelp.txtHelp = sHelp
    fHelp.Show vbModal
    Exit Sub

ErrorHandler:
    Set fDisp = New frmDisplay
    fDisp.Caption = "Error!"
    fDisp.lblDisp.Caption = "Cannot display help file.  Make sure file helpdoc.bct exists in application folder."
    fDisp.cmdYes.Visible = False
    fDisp.cmdNo.Visible = False
    fDisp.Show vbModal
End Sub

Public Sub Show_Info()
    Set fInfo = New frmInfo
    fInfo.Show vbModal
End Sub

Public Function Password_2_Seed(sPass As String) As Single
    Const iTagUp = 20
    Dim nSeed As Single
    Dim iCount As Integer
    
    If (Len(sPass) < 3) Or (Len(sPass) > 12) Then
        Set fDisp = New frmDisplay
        fDisp.Caption = "Incorrect Format"
        fDisp.lblDisp.Caption = "Password is not in correct range.  3 - 12 characters allowed."
        fDisp.cmdYes.Visible = False
        fDisp.cmdNo.Visible = False
        fDisp.Show vbModal
    End If
    nSeed = Asc(sPass) + iTagUp
    sPass = Right(sPass, Len(sPass) - 1)
    nSeed = nSeed * (Asc(sPass) + iTagUp)
    sPass = Right(sPass, Len(sPass) - 1)
    nSeed = nSeed * (Asc(sPass) + iTagUp)
    sPass = Right(sPass, Len(sPass) - 1)
    For iCount = 1 To Len(sPass)
        nSeed = nSeed + Asc(sPass) + iTagUp
        sPass = Right(sPass, Len(sPass) - 1)
    Next iCount
    While (nSeed >= 1)
        nSeed = nSeed / 10
    Wend
    Password_2_Seed = nSeed
End Function

Public Function Has_Password(sFile As String) As Boolean
    Dim nJunk As Long
    Dim bPass As Boolean
    
    On Error GoTo ErrorHandler
    Open sFile For Binary As #1
    Get #1, , nJunk
    Get #1, , bPass
    Close #1
    Has_Password = bPass
    Exit Function
    
ErrorHandler:
    MsgBox "Error! Cannot open file."
    End_Prog
End Function

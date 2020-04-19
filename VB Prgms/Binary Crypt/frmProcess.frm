VERSION 5.00
Begin VB.Form frmProcess 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Black Lotus Binary Crypt"
   ClientHeight    =   1260
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3150
   Icon            =   "frmProcess.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1260
   ScaleWidth      =   3150
   StartUpPosition =   1  'CenterOwner
   Begin VB.Timer tmrClock 
      Enabled         =   0   'False
      Interval        =   10
      Left            =   2700
      Top             =   780
   End
   Begin VB.Label lblCap 
      Alignment       =   2  'Center
      Caption         =   "Now encrypting your file.  Please wait."
      Height          =   255
      Left            =   60
      TabIndex        =   1
      Top             =   120
      Width           =   3015
   End
   Begin VB.Shape shpProg 
      FillColor       =   &H000080FF&
      FillStyle       =   0  'Solid
      Height          =   255
      Left            =   360
      Top             =   540
      Width           =   2415
   End
   Begin VB.Label lblProg 
      Alignment       =   2  'Center
      Caption         =   "0% done."
      Height          =   195
      Left            =   420
      TabIndex        =   0
      Top             =   960
      Width           =   2295
   End
   Begin VB.Shape shpBack 
      FillColor       =   &H00808080&
      FillStyle       =   0  'Solid
      Height          =   375
      Left            =   300
      Top             =   480
      Width           =   2535
   End
End
Attribute VB_Name = "frmProcess"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim iBytesDone As Long
Dim iBytesTot As Long
Dim iByteWorth As Single
Dim iBLCTag As Long

Private Sub Form_Activate()
    Dim iBytesCoded As Long
        
    On Error GoTo ErrorHandler
    iBLCTag = 6676672
    If BLBC.iProcType = 1 Then      ' Encrypt file
        If FileLen(BLBC.sInFile) > 0 Then
            iByteWorth = 2415 / FileLen(BLBC.sInFile)
        Else
            iByteWorth = 1
        End If
        Me.Caption = "Black Lotus Binary Crypt"
        lblProg.Caption = Str(iBytesDone) & " / " & Str(iBytesTot) & " bytes done."
        lblCap.Caption = "Now encrypting your file.  Please wait."
        iBytesCoded = Binary_Crypt(BLBC.sInFile, BLBC.sOutFile, BLBC.bPassword, BLBC.nPassSeed)
        shpProg.Width = iBytesDone * iByteWorth
    Else                            ' Decrypt file
        If FileLen(BLBC.sInFile) > 8 Then
            iByteWorth = 2415 / (FileLen(BLBC.sInFile) - 8)
        Else
            iByteWorth = 1
        End If
        Me.Caption = "Black Lotus Binary Decrypt"
        lblProg.Caption = Str(iBytesDone) & " / " & Str(iBytesTot) & " bytes done."
        lblCap.Caption = "Now decrypting your file.  Please wait."
        iBytesCoded = Binary_Decrypt(BLBC.sInFile, BLBC.sOutFile, BLBC.nPassSeed)
        shpProg.Width = iBytesDone * iByteWorth
    End If
    Unload Me
    Exit Sub
    
ErrorHandler:
    Set fDisp = New frmDisplay
    fDisp.Caption = "Error!"
    fDisp.lblDisp.Caption = "An unexpected error has occured while trying to crypt or decrypt a file.  An invalid filepath was probably entered.  Click OK to end program."
    fDisp.cmdYes.Visible = False
    fDisp.cmdNo.Visible = False
    fDisp.Show vbModal
    Close
    End_Prog
End Sub

' Black Lotus Binary Crypt Function v2.0
' (c) 1999 Black Lotus Software. All rights reserved.
' Converts a binary file passed to in into an encrypted
' binary form.  Function returns number of bytes encrypted,
' or negative number for possible defined error values.
Public Function Binary_Crypt(ByVal sInFile As String, ByVal sOutFile As String, ByVal bUsePass As Boolean, ByVal nPassSeed As Single) As Long
    Dim nSeed As Single
    Dim iByte As Byte
    Dim iIByte As Integer
    Dim iSize As Long
    Dim iBCnt As Long
    Dim iICnt As Integer
    Dim iPercent As Integer     ' added for progress indicator
    
    On Error GoTo ErrorHandler
    Randomize
    nSeed = Rnd
    Open sInFile For Binary As #1
    Open sOutFile For Binary As #2
    Put #2, , iBLCTag
    Put #2, , bUsePass
    Put #2, , nSeed
    If bUsePass Then
        nSeed = nSeed + nPassSeed
        While (nSeed >= 1)
            nSeed = nSeed / 10
        Wend
    End If
    Rnd -1
    Randomize nSeed
    iSize = FileLen(sInFile)
    iBytesTot = iSize
    iBytesDone = 0
    iPercent = -1               ' added for progress indicator
    For iBCnt = 1 To iSize
        If Not EOF(1) Then
            Get #1, , iByte
            iIByte = iByte
            For iICnt = 1 To Int((Rnd * 192) + 1)
                iIByte = iIByte + 1
                If iIByte > 255 Then iIByte = 0
            Next iICnt
            iByte = iIByte
            Put #2, , iByte
            iBytesDone = iBytesDone + 1
            ' added for progress indicator, next 5 lines
            If Int((iBytesDone / iSize) * 100) <> iPercent Then
                iPercent = Int((iBytesDone / iSize) * 100)
                lblProg.Caption = Str(iPercent) & "% done."
                shpProg.Width = iBytesDone * iByteWorth
            End If
        Else
            MsgBox "Error! Attempt to read past end of input file."
            Binary_Crypt = -1
            Close
            Exit Function
        End If
    Next iBCnt
    Close
    Binary_Crypt = iBytesDone
    Exit Function

ErrorHandler:
    Set fDisp = New frmDisplay
    fDisp.Caption = "Error!"
    fDisp.lblDisp.Caption = "An unexpected error has occured while trying to crypt or decrypt a file.  An invalid filepath was probably entered.  Click OK to end program."
    fDisp.cmdYes.Visible = False
    fDisp.cmdNo.Visible = False
    fDisp.Show vbModal
    Close
    End_Prog
End Function

Public Function Binary_Decrypt(ByVal sInFile As String, ByVal sOutFile As String, ByVal nPassSeed As Single) As Long
    Dim iTag As Long
    Dim nSeed As Single
    Dim bUsePass As Boolean
    Dim iByte As Byte
    Dim iIByte As Integer
    Dim iSize As Long
    Dim iBCnt As Long
    Dim iICnt As Integer
    Dim iPercent As Integer     ' added for progress indicator
    
    On Error GoTo ErrorHandler
    iSize = FileLen(sInFile) - 10
    iBytesTot = iSize
    iBytesDone = 0
    iPercent = -1               ' added for progress indicator
    Open sInFile For Binary As #1
    Get #1, , iTag
    If iTag <> iBLCTag Then
        MsgBox "Input file type does not appear to be of valid BLBinEnc type."
        Close
        Exit Function
    End If
    Get #1, , bUsePass
    Get #1, , nSeed
    If bUsePass Then
        nSeed = nSeed + nPassSeed
        While (nSeed >= 1)
            nSeed = nSeed / 10
        Wend
    End If
    Rnd -1
    Randomize nSeed
    Open sOutFile For Binary As #2
    For iBCnt = 1 To iSize
        If Not EOF(1) Then
            Get #1, , iByte
            iIByte = iByte
            For iICnt = 1 To Int((Rnd * 192) + 1)
                iIByte = iIByte - 1
                If iIByte < 0 Then iIByte = 255
            Next iICnt
            iByte = iIByte
            Put #2, , iByte
            iBytesDone = iBytesDone + 1
            ' added for progress indicator, next 5 lines
            If Int((iBytesDone / iSize) * 100) <> iPercent Then
                iPercent = Int((iBytesDone / iSize) * 100)
                lblProg.Caption = Str(iPercent) & "% done."
                shpProg.Width = iBytesDone * iByteWorth
            End If
        Else
            MsgBox "Error! Attempt to read past end of input file."
            Binary_Decrypt = -1
            Close
            Exit Function
        End If
    Next iBCnt
    Close
    Binary_Decrypt = iBytesDone
    Exit Function

ErrorHandler:
    Set fDisp = New frmDisplay
    fDisp.Caption = "Error!"
    fDisp.lblDisp.Caption = "An unexpected error has occured while trying to crypt or decrypt a file.  An invalid filepath was probably entered.  Click OK to end program."
    fDisp.cmdYes.Visible = False
    fDisp.cmdNo.Visible = False
    fDisp.Show vbModal
    Close
    End_Prog
End Function


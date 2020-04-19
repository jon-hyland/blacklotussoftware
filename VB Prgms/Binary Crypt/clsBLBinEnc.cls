VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsBLBinEnc"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public iBLCTag As Long
Public iBytesDone As Long
Public iBytesTot As Long

' Black Lotus Binary Encrypt v1.0
' (c) 1999 Black Lotus Software. All rights reserved.
' Converts a binary file passed to in into an encrypted
' binary form.  Function returns number of bytes encrypted,
' or negative number for possible defined error values.
Public Function Binary_Crypt(ByVal sInFile As String, ByVal sOutFile As String) As Long
    Dim nSeed As Single
    Dim iByte As Byte
    Dim iIByte As Integer
    Dim iSize As Long
    Dim iBCnt As Long
    Dim iICnt As Integer
    
    On Error GoTo ErrorHandler
    Randomize
    nSeed = Rnd
    Rnd -1
    Randomize nSeed
    iSize = FileLen(sInFile)
    iBytesTot = iSize
    iBytesDone = 0
    Open sInFile For Binary As #1
    Open sOutFile For Binary As #2
    Put #2, , iBLCTag
    Put #2, , nSeed
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
    MsgBox "Error #" & Str(Err.Number) & ".  " & Err.Description & "."
End Function

Public Sub Binary_Decrypt(ByVal sInFile As String, ByVal sOutFile As String)



End Sub

Private Sub Class_Initialize()
    iBLCTag = 6676671
    iBytesDone = 0
    iBytesTot = 0
End Sub

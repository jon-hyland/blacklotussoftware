VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Perfect Filename"
   ClientHeight    =   1935
   ClientLeft      =   60
   ClientTop       =   375
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   1935
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdClick 
      Caption         =   "Modify"
      Height          =   375
      Left            =   1680
      TabIndex        =   2
      Top             =   1320
      Width           =   1575
   End
   Begin VB.TextBox txtFile 
      Height          =   285
      Left            =   1320
      TabIndex        =   1
      Top             =   480
      Width           =   3135
   End
   Begin VB.Label Label1 
      Caption         =   "Enter long filename."
      Height          =   495
      Left            =   120
      TabIndex        =   0
      Top             =   360
      Width           =   855
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdClick_Click()
    
Dim strFile As String
strFile = txtFile.Text
strFile = Format_Path(strFile)
txtFile.Text = strFile

End Sub

Private Function Format_Path(strFile As String) As String
    Dim strCopy As String
    Dim bteFile(256) As Byte
    Dim bteTemp As Byte
    Dim numOld As Integer
    Dim numNew As Integer
    Dim numBack As Integer
            
    strCopy = strFile
    For numOld = 1 To Len(strFile)
        bteTemp = Asc(Left(strCopy, 1))
        strCopy = Right(strCopy, Len(strCopy) - 1)
        If bteTemp = 92 Then numBack = numBack + 1 Else numBack = 0
        If numBack <= 1 Then
            bteFile(numNew) = bteTemp
            numNew = numNew + 1
        End If
    Next numOld
    strCopy = ""
    For numOld = 1 To numNew
        strCopy = strCopy + Chr(bteFile(numOld - 1))
    Next numOld
    Format_Path = strCopy
End Function

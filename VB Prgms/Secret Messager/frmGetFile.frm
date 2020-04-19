VERSION 5.00
Begin VB.Form frmGetFile 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Caption"
   ClientHeight    =   3795
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4680
   Icon            =   "frmGetFile.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3795
   ScaleWidth      =   4680
   StartUpPosition =   1  'CenterOwner
   Begin VB.TextBox txtWild 
      BackColor       =   &H00E0E0E0&
      Height          =   315
      Left            =   240
      TabIndex        =   6
      Top             =   2340
      Width           =   1215
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   3420
      TabIndex        =   5
      Top             =   3300
      Width           =   1095
   End
   Begin VB.TextBox txtName 
      BackColor       =   &H00E0E0E0&
      Height          =   315
      Left            =   240
      TabIndex        =   4
      Top             =   2820
      Width           =   3255
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Height          =   375
      Left            =   120
      TabIndex        =   3
      Top             =   3300
      Width           =   1095
   End
   Begin VB.FileListBox lstFile 
      BackColor       =   &H00E0E0E0&
      Height          =   2040
      Left            =   2400
      TabIndex        =   2
      Top             =   120
      Width           =   2175
   End
   Begin VB.DirListBox lstFolder 
      BackColor       =   &H00E0E0E0&
      Height          =   1665
      Left            =   120
      TabIndex        =   1
      Top             =   480
      Width           =   2235
   End
   Begin VB.DriveListBox lstDrive 
      BackColor       =   &H00E0E0E0&
      Height          =   315
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   2235
   End
   Begin VB.Label Label2 
      Caption         =   "Filename"
      Height          =   255
      Left            =   3600
      TabIndex        =   8
      Top             =   2820
      Width           =   855
   End
   Begin VB.Label Label1 
      Caption         =   "Files to Show (*.*)"
      Height          =   315
      Left            =   1560
      TabIndex        =   7
      Top             =   2340
      Width           =   1635
   End
End
Attribute VB_Name = "frmGetFile"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public sWildcard As String
Public sReqExt As String    ' "" = None reg., ".txt" = req. .txt

Private Sub cmdCancel_Click()
    BLSM.sGetFileResult = "#CANCEL#"
    Unload Me
End Sub

Private Sub cmdOK_Click()
    If Right(lstFolder.Path, 1) <> "\" Then
        BLSM.sGetFileResult = lstFolder.Path & "\" & txtName.Text
    Else
        BLSM.sGetFileResult = lstFolder.Path & txtName.Text
    End If
    Unload Me
End Sub

Private Sub Form_Activate()
    txtWild.Text = sWildcard
    lstFile.Pattern = sWildcard
    BLSM.sGetFileResult = "#CANCEL#"
End Sub

Private Sub lstDrive_Change()
    lstFolder.Path = lstDrive.Drive
    
End Sub

Private Sub lstFile_Click()
    txtName.Text = lstFile.List(lstFile.ListIndex)
End Sub

Private Sub lstFile_DblClick()
    cmdOK_Click
End Sub

Private Sub lstFolder_Change()
    lstFile.Path = lstFolder.Path
End Sub

Private Sub txtName_LostFocus()
    Dim iCount As Integer
    Dim iPos As Integer
    
    iCount = Len(txtName.Text)
    Do Until (iCount <= 0)
        If Mid(txtName.Text, iCount, 1) = "\" Or Mid(txtName.Text, iCount, 1) = "/" Then
            If iPos < iCount Then iPos = iCount
        End If
        iCount = iCount - 1
    Loop
    If iPos > 0 Then txtName.Text = Mid(txtName.Text, iPos + 1)
    If sReqExt <> "" Then
        If Right(txtName.Text, Len(sReqExt)) <> sReqExt Then
            txtName.Text = txtName.Text & sReqExt
        End If
    End If
End Sub


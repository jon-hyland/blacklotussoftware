VERSION 5.00
Begin VB.Form frmHelpFile 
   Caption         =   "Secret Messager Help File"
   ClientHeight    =   5700
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7560
   Icon            =   "frmHelpFile.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   5700
   ScaleWidth      =   7560
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cmdDone 
      Caption         =   "Done"
      Height          =   375
      Left            =   3180
      TabIndex        =   1
      Top             =   5220
      Width           =   1215
   End
   Begin VB.TextBox txtHelp 
      BackColor       =   &H00E0E0E0&
      Height          =   4995
      Left            =   60
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Text            =   "frmHelpFile.frx":030A
      Top             =   60
      Width           =   7455
   End
End
Attribute VB_Name = "frmHelpFile"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdDone_Click()
    Unload Me
End Sub

Private Sub Form_Load()
    Dim sHelp As String
    
    On Error GoTo ErrorHandler
    If Right(App.Path, 1) <> "\" Then
        Open App.Path & "\" & "readme.txp" For Input As #1
    Else
        Open App.Path & "readme.txp" For Input As #1
    End If
    Input #1, sHelp
    Close #1
    txtHelp.Text = sHelp
    Exit Sub
    
ErrorHandler:
    MsgBox "An error has occured in frmHelpFile.Form_Load. " & Err.Description & "."
End Sub

VERSION 5.00
Begin VB.Form Main 
   BorderStyle     =   0  'None
   Caption         =   "Black Lotus Slider"
   ClientHeight    =   3195
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4095
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   ScaleHeight     =   3195
   ScaleWidth      =   4095
   Begin VB.Timer tmrClock 
      Interval        =   100
      Left            =   240
      Top             =   2520
   End
   Begin VB.CommandButton cmdNext 
      Caption         =   "Next"
      Height          =   255
      Left            =   1440
      TabIndex        =   1
      Top             =   240
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.CommandButton cmdPrev 
      Caption         =   "Prev"
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.Image imgWin 
      Height          =   1455
      Left            =   1080
      Stretch         =   -1  'True
      Top             =   840
      Width           =   1935
   End
End
Attribute VB_Name = "Main"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdNext_Click()
    FileIndex = FileIndex + 1
    If FileIndex > TotFiles Then FileIndex = 1
    Show_Picture
End Sub

Private Sub cmdPrev_Click()
    FileIndex = FileIndex - 1
    If FileIndex < 1 Then FileIndex = TotFiles
    Show_Picture
End Sub

Private Sub Form_Load()
    Resize_Img (ScreenMode)
    Show_Picture
    If Manual Then
        cmdPrev.Visible = True
        cmdNext.Visible = True
    Else
        cmdPrev.Visible = False
        cmdNext.Visible = False
    End If
End Sub

Private Sub Form_Click()
    Options.Show
End Sub

Private Sub imgWin_Click()
    Options.Show
End Sub

Private Sub tmrClock_Timer()
    Dim NowTime As Single
    
    If (Not NoTimer) And (Not StopForError) Then
        NowTime = Timer
        If NowTime >= (StartTime + SecDelay) Then
            Call cmdNext_Click
        End If
    End If
End Sub

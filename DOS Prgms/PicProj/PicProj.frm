VERSION 5.00
Begin VB.Form PicProj 
   BorderStyle     =   0  'None
   Caption         =   "Picture Projector"
   ClientHeight    =   3135
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4710
   LinkTopic       =   "Form1"
   ScaleHeight     =   3135
   ScaleWidth      =   4710
   ShowInTaskbar   =   0   'False
   Begin VB.CommandButton cmdPrev 
      Caption         =   "Prev"
      Height          =   375
      Left            =   240
      TabIndex        =   3
      Top             =   240
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.CommandButton cmdNext 
      Caption         =   "Next"
      Height          =   375
      Left            =   1200
      TabIndex        =   2
      Top             =   240
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.Timer tmrClock 
      Interval        =   25
      Left            =   2040
      Top             =   2400
   End
   Begin VB.FileListBox fileBox 
      Height          =   1845
      Left            =   240
      TabIndex        =   1
      Top             =   1080
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.TextBox txtBox 
      Height          =   405
      Left            =   2160
      TabIndex        =   0
      Top             =   1560
      Visible         =   0   'False
      Width           =   2055
   End
   Begin VB.Image imgWin 
      Appearance      =   0  'Flat
      Height          =   3135
      Left            =   0
      Stretch         =   -1  'True
      Top             =   0
      Width           =   4695
   End
End
Attribute VB_Name = "PicProj"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdNext_Click()
    NextImg
End Sub

Private Sub cmdPrev_Click()
    PrevImg
End Sub

Private Sub Form_Load()
    InitProg
    PicProj.Height = Screen.Height
    PicProj.Width = Screen.Width
    PicProj.Left = 0
    PicProj.Top = 0
    ResetImg
    ShowImage (FixPath(ViewPath + "\" + FileList(Index)))
End Sub

Private Sub Form_Resize()
    ResetImg
End Sub

Private Sub imgWin_Click()
    Options.Show
End Sub

Private Sub tmrClock_Timer()
    NowTime = Timer
    If NowTime >= StartTime + DelayTime Then NextImg
End Sub

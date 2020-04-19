VERSION 5.00
Begin VB.Form SlideShow 
   Caption         =   "Slide Show - v1.0"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdSave 
      Caption         =   "Save"
      Enabled         =   0   'False
      Height          =   375
      Left            =   2400
      TabIndex        =   6
      Top             =   240
      Visible         =   0   'False
      Width           =   615
   End
   Begin VB.CommandButton cmdAside 
      Caption         =   "Aside"
      Enabled         =   0   'False
      Height          =   375
      Left            =   1680
      TabIndex        =   5
      Top             =   240
      Visible         =   0   'False
      Width           =   615
   End
   Begin VB.CommandButton cmdDel 
      Caption         =   "Toss"
      Enabled         =   0   'False
      Height          =   375
      Left            =   960
      TabIndex        =   4
      Top             =   240
      Visible         =   0   'False
      Width           =   615
   End
   Begin VB.CommandButton cmdKeep 
      Caption         =   "Keep"
      Enabled         =   0   'False
      Height          =   375
      Left            =   240
      TabIndex        =   3
      Top             =   240
      Visible         =   0   'False
      Width           =   615
   End
   Begin VB.CommandButton cmdSort 
      Caption         =   "Sort"
      Height          =   375
      Left            =   2640
      TabIndex        =   2
      Top             =   2640
      Width           =   1095
   End
   Begin VB.Timer Clock 
      Interval        =   120
      Left            =   3840
      Top             =   2400
   End
   Begin VB.FileListBox FileList 
      Height          =   675
      Left            =   360
      TabIndex        =   1
      Top             =   2160
      Width           =   1575
   End
   Begin VB.PictureBox PicBox 
      AutoRedraw      =   -1  'True
      Height          =   615
      Left            =   1080
      ScaleHeight     =   555
      ScaleWidth      =   2595
      TabIndex        =   0
      Top             =   960
      Width           =   2655
   End
   Begin VB.Image ImgWin 
      BorderStyle     =   1  'Fixed Single
      Height          =   3015
      Left            =   120
      Top             =   120
      Width           =   4455
   End
End
Attribute VB_Name = "SlideShow"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Form_Load()
    Randomize
    RunPath = FixPath(CurDir)
    SHeight = Screen.Height
    SWidth = Screen.Width
    ImgHeight = Screen.Height - 256
    Options.Hide
    ImgWin.Visible = False
    PicBox.Visible = False
    FileList.Visible = False
    SlideShow.Top = 0
    SlideShow.Left = 0
    SlideShow.Height = SHeight
    SlideShow.Width = SWidth
    PicBox.Left = (SlideShow.Width - PicBox.Width) / 2
    GetSavedData
    InitDir
    ShowPic
End Sub

Private Sub ImgWin_Click()
    Options.Show
End Sub

Private Sub PicBox_Click()
    PicBox.Cls
    PicBox.Visible = False
    PicBox.Enabled = False
End Sub

Private Sub Clock_Timer()
    If Not SortMode Then
    
    NowT = Timer
    If NowT >= (StartT + DelayT) Then
        Index = Index + 1
        If Index > TotFiles Then Index = 1
        ShowPic
    End If
    
    End If
End Sub


Private Sub cmdSort_Click()
    cmdSort.Enabled = False
    cmdSort.Visible = False
    cmdKeep.Enabled = True
    cmdKeep.Visible = True
    cmdDel.Enabled = True
    cmdDel.Visible = True
    cmdAside.Enabled = True
    cmdAside.Visible = True
    cmdSave.Enabled = True
    cmdSave.Visible = True
    RandomOrder = False
    ImgPath = FixPath("d:\games\tetris\info\")
    InitDir
    SortMode = True
    Index = 1
    ShowPic
End Sub

Private Sub cmdKeep_Click()
    FileInfo(Index) = "KEEP"
    Index = Index + 1
    If Index > TotFiles Then Index = 1
    ShowPic
End Sub
Private Sub cmdDel_Click()
    FileInfo(Index) = "KEEP"
    Index = Index + 1
    If Index > TotFiles Then Index = 1
    ShowPic
End Sub

Private Sub cmdAside_Click()
    FileInfo(Index) = "ASIDE"
    Index = Index + 1
    If Index > TotFiles Then Index = 1
    ShowPic
End Sub

Private Sub cmdSave_Click()
    Dim Count As Integer
    
    Open "d:\games\tetris\info\fileinfo.dat" For Output As #1
    For Count = 1 To TotFiles
        Write #1, FileName(Count), FileInfo(Count)
    Next Count
    Close #1
End Sub


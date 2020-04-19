VERSION 5.00
Begin VB.Form SlideShow 
   Caption         =   "Age of Innocence"
   ClientHeight    =   8565
   ClientLeft      =   165
   ClientTop       =   480
   ClientWidth     =   9915
   ForeColor       =   &H00808080&
   Icon            =   "SlideShow.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   Moveable        =   0   'False
   NegotiateMenus  =   0   'False
   ScaleHeight     =   8595
   ScaleMode       =   0  'User
   ScaleWidth      =   9820.291
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdFull 
      Height          =   375
      Left            =   1320
      Picture         =   "SlideShow.frx":0442
      Style           =   1  'Graphical
      TabIndex        =   9
      Top             =   7920
      Width           =   855
   End
   Begin VB.TextBox txtMessage 
      Height          =   285
      Left            =   3600
      TabIndex        =   8
      Text            =   "Message"
      Top             =   6960
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.FileListBox fileList 
      Height          =   285
      Hidden          =   -1  'True
      Left            =   1200
      TabIndex        =   7
      Top             =   6960
      Visible         =   0   'False
      Width           =   2055
   End
   Begin VB.Timer tmrClock 
      Interval        =   25
      Left            =   600
      Top             =   6840
   End
   Begin VB.CommandButton cmdNext 
      Height          =   375
      Left            =   8880
      Picture         =   "SlideShow.frx":199C
      Style           =   1  'Graphical
      TabIndex        =   6
      Top             =   7920
      Width           =   855
   End
   Begin VB.CommandButton cmdPrev 
      Height          =   375
      Left            =   7920
      Picture         =   "SlideShow.frx":2EF6
      Style           =   1  'Graphical
      TabIndex        =   5
      Top             =   7920
      Width           =   855
   End
   Begin VB.CommandButton cmdMode 
      Height          =   375
      Left            =   6720
      Picture         =   "SlideShow.frx":4450
      Style           =   1  'Graphical
      TabIndex        =   4
      Top             =   7920
      Width           =   1095
   End
   Begin VB.CommandButton cmdAdd 
      Height          =   375
      Left            =   3120
      Picture         =   "SlideShow.frx":5D6A
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   7920
      Width           =   735
   End
   Begin VB.CommandButton cmdDel 
      Height          =   375
      Left            =   2280
      Picture         =   "SlideShow.frx":6F7C
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   7920
      Width           =   735
   End
   Begin VB.CommandButton cmdPower 
      BackColor       =   &H00C0C0C0&
      Height          =   375
      Left            =   120
      MaskColor       =   &H00FFFFFF&
      Picture         =   "SlideShow.frx":818E
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   7920
      Width           =   975
   End
   Begin VB.PictureBox picDisp 
      AutoRedraw      =   -1  'True
      BackColor       =   &H00C0C0C0&
      FillColor       =   &H000000FF&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   4080
      MousePointer    =   12  'No Drop
      ScaleHeight     =   33.75
      ScaleMode       =   2  'Point
      ScaleWidth      =   117.75
      TabIndex        =   0
      Top             =   7680
      Width           =   2415
   End
   Begin VB.Image imgWin 
      BorderStyle     =   1  'Fixed Single
      Height          =   7260
      Left            =   121
      Stretch         =   -1  'True
      Top             =   240
      Width           =   9660
   End
End
Attribute VB_Name = "SlideShow"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim iList(1 To 400) As Integer

Private Sub Form_Load()
    Dim sPass As String
    sPass = InputBox("Enter modem specification number.", "ModeDex for Windows95")
    If sPass <> "ageofinnocence" Then
        End
    End If
    sRunPath = App.Path
    SlideShow.Top = 0
    SlideShow.Height = Screen.Height
    SlideShow.Width = 10035
    SlideShow.Left = (Screen.Width / 2) - (SlideShow.Width / 2)
    Randomize
    iNum = 0
    iTotal = 400
    iDelay = 12
    bManual = False
    bSeries = False
    iSNum = 0
    bFull = False
    Dim iCount As Integer, iPlace As Integer
    For iCount = 1 To iTotal
        iList(iCount) = 0
    Next iCount
    For iCount = 1 To iTotal
        Do
            iPlace = Int(Rnd * iTotal) + 1
        Loop Until iList(iPlace) = 0
        iList(iPlace) = iCount
    Next iCount
    Call Start_Image
End Sub

Private Sub cmdAdd_Click()
    iDelay = iDelay + 1
    If iDelay > 60 Then
        iDelay = 60
    End If
    Call Disp_Stats
End Sub

Private Sub cmdDel_Click()
    iDelay = iDelay - 1
    If iDelay < 3 Then
        iDelay = 3
    End If
    Call Disp_Stats
End Sub

Private Sub cmdMode_Click()
    If bManual Then
        bManual = False
        cmdMode.Picture = LoadPicture(Format_Path(sRunPath + "\MODEM.DAT"))
        iStart = Timer
        iNow = iStart
    Else
        bManual = True
        cmdMode.Picture = LoadPicture(Format_Path(sRunPath + "\PROTOCOL.DAT"))
    End If
    Call Disp_Stats
End Sub

Private Sub cmdNext_Click()
    If bSeries = False Then
        iNum = iNum + 1
        If iNum > iTotal Then iNum = 1
    Else
        iSNum = iSNum + 1
        If iSNum > (fileList.ListCount - 1) Then iSNum = 0
    End If
    Call Start_Image
End Sub

Private Sub cmdPower_Click()
    End
End Sub

Private Sub cmdPrev_Click()
    If bSeries = False Then
        iNum = iNum - 1
        If iNum < 1 Then iNum = iTotal
    Else
        iSNum = iSNum - 1
        If iSNum < 0 Then iSNum = (fileList.ListCount - 1)
    End If
    Call Start_Image
End Sub

Private Sub Start_Image()
    If bSeries = True Then txtMessage.Text = "Series" Else txtMessage.Text = "No Series"
    
    If bSeries = False Then
        If iNum = 0 Then
            sFileName = Format_Path(sRunPath + "\MODTTL.DAT")
        Else
            sFileName = Format_Path(sRunPath + "\MODULES\IPDAT" + Format(iList(iNum), "000") + ".EXT")
        End If
    Else
        sFileName = Format_Path(fileList.Path + "\" + fileList.List(iSNum))
    End If
    imgWin.Picture = LoadPicture(sFileName)
    iStart = Timer
    iNow = iStart
    Call Disp_Stats
End Sub

Private Sub Disp_Stats()
    picDisp.Cls
    If bManual Then
        picDisp.Print " SECONDS  LEFT"
        picDisp.Print " DELAY  FOR"
        picDisp.Print " MANUAL  MODE"
    Else
        picDisp.Print " SECONDS  LEFT", Int((iStart + iDelay) - iNow + 1)
        picDisp.Print " DELAY  FOR", , iDelay
        picDisp.Print " TIMER  MODE"
    End If
End Sub

Private Sub imgWin_Click()
    If bFull = False Then
        SetNewDir.Show 1
        Call cmdNext_Click
    Else
        bFull = False
        imgWin.Picture = LoadPicture()
        SlideShow.Width = 10035
        SlideShow.Left = (Screen.Width / 2) - (SlideShow.Width / 2)
        imgWin.Top = 240.841
        imgWin.Left = 119.844
        imgWin.Width = 9567.727
        imgWin.Height = 7285.429
        cmdPower.Visible = True
        cmdPower.Enabled = True
        cmdFull.Visible = True
        cmdFull.Enabled = True
        cmdDel.Visible = True
        cmdDel.Enabled = True
        cmdAdd.Visible = True
        cmdAdd.Enabled = True
        picDisp.Visible = True
        picDisp.Enabled = True
        cmdMode.Visible = True
        cmdMode.Enabled = True
        cmdPrev.Visible = True
        cmdPrev.Enabled = True
        cmdNext.Visible = True
        cmdNext.Enabled = True
        imgWin.Picture = LoadPicture(sFileName)
    End If
End Sub

Private Sub cmdFull_Click()
    If (bFull = False) Then
        bFull = True
        cmdPower.Visible = False
        cmdPower.Enabled = False
        cmdFull.Visible = False
        cmdFull.Enabled = False
        cmdDel.Visible = False
        cmdDel.Enabled = False
        cmdAdd.Visible = False
        cmdAdd.Enabled = False
        picDisp.Visible = False
        picDisp.Enabled = False
        cmdMode.Visible = False
        cmdMode.Enabled = False
        cmdPrev.Visible = False
        cmdPrev.Enabled = False
        cmdNext.Visible = False
        cmdNext.Enabled = False
        imgWin.Picture = LoadPicture()
        SlideShow.Left = 0
        SlideShow.Width = Screen.Width
        imgWin.Top = 0
        imgWin.Left = 0
        imgWin.Width = SlideShow.Width
        imgWin.Height = SlideShow.Height - 350
        imgWin.Picture = LoadPicture(sFileName)
    End If
End Sub

Private Sub tmrClock_Timer()
    If bManual = False Then
        Dim iONow As Single
        iONow = iNow
        iNow = Timer
        If Int((iStart + iDelay) - iNow) <> Int((iStart + iDelay) - iONow) Then
            Call Disp_Stats
        End If
        If iNow >= (iStart + iDelay) Then
            Call cmdNext_Click
        End If
    End If
End Sub

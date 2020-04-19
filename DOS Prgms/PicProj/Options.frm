VERSION 5.00
Begin VB.Form Options 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Picture Projector Options"
   ClientHeight    =   4215
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4440
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4215
   ScaleWidth      =   4440
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cmdQuit 
      Caption         =   "Quit"
      Height          =   375
      Left            =   3000
      TabIndex        =   12
      Top             =   3600
      Width           =   1215
   End
   Begin VB.CheckBox chkSee 
      Caption         =   "View control buttons."
      Height          =   495
      Left            =   360
      TabIndex        =   11
      Top             =   3000
      Width           =   1935
   End
   Begin VB.TextBox txtDelay 
      Height          =   285
      Left            =   240
      TabIndex        =   9
      Top             =   1800
      Width           =   615
   End
   Begin VB.CheckBox chkManual 
      Caption         =   "Manual control of time delay."
      Height          =   495
      Left            =   360
      TabIndex        =   8
      Top             =   2640
      Width           =   2415
   End
   Begin VB.CheckBox chkRand 
      Caption         =   "Randomize file list."
      Height          =   495
      Left            =   360
      TabIndex        =   7
      Top             =   2280
      Width           =   2895
   End
   Begin VB.TextBox txtExt 
      Height          =   285
      Left            =   2280
      TabIndex        =   5
      Top             =   1800
      Width           =   855
   End
   Begin VB.DriveListBox driveBox 
      Height          =   315
      Left            =   240
      TabIndex        =   3
      Top             =   120
      Width           =   1935
   End
   Begin VB.DirListBox dirBox 
      Height          =   990
      Left            =   240
      TabIndex        =   2
      Top             =   600
      Width           =   1935
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   1560
      TabIndex        =   1
      Top             =   3600
      Width           =   1215
   End
   Begin VB.CommandButton cmdOk 
      Caption         =   "OK"
      Height          =   375
      Left            =   240
      TabIndex        =   0
      Top             =   3600
      Width           =   1215
   End
   Begin VB.Label Label3 
      Caption         =   "Selay time in seconds."
      Height          =   495
      Left            =   1080
      TabIndex        =   10
      Top             =   1800
      Width           =   1095
   End
   Begin VB.Label Label2 
      Caption         =   "Image file extention (*.JPG)."
      Height          =   615
      Left            =   3360
      TabIndex        =   6
      Top             =   1800
      Width           =   975
   End
   Begin VB.Label Label1 
      Caption         =   "Select image folder for viewing."
      Height          =   615
      Left            =   2400
      TabIndex        =   4
      Top             =   120
      Width           =   1695
      WordWrap        =   -1  'True
   End
End
Attribute VB_Name = "Options"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdCancel_Click()
    Options.Hide
End Sub

Private Sub cmdOK_Click()
    Dim OldViewPath As String
    Dim OldFileExt As String
    Dim OldRandom As Boolean
        
    If NoFiles Then
        Info.imgIcon.Picture = LoadPicture(FixPath(RunPath + "\error.bmp"))
        Info.lblText = "An error was encountered while building file list.  Make sure path and file extention are correct."
        Info.Show
        Exit Sub
    End If
    OldViewPath = ViewPath
    OldFileExt = FileExt
    OldRandom = Random
    DelayTime = Val(txtDelay.Text)
    If chkRand.Value = 1 Then Random = True Else Random = False
    If chkManual.Value = 1 Then Manual = True Else Manual = False
    If chkSee.Value = 1 Then SeeButt = True Else SeeButt = False
    If SeeButt Then
        PicProj.cmdNext.Visible = True
        PicProj.cmdPrev.Visible = True
    Else
        PicProj.cmdNext.Visible = False
        PicProj.cmdPrev.Visible = False
    End If
    If Manual Then
        PicProj.tmrClock.Enabled = False
    Else
        PicProj.tmrClock.Enabled = True
    End If
    ViewPath = dirBox.Path
    FileExt = txtExt.Text
    If (ViewPath <> OldViewPath) Or (FileExt <> OldFileExt) Or (Random <> OldRandom) Then
        InitDir (ViewPath)
    End If
    If TotFiles = 0 Then
        ViewPath = OldViewPath
        FileExt = OldFileExt
        Info.imgIcon.Picture = LoadPicture(FixPath(RunPath + "\error.bmp"))
        Info.lblText = "An error was encountered while building file list.  Make sure path and file extention are correct."
        Info.Show
    Else
        If Not RunFromCD Then SaveData
        Options.Hide
    End If
End Sub

Private Sub cmdQuit_Click()
    End
End Sub

Private Sub dirBox_Change()
    NoFiles = False
    PicProj.fileBox.Path = dirBox.Path
    If PicProj.fileBox.ListCount <= 0 Then NoFiles = True
End Sub

Private Sub driveBox_Change()
    dirBox.Path = driveBox.Drive
End Sub

Private Sub Form_GotFocus()
    Call Form_Load
End Sub

Private Sub Form_Load()
    driveBox.Drive = ViewPath
    dirBox.Path = ViewPath
    txtDelay.Text = Str(DelayTime)
    txtExt.Text = FileExt
    If Random Then chkRand.Value = 1 Else chkRand.Value = 0
    If Manual Then chkManual.Value = 1 Else chkManual.Value = 0
    If SeeButt Then chkSee.Value = 1 Else chkSee.Value = 0
End Sub

Private Sub txtExt_LostFocus()
    txtExt.Text = UCase(txtExt.Text)
End Sub

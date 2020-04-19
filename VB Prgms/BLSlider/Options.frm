VERSION 5.00
Begin VB.Form Options 
   AutoRedraw      =   -1  'True
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Black Lotus Slider - Options"
   ClientHeight    =   5355
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5070
   Icon            =   "Options.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5355
   ScaleWidth      =   5070
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.FileListBox boxTemp 
      Height          =   675
      Left            =   1560
      TabIndex        =   23
      Top             =   1200
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.PictureBox picFound 
      AutoRedraw      =   -1  'True
      Height          =   255
      Left            =   3000
      ScaleHeight     =   195
      ScaleWidth      =   1275
      TabIndex        =   21
      Top             =   1200
      Width           =   1335
   End
   Begin VB.CommandButton cmdReset 
      Caption         =   "Reset Options"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   1800
      TabIndex        =   19
      Top             =   4800
      Width           =   1455
   End
   Begin VB.OptionButton opt6 
      Height          =   375
      Left            =   3000
      TabIndex        =   17
      Top             =   2760
      Width           =   255
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   240
      TabIndex        =   15
      Top             =   4800
      Width           =   1215
   End
   Begin VB.OptionButton opt5 
      Height          =   495
      Left            =   4200
      TabIndex        =   14
      Top             =   3120
      Width           =   255
   End
   Begin VB.OptionButton opt3 
      Height          =   375
      Left            =   3840
      TabIndex        =   13
      Top             =   3600
      Width           =   255
   End
   Begin VB.OptionButton opt1 
      Height          =   375
      Left            =   3840
      TabIndex        =   12
      Top             =   2760
      Width           =   255
   End
   Begin VB.OptionButton opt4 
      Height          =   375
      Left            =   4560
      TabIndex        =   11
      Top             =   3600
      Width           =   255
   End
   Begin VB.OptionButton opt2 
      Height          =   375
      Left            =   4560
      TabIndex        =   10
      Top             =   2760
      Width           =   255
   End
   Begin VB.TextBox txtDelay 
      Height          =   285
      Left            =   240
      TabIndex        =   8
      Top             =   3840
      Width           =   1335
   End
   Begin VB.CheckBox chkManual 
      Caption         =   "  View control buttons."
      Height          =   255
      Left            =   240
      TabIndex        =   7
      Top             =   3240
      Width           =   1935
   End
   Begin VB.CheckBox chkDis 
      Caption         =   "  Disable timer function."
      Height          =   255
      Left            =   240
      TabIndex        =   6
      Top             =   2880
      Width           =   2175
   End
   Begin VB.CheckBox chkRand 
      Caption         =   "  Randomize file list."
      Height          =   255
      Left            =   240
      TabIndex        =   5
      Top             =   2520
      Width           =   1815
   End
   Begin VB.TextBox txtExt 
      Height          =   285
      Left            =   3000
      TabIndex        =   3
      Top             =   120
      Width           =   1335
   End
   Begin VB.DirListBox boxDir 
      Height          =   1215
      Left            =   240
      TabIndex        =   2
      Top             =   600
      Width           =   1935
   End
   Begin VB.DriveListBox boxDrv 
      Height          =   315
      Left            =   240
      TabIndex        =   1
      Top             =   120
      Width           =   1935
   End
   Begin VB.CommandButton cmdQuit 
      Caption         =   "Quit"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3600
      TabIndex        =   0
      Top             =   4800
      Width           =   1215
   End
   Begin VB.Line Line2 
      BorderColor     =   &H80000003&
      X1              =   2640
      X2              =   2640
      Y1              =   2280
      Y2              =   4680
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000003&
      X1              =   120
      X2              =   4920
      Y1              =   2280
      Y2              =   2280
   End
   Begin VB.Label Label6 
      Caption         =   "Number of files found."
      Height          =   375
      Left            =   3000
      TabIndex        =   22
      Top             =   1560
      Width           =   1335
   End
   Begin VB.Label lblPath 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   20
      Top             =   1920
      Width           =   4815
   End
   Begin VB.Label Label5 
      Alignment       =   1  'Right Justify
      Caption         =   "Full View"
      Height          =   255
      Left            =   2760
      TabIndex        =   18
      Top             =   4200
      Width           =   735
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      Caption         =   "Partial Views"
      Height          =   255
      Left            =   3720
      TabIndex        =   16
      Top             =   4200
      Width           =   1095
   End
   Begin VB.Label Label3 
      Caption         =   "Timer delay in seconds."
      Height          =   375
      Left            =   240
      TabIndex        =   9
      Top             =   4200
      Width           =   1335
   End
   Begin VB.Label Label2 
      Caption         =   "Filespec for viewing. (Ex.  * . JPG)"
      Height          =   495
      Left            =   3000
      TabIndex        =   4
      Top             =   480
      Width           =   1455
   End
End
Attribute VB_Name = "Options"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub boxDir_Change()
    Splash.boxFile.Path = boxDir.Path
    NewFilePath = boxDir.Path
    If Right(NewFilePath, 1) <> "\" Then NewFilePath = NewFilePath + "\"
    lblPath.Caption = NewFilePath
    boxTemp.Path = NewFilePath
    boxTemp.Pattern = NewFileSpec
    picFound.Cls
    picFound.Print boxTemp.ListCount
End Sub

Private Sub boxDrv_Change()
    boxDir.Path = boxDrv.Drive
End Sub

Private Sub chkDis_Click()
    If chkDis.Value = 0 Then
        NoTimer = False
    Else
        NoTimer = True
    End If
End Sub

Private Sub chkManual_Click()
    If chkManual.Value = 0 Then
        Manual = False
        Main.cmdPrev.Visible = False
        Main.cmdNext.Visible = False
    Else
        Manual = True
        Main.cmdPrev.Visible = True
        Main.cmdNext.Visible = True
    End If
End Sub

Private Sub chkRand_Click()
    If chkRand.Value = 0 Then
        Random = False
    Else
        Random = True
    End If
    Init_FileList
    Show_Picture
End Sub

Private Sub cmdOK_Click()
    Dim ReloadFiles As Boolean
    
    ReloadFiles = False
    If NewFilePath <> FilePath Then
        FilePath = NewFilePath
        ReloadFiles = True
    End If
    If NewFileSpec <> FileSpec Then
        FileSpec = NewFileSpec
        ReloadFiles = True
    End If
    If ReloadFiles Then Init_FileList
    Save_Settings
    Options.Hide
End Sub

Private Sub cmdQuit_Click()
    Save_Settings
    Unload Me
    End
End Sub

Private Sub cmdReset_Click()
    Options.Hide
    FileSpec = "*.JPG"
    SecDelay = 3
    Random = True
    NoTimer = False
    Manual = False
    ScreenMode = 6
    Save_Settings
    FilePath = (App.Path + "\")
    Init_FileList
    Resize_Img (ScreenMode)
    Show_Picture
    Options.Show
End Sub

Private Sub Form_Activate()
    boxDrv.Drive = FilePath
    boxDir.Path = FilePath
    txtExt.Text = FileSpec
    txtDelay.Text = Str(SecDelay)
    picFound.Cls
    picFound.Print TotFiles
    If Random Then
        chkRand.Value = 1
    Else
        chkRand.Value = 0
    End If
    If NoTimer Then
        chkDis.Value = 1
    Else
        chkDis.Value = 0
    End If
    If Manual Then
        chkManual.Value = 1
    Else
        chkManual.Value = 0
    End If
    Select Case ScreenMode
        Case 1
            opt1.Value = 1
        Case 2
            opt2.Value = 1
        Case 3
            opt3.Value = 1
        Case 4
            opt4.Value = 1
        Case 5
            opt5.Value = 1
        Case 6
            opt6.Value = 1
    End Select
End Sub

Private Sub Form_LostFocus()
    Options.Hide
End Sub


Private Sub opt1_Click()
    opt1.Value = 1
    ScreenMode = 1
    Resize_Img (ScreenMode)
End Sub

Private Sub opt2_Click()
    opt2.Value = 1
    ScreenMode = 2
    Resize_Img (ScreenMode)
End Sub

Private Sub opt3_Click()
    opt3.Value = 1
    ScreenMode = 3
    Resize_Img (ScreenMode)
End Sub

Private Sub opt4_Click()
    opt4.Value = 1
    ScreenMode = 4
    Resize_Img (ScreenMode)
End Sub

Private Sub opt5_Click()
    opt5.Value = 1
    ScreenMode = 5
    Resize_Img (ScreenMode)
End Sub

Private Sub opt6_Click()
    opt6.Value = 1
    ScreenMode = 6
    Resize_Img (ScreenMode)
End Sub

Private Sub txtDelay_Change()
    SecDelay = Val(txtDelay.Text)
End Sub

Private Sub txtExt_Change()
    NewFileSpec = txtExt.Text
    boxTemp.Pattern = NewFileSpec
    picFound.Cls
    picFound.Print boxTemp.ListCount
End Sub

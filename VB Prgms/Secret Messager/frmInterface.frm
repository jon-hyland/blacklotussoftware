VERSION 5.00
Begin VB.Form frmInterface 
   Caption         =   "Black Lotus Secret Messager - v1.2"
   ClientHeight    =   3555
   ClientLeft      =   165
   ClientTop       =   450
   ClientWidth     =   5820
   Icon            =   "frmInterface.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3555
   ScaleWidth      =   5820
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdTest 
      Caption         =   "Test"
      Height          =   495
      Left            =   2280
      TabIndex        =   3
      Top             =   2940
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.CommandButton cmdSave 
      Caption         =   "Save As Secret Message"
      Height          =   495
      Left            =   4080
      TabIndex        =   2
      Top             =   2940
      Width           =   1335
   End
   Begin VB.CommandButton cmdOpen 
      Caption         =   "Open Secret Message"
      Height          =   495
      Left            =   360
      TabIndex        =   1
      Top             =   2940
      Width           =   1335
   End
   Begin VB.TextBox txtMsg 
      BackColor       =   &H00E0E0E0&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2595
      Left            =   180
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   180
      Width           =   5475
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      NegotiatePosition=   1  'Left
      Begin VB.Menu mnuNew 
         Caption         =   "&New"
      End
      Begin VB.Menu mnuOpen 
         Caption         =   "&Open"
      End
      Begin VB.Menu mnuSave 
         Caption         =   "&Save"
      End
      Begin VB.Menu mnuDiv1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuExit 
         Caption         =   "E&xit"
      End
   End
   Begin VB.Menu mnuInfo 
      Caption         =   "&Info"
      NegotiatePosition=   3  'Right
      Begin VB.Menu mnuHelp 
         Caption         =   "&Help File"
      End
      Begin VB.Menu mnuAbout 
         Caption         =   "&About"
      End
   End
End
Attribute VB_Name = "frmInterface"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdOpen_Click()
    BLSM.Open_File
End Sub

Private Sub cmdSave_Click()
    BLSM.Save_File
End Sub

Private Sub cmdTest_Click()
    BLSM.Test_It
End Sub

Private Sub Form_Load()
    BLSM.Show_Splash
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
    Cancel = BLSM.bCancelQuit
End Sub

Private Sub Form_Resize()
    Me.txtMsg.Width = Me.Width - 465
    If Me.Height > 1650 Then Me.txtMsg.Height = Me.Height - 1650
    Me.cmdSave.Left = Me.Width - 1860
    Me.cmdOpen.Top = Me.Height - 1305
    Me.cmdTest.Top = Me.Height - 1305
    Me.cmdSave.Top = Me.Height - 1305
End Sub

Private Sub Form_Unload(Cancel As Integer)
    BLSM.End_Prog
End Sub

Private Sub mnuAbout_Click()
    BLSM.Show_Info
End Sub

Private Sub mnuExit_Click()
    BLSM.End_Prog
End Sub

Private Sub mnuHelp_Click()
    BLSM.Show_Help
End Sub

Private Sub mnuNew_Click()
    BLSM.Clear_Msg
End Sub

Private Sub mnuOpen_Click()
    BLSM.Open_File
End Sub

Private Sub mnuSave_Click()
    BLSM.Save_File
End Sub

Private Sub txtMsg_Change()
    BLSM.Msg_Changed
End Sub

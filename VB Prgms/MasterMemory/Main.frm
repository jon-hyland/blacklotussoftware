VERSION 5.00
Begin VB.Form Main 
   Caption         =   "Master Memory"
   ClientHeight    =   3600
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3855
   LinkTopic       =   "Form1"
   ScaleHeight     =   3600
   ScaleWidth      =   3855
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdAll 
      Caption         =   "All"
      Height          =   375
      Left            =   240
      TabIndex        =   5
      Top             =   3120
      Width           =   1215
   End
   Begin VB.CommandButton cmdQuit 
      Caption         =   "Quit"
      Height          =   375
      Left            =   2400
      TabIndex        =   4
      Top             =   3120
      Width           =   1215
   End
   Begin VB.CommandButton cmdDown 
      Height          =   855
      Left            =   1440
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   1920
      Width           =   975
   End
   Begin VB.CommandButton cmdRight 
      Height          =   855
      Left            =   2400
      Style           =   1  'Graphical
      TabIndex        =   2
      Top             =   1080
      Width           =   975
   End
   Begin VB.CommandButton cmdLeft 
      Height          =   855
      Left            =   480
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   1080
      Width           =   975
   End
   Begin VB.CommandButton cmdUp 
      Height          =   855
      Left            =   1440
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   240
      Width           =   975
   End
End
Attribute VB_Name = "Main"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdAll_Click()
    If Turn Then
        Go_Turn
    Else
        Init_Turn
        Watch_Turn
    End If
End Sub

Private Sub cmdQuit_Click()
    Unload Me
    End
End Sub

Private Sub Form_Load()
    cmdUp.Picture = LoadPicture(App.Path + "\black.bmp")
    cmdLeft.Picture = LoadPicture(App.Path + "\black.bmp")
    cmdRight.Picture = LoadPicture(App.Path + "\black.bmp")
    cmdDown.Picture = LoadPicture(App.Path + "\black.bmp")
    cmdUp.DisabledPicture = LoadPicture(App.Path + "\yellow.bmp")
    cmdLeft.DisabledPicture = LoadPicture(App.Path + "\red.bmp")
    cmdRight.DisabledPicture = LoadPicture(App.Path + "\blue.bmp")
    cmdDown.DisabledPicture = LoadPicture(App.Path + "\green.bmp")
End Sub

VERSION 5.00
Begin VB.Form Splash 
   Caption         =   "Black Lotus Slider  v1.0"
   ClientHeight    =   4230
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4740
   Icon            =   "Splash.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4230
   ScaleWidth      =   4740
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.FileListBox boxFile 
      Height          =   870
      Left            =   120
      TabIndex        =   1
      Top             =   3120
      Visible         =   0   'False
      Width           =   1455
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
      Left            =   1800
      TabIndex        =   0
      Top             =   3720
      Width           =   1095
   End
   Begin VB.Image imgSplash 
      Appearance      =   0  'Flat
      Height          =   3375
      Left            =   120
      Top             =   120
      Width           =   4455
   End
End
Attribute VB_Name = "Splash"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub cmdOK_Click()
    Splash.Visible = False
    Main.Show
End Sub

Private Sub Form_Load()
    Call Init_Prog
    imgSplash.Picture = LoadPicture(App.Path + "\" + ProdLogoFile)
End Sub

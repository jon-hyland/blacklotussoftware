VERSION 5.00
Begin VB.Form First 
   Caption         =   "Black Lotus Software"
   ClientHeight    =   3735
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3555
   Icon            =   "First.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3735
   ScaleWidth      =   3555
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
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
      Left            =   1200
      TabIndex        =   0
      Top             =   3240
      Width           =   1215
   End
   Begin VB.Image imgFirst 
      Appearance      =   0  'Flat
      Height          =   3015
      Left            =   120
      Top             =   120
      Width           =   3375
   End
End
Attribute VB_Name = "First"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdOK_Click()
    Splash.Show
    Unload Me
End Sub

Private Sub Form_Load()
    imgFirst.Picture = LoadPicture(App.Path + "\" + CompLogoFile)
End Sub

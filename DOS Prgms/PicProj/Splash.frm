VERSION 5.00
Begin VB.Form Splash 
   AutoRedraw      =   -1  'True
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Black Lotus Software"
   ClientHeight    =   4215
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4215
   ScaleWidth      =   4680
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Height          =   375
      Left            =   1680
      TabIndex        =   0
      Top             =   3720
      Width           =   1335
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "(c) 1998 by Black Lotus Software.  All rights reserved."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   840
      TabIndex        =   1
      Top             =   3240
      Width           =   3015
   End
   Begin VB.Image imgSplash 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      Height          =   3015
      Left            =   120
      Stretch         =   -1  'True
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
    PicProj.Show
    Unload Me
End Sub

Private Sub Form_Load()
    InitProg
    imgSplash.Picture = LoadPicture(FixPath(RunPath + "\splash.bmp"))
End Sub


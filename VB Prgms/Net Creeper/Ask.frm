VERSION 5.00
Begin VB.Form Ask 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Message"
   ClientHeight    =   2115
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5250
   Icon            =   "Ask.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2115
   ScaleWidth      =   5250
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cmdYes 
      Caption         =   "Yes"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   480
      TabIndex        =   1
      Top             =   1560
      Width           =   1095
   End
   Begin VB.CommandButton cmdNo 
      Caption         =   "No"
      Default         =   -1  'True
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3720
      TabIndex        =   0
      Top             =   1560
      Width           =   1095
   End
   Begin VB.Label lblMsg 
      Alignment       =   2  'Center
      Caption         =   "Would you like to set ""http://www.whatever.com"" as your personal homepage?"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1215
      Left            =   120
      TabIndex        =   2
      Top             =   240
      Width           =   4935
   End
End
Attribute VB_Name = "Ask"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public SetAs As Integer

Private Sub cmdNo_Click()
    Unload Me
End Sub

Private Sub cmdYes_Click()
    Select Case SetAs
        Case 1
            HomeAdd = Address
        Case 2
            SrchAdd = Address
        Case 3
            MailAdd = Address
        Case 4
            Favs.lstFavs.AddItem Address
            Favs.lstFavs.ListIndex = Favs.lstFavs.ListCount - 1
            TotFavs = TotFavs + 1
            SaveFavs
            Me.Hide
            Favs.Show vbModal
    End Select
    Unload Me
    SaveData
End Sub


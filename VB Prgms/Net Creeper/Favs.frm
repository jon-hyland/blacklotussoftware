VERSION 5.00
Begin VB.Form Favs 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Favorite Web Locations"
   ClientHeight    =   3570
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5415
   Icon            =   "Favs.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3570
   ScaleWidth      =   5415
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cmdDel 
      Caption         =   "Delete"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   2220
      TabIndex        =   3
      Top             =   3000
      Width           =   975
   End
   Begin VB.ListBox lstFavs 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2595
      Left            =   120
      TabIndex        =   2
      Top             =   120
      Width           =   5175
   End
   Begin VB.CommandButton cmdExit 
      Caption         =   "Exit"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3960
      TabIndex        =   1
      Top             =   3000
      Width           =   1095
   End
   Begin VB.CommandButton cmdNav 
      Caption         =   "Navigate"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   360
      TabIndex        =   0
      Top             =   3000
      Width           =   1095
   End
End
Attribute VB_Name = "Favs"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub cmdDel_Click()
    If lstFavs.ListIndex <> -1 Then
        lstFavs.RemoveItem lstFavs.ListIndex
        TotFavs = TotFavs - 1
        cmdDel.Enabled = False
        cmdNav.Enabled = False
        SaveFavs
    End If
End Sub

Private Sub cmdExit_Click()
    Unload Me
End Sub

Private Sub cmdNav_Click()
    Address = lstFavs.List(lstFavs.ListIndex)
    GoType = 3
    Unload Me
    Main.IE.Navigate Address
End Sub

Private Sub Form_Load()
    LoadFavs
    cmdNav.Enabled = False
    cmdDel.Enabled = False
    lstFavs.ListIndex = -1
End Sub

Private Sub lstFavs_Click()
    If (lstFavs.ListIndex <> -1) Then
        If (lstFavs.List(lstFavs.ListIndex) <> "") Then
            cmdNav.Enabled = True
            cmdDel.Enabled = True
        Else
            cmdNav.Enabled = False
            cmdDel.Enabled = True
        End If
    Else
        cmdNav.Enabled = True
        cmdDel.Enabled = True
    End If
End Sub

Private Sub lstFavs_DblClick()
    Call cmdNav_Click
End Sub

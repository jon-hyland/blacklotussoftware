VERSION 5.00
Begin VB.Form Results 
   Caption         =   "Contact List -- Search Results"
   ClientHeight    =   4935
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5760
   Icon            =   "Results.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4935
   ScaleWidth      =   5760
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.ListBox lstSearch 
      BeginProperty Font 
         Name            =   "Fixedsys"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4110
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   5535
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
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
      Left            =   2160
      TabIndex        =   0
      Top             =   4440
      Width           =   1455
   End
End
Attribute VB_Name = "Results"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdOK_Click()
    If lstSearch.List(lstSearch.ListIndex) <> "No Matches Found" Then
        RecNum = Results_Index(lstSearch.ListIndex + 1)
        Results.Hide
        Show_Record (RecNum)
    Else
        Results.Hide
    End If
End Sub

Private Sub Form_Activate()
    lstSearch.ListIndex = 0
End Sub

Private Sub lstSearch_DblClick()
    cmdOK_Click
End Sub

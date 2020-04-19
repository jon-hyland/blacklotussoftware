VERSION 5.00
Begin VB.Form frmError 
   Caption         =   "An error has occured in this Black Lotus Application!"
   ClientHeight    =   2865
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5265
   Icon            =   "frmError.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2865
   ScaleWidth      =   5265
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdOK 
      Caption         =   "Try to Continue."
      Height          =   495
      Left            =   3720
      TabIndex        =   2
      Top             =   2220
      Width           =   1215
   End
   Begin VB.CommandButton cmdQuit 
      Caption         =   "Quit Application"
      Height          =   495
      Left            =   300
      TabIndex        =   1
      Top             =   2220
      Width           =   1155
   End
   Begin VB.Label Label2 
      Caption         =   "You may close the program or choose to try to continue running the program."
      Height          =   495
      Left            =   2280
      TabIndex        =   3
      Top             =   1380
      Width           =   2775
   End
   Begin VB.Image Image1 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      Height          =   1980
      Left            =   120
      Picture         =   "frmError.frx":030A
      Top             =   120
      Width           =   1980
   End
   Begin VB.Label lblMsg 
      Caption         =   "An error has occured in module ? ."
      Height          =   675
      Left            =   2280
      TabIndex        =   0
      Top             =   300
      Width           =   2955
   End
End
Attribute VB_Name = "frmError"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdOK_Click()
    Me.Hide
End Sub

Private Sub cmdQuit_Click()
    Code.End_Prog
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Code.End_Prog
End Sub

VERSION 5.00
Begin VB.Form frmDisplay 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Caption Goes Here"
   ClientHeight    =   1620
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3555
   Icon            =   "frmDisplay.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1620
   ScaleWidth      =   3555
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Height          =   375
      Left            =   1260
      TabIndex        =   3
      Top             =   1080
      Width           =   1035
   End
   Begin VB.CommandButton cmdNo 
      Caption         =   "No"
      Height          =   375
      Left            =   2340
      TabIndex        =   1
      Top             =   1080
      Width           =   975
   End
   Begin VB.CommandButton cmdYes 
      Caption         =   "Yes"
      Height          =   375
      Left            =   240
      TabIndex        =   0
      Top             =   1080
      Width           =   975
   End
   Begin VB.Label lblDisp 
      Caption         =   "Statement goes here."
      Height          =   615
      Left            =   180
      TabIndex        =   2
      Top             =   180
      Width           =   3255
   End
End
Attribute VB_Name = "frmDisplay"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdNo_Click()
    BLSM.bDisplayResult = False
    Unload Me
End Sub

Private Sub cmdOK_Click()
    Unload Me
End Sub

Private Sub cmdYes_Click()
    BLSM.bDisplayResult = True
    Unload Me
End Sub

Private Sub Form_Load()
    BLSM.bDisplayResult = False
End Sub

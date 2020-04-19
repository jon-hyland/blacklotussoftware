VERSION 5.00
Begin VB.Form Info 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Info"
   ClientHeight    =   2040
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3675
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2040
   ScaleWidth      =   3675
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Height          =   375
      Left            =   1200
      TabIndex        =   1
      Top             =   1440
      Width           =   1215
   End
   Begin VB.Image imgIcon 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      Height          =   975
      Left            =   120
      Stretch         =   -1  'True
      Top             =   120
      Width           =   975
   End
   Begin VB.Label lblText 
      Height          =   975
      Left            =   1320
      TabIndex        =   0
      Top             =   120
      Width           =   2055
   End
End
Attribute VB_Name = "Info"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdOK_Click()
    Info.Hide
End Sub

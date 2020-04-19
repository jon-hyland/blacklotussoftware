VERSION 5.00
Begin VB.Form frmSplash 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Secret Messager - v1.2"
   ClientHeight    =   2025
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4470
   Icon            =   "frmSplash.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2025
   ScaleWidth      =   4470
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdOK 
      Caption         =   "Agree"
      Height          =   375
      Left            =   1680
      TabIndex        =   0
      Top             =   1500
      Width           =   1155
   End
   Begin VB.Label Label1 
      Caption         =   $"frmSplash.frx":030A
      Height          =   1215
      Left            =   180
      TabIndex        =   1
      Top             =   120
      Width           =   4095
   End
End
Attribute VB_Name = "frmSplash"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Agree As Boolean

Private Sub cmdOK_Click()
    Agree = True
    Unload Me
End Sub

Private Sub Form_Load()
    Agree = False
End Sub

Private Sub Form_Unload(Cancel As Integer)
    If Not Agree Then BLSM.End_Prog
End Sub

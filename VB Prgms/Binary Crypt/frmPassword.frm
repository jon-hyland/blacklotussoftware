VERSION 5.00
Begin VB.Form frmPassword 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Binary Crypt v1.21"
   ClientHeight    =   1755
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   2955
   Icon            =   "frmPassword.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1755
   ScaleWidth      =   2955
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Height          =   345
      Left            =   990
      TabIndex        =   2
      Top             =   1260
      Width           =   1005
   End
   Begin VB.TextBox txtPassword 
      BackColor       =   &H00E0E0E0&
      Height          =   285
      Left            =   690
      TabIndex        =   0
      Top             =   210
      Width           =   1605
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "Encryption password (3 - 12) characters, case sensitive."
      Height          =   465
      Left            =   450
      TabIndex        =   1
      Top             =   660
      Width           =   2085
   End
End
Attribute VB_Name = "frmPassword"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim bCont As Boolean

Private Sub cmdOK_Click()
    bCont = True
    BLBC.nPassSeed = BLBC.Password_2_Seed(txtPassword.Text)
    Unload Me
End Sub

Private Sub Form_Load()
    bCont = False
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
    If Not bCont Then BLBC.bCancelProc = True
End Sub

Private Sub txtPassword_KeyPress(KeyAscii As Integer)
    If (KeyAscii >= 32) And (KeyAscii <= 126) Then
        If Len(txtPassword.Text) >= 12 Then KeyAscii = 0
    End If
End Sub

Private Sub txtPassword_LostFocus()
    If (Len(txtPassword) < 3) Or (Len(txtPassword) > 12) Then
        txtPassword.SetFocus
    End If
End Sub

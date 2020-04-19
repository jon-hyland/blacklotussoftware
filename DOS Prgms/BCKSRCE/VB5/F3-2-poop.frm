VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Information"
   ClientHeight    =   1995
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5745
   LinkTopic       =   "Form1"
   ScaleHeight     =   1995
   ScaleWidth      =   5745
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtBox2 
      Height          =   375
      Index           =   1
      Left            =   3840
      TabIndex        =   1
      Top             =   240
      Width           =   1575
   End
   Begin VB.TextBox txtBox1 
      Height          =   405
      Index           =   0
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   1575
   End
   Begin VB.Label labOut 
      Height          =   1215
      Left            =   2040
      TabIndex        =   2
      Top             =   240
      Width           =   1695
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Private Sub txtBox1_GotFocus(Index As Integer)

labOut.Caption = "Enter your full name."

End Sub

Private Sub txtBox2_GotFocus(Index As Integer)
 
labOut.Caption = "Enter your phone number, including area code."

End Sub

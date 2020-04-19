VERSION 5.00
Begin VB.Form frmTest 
   Caption         =   "Secret Messager Test"
   ClientHeight    =   5700
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   Icon            =   "frmTest.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5700
   ScaleWidth      =   4680
   StartUpPosition =   1  'CenterOwner
   Begin VB.TextBox txt2 
      BackColor       =   &H00E0E0E0&
      Height          =   795
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   7
      Top             =   1320
      Width           =   4455
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Height          =   375
      Left            =   1740
      TabIndex        =   3
      Top             =   5160
      Width           =   1215
   End
   Begin VB.TextBox txt4 
      BackColor       =   &H00E0E0E0&
      Height          =   795
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   2
      Top             =   3840
      Width           =   4455
   End
   Begin VB.TextBox txt3 
      BackColor       =   &H00E0E0E0&
      Height          =   795
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   1
      Top             =   2580
      Width           =   4455
   End
   Begin VB.TextBox txt1 
      BackColor       =   &H00E0E0E0&
      Height          =   795
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   0
      Top             =   60
      Width           =   4455
   End
   Begin VB.Label lbl2 
      Caption         =   "Code message encrypted from original messsage. (0 char)"
      Height          =   315
      Left            =   120
      TabIndex        =   8
      Top             =   2220
      Width           =   4455
   End
   Begin VB.Label lbl4 
      Caption         =   "Decoded message taken from above. (0 char)"
      Height          =   255
      Left            =   180
      TabIndex        =   6
      Top             =   4740
      Width           =   4215
   End
   Begin VB.Label lbl3 
      Caption         =   "Code message taken from file. (0 char)"
      Height          =   315
      Left            =   120
      TabIndex        =   5
      Top             =   3480
      Width           =   4395
   End
   Begin VB.Label lbl1 
      Caption         =   "Original message. (0 char)"
      Height          =   315
      Left            =   120
      TabIndex        =   4
      Top             =   900
      Width           =   4515
   End
End
Attribute VB_Name = "frmTest"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdOK_Click()
    Unload Me
End Sub


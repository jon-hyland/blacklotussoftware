VERSION 5.00
Begin VB.Form frmSplash 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Black Lotus Binary Crypt - v1.21"
   ClientHeight    =   2745
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4035
   Icon            =   "frmSplash.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2745
   ScaleWidth      =   4035
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cmdOK 
      Caption         =   "Agree"
      Height          =   375
      Left            =   1440
      TabIndex        =   0
      Top             =   2220
      Width           =   1155
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      Caption         =   "v1.21"
      BeginProperty Font 
         Name            =   "Impact"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   2700
      TabIndex        =   3
      Top             =   360
      Width           =   495
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      Caption         =   "Binary Crypt"
      BeginProperty Font 
         Name            =   "Impact"
         Size            =   14.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   360
      TabIndex        =   2
      Top             =   150
      Width           =   3195
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   $"frmSplash.frx":030A
      Height          =   1215
      Left            =   240
      TabIndex        =   1
      Top             =   840
      Width           =   3615
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
    If Not Agree Then BLBC.End_Prog
End Sub


VERSION 5.00
Begin VB.Form Logo 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Net Creeper by Black Lotus Software"
   ClientHeight    =   5220
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4080
   Icon            =   "Logo.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5220
   ScaleWidth      =   4080
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
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
      Left            =   1440
      TabIndex        =   0
      Top             =   4740
      Width           =   1215
   End
   Begin VB.Label Label2 
      Caption         =   "http://www.angelfire.com/wa/blacklotus."
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   255
      Left            =   300
      TabIndex        =   2
      Top             =   4470
      Width           =   3615
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   $"Logo.frx":030A
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   270
      TabIndex        =   1
      Top             =   3480
      Width           =   3555
   End
   Begin VB.Image Image1 
      Height          =   3300
      Left            =   240
      Picture         =   "Logo.frx":03CE
      Top             =   105
      Width           =   3600
   End
End
Attribute VB_Name = "Logo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Continue As Boolean
 
Private Sub cmdOK_Click()
    Continue = True
    Unload Me
End Sub

Private Sub Form_Unload(Cancel As Integer)
    If Not Continue Then EndProg
End Sub

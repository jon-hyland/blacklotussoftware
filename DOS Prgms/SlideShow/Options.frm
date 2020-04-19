VERSION 5.00
Begin VB.Form Options 
   Caption         =   "Options"
   ClientHeight    =   2865
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3360
   LinkTopic       =   "Form1"
   ScaleHeight     =   2865
   ScaleWidth      =   3360
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox ChkManual 
      Caption         =   "Manual slide change."
      Height          =   255
      Left            =   240
      TabIndex        =   7
      Top             =   2400
      Width           =   2775
   End
   Begin VB.CheckBox ChkRand 
      Caption         =   " Randomize order at directory initilize."
      DataField       =   "Res.RandomOrder"
      DataSource      =   "True"
      Height          =   255
      Left            =   240
      TabIndex        =   6
      Top             =   2040
      Width           =   3015
   End
   Begin VB.TextBox TxtDefPath 
      Height          =   285
      Left            =   240
      TabIndex        =   4
      Top             =   1320
      Width           =   2895
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Add"
      Height          =   255
      Left            =   2280
      TabIndex        =   3
      Top             =   240
      Width           =   615
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Del"
      Height          =   255
      Left            =   1440
      TabIndex        =   2
      Top             =   240
      Width           =   615
   End
   Begin VB.TextBox TxtDelay 
      Height          =   285
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   735
   End
   Begin VB.Label Label2 
      Caption         =   "Default startup path."
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   1680
      Width           =   1935
   End
   Begin VB.Label Label1 
      Caption         =   "Slideshow delay in seconds."
      Height          =   495
      Left            =   120
      TabIndex        =   1
      Top             =   600
      Width           =   1575
   End
End
Attribute VB_Name = "Options"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub ChkManual_Click()
    Manual = ChkManual.Value
End Sub

Private Sub ChkRand_Click()
    RandomOrder = ChkRand.Value
End Sub

Private Sub Form_Initialize()
    Rem TxtDelay.Text = Str()
    
    
End Sub


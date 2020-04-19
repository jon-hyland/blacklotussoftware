VERSION 5.00
Begin VB.Form Help 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Help / Product Documentation"
   ClientHeight    =   5310
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6990
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5310
   ScaleWidth      =   6990
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
      Left            =   2820
      TabIndex        =   1
      Top             =   4740
      Width           =   1335
   End
   Begin VB.TextBox txtHelp 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4395
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Text            =   "Help.frx":0000
      Top             =   120
      Width           =   6735
   End
End
Attribute VB_Name = "Help"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdOK_Click()
    Unload Me
End Sub

Private Sub Form_Load()
    Dim sHelp As String
    
    If Right(App.Path, 1) <> "\" Then
        Open App.Path & "\" & "helpdoc.dat" For Input As #1
    Else
        Open App.Path & "helpdoc.dat" For Input As #1
    End If
    Input #1, sHelp
    Close #1
    txtHelp.Text = sHelp
    Exit Sub
End Sub

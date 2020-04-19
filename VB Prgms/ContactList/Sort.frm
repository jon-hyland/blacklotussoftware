VERSION 5.00
Begin VB.Form Sort 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Contact List -- Sort Database"
   ClientHeight    =   2610
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4095
   Icon            =   "Sort.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2610
   ScaleWidth      =   4095
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   1440
      TabIndex        =   4
      Top             =   2040
      Width           =   1215
   End
   Begin VB.OptionButton chkDate 
      Caption         =   "  Sort by date created."
      Height          =   495
      Left            =   360
      TabIndex        =   2
      Top             =   840
      Width           =   2775
   End
   Begin VB.OptionButton chkLast 
      Caption         =   "  Sort alphabetically by last name."
      Height          =   495
      Left            =   360
      TabIndex        =   1
      Top             =   480
      Width           =   3135
   End
   Begin VB.OptionButton chkFirst 
      Caption         =   "  Sort alphabetically by first name."
      Height          =   495
      Left            =   360
      TabIndex        =   0
      Top             =   120
      Width           =   3735
   End
   Begin VB.Label Label1 
      Caption         =   "Select an option to sort the record list."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   360
      TabIndex        =   3
      Top             =   1560
      Width           =   3375
   End
End
Attribute VB_Name = "Sort"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub chkDate_Click()
    chkDate.Value = True
    Sort_Data (3)
End Sub

Private Sub chkFirst_Click()
    chkFirst.Value = True
    Sort_Data (1)
End Sub

Private Sub chkLast_Click()
    chkLast.Value = True
    Sort_Data (2)
End Sub

Private Sub cmdOK_Click()
    Sort.Hide
End Sub

Private Sub Form_Activate()
    chkFirst.Value = False
    chkLast.Value = False
    chkDate.Value = False
    cmdOK.SetFocus
End Sub

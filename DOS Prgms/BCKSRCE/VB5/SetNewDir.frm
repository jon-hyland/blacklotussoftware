VERSION 5.00
Begin VB.Form SetNewDir 
   Caption         =   "Select Series"
   ClientHeight    =   2445
   ClientLeft      =   60
   ClientTop       =   375
   ClientWidth     =   4560
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   2445
   ScaleWidth      =   4560
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cmdEndSeries 
      Caption         =   "End Series"
      Height          =   375
      Left            =   3240
      TabIndex        =   4
      Top             =   1680
      Width           =   1095
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   3240
      TabIndex        =   3
      Top             =   840
      Width           =   1095
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Height          =   375
      Left            =   3240
      TabIndex        =   2
      Top             =   240
      Width           =   1095
   End
   Begin VB.ListBox viewList 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1740
      Left            =   240
      TabIndex        =   1
      Top             =   240
      Width           =   2655
   End
   Begin VB.DirListBox dirList 
      Height          =   315
      Left            =   960
      TabIndex        =   0
      Top             =   2160
      Visible         =   0   'False
      Width           =   1215
   End
End
Attribute VB_Name = "SetNewDir"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdCancel_Click()
    SetNewDir.Hide
End Sub

Private Sub cmdEndSeries_Click()
    bSeries = False
    iNum = iNum - 1
    SetNewDir.Hide
End Sub

Private Sub cmdOK_Click()
    SlideShow.fileList.Path = Format_Path(sRunPath + "\MODULES\MULTI\" + viewList.List(viewList.ListIndex))
    bSeries = True
    iSNum = -1
    SetNewDir.Hide
End Sub

Private Sub Form_Load()
    Dim iCount As Integer
    SetNewDir.Left = (Screen.Width / 2) - (SetNewDir.Width / 2)
    SetNewDir.Top = (Screen.Height / 2) - (SetNewDir.Height / 2)
    dirList.Path = Format_Path(sRunPath + "\MODULES\MULTI\")
    For iCount = 0 To dirList.ListCount - 1
        viewList.AddItem Remove_Path(dirList.List(iCount))
    Next iCount
    viewList.ListIndex = 0
End Sub

Private Sub viewList_DblClick()
    Call cmdOK_Click
End Sub

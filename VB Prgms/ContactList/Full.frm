VERSION 5.00
Begin VB.Form Full 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Contact List -- View All Contacts"
   ClientHeight    =   4950
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5760
   Icon            =   "Full.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4950
   ScaleWidth      =   5760
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
      Left            =   2160
      TabIndex        =   1
      Top             =   4440
      Width           =   1455
   End
   Begin VB.ListBox lstFull 
      BeginProperty Font 
         Name            =   "Fixedsys"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4110
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   5535
   End
End
Attribute VB_Name = "Full"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdOK_Click()
    RecNum = lstFull.ListIndex + 1
    Full.Hide
    Show_Record (RecNum)
End Sub

Private Sub Form_Activate()
    Dim Count As Integer
    Dim StrItem As String
    Dim JunkStr As String
    Const Junk = "                         "
    
    lstFull.Clear
    For Count = 1 To RecTot
        JunkStr = FirstName(Count)
        If Len(JunkStr) > 14 Then JunkStr = Left(JunkStr, 14)
        StrItem = JunkStr + Left(Junk, 14 - (Len(JunkStr)))
        JunkStr = LastName(Count)
        If Len(JunkStr) > 15 Then JunkStr = Left(JunkStr, 15)
        StrItem = StrItem + JunkStr + Left(Junk, 14 - (Len(JunkStr)))
        StrItem = StrItem + PhoneNumber(Count)
        lstFull.AddItem StrItem
    Next Count
    lstFull.ListIndex = RecNum - 1
End Sub

Private Sub lstFull_DblClick()
    cmdOK_Click
End Sub

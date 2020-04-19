VERSION 5.00
Begin VB.Form Search 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Contact List -- Search Database"
   ClientHeight    =   2100
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3975
   Icon            =   "Search.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2100
   ScaleWidth      =   3975
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
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
      Left            =   2520
      TabIndex        =   2
      Top             =   1560
      Width           =   1215
   End
   Begin VB.CommandButton cmdSearch 
      Caption         =   "Search"
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
      Left            =   240
      TabIndex        =   1
      Top             =   1560
      Width           =   1215
   End
   Begin VB.TextBox txtSearch 
      Height          =   285
      Left            =   720
      TabIndex        =   0
      Top             =   240
      Width           =   2415
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "Enter first name, last name or phone number to search database for.  Not case-sensitive."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   480
      TabIndex        =   3
      Top             =   720
      Width           =   3015
   End
End
Attribute VB_Name = "Search"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdCancel_Click()
    Search.Hide
End Sub

Private Sub cmdSearch_Click()
    Dim SearchStr As String
    Dim Count As Integer
    Dim Match As Boolean
    Dim StrItem As String
    Dim JunkStr As String
    Const JunkConst = "                    "
    
    SearchStr = Format(Clip_Str(txtSearch.Text), ">")
    If SearchStr <> "" Then
        Results.lstSearch.Clear
        For Count = 1 To RecTot
            Match = False
            If Format(FirstName(Count), ">") = SearchStr Then Match = True
            If Format(LastName(Count), ">") = SearchStr Then Match = True
            If Format(PhoneNumber(Count), ">") = SearchStr Then Match = True
            If Format(SecPhoneNumber(Count), ">") = SearchStr Then Match = True
            If Match Then
                JunkStr = FirstName(Count)
                If Len(JunkStr) > 14 Then JunkStr = Left(JunkStr, 14)
                StrItem = JunkStr + Left(JunkConst, 14 - (Len(JunkStr)))
                JunkStr = LastName(Count)
                If Len(JunkStr) > 15 Then JunkStr = Left(JunkStr, 15)
                StrItem = StrItem + JunkStr + Left(JunkConst, 14 - (Len(JunkStr)))
                StrItem = StrItem + PhoneNumber(Count)
                Results.lstSearch.AddItem StrItem
                Results_Index(Results.lstSearch.ListCount) = Count
            End If
        Next Count
        If Results.lstSearch.ListCount < 1 Then
            StrItem = "No Matches Found"
            Results.lstSearch.AddItem StrItem
        End If
        Results.Show
        Search.Hide
    Else
        txtSearch.Text = ""
        txtSearch.SetFocus
    End If
End Sub

Private Sub Form_Activate()
    txtSearch.SetFocus
    txtSearch.Text = ""
End Sub

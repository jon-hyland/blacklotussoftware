VERSION 5.00
Begin VB.Form Del 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Delete Entry?"
   ClientHeight    =   2670
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3240
   Icon            =   "Del.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2670
   ScaleWidth      =   3240
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdNo 
      Caption         =   "No"
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
      Left            =   2040
      TabIndex        =   2
      Top             =   2160
      Width           =   975
   End
   Begin VB.CommandButton cmdYes 
      Caption         =   "Yes"
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
      Top             =   2160
      Width           =   975
   End
   Begin VB.Shape Shape3 
      FillColor       =   &H0000FFFF&
      FillStyle       =   0  'Solid
      Height          =   375
      Left            =   1440
      Shape           =   3  'Circle
      Top             =   960
      Width           =   255
   End
   Begin VB.Shape Shape2 
      FillColor       =   &H0000FFFF&
      FillStyle       =   0  'Solid
      Height          =   615
      Left            =   1440
      Shape           =   4  'Rounded Rectangle
      Top             =   360
      Width           =   255
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "Are you sure you want to delete the current contact entry?"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   240
      TabIndex        =   0
      Top             =   1560
      Width           =   2775
   End
   Begin VB.Shape Shape1 
      FillColor       =   &H000000FF&
      FillStyle       =   0  'Solid
      Height          =   1335
      Left            =   960
      Shape           =   3  'Circle
      Top             =   120
      Width           =   1215
   End
End
Attribute VB_Name = "Del"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub cmdNo_Click()
    Del.Hide
End Sub

Private Sub cmdYes_Click()
    Dim Count As Integer
    
    For Count = RecNum To RecTot
        FirstName(Count) = FirstName(Count + 1)
        LastName(Count) = LastName(Count + 1)
        PhoneNumber(Count) = PhoneNumber(Count + 1)
        SecPhoneNumber(Count) = SecPhoneNumber(Count + 1)
        EMailAddress(Count) = EMailAddress(Count + 1)
    Next Count
    RecTot = RecTot - 1
    If RecNum > RecTot Then RecNum = RecTot
    If RecTot < 1 Then
        Add.cmdCancel.Enabled = False
        Add.Show
        Del.Hide
    Else
        Show_Record (RecNum)
        Save_Data
        Del.Hide
    End If
End Sub

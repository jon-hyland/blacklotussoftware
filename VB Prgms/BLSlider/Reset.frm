VERSION 5.00
Begin VB.Form Reset 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Reset BLSlider Data File"
   ClientHeight    =   2970
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3855
   Icon            =   "Reset.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2970
   ScaleWidth      =   3855
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
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
      Left            =   2520
      TabIndex        =   2
      Top             =   2400
      Width           =   1095
   End
   Begin VB.CommandButton cmdReset 
      Caption         =   "Reset"
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
      Left            =   240
      TabIndex        =   1
      Top             =   2400
      Width           =   1095
   End
   Begin VB.Shape Shape3 
      FillColor       =   &H0000FFFF&
      FillStyle       =   0  'Solid
      Height          =   375
      Left            =   1800
      Shape           =   3  'Circle
      Top             =   960
      Width           =   255
   End
   Begin VB.Shape Shape2 
      FillColor       =   &H0000FFFF&
      FillStyle       =   0  'Solid
      Height          =   615
      Left            =   1800
      Shape           =   4  'Rounded Rectangle
      Top             =   360
      Width           =   255
   End
   Begin VB.Shape Shape1 
      FillColor       =   &H000000FF&
      FillStyle       =   0  'Solid
      Height          =   1335
      Left            =   1320
      Shape           =   3  'Circle
      Top             =   120
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "Clicking the Reset button will return the data file to it's default settings."
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
      Left            =   360
      TabIndex        =   0
      Top             =   1680
      Width           =   3135
   End
End
Attribute VB_Name = "Reset"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdCancel_Click()
    Unload Me
    End
End Sub

Private Sub cmdReset_Click()
    Const InitOptionsFile = "blsini.dat"
    Const Random = True
    Const NoTimer = False
    Const Manual = False
    
    Open (App.Path + "\" + InitOptionsFile) For Output As #1
    If Right(App.Path, 1) = "\" Then
        Write #1, App.Path
    Else
        Write #1, (App.Path + "\")
    End If
    Write #1, "*.JPG"
    Write #1, 3
    Write #1, Random
    Write #1, NoTimer
    Write #1, Manual
    Write #1, 6
    Close #1
    Unload Me
    End
End Sub

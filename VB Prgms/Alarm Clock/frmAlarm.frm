VERSION 5.00
Begin VB.Form frmAlarm 
   Caption         =   "Alarm Clock - Black Lotus Software"
   ClientHeight    =   2295
   ClientLeft      =   60
   ClientTop       =   630
   ClientWidth     =   6210
   Icon            =   "frmAlarm.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2295
   ScaleWidth      =   6210
   StartUpPosition =   2  'CenterScreen
   Begin VB.Timer tmrClock 
      Interval        =   42
      Left            =   4980
      Top             =   1680
   End
   Begin VB.Label lblAlarm 
      Alignment       =   2  'Center
      Caption         =   "12:00 AM"
      BeginProperty Font 
         Name            =   "Impact"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000080FF&
      Height          =   315
      Left            =   420
      TabIndex        =   2
      Top             =   1740
      Width           =   1635
   End
   Begin VB.Image imgAlarm 
      Height          =   435
      Left            =   2520
      Top             =   1680
      Width           =   1275
   End
   Begin VB.Shape shpAlarm 
      FillColor       =   &H00C00000&
      FillStyle       =   0  'Solid
      Height          =   435
      Left            =   2520
      Shape           =   2  'Oval
      Top             =   1680
      Width           =   1275
   End
   Begin VB.Label lblSec 
      Caption         =   "59"
      BeginProperty Font 
         Name            =   "Impact"
         Size            =   27.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   555
      Left            =   5520
      TabIndex        =   1
      Top             =   1560
      Width           =   795
   End
   Begin VB.Label lblTime 
      Alignment       =   2  'Center
      Caption         =   "12:00  AM"
      BeginProperty Font 
         Name            =   "Impact"
         Size            =   72
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   1515
      Left            =   120
      TabIndex        =   0
      Top             =   -60
      Width           =   6075
   End
   Begin VB.Menu mnuClock 
      Caption         =   "&Clock"
      Begin VB.Menu mnuSet 
         Caption         =   "&Set Alarm"
      End
      Begin VB.Menu mnuExit 
         Caption         =   "E&xit"
      End
   End
   Begin VB.Menu mnuInfo 
      Caption         =   "&Info"
      Begin VB.Menu mnuAbout 
         Caption         =   "&About"
      End
   End
End
Attribute VB_Name = "frmAlarm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Form_Unload(Cancel As Integer)
    Code.End_Prog
End Sub

Private Sub imgAlarm_Click()
    Code.Show_Settings
End Sub

Private Sub mnuAbout_Click()
    Code.Show_About
End Sub

Private Sub mnuExit_Click()
    Code.End_Prog
End Sub

Private Sub mnuSet_Click()
    Code.Show_Settings
End Sub

Private Sub tmrClock_Timer()
    Code.Update_Time
End Sub

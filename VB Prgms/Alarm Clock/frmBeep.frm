VERSION 5.00
Begin VB.Form frmBeep 
   BorderStyle     =   0  'None
   Caption         =   "Wake Up!"
   ClientHeight    =   3195
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4680
   Icon            =   "frmBeep.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer tmrClock 
      Interval        =   50
      Left            =   3960
      Top             =   2400
   End
   Begin VB.Image imgBeep 
      Height          =   1335
      Left            =   1440
      Top             =   840
      Width           =   2175
   End
   Begin VB.Shape shpBeep 
      FillColor       =   &H00FFFFFF&
      FillStyle       =   0  'Solid
      Height          =   2895
      Left            =   120
      Top             =   120
      Width           =   4455
   End
End
Attribute VB_Name = "frmBeep"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim iLight As Integer

Private Sub Form_Load()
    Me.Top = 0
    Me.Left = 0
    Me.Height = Screen.Height
    Me.Width = Screen.Width
    shpBeep.Top = 0
    shpBeep.Left = 0
    shpBeep.Height = Me.Height
    shpBeep.Width = Me.Width
    imgBeep.Top = 0
    imgBeep.Left = 0
    imgBeep.Height = Me.Height
    imgBeep.Width = Me.Width
End Sub

Private Sub imgBeep_Click()
    Unload Me
End Sub

Private Sub tmrClock_Timer()
    iLight = iLight + 1
    If iLight > 1 Then iLight = 0
    If iLight Then
        shpBeep.FillColor = &HFFFFFF
    Else
        shpBeep.FillColor = &H0&
    End If
    Beep
End Sub

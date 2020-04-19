VERSION 5.00
Begin VB.Form frmSet 
   BackColor       =   &H8000000A&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Alarm Clock Settings"
   ClientHeight    =   1770
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4680
   Icon            =   "frmSet.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1770
   ScaleWidth      =   4680
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cmdDownMin 
      Height          =   135
      Left            =   1020
      TabIndex        =   12
      Top             =   840
      Width           =   315
   End
   Begin VB.CommandButton cmdUpMin 
      Height          =   135
      Left            =   1020
      TabIndex        =   11
      Top             =   720
      Width           =   315
   End
   Begin VB.CommandButton cmdDownHour 
      Height          =   135
      Left            =   1020
      TabIndex        =   10
      Top             =   300
      Width           =   315
   End
   Begin VB.CommandButton cmdUpHour 
      Height          =   135
      Left            =   1020
      TabIndex        =   9
      Top             =   180
      Width           =   315
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Height          =   375
      Left            =   1860
      TabIndex        =   8
      Top             =   1260
      Width           =   915
   End
   Begin VB.CommandButton cmdTest 
      Caption         =   "Test"
      Height          =   315
      Left            =   3660
      TabIndex        =   7
      Top             =   720
      Width           =   795
   End
   Begin VB.CommandButton cmdOnOff 
      Caption         =   "Alarm is OFF"
      Height          =   315
      Left            =   2220
      TabIndex        =   6
      Top             =   720
      Width           =   1095
   End
   Begin VB.OptionButton optPM 
      Caption         =   "PM"
      Height          =   315
      Left            =   3660
      TabIndex        =   5
      Top             =   120
      Width           =   615
   End
   Begin VB.OptionButton optAM 
      BackColor       =   &H8000000A&
      Caption         =   "AM"
      Height          =   315
      Left            =   2400
      TabIndex        =   4
      Top             =   120
      Width           =   615
   End
   Begin VB.TextBox txtMin 
      BackColor       =   &H00E0E0E0&
      Height          =   285
      Left            =   180
      TabIndex        =   1
      Top             =   720
      Width           =   855
   End
   Begin VB.TextBox txtHour 
      BackColor       =   &H00E0E0E0&
      Height          =   285
      Left            =   180
      TabIndex        =   0
      Top             =   180
      Width           =   855
   End
   Begin VB.Label Label2 
      Caption         =   "Minute"
      Height          =   255
      Left            =   1500
      TabIndex        =   3
      Top             =   720
      Width           =   615
   End
   Begin VB.Label Label1 
      Caption         =   "Hour"
      Height          =   195
      Left            =   1500
      TabIndex        =   2
      Top             =   180
      Width           =   555
   End
End
Attribute VB_Name = "frmSet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub cmdDownHour_Click()
    Dim iNum As Integer
    
    iNum = Val(txtHour.Text) - 1
    If iNum < 1 Then iNum = 12
    txtHour = Str(iNum)
End Sub

Private Sub cmdDownMin_Click()
    Dim iNum As Integer
    
    iNum = Val(txtMin.Text) - 1
    If iNum < 0 Then iNum = 59
    txtMin = Str(iNum)
End Sub

Private Sub cmdOK_Click()
    Code.Save_Settings
    Unload Me
End Sub

Private Sub cmdOnOff_Click()
    Code.Alarm_OnOff
End Sub

Private Sub cmdTest_Click()
    Dim fBeep As frmBeep
    Set fBeep = New frmBeep
    fBeep.Show vbModal
End Sub

Private Sub cmdUpHour_Click()
    Dim iNum As Integer
    
    iNum = Val(txtHour.Text) + 1
    If iNum > 12 Then iNum = 1
    txtHour = Str(iNum)
End Sub

Private Sub cmdUpMin_Click()
    Dim iNum As Integer
    
    iNum = Val(txtMin.Text) + 1
    If iNum > 59 Then iNum = 0
    txtMin = Str(iNum)
End Sub

Private Sub Form_Load()
    Code.Update_Settings
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Code.Save_Settings
End Sub

Private Sub optAM_Click()
    Code.sAlarmAMPM = "AM"
    Code.Save_Settings
End Sub

Private Sub optPM_Click()
    Code.sAlarmAMPM = "PM"
    Code.Save_Settings
End Sub

Private Sub txtHour_Change()
    If (Val(txtHour.Text) >= 1) And (Val(txtHour.Text) <= 12) Then
        Code.iAlarmHour = Val(txtHour.Text)
    Else
        txtHour.Text = " 0"
        Code.iAlarmHour = Val(txtHour.Text)
    End If
    Code.Save_Settings
End Sub

Private Sub txtMin_Change()
    If (Val(txtMin.Text) >= 0) And (Val(txtMin.Text) <= 59) Then
        Code.iAlarmMin = Val(txtMin.Text)
    Else
        txtMin.Text = " 0"
        Code.iAlarmMin = Val(txtMin.Text)
    End If
    Code.Save_Settings
End Sub

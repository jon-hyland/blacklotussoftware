VERSION 5.00
Object = "{EAB22AC0-30C1-11CF-A7EB-0000C05BAE0B}#1.1#0"; "SHDOCVW.DLL"
Begin VB.Form Full 
   BorderStyle     =   0  'None
   Caption         =   "Net Creeper by Black Lotus Software"
   ClientHeight    =   5340
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   9600
   Icon            =   "Full.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5340
   ScaleWidth      =   9600
   StartUpPosition =   3  'Windows Default
   Begin VB.ListBox lstRecent 
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0080C0FF&
      Height          =   1425
      Left            =   2640
      TabIndex        =   9
      Top             =   450
      Visible         =   0   'False
      Width           =   4875
   End
   Begin VB.CommandButton cmdRefresh 
      Appearance      =   0  'Flat
      DisabledPicture =   "Full.frx":030A
      DownPicture     =   "Full.frx":098C
      Enabled         =   0   'False
      Height          =   375
      Left            =   2040
      MaskColor       =   &H00FFFFFF&
      Picture         =   "Full.frx":100E
      Style           =   1  'Graphical
      TabIndex        =   8
      ToolTipText     =   "Refresh Current Page"
      Top             =   60
      UseMaskColor    =   -1  'True
      Width           =   495
   End
   Begin VB.CommandButton cmdStop 
      Appearance      =   0  'Flat
      DisabledPicture =   "Full.frx":1690
      DownPicture     =   "Full.frx":1CE2
      Enabled         =   0   'False
      Height          =   375
      Left            =   1560
      MaskColor       =   &H00FFFFFF&
      Picture         =   "Full.frx":2334
      Style           =   1  'Graphical
      TabIndex        =   7
      ToolTipText     =   "Stop Navigation"
      Top             =   60
      UseMaskColor    =   -1  'True
      Width           =   495
   End
   Begin VB.CommandButton cmdNext 
      Appearance      =   0  'Flat
      DisabledPicture =   "Full.frx":2986
      DownPicture     =   "Full.frx":2FD8
      Enabled         =   0   'False
      Height          =   375
      Left            =   1080
      MaskColor       =   &H00FFFFFF&
      Picture         =   "Full.frx":362A
      Style           =   1  'Graphical
      TabIndex        =   6
      ToolTipText     =   "Next Page"
      Top             =   60
      UseMaskColor    =   -1  'True
      Width           =   495
   End
   Begin VB.CommandButton cmdPrev 
      Appearance      =   0  'Flat
      DisabledPicture =   "Full.frx":3C7C
      DownPicture     =   "Full.frx":42CE
      Enabled         =   0   'False
      Height          =   375
      Left            =   600
      MaskColor       =   &H00FFFFFF&
      Picture         =   "Full.frx":4920
      Style           =   1  'Graphical
      TabIndex        =   5
      ToolTipText     =   "Previous Page"
      Top             =   60
      UseMaskColor    =   -1  'True
      Width           =   495
   End
   Begin VB.CommandButton cmdNorm 
      Appearance      =   0  'Flat
      DisabledPicture =   "Full.frx":4F72
      DownPicture     =   "Full.frx":55C4
      Enabled         =   0   'False
      Height          =   375
      Left            =   8460
      MaskColor       =   &H00FFFFFF&
      Picture         =   "Full.frx":5C16
      Style           =   1  'Graphical
      TabIndex        =   4
      ToolTipText     =   "Exit Fullscreen Mode"
      Top             =   60
      UseMaskColor    =   -1  'True
      Width           =   495
   End
   Begin VB.Timer tmrClock 
      Interval        =   420
      Left            =   9060
      Top             =   600
   End
   Begin VB.TextBox txtAddress 
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0080C0FF&
      Height          =   375
      Left            =   2640
      TabIndex        =   3
      Top             =   60
      Width           =   4875
   End
   Begin VB.CommandButton cmdGo 
      Appearance      =   0  'Flat
      DisabledPicture =   "Full.frx":6268
      DownPicture     =   "Full.frx":6966
      Enabled         =   0   'False
      Height          =   375
      Left            =   7860
      MaskColor       =   &H00FFFFFF&
      Picture         =   "Full.frx":7064
      Style           =   1  'Graphical
      TabIndex        =   2
      ToolTipText     =   "Navigate"
      Top             =   60
      UseMaskColor    =   -1  'True
      Width           =   495
   End
   Begin VB.CommandButton cmdDrop 
      Appearance      =   0  'Flat
      DisabledPicture =   "Full.frx":7762
      DownPicture     =   "Full.frx":7D5C
      Enabled         =   0   'False
      Height          =   375
      Left            =   7500
      MaskColor       =   &H00FFFFFF&
      Picture         =   "Full.frx":8356
      Style           =   1  'Graphical
      TabIndex        =   1
      ToolTipText     =   "Recent Box"
      Top             =   60
      UseMaskColor    =   -1  'True
      Width           =   315
   End
   Begin SHDocVwCtl.WebBrowser IEF 
      Height          =   4395
      Left            =   120
      TabIndex        =   0
      Top             =   500
      Width           =   9375
      ExtentX         =   16536
      ExtentY         =   7752
      ViewMode        =   1
      Offline         =   0
      Silent          =   0
      RegisterAsBrowser=   0
      RegisterAsDropTarget=   1
      AutoArrange     =   -1  'True
      NoClientEdge    =   0   'False
      AlignLeft       =   0   'False
      ViewID          =   "{0057D0E0-3573-11CF-AE69-08002B2E1262}"
      Location        =   ""
   End
   Begin VB.Image imgRefresh 
      Height          =   375
      Left            =   2040
      Top             =   60
      Width           =   495
   End
   Begin VB.Image imgStop 
      Height          =   375
      Left            =   1560
      Top             =   60
      Width           =   495
   End
   Begin VB.Image imgNext 
      Height          =   375
      Left            =   1080
      Top             =   60
      Width           =   495
   End
   Begin VB.Image imgPrev 
      Height          =   375
      Left            =   600
      Top             =   60
      Width           =   495
   End
   Begin VB.Image imgLogo 
      Appearance      =   0  'Flat
      Height          =   525
      Left            =   60
      Picture         =   "Full.frx":8950
      ToolTipText     =   "Options Menu"
      Top             =   0
      Width           =   525
   End
   Begin VB.Image imgGo 
      Height          =   375
      Left            =   7860
      Top             =   60
      Width           =   495
   End
   Begin VB.Image imgNorm 
      Height          =   375
      Left            =   8460
      Top             =   60
      Width           =   495
   End
   Begin VB.Image imgDrop 
      Height          =   375
      Left            =   7500
      Top             =   60
      Width           =   315
   End
   Begin VB.Shape shpBusy 
      BorderWidth     =   2
      FillColor       =   &H000000FF&
      FillStyle       =   0  'Solid
      Height          =   375
      Left            =   9120
      Shape           =   2  'Oval
      Top             =   60
      Width           =   315
   End
End
Attribute VB_Name = "Full"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub cmdDrop_Click()
    If DropDown Then
        DropDown = False
        lstRecent.Visible = DropDown
    Else
        DropDown = True
        lstRecent.Visible = DropDown
        lstRecent.SetFocus
    End If
End Sub

Private Sub cmdGo_Click()
    If Not lstRecent.Visible Then
        txtAddress.SetFocus
        DropDown = False
        lstRecent.Visible = DropDown
        Address = txtAddress.Text
        GoType = 3
        IEF.Navigate Address
    End If
End Sub

Private Sub cmdNext_Click()
    txtAddress.SetFocus
    DropDown = False
    lstRecent.Visible = DropDown
    If NumRecent < (TotRecent - 1) Then
        Address = lstRecent.List(NumRecent + 1)
        GoType = 2
        IEF.Navigate Address
    End If
End Sub

Private Sub cmdPrev_Click()
    txtAddress.SetFocus
    DropDown = False
    lstRecent.Visible = DropDown
    If NumRecent > 0 Then
        Address = lstRecent.List(NumRecent - 1)
        GoType = 1
        IEF.Navigate Address
    End If
End Sub

Private Sub cmdRefresh_Click()
    txtAddress.SetFocus
    DropDown = False
    lstRecent.Visible = DropDown
    IEF.Refresh
End Sub

Private Sub cmdStop_Click()
    txtAddress.SetFocus
    DropDown = False
    lstRecent.Visible = DropDown
    IEF.Stop
    'Address = IEF.LocationURL
    'txtAddress.Text = Address
End Sub

Private Sub Form_Click()
    DropDown = False
    lstRecent.Visible = DropDown
End Sub

Private Sub IEF_NavigateComplete2(ByVal pDisp As Object, URL As Variant)
    Dim Count As Integer

    For Count = 1 To Unallowed.Count
        If Left(URL, Len(Unallowed.Item(Count))) = Unallowed.Item(Count) Then
            Exit Sub
        End If
    Next Count
    Address = URL
    txtAddress.Text = Address
    txtAddress.SelStart = Len(txtAddress.Text)
    Select Case GoType
        Case 0
            NumRecent = NumRecent + 1
            Main.lstRecent.AddItem Address, NumRecent
            TotRecent = TotRecent + 1
        Case 1
            NumRecent = NumRecent - 1
            Main.lstRecent.ListIndex = NumRecent
            If NumRecent = 0 Then cmdPrev.Enabled = False
        Case 2
            NumRecent = NumRecent + 1
            Main.lstRecent.ListIndex = NumRecent
            If NumRecent >= (TotRecent - 1) Then cmdNext.Enabled = False
        Case 3
            Main.lstRecent.AddItem (Address)
            TotRecent = TotRecent + 1
            NumRecent = TotRecent - 1
        Case 4
            NumRecent = lstRecent.ListIndex
    End Select
    Count = 0
    Do While (Count <= (TotRecent - 2))
        If Main.lstRecent.List(Count) = Main.lstRecent.List(Count + 1) Then
            Main.lstRecent.RemoveItem Count
            TotRecent = TotRecent - 1
            If NumRecent > Count Then NumRecent = NumRecent - 1
        End If
        Count = Count + 1
    Loop
    While TotRecent > MaxRecent
        Main.lstRecent.RemoveItem 0
        TotRecent = TotRecent - 1
        If NumRecent > 0 Then NumRecent = NumRecent - 1
    Wend
    Main.lstRecent.ListIndex = NumRecent
    GoType = 0
    lstRecent.Clear
    For Count = 1 To Main.lstRecent.ListCount
        lstRecent.AddItem Main.lstRecent.List(Count - 1)
    Next Count
    lstRecent.ListIndex = Main.lstRecent.ListIndex
End Sub

Private Sub IEF_TitleChange(ByVal Text As String)
    Me.Caption = IEF.LocationName + " - Net Creeper"
End Sub

Private Sub imgDrop_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    cmdPrev.Enabled = False
    cmdNext.Enabled = False
    cmdStop.Enabled = False
    cmdRefresh.Enabled = False
    cmdDrop.Enabled = True
    cmdGo.Enabled = False
    cmdNorm.Enabled = False
End Sub

Private Sub cmdNorm_Click()
    DropDown = False
    lstRecent.Visible = DropDown
    FullScrn = False
    Main.Show
    Me.Hide
End Sub

Private Sub imgLogo_Click()
    DropDown = False
    lstRecent.Visible = DropDown
    Menu.Show vbModal
End Sub

Private Sub imgNext_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If NumRecent < (TotRecent - 1) Then
        cmdPrev.Enabled = False
        cmdNext.Enabled = True
        cmdStop.Enabled = False
        cmdRefresh.Enabled = False
        cmdDrop.Enabled = False
        cmdGo.Enabled = False
        cmdNorm.Enabled = False
    Else
        cmdPrev.Enabled = False
        cmdNext.Enabled = False
        cmdStop.Enabled = False
        cmdRefresh.Enabled = False
        cmdDrop.Enabled = False
        cmdGo.Enabled = False
        cmdNorm.Enabled = False
    End If
End Sub

Private Sub imgNorm_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    cmdPrev.Enabled = False
    cmdNext.Enabled = False
    cmdStop.Enabled = False
    cmdRefresh.Enabled = False
    cmdDrop.Enabled = False
    cmdGo.Enabled = False
    cmdNorm.Enabled = True
End Sub

Private Sub Form_Activate()
    Me.Left = 0
    Me.Width = Screen.Width
    Me.Top = 0
    Me.Height = Screen.Height - 420
    If (IEF.LocationURL <> Address) Then InitIEF
    txtAddress.SetFocus
End Sub

Private Sub Form_Load()
    Me.Left = 0
    Me.Width = Screen.Width
    Me.Top = 0
    Me.Height = Screen.Height - 420
    InitIEF
End Sub

Private Sub Form_Resize()
    shpBusy.Left = Me.Width - 480
    cmdNorm.Left = Me.Width - 1140
    imgNorm.Left = Me.Width - 1140
    cmdGo.Left = Me.Width - 1740
    imgGo.Left = Me.Width - 1740
    cmdDrop.Left = Me.Width - 2100
    imgDrop.Left = Me.Width - 2100
    txtAddress.Width = Me.Width - 4725
    lstRecent.Width = Me.Width - 4725
    ResizeIE
End Sub

Private Sub imgGo_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    cmdPrev.Enabled = False
    cmdNext.Enabled = False
    cmdStop.Enabled = False
    cmdRefresh.Enabled = False
    cmdDrop.Enabled = False
    cmdGo.Enabled = True
    cmdNorm.Enabled = False
End Sub

Private Sub imgPrev_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If NumRecent > 0 Then
        cmdPrev.Enabled = True
        cmdNext.Enabled = False
        cmdStop.Enabled = False
        cmdRefresh.Enabled = False
        cmdDrop.Enabled = False
        cmdGo.Enabled = False
        cmdNorm.Enabled = False
    Else
        cmdPrev.Enabled = False
        cmdNext.Enabled = False
        cmdStop.Enabled = False
        cmdRefresh.Enabled = False
        cmdDrop.Enabled = False
        cmdGo.Enabled = False
        cmdNorm.Enabled = False
    End If
End Sub

Private Sub imgRefresh_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    cmdPrev.Enabled = False
    cmdNext.Enabled = False
    cmdStop.Enabled = False
    cmdRefresh.Enabled = True
    cmdDrop.Enabled = False
    cmdGo.Enabled = False
    cmdNorm.Enabled = False
End Sub

Private Sub imgStop_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    cmdPrev.Enabled = False
    cmdNext.Enabled = False
    cmdStop.Enabled = True
    cmdRefresh.Enabled = False
    cmdDrop.Enabled = False
    cmdGo.Enabled = False
    cmdNorm.Enabled = False
End Sub

Private Sub lstRecent_Click()
    If lstRecent.ListIndex >= 0 Then
        txtAddress.Text = lstRecent.List(lstRecent.ListIndex)
    Else
        txtAddress.Text = Address
    End If
End Sub

Private Sub lstRecent_DblClick()
    Address = lstRecent.List(lstRecent.ListIndex)
    txtAddress = Address
    DropDown = False
    lstRecent.Visible = DropDown
    GoType = 4
    IEF.Navigate Address
End Sub

Private Sub tmrClock_Timer()
    If IEF.Busy = True Then
        shpBusy.FillColor = &HFF&
    Else
        shpBusy.FillColor = &HC00000
    End If
End Sub

Private Sub txtAddress_GotFocus()
    DropDown = False
    lstRecent.Visible = DropDown
    If txtAddress.SelStart = 0 Then
        txtAddress.SelStart = Len(txtAddress.Text)
    End If
End Sub

Private Sub txtAddress_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        KeyAscii = 0
        cmdGo_Click
    End If
End Sub

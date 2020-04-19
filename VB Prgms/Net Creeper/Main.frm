VERSION 5.00
Object = "{EAB22AC0-30C1-11CF-A7EB-0000C05BAE0B}#1.1#0"; "SHDOCVW.DLL"
Begin VB.Form Main 
   BackColor       =   &H8000000A&
   Caption         =   "Net Creeper by Black Lotus Software"
   ClientHeight    =   8145
   ClientLeft      =   165
   ClientTop       =   450
   ClientWidth     =   12075
   Icon            =   "Main.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8145
   ScaleWidth      =   12075
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Appearance      =   0  'Flat
      DisabledPicture =   "Main.frx":030A
      DownPicture     =   "Main.frx":114C
      Enabled         =   0   'False
      Height          =   690
      Left            =   9540
      MaskColor       =   &H00FFFFFF&
      Picture         =   "Main.frx":1F8E
      Style           =   1  'Graphical
      TabIndex        =   15
      ToolTipText     =   "Your Mail Page"
      Top             =   0
      UseMaskColor    =   -1  'True
      Width           =   780
   End
   Begin VB.CommandButton cmdDrop 
      Appearance      =   0  'Flat
      DisabledPicture =   "Main.frx":2DD0
      DownPicture     =   "Main.frx":33CA
      Enabled         =   0   'False
      Height          =   375
      Left            =   7320
      MaskColor       =   &H00FFFFFF&
      Picture         =   "Main.frx":39C4
      Style           =   1  'Graphical
      TabIndex        =   14
      ToolTipText     =   "Recent Box"
      Top             =   780
      UseMaskColor    =   -1  'True
      Width           =   315
   End
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
      Left            =   1860
      TabIndex        =   13
      Top             =   1170
      Visible         =   0   'False
      Width           =   5475
   End
   Begin VB.CommandButton cmdSet 
      Appearance      =   0  'Flat
      DisabledPicture =   "Main.frx":3FBE
      DownPicture     =   "Main.frx":4748
      DragMode        =   1  'Automatic
      Enabled         =   0   'False
      Height          =   495
      Left            =   8460
      MaskColor       =   &H00FFFFFF&
      Picture         =   "Main.frx":4ED2
      Style           =   1  'Graphical
      TabIndex        =   12
      ToolTipText     =   "Drag Icon to Set"
      Top             =   720
      UseMaskColor    =   -1  'True
      Width           =   495
   End
   Begin VB.CommandButton cmdMail 
      Appearance      =   0  'Flat
      DisabledPicture =   "Main.frx":565C
      DownPicture     =   "Main.frx":649E
      Enabled         =   0   'False
      Height          =   690
      Left            =   8655
      MaskColor       =   &H00FFFFFF&
      Picture         =   "Main.frx":72E0
      Style           =   1  'Graphical
      TabIndex        =   9
      ToolTipText     =   "Your Mail Page"
      Top             =   0
      UseMaskColor    =   -1  'True
      Width           =   780
   End
   Begin VB.CommandButton cmdSearch 
      Appearance      =   0  'Flat
      DisabledPicture =   "Main.frx":8122
      DownPicture     =   "Main.frx":8F64
      Enabled         =   0   'False
      Height          =   690
      Left            =   7875
      MaskColor       =   &H00FFFFFF&
      Picture         =   "Main.frx":9DA6
      Style           =   1  'Graphical
      TabIndex        =   6
      ToolTipText     =   "Your Search Page"
      Top             =   0
      UseMaskColor    =   -1  'True
      Width           =   780
   End
   Begin VB.CommandButton cmdHome 
      Appearance      =   0  'Flat
      DisabledPicture =   "Main.frx":ABE8
      DownPicture     =   "Main.frx":BA2A
      Enabled         =   0   'False
      Height          =   690
      Left            =   7095
      MaskColor       =   &H00FFFFFF&
      Picture         =   "Main.frx":C86C
      Style           =   1  'Graphical
      TabIndex        =   5
      ToolTipText     =   "Your Home Page"
      Top             =   0
      UseMaskColor    =   -1  'True
      Width           =   780
   End
   Begin VB.CommandButton cmdFull 
      Appearance      =   0  'Flat
      DisabledPicture =   "Main.frx":D6AE
      DownPicture     =   "Main.frx":E4F0
      Enabled         =   0   'False
      Height          =   690
      Left            =   5160
      MaskColor       =   &H00FFFFFF&
      Picture         =   "Main.frx":F332
      Style           =   1  'Graphical
      TabIndex        =   8
      ToolTipText     =   "Fullscreen Mode"
      Top             =   0
      UseMaskColor    =   -1  'True
      Width           =   1020
   End
   Begin VB.CommandButton cmdFavs 
      Appearance      =   0  'Flat
      DisabledPicture =   "Main.frx":10174
      DownPicture     =   "Main.frx":10FB6
      Enabled         =   0   'False
      Height          =   690
      Left            =   6180
      MaskColor       =   &H00FFFFFF&
      Picture         =   "Main.frx":11DF8
      Style           =   1  'Graphical
      TabIndex        =   7
      ToolTipText     =   "Favorite Sites"
      Top             =   0
      UseMaskColor    =   -1  'True
      Width           =   920
   End
   Begin VB.CommandButton cmdRefresh 
      Appearance      =   0  'Flat
      DisabledPicture =   "Main.frx":12C3A
      DownPicture     =   "Main.frx":13A7C
      Enabled         =   0   'False
      Height          =   690
      Left            =   4260
      MaskColor       =   &H00FFFFFF&
      Picture         =   "Main.frx":148BE
      Style           =   1  'Graphical
      TabIndex        =   4
      ToolTipText     =   "Refresh Current Page"
      Top             =   0
      UseMaskColor    =   -1  'True
      Width           =   900
   End
   Begin VB.CommandButton cmdStop 
      Appearance      =   0  'Flat
      DisabledPicture =   "Main.frx":15700
      DownPicture     =   "Main.frx":16542
      Enabled         =   0   'False
      Height          =   690
      Left            =   3420
      MaskColor       =   &H00FFFFFF&
      Picture         =   "Main.frx":17384
      Style           =   1  'Graphical
      TabIndex        =   3
      ToolTipText     =   "Stop Navigation"
      Top             =   0
      UseMaskColor    =   -1  'True
      Width           =   840
   End
   Begin VB.CommandButton cmdNext 
      Appearance      =   0  'Flat
      DisabledPicture =   "Main.frx":181C6
      DownPicture     =   "Main.frx":19008
      Enabled         =   0   'False
      Height          =   690
      Left            =   2580
      MaskColor       =   &H00FFFFFF&
      Picture         =   "Main.frx":19E4A
      Style           =   1  'Graphical
      TabIndex        =   2
      ToolTipText     =   "Next Page"
      Top             =   0
      UseMaskColor    =   -1  'True
      Width           =   840
   End
   Begin VB.CommandButton cmdPrev 
      Appearance      =   0  'Flat
      DisabledPicture =   "Main.frx":1AC8C
      DownPicture     =   "Main.frx":1BACE
      Enabled         =   0   'False
      Height          =   690
      Left            =   1740
      MaskColor       =   &H00FFFFFF&
      Picture         =   "Main.frx":1C910
      Style           =   1  'Graphical
      TabIndex        =   1
      ToolTipText     =   "Previous Page"
      Top             =   0
      UseMaskColor    =   -1  'True
      Width           =   840
   End
   Begin VB.CommandButton cmdGo 
      Appearance      =   0  'Flat
      Default         =   -1  'True
      DisabledPicture =   "Main.frx":1D752
      DownPicture     =   "Main.frx":1E080
      Enabled         =   0   'False
      Height          =   495
      Left            =   7680
      MaskColor       =   &H00FFFFFF&
      Picture         =   "Main.frx":1E9AE
      Style           =   1  'Graphical
      TabIndex        =   11
      ToolTipText     =   "Navigate"
      Top             =   720
      UseMaskColor    =   -1  'True
      Width           =   615
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
      Left            =   1860
      TabIndex        =   10
      Top             =   780
      Width           =   5475
   End
   Begin SHDocVwCtl.WebBrowser IE 
      Height          =   3780
      Left            =   660
      TabIndex        =   0
      Top             =   1560
      Visible         =   0   'False
      Width           =   7980
      ExtentX         =   14076
      ExtentY         =   6667
      ViewMode        =   1
      Offline         =   0
      Silent          =   0
      RegisterAsBrowser=   0
      RegisterAsDropTarget=   1
      AutoArrange     =   -1  'True
      NoClientEdge    =   0   'False
      AlignLeft       =   0   'False
      ViewID          =   "{0057D0E0-3573-11CF-AE69-08002B2E1262}"
      Location        =   "res://C:\WIN98\SYSTEM\SHDOCLC.DLL/dnserror.htm#http:///"
   End
   Begin VB.Timer tmrClock 
      Interval        =   420
      Left            =   9000
      Top             =   1320
   End
   Begin VB.Image imgDrop 
      Height          =   375
      Left            =   7320
      Top             =   780
      Width           =   315
   End
   Begin VB.Image imgSet 
      Height          =   495
      Left            =   8460
      Top             =   720
      Width           =   435
   End
   Begin VB.Shape shpBusy 
      BorderWidth     =   2
      FillColor       =   &H000000FF&
      FillStyle       =   0  'Solid
      Height          =   435
      Left            =   9060
      Shape           =   2  'Oval
      Top             =   780
      Width           =   375
   End
   Begin VB.Image imgGo 
      Appearance      =   0  'Flat
      Height          =   495
      Left            =   7680
      Top             =   720
      Width           =   615
   End
   Begin VB.Image imgMail 
      Appearance      =   0  'Flat
      Height          =   690
      Left            =   8640
      Top             =   0
      Width           =   780
   End
   Begin VB.Image imgSearch 
      Appearance      =   0  'Flat
      Height          =   690
      Left            =   7860
      Top             =   0
      Width           =   780
   End
   Begin VB.Image imgHome 
      Appearance      =   0  'Flat
      Height          =   690
      Left            =   7080
      Top             =   0
      Width           =   780
   End
   Begin VB.Image imgFull 
      Appearance      =   0  'Flat
      Height          =   690
      Left            =   5160
      Top             =   0
      Width           =   1020
   End
   Begin VB.Image imgFavs 
      Appearance      =   0  'Flat
      Height          =   645
      Left            =   6165
      Top             =   -15
      Width           =   915
   End
   Begin VB.Image imgRefresh 
      Appearance      =   0  'Flat
      Height          =   690
      Left            =   4260
      Top             =   0
      Width           =   900
   End
   Begin VB.Image imgStop 
      Appearance      =   0  'Flat
      Height          =   690
      Left            =   3420
      Top             =   0
      Width           =   840
   End
   Begin VB.Image imgNext 
      Appearance      =   0  'Flat
      Height          =   690
      Left            =   2580
      Top             =   0
      Width           =   840
   End
   Begin VB.Image imgPrev 
      Appearance      =   0  'Flat
      Height          =   690
      Left            =   1740
      Top             =   0
      Width           =   840
   End
   Begin VB.Image imgLogo 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      Height          =   1065
      Left            =   60
      Picture         =   "Main.frx":1F2DC
      Stretch         =   -1  'True
      ToolTipText     =   "Options Menu"
      Top             =   60
      Width           =   1605
   End
End
Attribute VB_Name = "Main"
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

Private Sub cmdFavs_Click()
    txtAddress.SetFocus
    DropDown = False
    lstRecent.Visible = DropDown
    Favs.Show vbModal
End Sub

Private Sub cmdFavs_DragDrop(Source As Control, X As Single, Y As Single)
       
       
       
       
       
       
       
       
    
    
    Ask.Caption = "Add to Favorites"
    Ask.lblMsg.Caption = "Would you like to add """ & Address & """ to your favorites list?"
    Ask.SetAs = 4
    Ask.Show vbModal
End Sub

Private Sub cmdFull_Click()
    DropDown = False
    lstRecent.Visible = DropDown
    FullScrn = True
    Full.Show
    Me.Hide
End Sub

Private Sub cmdGo_Click()
    If Not lstRecent.Visible Then
        txtAddress.SetFocus
        DropDown = False
        lstRecent.Visible = DropDown
        Address = txtAddress.Text
        GoType = 3
        IE.Navigate Address
    End If
End Sub

Private Sub cmdHome_Click()
    txtAddress.SetFocus
    DropDown = False
    lstRecent.Visible = DropDown
    Address = HomeAdd
    GoType = 3
    IE.Navigate Address
End Sub

Private Sub cmdHome_DragDrop(Source As Control, X As Single, Y As Single)
    Ask.Caption = "Set Homepage"
    Ask.lblMsg.Caption = "Would you like to set """ & Address & """ as your personal homepage?"
    Ask.SetAs = 1
    Ask.Show vbModal
End Sub

Private Sub cmdMail_Click()
    txtAddress.SetFocus
    DropDown = False
    lstRecent.Visible = DropDown
    Address = MailAdd
    GoType = 3
    IE.Navigate Address
End Sub

Private Sub cmdMail_DragDrop(Source As Control, X As Single, Y As Single)
    Ask.Caption = "Set Mail Site"
    Ask.lblMsg.Caption = "Would you like to set """ & Address & """ as your personal mail site?"
    Ask.SetAs = 3
    Ask.Show vbModal
End Sub

Private Sub cmdNext_Click()
    txtAddress.SetFocus
    DropDown = False
    lstRecent.Visible = DropDown
    If NumRecent < (TotRecent - 1) Then
        Address = lstRecent.List(NumRecent + 1)
        GoType = 2
        IE.Navigate Address
    End If
End Sub

Private Sub cmdPrev_Click()
    txtAddress.SetFocus
    DropDown = False
    lstRecent.Visible = DropDown
    If NumRecent > 0 Then
        Address = lstRecent.List(NumRecent - 1)
        GoType = 1
        IE.Navigate Address
    End If
End Sub

Private Sub cmdRefresh_Click()
    txtAddress.SetFocus
    DropDown = False
    lstRecent.Visible = DropDown
    IE.Refresh
End Sub

Private Sub cmdSearch_Click()
    txtAddress.SetFocus
    DropDown = False
    lstRecent.Visible = DropDown
    Address = SrchAdd
    GoType = 3
    IE.Navigate Address
End Sub

Private Sub cmdSearch_DragDrop(Source As Control, X As Single, Y As Single)
    Ask.Caption = "Set Search Site"
    Ask.lblMsg.Caption = "Would you like to set """ & Address & """ as your personal search site?"
    Ask.SetAs = 2
    Ask.Show vbModal
End Sub

Private Sub cmdStop_Click()
    txtAddress.SetFocus
    DropDown = False
    lstRecent.Visible = DropDown
    IE.Stop
    'Address = IE.LocationURL
    'txtAddress.Text = Address
End Sub

Private Sub Form_Activate()
    Me.Top = 0
    Me.Left = 0
    Me.Width = Screen.Width
    Me.Height = Screen.Height - 420
    If (IE.LocationURL <> Address) Then InitIE
    DropDown = False
    lstRecent.Visible = DropDown
End Sub

Private Sub Form_Click()
    DropDown = False
    lstRecent.Visible = DropDown
End Sub

Private Sub Form_DragOver(Source As Control, X As Single, Y As Single, State As Integer)
    cmdFavs.Enabled = False
    cmdHome.Enabled = False
    cmdSearch.Enabled = False
    cmdMail.Enabled = False
End Sub

Private Sub Form_Load()
    InitProg
    'Logo.Show vbModal
    Me.Top = 0
    Me.Left = 0
    Me.Width = Screen.Width
    Me.Height = Screen.Height - 420
    InitIE
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    cmdPrev.Enabled = False
    cmdNext.Enabled = False
    cmdStop.Enabled = False
    cmdRefresh.Enabled = False
    cmdFavs.Enabled = False
    cmdFull.Enabled = False
    cmdHome.Enabled = False
    cmdSearch.Enabled = False
    cmdMail.Enabled = False
    cmdSet.Enabled = False
    cmdDrop.Enabled = False
    cmdGo.Enabled = False
End Sub

Private Sub Form_Resize()
    shpBusy.Left = Me.Width - 540
    cmdSet.Left = Me.Width - 1200
    imgSet.Left = Me.Width - 1200
    cmdGo.Left = Me.Width - 1920
    imgGo.Left = Me.Width - 1920
    cmdDrop.Left = Me.Width - 2280
    imgDrop.Left = Me.Width - 2280
    If Me.Width > 4125 Then
        txtAddress.Width = Me.Width - 4125
        lstRecent.Width = Me.Width - 4125
    End If
    ResizeIE
End Sub

Private Sub Form_Terminate()
    EndProg
End Sub

Private Sub Form_Unload(Cancel As Integer)
    EndProg
End Sub

Private Sub IE_GotFocus()
    cmdPrev.Enabled = False
    cmdNext.Enabled = False
    cmdStop.Enabled = False
    cmdRefresh.Enabled = False
    cmdFavs.Enabled = False
    cmdFull.Enabled = False
    cmdHome.Enabled = False
    cmdSearch.Enabled = False
    cmdMail.Enabled = False
    cmdSet.Enabled = False
    cmdDrop.Enabled = False
    cmdGo.Enabled = False
End Sub

Private Sub IE_NavigateComplete2(ByVal pDisp As Object, URL As Variant)
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
            lstRecent.AddItem Address, NumRecent
            TotRecent = TotRecent + 1
        Case 1
            NumRecent = NumRecent - 1
            lstRecent.ListIndex = NumRecent
            If NumRecent = 0 Then cmdPrev.Enabled = False
        Case 2
            NumRecent = NumRecent + 1
            lstRecent.ListIndex = NumRecent
            If NumRecent >= (TotRecent - 1) Then cmdNext.Enabled = False
        Case 3
            lstRecent.AddItem (Address)
            TotRecent = TotRecent + 1
            NumRecent = TotRecent - 1
        Case 4
            NumRecent = lstRecent.ListIndex
    End Select
    Count = 0
    Do While (Count <= (TotRecent - 2))
        If lstRecent.List(Count) = lstRecent.List(Count + 1) Then
            lstRecent.RemoveItem Count
            TotRecent = TotRecent - 1
            If NumRecent > Count Then NumRecent = NumRecent - 1
        End If
        Count = Count + 1
    Loop
    While TotRecent > MaxRecent
        lstRecent.RemoveItem 0
        TotRecent = TotRecent - 1
        If NumRecent > 0 Then NumRecent = NumRecent - 1
    Wend
    lstRecent.ListIndex = NumRecent
    GoType = 0
End Sub

Private Sub IE_TitleChange(ByVal Text As String)
    Me.Caption = IE.LocationName + " - Net Creeper"
End Sub

Private Sub imgDrop_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    cmdPrev.Enabled = False
    cmdNext.Enabled = False
    cmdStop.Enabled = False
    cmdRefresh.Enabled = False
    cmdFavs.Enabled = False
    cmdFull.Enabled = False
    cmdHome.Enabled = False
    cmdSearch.Enabled = False
    cmdMail.Enabled = False
    cmdSet.Enabled = False
    cmdDrop.Enabled = True
    cmdGo.Enabled = False
End Sub

Private Sub imgFavs_DragOver(Source As Control, X As Single, Y As Single, State As Integer)
    cmdFavs.Enabled = True
    cmdHome.Enabled = False
    cmdSearch.Enabled = False
    cmdMail.Enabled = False
End Sub

Private Sub imgFavs_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    cmdPrev.Enabled = False
    cmdNext.Enabled = False
    cmdStop.Enabled = False
    cmdRefresh.Enabled = False
    cmdFavs.Enabled = True
    cmdFull.Enabled = False
    cmdHome.Enabled = False
    cmdSearch.Enabled = False
    cmdMail.Enabled = False
    cmdSet.Enabled = False
    cmdDrop.Enabled = False
    cmdGo.Enabled = False
End Sub

Private Sub imgFull_DragOver(Source As Control, X As Single, Y As Single, State As Integer)
    cmdFavs.Enabled = False
    cmdHome.Enabled = False
    cmdSearch.Enabled = False
    cmdMail.Enabled = False
End Sub

Private Sub imgFull_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    cmdPrev.Enabled = False
    cmdNext.Enabled = False
    cmdStop.Enabled = False
    cmdRefresh.Enabled = False
    cmdFavs.Enabled = False
    cmdFull.Enabled = True
    cmdHome.Enabled = False
    cmdSearch.Enabled = False
    cmdMail.Enabled = False
    cmdSet.Enabled = False
    cmdDrop.Enabled = False
    cmdGo.Enabled = False
End Sub

Private Sub imgGo_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If Not lstRecent.Visible Then
        cmdPrev.Enabled = False
        cmdNext.Enabled = False
        cmdStop.Enabled = False
        cmdRefresh.Enabled = False
        cmdFavs.Enabled = False
        cmdFull.Enabled = False
        cmdHome.Enabled = False
        cmdSearch.Enabled = False
        cmdMail.Enabled = False
        cmdSet.Enabled = False
        cmdDrop.Enabled = False
        cmdGo.Enabled = True
    Else
        cmdPrev.Enabled = False
        cmdNext.Enabled = False
        cmdStop.Enabled = False
        cmdRefresh.Enabled = False
        cmdFavs.Enabled = False
        cmdFull.Enabled = False
        cmdHome.Enabled = False
        cmdSearch.Enabled = False
        cmdMail.Enabled = False
        cmdSet.Enabled = False
        cmdDrop.Enabled = False
        cmdGo.Enabled = False
    End If
End Sub

Private Sub imgHome_DragOver(Source As Control, X As Single, Y As Single, State As Integer)
    cmdFavs.Enabled = False
    cmdHome.Enabled = True
    cmdSearch.Enabled = False
    cmdMail.Enabled = False
End Sub

Private Sub imgHome_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    cmdPrev.Enabled = False
    cmdNext.Enabled = False
    cmdStop.Enabled = False
    cmdRefresh.Enabled = False
    cmdFavs.Enabled = False
    cmdFull.Enabled = False
    cmdHome.Enabled = True
    cmdSearch.Enabled = False
    cmdMail.Enabled = False
    cmdSet.Enabled = False
    cmdDrop.Enabled = False
    cmdGo.Enabled = False
    cmdHome.ToolTipText = HomeAdd
End Sub

Private Sub imgLogo_Click()
    DropDown = False
    lstRecent.Visible = DropDown
    Menu.Show vbModal
End Sub

Private Sub imgLogo_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    cmdPrev.Enabled = False
    cmdNext.Enabled = False
    cmdStop.Enabled = False
    cmdRefresh.Enabled = False
    cmdFavs.Enabled = False
    cmdFull.Enabled = False
    cmdHome.Enabled = False
    cmdSearch.Enabled = False
    cmdMail.Enabled = False
    cmdSet.Enabled = False
    cmdDrop.Enabled = False
    cmdGo.Enabled = False
End Sub

Private Sub imgMail_DragOver(Source As Control, X As Single, Y As Single, State As Integer)
    cmdFavs.Enabled = False
    cmdHome.Enabled = False
    cmdSearch.Enabled = False
    cmdMail.Enabled = True
End Sub

Private Sub imgMail_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    cmdPrev.Enabled = False
    cmdNext.Enabled = False
    cmdStop.Enabled = False
    cmdRefresh.Enabled = False
    cmdFavs.Enabled = False
    cmdFull.Enabled = False
    cmdHome.Enabled = False
    cmdSearch.Enabled = False
    cmdMail.Enabled = True
    cmdSet.Enabled = False
    cmdDrop.Enabled = False
    cmdGo.Enabled = False
    cmdMail.ToolTipText = MailAdd
End Sub

Private Sub imgNext_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If NumRecent < (TotRecent - 1) Then
        cmdPrev.Enabled = False
        cmdNext.Enabled = True
        cmdStop.Enabled = False
        cmdRefresh.Enabled = False
        cmdFavs.Enabled = False
        cmdFull.Enabled = False
        cmdHome.Enabled = False
        cmdSearch.Enabled = False
        cmdMail.Enabled = False
        cmdSet.Enabled = False
        cmdDrop.Enabled = False
        cmdGo.Enabled = False
    Else
        cmdPrev.Enabled = False
        cmdNext.Enabled = False
        cmdStop.Enabled = False
        cmdRefresh.Enabled = False
        cmdFavs.Enabled = False
        cmdFull.Enabled = False
        cmdHome.Enabled = False
        cmdSearch.Enabled = False
        cmdMail.Enabled = False
        cmdSet.Enabled = False
        cmdDrop.Enabled = False
        cmdGo.Enabled = False
    End If
End Sub

Private Sub imgPrev_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If NumRecent > 0 Then
        cmdPrev.Enabled = True
        cmdNext.Enabled = False
        cmdStop.Enabled = False
        cmdRefresh.Enabled = False
        cmdFavs.Enabled = False
        cmdFull.Enabled = False
        cmdHome.Enabled = False
        cmdSearch.Enabled = False
        cmdMail.Enabled = False
        cmdSet.Enabled = False
        cmdDrop.Enabled = False
        cmdGo.Enabled = False
    Else
        cmdPrev.Enabled = False
        cmdNext.Enabled = False
        cmdStop.Enabled = False
        cmdRefresh.Enabled = False
        cmdFavs.Enabled = False
        cmdFull.Enabled = False
        cmdHome.Enabled = False
        cmdSearch.Enabled = False
        cmdMail.Enabled = False
        cmdSet.Enabled = False
        cmdDrop.Enabled = False
        cmdGo.Enabled = False
    End If
End Sub

Private Sub imgRefresh_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    cmdPrev.Enabled = False
    cmdNext.Enabled = False
    cmdStop.Enabled = False
    cmdRefresh.Enabled = True
    cmdFavs.Enabled = False
    cmdFull.Enabled = False
    cmdHome.Enabled = False
    cmdSearch.Enabled = False
    cmdMail.Enabled = False
    cmdSet.Enabled = False
    cmdDrop.Enabled = False
    cmdGo.Enabled = False
End Sub

Private Sub imgSearch_DragOver(Source As Control, X As Single, Y As Single, State As Integer)
    cmdFavs.Enabled = False
    cmdHome.Enabled = False
    cmdSearch.Enabled = True
    cmdDrop.Enabled = False
End Sub

Private Sub imgSearch_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    cmdPrev.Enabled = False
    cmdNext.Enabled = False
    cmdStop.Enabled = False
    cmdRefresh.Enabled = False
    cmdFavs.Enabled = False
    cmdFull.Enabled = False
    cmdHome.Enabled = False
    cmdSearch.Enabled = True
    cmdMail.Enabled = False
    cmdSet.Enabled = False
    cmdDrop.Enabled = False
    cmdGo.Enabled = False
    cmdSearch.ToolTipText = SrchAdd
End Sub

Private Sub imgSet_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    cmdPrev.Enabled = False
    cmdNext.Enabled = False
    cmdStop.Enabled = False
    cmdRefresh.Enabled = False
    cmdFavs.Enabled = False
    cmdFull.Enabled = False
    cmdHome.Enabled = False
    cmdSearch.Enabled = False
    cmdMail.Enabled = False
    cmdSet.Enabled = True
    cmdDrop.Enabled = False
    cmdGo.Enabled = False
End Sub

Private Sub imgStop_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    cmdPrev.Enabled = False
    cmdNext.Enabled = False
    cmdStop.Enabled = True
    cmdRefresh.Enabled = False
    cmdFavs.Enabled = False
    cmdFull.Enabled = False
    cmdHome.Enabled = False
    cmdSearch.Enabled = False
    cmdMail.Enabled = False
    cmdSet.Enabled = False
    cmdDrop.Enabled = False
    cmdGo.Enabled = False
End Sub

Private Sub munExit_Click()
    EndProg
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
    IE.Navigate Address
End Sub

Private Sub lstRecent_GotFocus()
    lstRecent.ListIndex = NumRecent
End Sub

Private Sub lstRecent_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Address = lstRecent.List(lstRecent.ListIndex)
        txtAddress = Address
        DropDown = False
        lstRecent.Visible = DropDown
        cmdGo_Click
    End If
End Sub

Private Sub tmrClock_Timer()
    If IE.Busy = True Then
        shpBusy.FillColor = &HFF&
    Else
        shpBusy.FillColor = &HC00000
    End If
End Sub

Private Sub txtAddress_DragOver(Source As Control, X As Single, Y As Single, State As Integer)
    cmdHome.Enabled = False
    cmdSearch.Enabled = False
    cmdMail.Enabled = False
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

Private Sub txtAddress_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    cmdPrev.Enabled = False
    cmdNext.Enabled = False
    cmdStop.Enabled = False
    cmdRefresh.Enabled = False
    cmdFavs.Enabled = False
    cmdFull.Enabled = False
    cmdHome.Enabled = False
    cmdSearch.Enabled = False
    cmdMail.Enabled = False
    cmdSet.Enabled = False
    cmdDrop.Enabled = False
    cmdGo.Enabled = False
End Sub

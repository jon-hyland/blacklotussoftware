VERSION 5.00
Begin VB.Form Menu 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Settings and Options Menu"
   ClientHeight    =   5985
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5535
   Icon            =   "Menu.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5985
   ScaleWidth      =   5535
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cmdHelp 
      Caption         =   "Help"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   2100
      TabIndex        =   19
      Top             =   5400
      Width           =   1335
   End
   Begin VB.CommandButton cmdAbout 
      Caption         =   "About"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3840
      TabIndex        =   18
      Top             =   5400
      Width           =   1335
   End
   Begin VB.CheckBox chkKeepRec 
      Caption         =   " Remember recent sites on exit?"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   360
      TabIndex        =   15
      Top             =   4020
      Width           =   2655
   End
   Begin VB.Frame fraRecent 
      Caption         =   "Recent"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1395
      Left            =   120
      TabIndex        =   14
      Top             =   3780
      Width           =   5295
      Begin VB.TextBox txtMaxRec 
         Height          =   285
         Left            =   240
         TabIndex        =   16
         Top             =   780
         Width           =   555
      End
      Begin VB.Label Label5 
         Caption         =   "Maximum sites in recent drop box."
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   1020
         TabIndex        =   17
         Top             =   840
         Width           =   2535
      End
   End
   Begin VB.OptionButton optLast 
      Caption         =   "Last Site Visited"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   360
      TabIndex        =   13
      Top             =   3360
      Width           =   1695
   End
   Begin VB.OptionButton optMail 
      Caption         =   "EMail Site"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   360
      TabIndex        =   12
      Top             =   3000
      Width           =   1215
   End
   Begin VB.OptionButton optSrch 
      Caption         =   "Web Search"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   360
      TabIndex        =   11
      Top             =   2640
      Width           =   1215
   End
   Begin VB.OptionButton optHome 
      Caption         =   "Homepage"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   360
      TabIndex        =   10
      Top             =   2280
      Width           =   1215
   End
   Begin VB.Frame fraStart 
      Caption         =   "Start"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1935
      Left            =   120
      TabIndex        =   8
      Top             =   1800
      Width           =   5295
      Begin VB.Label Label4 
         Caption         =   "Default to what link on startup?"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   180
         TabIndex        =   9
         Top             =   240
         Width           =   2295
      End
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   360
      TabIndex        =   7
      Top             =   5400
      Width           =   1335
   End
   Begin VB.Frame fraLinks 
      Caption         =   "Links"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1695
      Left            =   120
      TabIndex        =   0
      Top             =   60
      Width           =   5295
      Begin VB.TextBox txtMail 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   180
         TabIndex        =   5
         Top             =   1140
         Width           =   3435
      End
      Begin VB.TextBox txtSearch 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   180
         TabIndex        =   3
         Top             =   720
         Width           =   3435
      End
      Begin VB.TextBox txtHome 
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   180
         TabIndex        =   1
         Top             =   300
         Width           =   3435
      End
      Begin VB.Label Label3 
         Caption         =   "Personal EMail URL"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   3720
         TabIndex        =   6
         Top             =   1200
         Width           =   1455
      End
      Begin VB.Label Label2 
         Caption         =   "Web Search URL"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   3720
         TabIndex        =   4
         Top             =   780
         Width           =   1275
      End
      Begin VB.Label Label1 
         Caption         =   "Homepage URL"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   3720
         TabIndex        =   2
         Top             =   360
         Width           =   1215
      End
   End
End
Attribute VB_Name = "Menu"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub chkKeepRec_Click()
    If chkKeepRec.Value = 0 Then
        KeepRecent = False
    Else
        KeepRecent = True
    End If
End Sub

Private Sub cmdAbout_Click()
    Me.Hide
    About.Show vbModal
    Unload Me
End Sub

Private Sub cmdHelp_Click()
    Me.Hide
    Help.Show
    Unload Me
End Sub

Private Sub cmdOK_Click()
    HomeAdd = txtHome.Text
    SrchAdd = txtSearch.Text
    MailAdd = txtMail.Text
    SaveData
    Unload Me
End Sub

Private Sub Form_Activate()
    txtHome.Text = HomeAdd
    txtSearch.Text = SrchAdd
    txtMail.Text = MailAdd
    Select Case DefTo
        Case 1
            optHome.Value = True
        Case 2
            optSrch.Value = True
        Case 3
            optMail.Value = True
        Case 4
            optLast.Value = True
    End Select
    If KeepRecent Then chkKeepRec.Value = 1 Else chkKeepRec.Value = 0
    txtMaxRec.Text = Str(MaxRecent)
End Sub

Private Sub optHome_Click()
    DefTo = 1
End Sub

Private Sub optLast_Click()
    DefTo = 4
End Sub

Private Sub optMail_Click()
    DefTo = 3
End Sub

Private Sub optSrch_Click()
    DefTo = 2
End Sub


Private Sub txtHome_GotFocus()
    If txtHome.SelStart = 0 Then
        txtHome.SelStart = Len(txtHome.Text)
    End If
End Sub


Private Sub txtMail_GotFocus()
    If txtMail.SelStart = 0 Then
        txtMail.SelStart = Len(txtMail.Text)
    End If
End Sub

Private Sub txtMaxRec_Change()
    If IsNumeric(txtMaxRec.Text) Then
        If Val(txtMaxRec.Text) > 0 Then
            MaxRecent = Val(txtMaxRec.Text)
        Else
            MaxRecent = 1
            txtMaxRec.Text = "1"
        End If
    End If
End Sub


Private Sub txtSearch_GotFocus()
    If txtSearch.SelStart = 0 Then
        txtSearch.SelStart = Len(txtSearch.Text)
    End If
End Sub

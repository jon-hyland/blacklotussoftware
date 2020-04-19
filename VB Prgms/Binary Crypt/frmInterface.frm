VERSION 5.00
Begin VB.Form frmInterface 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Black Lotus Binary Crypt  v1.21"
   ClientHeight    =   2985
   ClientLeft      =   45
   ClientTop       =   615
   ClientWidth     =   5445
   Icon            =   "frmInterface.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2985
   ScaleWidth      =   5445
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox chkPassword 
      Caption         =   "Encrypt using optional password protection"
      Height          =   585
      Left            =   3480
      TabIndex        =   9
      TabStop         =   0   'False
      Top             =   2340
      Width           =   1905
   End
   Begin VB.CommandButton cmdBegin 
      Caption         =   "Begin"
      Enabled         =   0   'False
      Height          =   375
      Left            =   2250
      TabIndex        =   8
      Top             =   2460
      Width           =   975
   End
   Begin VB.CommandButton cmdBrsOut 
      Caption         =   "Browse"
      Height          =   315
      Left            =   4590
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   1560
      Width           =   675
   End
   Begin VB.TextBox txtOutFile 
      BackColor       =   &H00E0E0E0&
      Height          =   315
      Left            =   240
      TabIndex        =   5
      Top             =   1560
      Width           =   4215
   End
   Begin VB.CommandButton cmdDecrypt 
      Caption         =   "Decrypt Menu"
      Height          =   315
      Left            =   1590
      TabIndex        =   4
      TabStop         =   0   'False
      Top             =   180
      Width           =   1215
   End
   Begin VB.CommandButton cmdEncrypt 
      Caption         =   "Encrypt Menu"
      Height          =   315
      Left            =   240
      TabIndex        =   3
      TabStop         =   0   'False
      Top             =   180
      Width           =   1215
   End
   Begin VB.CommandButton cmdBrsIn 
      Caption         =   "Browse"
      Height          =   315
      Left            =   4590
      TabIndex        =   2
      TabStop         =   0   'False
      Top             =   720
      Width           =   675
   End
   Begin VB.TextBox txtInFile 
      BackColor       =   &H00E0E0E0&
      Height          =   315
      Left            =   240
      TabIndex        =   0
      Top             =   720
      Width           =   4215
   End
   Begin VB.Label lblInFile 
      Alignment       =   2  'Center
      Caption         =   "Input File Caption"
      Height          =   315
      Left            =   420
      TabIndex        =   6
      Top             =   1140
      Width           =   3855
   End
   Begin VB.Label lblOutFile 
      Alignment       =   2  'Center
      Caption         =   "Output File Caption"
      Height          =   315
      Left            =   420
      TabIndex        =   1
      Top             =   1980
      Width           =   3855
   End
   Begin VB.Menu munProgram 
      Caption         =   "&Program"
      Begin VB.Menu mnuExit 
         Caption         =   "E&xit"
      End
   End
   Begin VB.Menu mnuActions 
      Caption         =   "&Menu"
      Begin VB.Menu mnuCrypt 
         Caption         =   "&Encrypt"
      End
      Begin VB.Menu mnuDecrypt 
         Caption         =   "&Decrypt"
      End
   End
   Begin VB.Menu mnuInfo 
      Caption         =   "&Info"
      Begin VB.Menu mnuHelp 
         Caption         =   "&Help File"
      End
      Begin VB.Menu mnuAbout 
         Caption         =   "&About"
      End
   End
End
Attribute VB_Name = "frmInterface"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public iMenu As Integer
Public sInFile1 As String, sInFile2 As String
Public sOutFile1 As String, sOutFile2 As String

Private Sub chkPassword_Click()
    If chkPassword.Value = 1 Then
        BLBC.bPassword = True
    Else
        BLBC.bPassword = False
    End If
End Sub

Private Sub cmdBegin_Click()
    If iMenu = 1 Then
        BLBC.Encrypt_Now
    End If
    If iMenu = 2 Then
        BLBC.Decrypt_Now
    End If
End Sub

Private Sub cmdBrsIn_Click()
    BLBC.Get_InFile
End Sub

Private Sub cmdBrsOut_Click()
    BLBC.Get_OutFile
End Sub

Private Sub cmdDecrypt_Click()
    Show_Decrypt_Menu
End Sub

Private Sub cmdEncrypt_Click()
    Show_Encrypt_Menu
End Sub

Private Sub Form_Load()
    Set fSplash = New frmSplash
    fSplash.Show vbModal
    Show_Encrypt_Menu
End Sub

Private Sub Form_Unload(Cancel As Integer)
    BLBC.End_Prog
End Sub

Private Sub mnuAbout_Click()
    BLBC.Show_Info
End Sub

Private Sub mnuCrypt_Click()
    Show_Encrypt_Menu
End Sub

Private Sub mnuDecrypt_Click()
    Show_Decrypt_Menu
End Sub

Private Sub mnuExit_Click()
    BLBC.End_Prog
End Sub

Private Sub Show_Encrypt_Menu()
    sInFile2 = txtInFile.Text
    sOutFile2 = txtOutFile.Text
    iMenu = 1
    txtInFile.Text = sInFile1
    txtOutFile.Text = sOutFile1
    cmdEncrypt.Enabled = False
    cmdDecrypt.Enabled = True
    mnuCrypt.Enabled = False
    mnuDecrypt.Enabled = True
    lblInFile.Caption = "Filepath of binary file to encrypt."
    lblOutFile.Caption = "Filepath of coded output file."
    cmdBegin.Caption = "Encrypt"
    chkPassword.Visible = True
    If Me.Visible = True Then txtInFile.SetFocus
End Sub

Private Sub Show_Decrypt_Menu()
    sInFile1 = txtInFile.Text
    sOutFile1 = txtOutFile.Text
    iMenu = 2
    txtInFile.Text = sInFile2
    txtOutFile.Text = sOutFile2
    cmdDecrypt.Enabled = False
    cmdEncrypt.Enabled = True
    mnuDecrypt.Enabled = False
    mnuCrypt.Enabled = True
    lblInFile.Caption = "Filepath of coded file to decrypt."
    lblOutFile.Caption = "Filepath of decoded output file."
    cmdBegin.Caption = "Decrypt"
    chkPassword.Visible = False
    If Me.Visible = True Then txtInFile.SetFocus
End Sub

Private Sub mnuHelp_Click()
    BLBC.Show_Help
End Sub

Private Sub txtInFile_Change()
    If (txtInFile.Text <> "") And (txtOutFile.Text <> "") Then
        cmdBegin.Enabled = True
    Else
        cmdBegin.Enabled = False
    End If
End Sub

Private Sub txtInFile_LostFocus()
    If iMenu = 2 Then
        If (UCase(Right(txtInFile.Text, 4)) <> ".BLC") And (txtInFile.Text <> "") Then
            txtInFile.Text = txtInFile.Text & ".blc"
        End If
    End If
End Sub

Private Sub txtOutFile_Change()
    If (txtInFile.Text <> "") And (txtOutFile.Text <> "") Then
        cmdBegin.Enabled = True
    Else
        cmdBegin.Enabled = False
    End If
End Sub

Private Sub txtOutFile_LostFocus()
    If iMenu = 1 Then
        If (UCase(Right(txtOutFile.Text, 4)) <> ".BLC") And (txtOutFile.Text <> "") Then
            txtOutFile.Text = txtOutFile.Text & ".blc"
        End If
    End If
End Sub

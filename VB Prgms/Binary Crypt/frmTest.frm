VERSION 5.00
Begin VB.Form frmTest 
   Caption         =   "BLBinaryCrypt Test Interface"
   ClientHeight    =   2805
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4950
   LinkTopic       =   "Form1"
   ScaleHeight     =   2805
   ScaleWidth      =   4950
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdDecrypt 
      Caption         =   "Decrypt"
      Height          =   375
      Left            =   2940
      TabIndex        =   5
      Top             =   2280
      Width           =   1215
   End
   Begin VB.CommandButton cmdEncrypt 
      Caption         =   "Encrypt"
      Height          =   375
      Left            =   780
      TabIndex        =   4
      Top             =   2280
      Width           =   1245
   End
   Begin VB.TextBox txtOutFile 
      BackColor       =   &H00E0E0E0&
      Height          =   315
      Left            =   180
      TabIndex        =   2
      Top             =   750
      Width           =   3195
   End
   Begin VB.TextBox txtInFile 
      BackColor       =   &H00E0E0E0&
      Height          =   315
      Left            =   180
      TabIndex        =   0
      Top             =   180
      Width           =   3195
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      Caption         =   $"frmTest.frx":0000
      Height          =   675
      Left            =   480
      TabIndex        =   6
      Top             =   1380
      Width           =   4035
   End
   Begin VB.Label Label2 
      Caption         =   "Output path and filename."
      Height          =   435
      Left            =   3480
      TabIndex        =   3
      Top             =   720
      Width           =   1245
   End
   Begin VB.Label Label1 
      Caption         =   "Input path and filename."
      Height          =   495
      Left            =   3510
      TabIndex        =   1
      Top             =   150
      Width           =   1275
   End
End
Attribute VB_Name = "frmTest"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim cBEnc As clsBLBinEnc
Dim sInFile As String
Dim sOutFile As String

Private Sub cmdEncrypt_Click()
    cBEnc.Binary_Crypt sInFile, sOutFile
    MsgBox "here"
End Sub

Private Sub Form_Load()
    Set cBEnc = New clsBLBinEnc
    cmdEncrypt.Enabled = False
    cmdDecrypt.Enabled = False
End Sub

Private Sub txtInFile_Change()
    If txtInFile.Text <> "" And txtOutFile.Text <> "" Then
        cmdEncrypt.Enabled = True
        cmdDecrypt.Enabled = True
    Else
        cmdEncrypt.Enabled = False
        cmdDecrypt.Enabled = False
    End If
    sInFile = txtInFile.Text
End Sub

Private Sub txtOutFile_Change()
    If txtInFile.Text <> "" And txtOutFile.Text <> "" Then
        cmdEncrypt.Enabled = True
        cmdDecrypt.Enabled = True
    Else
        cmdEncrypt.Enabled = False
        cmdDecrypt.Enabled = False
    End If
    sOutFile = txtOutFile.Text
End Sub

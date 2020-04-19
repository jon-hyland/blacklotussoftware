VERSION 5.00
Begin VB.Form frmMain 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Picture DB"
   ClientHeight    =   3015
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7260
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3015
   ScaleWidth      =   7260
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdAdd 
      Caption         =   "Add"
      Height          =   435
      Left            =   5640
      TabIndex        =   3
      Top             =   600
      Width           =   1455
   End
   Begin VB.DirListBox lstFolder 
      Height          =   1440
      Left            =   120
      TabIndex        =   2
      Top             =   480
      Width           =   2055
   End
   Begin VB.DriveListBox lstDrive 
      Height          =   315
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   2055
   End
   Begin VB.FileListBox lstFile 
      Height          =   1845
      Left            =   2220
      TabIndex        =   0
      Top             =   120
      Width           =   3255
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Form_Unload(Cancel As Integer)
    End_Prog
End Sub

Private Sub lstDrive_Change()
    lstFolder.Path = lstDrive.Drive
End Sub

Private Sub lstFolder_Change()
    lstFile.Path = lstFolder.Path
End Sub

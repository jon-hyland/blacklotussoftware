VERSION 5.00
Begin VB.Form frmMain 
   Caption         =   "Account"
   ClientHeight    =   3885
   ClientLeft      =   60
   ClientTop       =   630
   ClientWidth     =   6090
   LinkTopic       =   "Form1"
   ScaleHeight     =   3885
   ScaleWidth      =   6090
   StartUpPosition =   3  'Windows Default
   Begin VB.Menu mnuUser 
      Caption         =   "&User"
      Begin VB.Menu mnuNewUser 
         Caption         =   "New User"
      End
   End
   Begin VB.Menu mnuAccount 
      Caption         =   "&Account"
      Begin VB.Menu mnuNewAccount 
         Caption         =   "&New Account"
      End
      Begin VB.Menu mnuEditAccount 
         Caption         =   "&Edit Account"
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub mnuNewAccount_Click()

End Sub

Private Sub mnuNewUser_Click()

End Sub

VERSION 5.00
Begin VB.Form frmInfo 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "About Secret Messager v1.2"
   ClientHeight    =   3255
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4770
   Icon            =   "frmInfo.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3255
   ScaleWidth      =   4770
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Height          =   435
      Left            =   1740
      TabIndex        =   2
      Top             =   2700
      Width           =   1215
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      Caption         =   $"frmInfo.frx":030A
      Height          =   675
      Left            =   240
      TabIndex        =   1
      Top             =   1920
      Width           =   4275
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   $"frmInfo.frx":03B2
      Height          =   1455
      Left            =   2040
      TabIndex        =   0
      Top             =   240
      Width           =   2535
   End
   Begin VB.Image imgLogo 
      Height          =   1680
      Left            =   120
      Picture         =   "frmInfo.frx":049D
      Top             =   120
      Width           =   1800
   End
End
Attribute VB_Name = "frmInfo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdOK_Click()
    Unload Me
End Sub

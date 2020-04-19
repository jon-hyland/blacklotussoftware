VERSION 5.00
Begin VB.Form frmInfo 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "About Binary Crypt v1.21"
   ClientHeight    =   3060
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6525
   Icon            =   "frmInfo.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3060
   ScaleWidth      =   6525
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cmdOK 
      Caption         =   "OK"
      Height          =   375
      Left            =   4170
      TabIndex        =   2
      Top             =   2580
      Width           =   1155
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      Caption         =   "v1.21"
      BeginProperty Font 
         Name            =   "Impact"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   5400
      TabIndex        =   3
      Top             =   420
      Width           =   495
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      Caption         =   "Binary Crypt"
      BeginProperty Font 
         Name            =   "Impact"
         Size            =   14.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3510
      TabIndex        =   4
      Top             =   180
      Width           =   2115
   End
   Begin VB.Image imgLogo 
      Height          =   2805
      Left            =   120
      Picture         =   "frmInfo.frx":030A
      Top             =   120
      Width           =   2790
   End
   Begin VB.Label Label2 
      Caption         =   $"frmInfo.frx":19C5C
      Height          =   795
      Left            =   3090
      TabIndex        =   1
      Top             =   1620
      Width           =   3345
   End
   Begin VB.Label Label1 
      Caption         =   "(c) 1996-2000 by Black Lotus Software.  Coding and design by Jon Hyland.  Graphics and testing by Ben Chase.  All rights reserved."
      Height          =   645
      Left            =   3090
      TabIndex        =   0
      Top             =   840
      Width           =   3285
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


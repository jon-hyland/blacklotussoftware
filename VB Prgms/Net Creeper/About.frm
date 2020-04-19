VERSION 5.00
Begin VB.Form About 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "About Net Creeper"
   ClientHeight    =   3675
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7275
   Icon            =   "About.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3675
   ScaleWidth      =   7275
   StartUpPosition =   1  'CenterOwner
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
      Left            =   1020
      TabIndex        =   0
      Top             =   3060
      Width           =   1095
   End
   Begin VB.Label lblAbout4 
      Alignment       =   2  'Center
      Caption         =   $"About.frx":030A
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000080FF&
      Height          =   615
      Left            =   3180
      TabIndex        =   4
      Top             =   2040
      Width           =   3915
   End
   Begin VB.Label lblAbout3 
      Alignment       =   2  'Center
      Caption         =   "Click on the logo to visit the Black Lotus Software homepage.  You can check out our other freeware releases or post us a message."
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   735
      Left            =   3180
      TabIndex        =   3
      Top             =   2880
      Width           =   3855
   End
   Begin VB.Label lblAbout2 
      Alignment       =   2  'Center
      Caption         =   $"About.frx":039D
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1395
      Left            =   3180
      TabIndex        =   2
      Top             =   600
      Width           =   3855
   End
   Begin VB.Label lblAbout1 
      Alignment       =   2  'Center
      Caption         =   "Net Creeper v1.5"
      BeginProperty Font 
         Name            =   "Viner Hand ITC"
         Size            =   14.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3180
      TabIndex        =   1
      Top             =   120
      Width           =   3855
      WordWrap        =   -1  'True
   End
   Begin VB.Image imgBLS 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      Height          =   2580
      Left            =   240
      Picture         =   "About.frx":04D5
      ToolTipText     =   "Link to Black Lotus Software homepage"
      Top             =   240
      Width           =   2730
   End
End
Attribute VB_Name = "About"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdOK_Click()
    Unload Me
End Sub

Private Sub imgBLS_Click()
    Address = "http://www.angelfire.com/wa/blacklotus/"
    GoType = 3
    Me.Hide
    Main.IE.Navigate Address
End Sub

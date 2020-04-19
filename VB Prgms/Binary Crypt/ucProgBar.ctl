VERSION 5.00
Begin VB.UserControl ucProgBar 
   ClientHeight    =   750
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   2670
   ScaleHeight     =   750
   ScaleWidth      =   2670
   Begin VB.Label lblCap 
      Alignment       =   2  'Center
      Caption         =   "Progress Bar Caption"
      Height          =   195
      Left            =   180
      TabIndex        =   0
      Top             =   480
      Width           =   2295
   End
   Begin VB.Shape shpProg 
      FillColor       =   &H00FF0000&
      FillStyle       =   0  'Solid
      Height          =   255
      Left            =   120
      Top             =   120
      Width           =   2415
   End
   Begin VB.Shape shpBack 
      FillColor       =   &H00808080&
      FillStyle       =   0  'Solid
      Height          =   375
      Left            =   60
      Top             =   60
      Width           =   2535
   End
End
Attribute VB_Name = "ucProgBar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Public cBEnc As clsBLBinEnc
Public iByteWorth As Single

Private Sub UserControl_Initialize()
    Set cBEnc = New clsBLBinEnc
End Sub

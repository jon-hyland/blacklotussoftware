VERSION 5.00
Begin VB.Form Edit 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Edit Existing Record"
   ClientHeight    =   3480
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3840
   Icon            =   "Edit.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3480
   ScaleWidth      =   3840
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtFirst 
      Height          =   285
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   1935
   End
   Begin VB.TextBox txtLast 
      Height          =   285
      Left            =   240
      TabIndex        =   1
      Top             =   720
      Width           =   1935
   End
   Begin VB.TextBox txtPhone 
      Height          =   285
      Left            =   240
      TabIndex        =   2
      Top             =   1200
      Width           =   1575
   End
   Begin VB.TextBox txtSec 
      Height          =   285
      Left            =   240
      TabIndex        =   3
      Top             =   1680
      Width           =   1575
   End
   Begin VB.TextBox txtAdd 
      Height          =   285
      Left            =   240
      TabIndex        =   4
      Top             =   2160
      Width           =   3375
   End
   Begin VB.CommandButton cmdDone 
      Caption         =   "Done"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   240
      TabIndex        =   5
      Top             =   2880
      Width           =   1215
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "Cancel"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   2400
      TabIndex        =   7
      Top             =   2880
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "First Name"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   2640
      TabIndex        =   11
      Top             =   240
      Width           =   1215
   End
   Begin VB.Label Label2 
      Caption         =   "Last Name"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   2640
      TabIndex        =   10
      Top             =   720
      Width           =   1215
   End
   Begin VB.Label Label3 
      Caption         =   "Phone Number"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   2280
      TabIndex        =   9
      Top             =   1200
      Width           =   1455
   End
   Begin VB.Label Label4 
      Caption         =   "Sec. Phone Num."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   2160
      TabIndex        =   8
      Top             =   1680
      Width           =   1575
   End
   Begin VB.Label Label5 
      Alignment       =   2  'Center
      Caption         =   "EMail Address"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   1200
      TabIndex        =   6
      Top             =   2520
      Width           =   1455
   End
End
Attribute VB_Name = "Edit"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdCancel_Click()
    Edit.Hide
End Sub

Private Sub cmdDone_Click()
    If Clip_Str(txtFirst.Text) <> "" Then
        FirstName(RecNum) = Clip_Str(txtFirst.Text)
        LastName(RecNum) = Clip_Str(txtLast.Text)
        PhoneNumber(RecNum) = Clip_Str(txtPhone.Text)
        SecPhoneNumber(RecNum) = Clip_Str(txtSec.Text)
        EMailAddress(RecNum) = Clip_Str(txtAdd.Text)
        Show_Record (RecNum)
        Save_Data
        Edit.Hide
    Else
        txtFirst.Text = ""
        txtFirst.SetFocus
    End If
End Sub

Private Sub Form_Activate()
    txtFirst.Text = FirstName(RecNum)
    txtLast.Text = LastName(RecNum)
    txtPhone.Text = PhoneNumber(RecNum)
    txtSec.Text = SecPhoneNumber(RecNum)
    txtAdd.Text = EMailAddress(RecNum)
    txtFirst.SetFocus
End Sub


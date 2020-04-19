VERSION 5.00
Begin VB.Form LastUsed 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "(c)  Black Lotus Software"
   ClientHeight    =   1530
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3600
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1530
   ScaleWidth      =   3600
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtDate 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   1920
      Locked          =   -1  'True
      TabIndex        =   4
      Top             =   960
      Width           =   1215
   End
   Begin VB.TextBox txtTime 
      Alignment       =   1  'Right Justify
      Height          =   285
      Left            =   1920
      Locked          =   -1  'True
      TabIndex        =   3
      Top             =   600
      Width           =   1215
   End
   Begin VB.Label Label3 
      Caption         =   "Date"
      Height          =   255
      Left            =   480
      TabIndex        =   2
      Top             =   960
      Width           =   375
   End
   Begin VB.Label Label2 
      Caption         =   "Time"
      Height          =   255
      Left            =   480
      TabIndex        =   1
      Top             =   600
      Width           =   495
   End
   Begin VB.Label Label1 
      Caption         =   "Computer was last used ..."
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
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   2655
   End
End
Attribute VB_Name = "LastUsed"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
    Dim FilePath As String
    Dim FileExist As String
    Dim LastTime
    Dim LastDate
    Dim NowTime
    Dim NowDate
    
    FilePath = FixFile(FixPath(CurDir) + "lastus95.dat")
    
    FileExist = Dir(FilePath)
    If FileExist = "" Then
        Open FilePath For Output As #1
        Write #1, "Current Time"
        Write #1, "Now Saved"
        Close #1
    End If
    Open FilePath For Input As #1
    Input #1, LastTime
    Input #1, LastDate
    Close #1
    txtTime.Text = LastTime
    txtDate.Text = LastDate
    NowTime = Time
    NowDate = Date
    Open FilePath For Output As #1
    Write #1, NowTime
    Write #1, NowDate
    Close #1
End Sub

Private Function FixPath(InPth As String) As String
    Dim OutPth As String
    Dim Backs As Integer
    Dim Cha As String
    Dim Count As Integer
    
    For Count = 1 To Len(InPth)
        Cha = Left(InPth, 1)
        InPth = Right(InPth, Len(InPth) - 1)
        If Cha = "\" Then Backs = Backs + 1 Else Backs = 0
        If Backs <= 1 Then OutPth = OutPth + Cha
    Next Count
    If Backs <= 0 Then OutPth = OutPth + "\"
    FixPath = OutPth
End Function

Private Function FixFile(InPth As String) As String
    Dim OutPth As String
    Dim Backs As Integer
    Dim Cha As String
    Dim Count As Integer
    
    For Count = 1 To Len(InPth)
        Cha = Left(InPth, 1)
        InPth = Right(InPth, Len(InPth) - 1)
        If Cha = "\" Then Backs = Backs + 1 Else Backs = 0
        If Backs <= 1 Then OutPth = OutPth + Cha
    Next Count
    If Backs > 0 Then OutPth = Left(OutPth, Len(OutPth) - 1)
    FixFile = OutPth
End Function


Attribute VB_Name = "Res"
Global SHeight, SWidth As Single
Global ImgHeight As Single
Global RunPath As String
Global ImgPath As String
Global RandomOrder As Boolean
Global FileName(1 To 10000) As String
Global TotFiles As Integer
Global Index As Integer
Global StartT As Single
Global NowT As Single
Global DelayT As Single
Global Manual As Boolean
Global SortMode As Boolean
Global FileInfo(1 To 10000) As String

Public Sub ShowMessage(Msg As String)
    SlideShow.PicBox.Enabled = True
    SlideShow.PicBox.Visible = True
    SlideShow.PicBox.Cls
    SlideShow.PicBox.Print " "; Msg
End Sub

Public Function FixPath(InPth As String) As String
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

Public Function FixFile(InPth As String) As String
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

Public Sub GetSavedData()
    Dim FullPath As String
    Dim StrTemp As String
    
    FullPath = FixFile(RunPath + "SLIDE.INI")
    Open FullPath For Input As #1
    Input #1, StrTemp
    Input #1, ImgPath
    Input #1, StrTemp
    Input #1, RandomOrder
    Input #1, StrTemp
    Input #1, DelayT
    ImgPath = FixPath(ImgPath)
    Close #1
End Sub

Public Sub InitDir()
    Dim Count As Integer
    Dim TempArray(1 To 10000) As String
    Dim RNum As Integer
    
    SlideShow.FileList.Path = ImgPath
    SlideShow.FileList.Pattern = "*.jpg"
    TotFiles = SlideShow.FileList.ListCount
    For Count = 1 To TotFiles
        FileName(Count) = SlideShow.FileList.List(Count - 1)
    Next Count
    If RandomOrder Then
        For Count = 1 To 10000
            TempArray(Count) = FileName(Count)
            FileName(Count) = ""
        Next Count
        For Count = 1 To TotFiles
            Do
                RNum = Int((Rnd * TotFiles) + 1)
            Loop While TempArray(RNum) = ""
            FileName(Count) = TempArray(RNum)
            TempArray(RNum) = ""
        Next Count
    End If
    Index = 1
End Sub

Public Sub ShowPic()
    Dim Prec As Single
    
    SlideShow.ImgWin.Visible = False
    SlideShow.ImgWin.Stretch = False
    SlideShow.ImgWin.Picture = LoadPicture(FixFile(ImgPath + FileName(Index)))
    Prec = SlideShow.ImgWin.Height / ImgHeight
    If (SlideShow.ImgWin.Width / Prec + 256) >= Screen.Width Then Prec = SlideShow.ImgWin.Width / (Screen.Width - 50)
    SlideShow.ImgWin.Height = SlideShow.ImgWin.Height / Prec
    SlideShow.ImgWin.Width = SlideShow.ImgWin.Width / Prec
    SlideShow.ImgWin.Stretch = True
    SlideShow.ImgWin.Top = 0
    SlideShow.Width = SlideShow.ImgWin.Width
    SlideShow.Height = SlideShow.ImgWin.Height
    SlideShow.Top = (Screen.Height - SlideShow.Height) / 2
    SlideShow.Left = (Screen.Width - SlideShow.Width) / 2
    SlideShow.ImgWin.Left = (SlideShow.Width - SlideShow.ImgWin.Width) / 2
    SlideShow.ImgWin.Visible = True
    StartT = Timer
End Sub



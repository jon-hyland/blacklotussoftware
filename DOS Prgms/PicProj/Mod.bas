Attribute VB_Name = "Mod"
Public RunPath As String
Public ViewPath As String
Public FileExt As String
Public FileList(1 To 10000) As String
Public TotFiles As Integer
Public Index As Integer
Public Manual As Boolean
Public Random As Boolean
Public SeeButt As Boolean
Public DelayTime As Single
Public StartTime As Single
Public NowTime As Single
Public RunFromCD As Boolean
Public NoFiles As Boolean

Public Function FixPath(strFile As String) As String
    Dim strCopy As String
    Dim bteFile(256) As Byte
    Dim bteTemp As Byte
    Dim numOld As Integer
    Dim numNew As Integer
    Dim numBack As Integer
            
    strCopy = strFile
    For numOld = 1 To Len(strFile)
        bteTemp = Asc(Left(strCopy, 1))
        strCopy = Right(strCopy, Len(strCopy) - 1)
        If bteTemp = 92 Then numBack = numBack + 1 Else numBack = 0
        If numBack <= 1 Then
            bteFile(numNew) = bteTemp
            numNew = numNew + 1
        End If
    Next numOld
    strCopy = ""
    For numOld = 1 To numNew
        strCopy = strCopy + Chr(bteFile(numOld - 1))
    Next numOld
    FixPath = strCopy
End Function

Public Sub GetData()
    Dim DatPath As String
    
    DatPath = FixPath(RunPath + "\picproj.dat")
    Open DatPath For Input As #1
    Input #1, ViewPath
    Input #1, FileExt
    Input #1, DelayTime
    Input #1, Manua1
    Input #1, Random
    Input #1, SeeButt
    Close #1
End Sub

Public Sub SaveData()
    Dim DatPath As String
    
    DatPath = FixPath(RunPath + "\picproj.dat")
    Open DatPath For Output As #1
    Write #1, ViewPath
    Write #1, FileExt
    Write #1, DelayTime
    Write #1, Manual
    Write #1, Random
    Write #1, SeeButt
    Close #1
End Sub

Public Sub InitDir(ViewPath As String)
    Dim Count As Integer
    Dim Swap(1 To 10000) As String
    Dim Rand As Integer
    
    TotFiles = 0
    PicProj.fileBox.Path = ViewPath
    PicProj.fileBox.Pattern = FileExt
    TotFiles = PicProj.fileBox.ListCount
    For Count = 1 To TotFiles
        FileList(Count) = PicProj.fileBox.List(Count - 1)
    Next Count
    If Random Then
        For Count = 1 To TotFiles
            Do
                Rand = Int(Rnd * TotFiles + 1)
            Loop Until Swap(Rand) = ""
            Swap(Rand) = FileList(Count)
        Next Count
        For Count = 1 To TotFiles
            FileList(Count) = Swap(Count)
        Next Count
    End If
    Index = 0
    NextImg
End Sub

Public Function CDViewPath(ViewPath As String)
    Dim Junk As String
    
    Junk = ViewPath
    Junk = Right(Junk, Len(ViewPath) - 1)
    Junk = Left(RunPath, 1) + Junk
    InitDir (Junk)
    CDViewPath = Junk
End Function

Public Sub InitProg()
    Randomize
    RunFromCD = False
    RunPath = FixPath(App.Path)
    GetData
    If RunFromCD Then ViewPath = CDViewPath(ViewPath)
    InitDir (ViewPath)
    If SeeButt Then
        PicProj.cmdNext.Visible = True
        PicProj.cmdPrev.Visible = True
    End If
End Sub

Public Sub ShowImage(ImgPath As String)
    PicProj.imgWin.Picture = LoadPicture(ImgPath)
    StartTime = Timer
End Sub

Public Sub NextImg()
    Index = Index + 1
    If Index > TotFiles Then Index = 1
    ShowImage (FixPath(ViewPath + "\" + FileList(Index)))
End Sub

Public Sub PrevImg()
    Index = Index - 1
    If Index < 1 Then Index = TotFiles
    ShowImage (FixPath(ViewPath + "\" + FileList(Index)))
End Sub

Public Sub ResetImg()
    PicProj.imgWin.Width = PicProj.Width
    PicProj.imgWin.Height = PicProj.Height
End Sub

Attribute VB_Name = "Mod"
Public Const InitDataFile = "blsini.dat"
Public Const CompLogoFile = "blslogo.dat"
Public Const ProdLogoFile = "prologo.dat"

Public ScreenMode As Integer
Public NewFileSpec As String
Public FileSpec As String
Public SecDelay As Integer
Public Random As Boolean
Public NoTimer As Boolean
Public Manual As Boolean
Public TotHeight As Integer
Public TotWidth As Integer
Public NewFilePath As String
Public FilePath As String
Public FileList(1024) As String
Public TotFiles As Integer
Public FileIndex As Integer
Public StartTime As Single
Public StopForError As Boolean

Public Sub Load_Settings()
    Open (App.Path + "\" + InitDataFile) For Input As #1
    Input #1, FilePath
    If Right(FilePath, 1) <> "\" Then FilePath = (FilePath + "\")
    Input #1, FileSpec
    Input #1, SecDelay
    Input #1, Random
    Input #1, NoTimer
    Input #1, Manual
    Input #1, ScreenMode
    Close #1
End Sub


Public Sub Save_Settings()
    Open (App.Path + "\" + InitDataFile) For Output As #1
    Write #1, FilePath
    Write #1, FileSpec
    Write #1, SecDelay
    Write #1, Random
    Write #1, NoTimer
    Write #1, Manual
    Write #1, ScreenMode
    Close #1
End Sub

Public Sub Init_Prog()
    Randomize
    Load_Settings
    TotHeight = Screen.Height
    TotWidth = Screen.Width
    NewFilePath = FilePath
    NewFileSpec = FileSpec
    Init_FileList
End Sub

Public Sub Resize_Img(Mode As Integer)
    Select Case Mode
        Case 1
            Main.Top = 0
            Main.Left = 0
            Main.Width = TotWidth / 2.25
            Main.Height = TotHeight / 2.25
            Main.imgWin.Top = 0
            Main.imgWin.Left = 0
            Main.imgWin.Width = Main.Width
            Main.imgWin.Height = Main.Height
        Case 2
            Main.Top = 0
            Main.Left = Screen.Width - (TotWidth / 2.25)
            Main.Width = TotWidth / 2.25
            Main.Height = TotHeight / 2.25
            Main.imgWin.Top = 0
            Main.imgWin.Left = 0
            Main.imgWin.Width = Main.Width
            Main.imgWin.Height = Main.Height
        Case 3
            Main.Top = Screen.Height - (TotHeight / 2.25)
            Main.Left = 0
            Main.Width = TotWidth / 2.25
            Main.Height = TotHeight / 2.25
            Main.imgWin.Top = 0
            Main.imgWin.Left = 0
            Main.imgWin.Width = Main.Width
            Main.imgWin.Height = Main.Height
        Case 4
            Main.Top = Screen.Height - (TotHeight / 2.25)
            Main.Left = Screen.Width - (TotWidth / 2.25)
            Main.Width = TotWidth / 2.25
            Main.Height = TotHeight / 2.25
            Main.imgWin.Top = 0
            Main.imgWin.Left = 0
            Main.imgWin.Width = Main.Width
            Main.imgWin.Height = Main.Height
        Case 5
            Main.Top = (Screen.Height / 2) - ((TotHeight / 2.25) / 2)
            Main.Left = (Screen.Width / 2) - ((TotWidth / 2.25) / 2)
            Main.Width = TotWidth / 2.25
            Main.Height = TotHeight / 2.25
            Main.imgWin.Top = 0
            Main.imgWin.Left = 0
            Main.imgWin.Width = Main.Width
            Main.imgWin.Height = Main.Height
        Case 6
            Main.Top = 0
            Main.Left = 0
            Main.Width = TotWidth
            Main.Height = TotHeight
            Main.imgWin.Top = 0
            Main.imgWin.Left = 0
            Main.imgWin.Width = Main.Width
            Main.imgWin.Height = Main.Height
    End Select
End Sub

Public Sub Init_FileList()
    Dim Count As Integer
    Dim Temp(1024) As String
    Dim Loc As Integer
    
    Splash.boxFile.Pattern = FileSpec
    Options.boxDrv.Drive = Left(FilePath, 1)
    Options.boxDir.Path = FilePath
    Splash.boxFile.Path = FilePath
    TotFiles = Splash.boxFile.ListCount
    For Count = 1 To TotFiles
        FileList(Count) = Splash.boxFile.List(Count - 1)
        Temp(Count) = FileList(Count)
    Next Count
    If Random Then
        For Count = 1 To TotFiles
            FileList(Count) = ""
        Next Count
        For Count = 1 To TotFiles
            Do
                Loc = Int((TotFiles * Rnd) + 1)
            Loop Until FileList(Loc) = ""
            FileList(Loc) = Temp(Count)
        Next Count
    End If
    FileIndex = 1
    If TotFiles = 0 Then
        StopForError = True
        Options.Hide
        Error.lblError.Caption = "Error!  Cannot find any files in specified folder with given filespec.  Try changing folder to another location, changing filespec to something like *.JPG. or clicking on the Reset Options button."
        Error.Show
    Else
        StopForError = False
    End If
    Options.picFound.Cls
    Options.picFound.Print TotFiles
End Sub

Public Sub Show_Picture()
    If Right(FilePath, 1) = "\" Then
        Main.imgWin.Picture = LoadPicture(FilePath + FileList(FileIndex))
    Else
        Main.imgWin.Picture = LoadPicture(FilePath + "\" + FileList(FileIndex))
    End If
    StartTime = Timer
End Sub



Attribute VB_Name = "Mod"
Public Const DataFile = "netcreep.dat"
Public Const FavsFile = "favorite.dat"
Public Const RecFile = "recent.dat"
Public Const UnallFile = "unallowed.dat"
Public HomeAdd As String
Public SrchAdd As String
Public MailAdd As String
Public LastAdd As String
Public DefTo As Integer
Public KeepRecent As Boolean
Public Address As String
Public FullScrn As Boolean
Public TotRecent As Integer
Public NumRecent As Integer
Public MaxRecent As Integer
Public GoType As Integer  ' see end of module for definition
Public DropDown As Boolean
Public TotFavs As Integer
Public Unallowed As New Collection

Public Sub InitProg()
    LoadData
    Select Case DefTo
        Case 1
            Address = HomeAdd
        Case 2
            Address = SrchAdd
        Case 3
            Address = MailAdd
        Case 4
            Address = LastAdd
    End Select
    FullScrn = False
    If KeepRecent Then
        LoadRecent
        NumRecent = TotRecent - 1
        GoType = 0
    Else
        NumRecent = -1
        TotRecent = 0
        GoType = 0
    End If
End Sub

Public Sub EndProg()
    LastAdd = Address
    SaveData
    If KeepRecent Then SaveRecent
    Unload Ask
    Unload Favs
    Unload Logo
    Unload Menu
    Unload About
    Unload Full
    Unload Main
    End
End Sub

Public Sub InitIE()
    ResizeIE
    Main.IE.Visible = True
    GoType = 3
    Main.IE.Navigate Address
End Sub

Public Sub InitIEF()
    ResizeIEF
    Full.IEF.Visible = True
    Full.IEF.Navigate Address
End Sub

Public Sub ResizeIE()
    If Main.WindowState = 0 Then
        Main.IE.Width = Main.Width - 180
        Main.IE.Left = 30
        Main.IE.Top = 1260
        Main.IE.Height = Main.Height - 1700
    End If
    If Main.WindowState = 2 Then
        Main.IE.Width = Main.Width - 240
        Main.IE.Left = 60
        Main.IE.Top = 1260
        Main.IE.Height = Main.Height - 1730
    End If
End Sub

Public Sub ResizeIEF()
    Full.IEF.Width = Full.Width
    Full.IEF.Left = 0
    Full.IEF.Top = 500
    Full.IEF.Height = Full.Height - 60 - 500
End Sub

Public Sub LoadData()
    Dim Count As Integer
    Dim JunkSt As String
    
    ' get Net Creeper settings
    If Right(App.Path, 1) = "\" Then
        Open App.Path & DataFile For Input As #1
    Else
        Open App.Path & "\" & DataFile For Input As #1
    End If
    Input #1, HomeAdd
    Input #1, SrchAdd
    Input #1, MailAdd
    Input #1, LastAdd
    Input #1, DefTo
    Input #1, KeepRecent
    Input #1, MaxRecent
    Close #1
        
    ' get unallowed (undisplayed) URL's
    If Right(App.Path, 1) = "\" Then
        Open App.Path & UnallFile For Input As #1
    Else
        Open App.Path & "\" & UnallFile For Input As #1
    End If
    While Unallowed.Count > 0
        Unallowed.Remove (1)
    Wend
    While Not EOF(1)
        Input #1, JunkSt
        Unallowed.Add JunkSt
    Wend
    Close #1
End Sub

Public Sub SaveData()
    Dim Count As Integer
    
    If Right(App.Path, 1) = "\" Then
        Open App.Path & DataFile For Output As #1
    Else
        Open App.Path & "\" & DataFile For Output As #1
    End If
    Write #1, HomeAdd
    Write #1, SrchAdd
    Write #1, MailAdd
    Write #1, LastAdd
    Write #1, DefTo
    Write #1, KeepRecent
    Write #1, MaxRecent
    Close #1
End Sub

Public Sub LoadFavs()
    If Right(App.Path, 1) = "\" Then
        Open App.Path & FavsFile For Input As #1
    Else
        Open App.Path & "\" & FavsFile For Input As #1
    End If
    Favs.lstFavs.Clear
    Input #1, TotFavs
    For Count = 1 To TotFavs
        Input #1, JunkSt
        Favs.lstFavs.AddItem JunkSt, (Count - 1)
    Next Count
    Close #1
End Sub

Public Sub SaveFavs()
    If Right(App.Path, 1) = "\" Then
        Open App.Path & FavsFile For Output As #1
    Else
        Open App.Path & "\" & FavsFile For Output As #1
    End If
    Write #1, TotFavs
    For Count = 1 To TotFavs
        Write #1, Favs.lstFavs.List(Count - 1)
    Next Count
    Close #1
End Sub

Public Sub LoadRecent()
    Dim Count As Integer, JunkS As String
    
    If Right(App.Path, 1) = "/" Then
        Open App.Path & RecFle For Input As #1
    Else
        Open App.Path & "/" & RecFile For Input As #1
    End If
    Input #1, TotRecent
    For Count = 1 To TotRecent
        Input #1, JunkS
        Main.lstRecent.AddItem JunkS, Count - 1
    Next Count
    Close #1
End Sub

Public Sub SaveRecent()
    Dim Count As Integer
    
    If Right(App.Path, 1) = "/" Then
        Open App.Path & RecFle For Output As #1
    Else
        Open App.Path & "/" & RecFile For Output As #1
    End If
    Write #1, TotRecent
    For Count = 1 To TotRecent
        Write #1, Main.lstRecent.List(Count - 1)
    Next Count
    Close #1
End Sub


' GoType definition, (where used)
'   0 - Insert new URL into recent drop-down box one spot after current position (default, web links)
'   1 - navigate to URL one spot before current position, don't add new URL (prev)
'   2 - navigate to URL one spot after current position, don't add new URL (next)
'   3 - add new URL to end of list (go_click, home_click, etc., all button navigates)
'   4 - move current position to item double-clicked on, don't add URL (lstrecent_dblclick)


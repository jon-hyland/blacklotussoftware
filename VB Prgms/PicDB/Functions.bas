Attribute VB_Name = "Functions"
Public Sub Main()
    Set cnPic = New Connection
    cnPic.Open ("PROVIDER=MSDASQL; dsn=dsnPicDB; uid=sa; pwd=;")
    
    
    Set fMain = New frmMain
    fMain.Show
End Sub

Public Sub End_Prog()
    Set fMain = Nothing
    End
End Sub





Attribute VB_Name = "Mod"
Global Correct As Integer
Global TotIter As Integer
Global Iter As Integer
Global Memory(50) As Integer
Global UserTry(50) As Integer
Global Turn As Integer


Sub Init_Game()
    Randomize
    Correct = 0
    Main.cmdAll.Caption = "Watch"
    Turn = 0
End Sub

Sub Init_Turn()
    Dim Count As Integer
    
    TotIter = Int((Correct) / 3) + 3
    Iter = 0
    For Count = 1 To TotIter
        Memory(Count) = Int((4 * Rnd) + 1)
        UserTry(Count) = 0
    Next Count
End Sub

Sub Watch_Turn()
    Dim Count As Integer
    
    For Count = 1 To TotIter
        Main.cmdAll.Caption = Str((TotIter + 1) - Count)
        Select Case Memory(Count)
            Case 1
                Main.cmdUp.Enabled = False
            Case 2
                Main.cmdLeft.Enabled = False
            Case 3
                Main.cmdDown.Enabled = False
            Case 4
                Main.cmdDown.Enabled = False
        End Select
        Wait_Second
        Main.cmdUp.Enabled = True
        Main.cmdLeft.Enabled = True
        Main.cmdRight.Enabled = True
        Main.cmdDown.Enabled = True
    Next Count
    Turn = 1
    Main.cmdAll.Caption = "Go"
End Sub

Sub Wait_Second()
    Dim StartTime As Single, NowTime As Single
    
    StartTime = Timer
    NowTime = StartTime
    While NowTime <= (StartTime + 2)
        NowTime = Timer
    Wend
End Sub

Sub Go_Turn()

    Main.cmdAll.Enabled = True
End Sub



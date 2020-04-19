Attribute VB_Name = "Mod"
Public FirstName(1024) As String
Public LastName(1024) As String
Public PhoneNumber(1024) As String
Public SecPhoneNumber(1024) As String
Public EMailAddress(1024) As String
Public DateTime(1024) As Variant
Public RecTot As Integer
Public RecNum As Integer
Public Results_Index(1024) As Integer

Public Sub Init_Prog()
    Load_Data
End Sub

Public Sub Load_Data()
    Dim Count As Integer
    
    Open (App.Path + "\record.dat") For Input As #1
    Input #1, RecTot
    Input #1, RecNum
    For Count = 1 To RecTot
        Input #1, FirstName(Count)
        Input #1, LastName(Count)
        Input #1, PhoneNumber(Count)
        Input #1, SecPhoneNumber(Count)
        Input #1, EMailAddress(Count)
        Input #1, DateTime(Count)
    Next Count
    Close #1
End Sub

Public Sub Save_Data()
    Dim Count As Integer
    
    Open (App.Path + "\record.dat") For Output As #1
    Write #1, RecTot
    Write #1, RecNum
    For Count = 1 To RecTot
        Write #1, FirstName(Count)
        Write #1, LastName(Count)
        Write #1, PhoneNumber(Count)
        Write #1, SecPhoneNumber(Count)
        Write #1, EMailAddress(Count)
        Write #1, DateTime(Count)
    Next Count
    Close #1
End Sub

Public Sub Show_Record(Num As Integer)
    Main.picFirst.Cls
    Main.picFirst.Print FirstName(Num)
    Main.picLast.Cls
    Main.picLast.Print LastName(Num)
    Main.picPhone.Cls
    Main.picPhone.Print PhoneNumber(Num)
    Main.picSec.Cls
    Main.picSec.Print SecPhoneNumber(Num)
    Main.picAdd.Cls
    Main.picAdd.Print EMailAddress(Num)
    Main.picNum.Cls
    Main.picNum.Print Str(Num) + " of " + Str(RecTot)
End Sub

Public Function Clip_Str(St As String) As String
    While ((Left(St, 1) = " ") And (Len(St) > 0))
        St = Right(St, Len(St) - 1)
    Wend
    While ((Right(St, 1) = " ") And (Len(St) > 0))
        St = Left(St, Len(St) - 1)
    Wend
    Clip_Str = St
End Function

Public Sub Sort_Data(SortMode As Integer)
    Dim Count As Integer
    Dim Swap As Boolean
    Dim Junk As Variant
    
    Select Case SortMode
        Case 1
            Do
                Swap = False
                For Count = 1 To RecTot - 1
                    If Format(FirstName(Count), ">") > Format(FirstName(Count + 1), ">") Then
                        JunkConst = FirstName(Count)
                        FirstName(Count) = FirstName(Count + 1)
                        FirstName(Count + 1) = JunkConst
                        Junk = LastName(Count)
                        LastName(Count) = LastName(Count + 1)
                        LastName(Count + 1) = Junk
                        Junk = PhoneNumber(Count)
                        PhoneNumber(Count) = PhoneNumber(Count + 1)
                        PhoneNumber(Count + 1) = Junk
                        Junk = SecPhoneNumber(Count)
                        SecPhoneNumber(Count) = SecPhoneNumber(Count + 1)
                        SecPhoneNumber(Count + 1) = Junk
                        Junk = EMailAddress(Count)
                        EMailAddress(Count) = EMailAddress(Count + 1)
                        EMailAddress(Count + 1) = Junk
                        Junk = DateTime(Count)
                        DateTime(Count) = DateTime(Count + 1)
                        DateTime(Count + 1) = Junk
                        Swap = True
                    End If
                Next Count
            Loop Until Swap = False
        Case 2
            Do
                Swap = False
                For Count = 1 To RecTot - 1
                    If Format(LastName(Count), ">") > Format(LastName(Count + 1), ">") Then
                        Junk = FirstName(Count)
                        FirstName(Count) = FirstName(Count + 1)
                        FirstName(Count + 1) = Junk
                        Junk = LastName(Count)
                        LastName(Count) = LastName(Count + 1)
                        LastName(Count + 1) = Junk
                        Junk = PhoneNumber(Count)
                        PhoneNumber(Count) = PhoneNumber(Count + 1)
                        PhoneNumber(Count + 1) = Junk
                        Junk = SecPhoneNumber(Count)
                        SecPhoneNumber(Count) = SecPhoneNumber(Count + 1)
                        SecPhoneNumber(Count + 1) = Junk
                        Junk = EMailAddress(Count)
                        EMailAddress(Count) = EMailAddress(Count + 1)
                        EMailAddress(Count + 1) = Junk
                        Junk = DateTime(Count)
                        DateTime(Count) = DateTime(Count + 1)
                        DateTime(Count + 1) = Junk
                        Swap = True
                    End If
                Next Count
            Loop Until Swap = False
        Case 3
            Do
                Swap = False
                For Count = 1 To RecTot - 1
                    If DateTime(Count) > DateTime(Count + 1) Then
                        Junk = FirstName(Count)
                        FirstName(Count) = FirstName(Count + 1)
                        FirstName(Count + 1) = Junk
                        Junk = LastName(Count)
                        LastName(Count) = LastName(Count + 1)
                        LastName(Count + 1) = Junk
                        Junk = PhoneNumber(Count)
                        PhoneNumber(Count) = PhoneNumber(Count + 1)
                        PhoneNumber(Count + 1) = Junk
                        Junk = SecPhoneNumber(Count)
                        SecPhoneNumber(Count) = SecPhoneNumber(Count + 1)
                        SecPhoneNumber(Count + 1) = Junk
                        Junk = EMailAddress(Count)
                        EMailAddress(Count) = EMailAddress(Count + 1)
                        EMailAddress(Count + 1) = Junk
                        Junk = DateTime(Count)
                        DateTime(Count) = DateTime(Count + 1)
                        DateTime(Count + 1) = Junk
                        Swap = True
                    End If
                Next Count
            Loop Until Swap = False
    End Select
    Save_Data
    RecNum = 1
    Show_Record (RecNum)
End Sub


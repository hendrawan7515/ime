Imports System.Data

Public Class QueryList
    Private DataContext As New DAL

    Public Function ExecuteQuery(ByVal modulename As String, ByVal id As Integer, Optional obj As Object = Nothing, Optional parameter As String = "") As Integer
        Dim SQLQuery As String = GetQuery(modulename, id, obj, parameter)
        Return DataContext.ExecuteNonQuery(SQLQuery)
    End Function

    Public Function GetScalar(ByVal modulename As String, ByVal id As Integer, Optional obj As Object = Nothing, Optional parameter As String = "") As String
        Dim SQLQuery As String = GetQuery(modulename, id, obj, parameter)
        Return DataContext.GetScalar(SQLQuery)
    End Function

    Public Function GetDataSet(ByVal modulename As String, ByVal id As Integer, Optional obj As Object = Nothing, Optional parameter As String = "") As DataSet
        Dim SQLQuery As String = GetQuery(modulename, id, obj, parameter)
        Return DataContext.GetDataSet(SQLQuery)
    End Function

    Public Function GetQuery(ByVal modulename As String, ByVal id As Integer, Optional obj As Object = Nothing, Optional parameter As String = "") As String
        Dim QueryString As String = ""

        Select Case modulename
            Case "Default"
                Dim LoginInput As New CustomModel.LoginInput
                If Not IsNothing(obj) Then LoginInput = obj

                If id = 1 Then
                    'Cek Akun Lock
                    QueryString = "SELECT isLock FROM uspr000 WHERE userid = '" & LoginInput.username & "' AND current_time() BETWEEN StartDate AND EndDate AND FlagDelete = '0';"
                ElseIf id = 2 Then
                    'Cek Password
                    QueryString = "SELECT pid from uspr000 where UserID = '" & LoginInput.username & "' and Userpassword = '" & LoginInput.password & "' AND current_time() BETWEEN StartDate AND EndDate AND FlagDelete = '0';"
                ElseIf id = 3 Then
                    'Cek First Login
                    QueryString = "SELECT isNew FROM uspr000 WHERE UserID = '" & LoginInput.username & "' AND current_time() BETWEEN StartDate AND EndDate AND FlagDelete = '0';"
                End If
            Case "Logout"
                If id = 1 Then
                    QueryString = "UPDATE `setup_log` SET `isActive`='0' WHERE `login_token`='" & parameter & "' AND `isActive`='1' "
                End If
            Case "ErrorLog"
                Dim ErrorInput As New CustomModel.ErrorLogInput
                If Not IsNothing(obj) Then ErrorInput = obj

                If id = 1 Then
                    QueryString = "INSERT INTO `setup_error_log` (`module_name`, `sub_name`, `error_message`, `sql_error_message`, `trans_date`, `username`, `ip`) VALUES ('" & ErrorInput.modulename & "', '" & ErrorInput.subname & "', '" & ErrorInput.errormsg & "', '" & ErrorInput.sqlmsg & "', '" & Now.Date & "', '" & ErrorInput.username & "', '" & ErrorInput.ip & "');"
                End If
            Case "Site Master"
                Dim MenuInput As New CustomModel.MenuInput
                If Not IsNothing(obj) Then MenuInput = obj

                If id = 1 Then          'Parent Menu
                    QueryString = "SELECT A.MenuID, A.Stext, A.UrlPath, A.Style FROM grpr004 A " &
                                  "INNER JOIN uspr001 B ON A.MenuID = B.MenuID AND current_time() BETWEEN B.CreateDate AND B.EndDate  " &
                                  "WHERE current_time() BETWEEN A.StartDate AND A.EndDate AND " &
                                  "B.UserID = '" & MenuInput.UserName & "' AND LEVEL = 1 AND Display = '1'" &
                                  "ORDER BY CAST(MenuSeq AS UNSIGNED);"
                ElseIf id = 2 Then      'Child Menu
                    QueryString = "SELECT A.MenuID, A.Stext, UrlPath FROM grpr004 A " &
                                  "INNER JOIN uspr001 B ON A.MenuID = B.MenuID AND current_time() BETWEEN B.CreateDate AND B.EndDate  " &
                                  "WHERE current_time() BETWEEN A.StartDate AND A.EndDate AND " &
                                  "B.UserID = '" & MenuInput.UserName & "' AND LEVEL = 2 AND Display = '1' AND A.ParentID = '" & MenuInput.ParentID & "' " &
                                  "ORDER BY CAST(MenuSeq AS UNSIGNED);"
                ElseIf id = 3 Then      'GChild Menu
                    QueryString = "SELECT A.MenuID, A.Stext, UrlPath FROM grpr004 A " &
                                  "INNER JOIN uspr001 B ON A.MenuID = B.MenuID AND current_time() BETWEEN B.CreateDate AND B.EndDate  " &
                                  "WHERE current_time() BETWEEN A.StartDate AND A.EndDate AND " &
                                  "B.UserID = '" & MenuInput.UserName & "' AND LEVEL = 3 AND Display = '1' AND A.ParentID = '" & MenuInput.ParentID & "' " &
                                  "ORDER BY CAST(MenuSeq AS UNSIGNED);"
                ElseIf id = 4 Then      'GGChild Menu
                    QueryString = "SELECT A.MenuID, A.Stext, UrlPath FROM grpr004 A " &
                                  "INNER JOIN uspr001 B ON A.MenuID = B.MenuID AND current_time() BETWEEN B.CreateDate AND B.EndDate  " &
                                  "WHERE current_time() BETWEEN A.StartDate AND A.EndDate AND " &
                                  "B.UserID = '" & MenuInput.UserName & "' AND LEVEL = 4 AND Display = '1' AND A.ParentID = '" & MenuInput.ParentID & "' " &
                                  "ORDER BY CAST(MenuSeq AS UNSIGNED);"
                End If

            Case "Pengaturan Pengguna"


                If id = 1 Then  ' Create New
                    QueryString = "INSERT INTO `uspr000` (`UserID`, `StartDate`, `EndDate`, `Userpassword`, `Username`, `Usertitle`, `Usermail`, `Userimage`, `LastLogin`, `LastMenu`, `isNew`, `isLock`, `FlagDelete`, `Creator`, `CreateDate`) VALUES ('IME-HAYKAL', '2017-01-01', '9999-12-31', '12345', 'Haykal Afif', 'Programmer', 'hkl@xxx.com', 'ime-hkl.png', '2017-01-01', 'xxxx', 'Y', 'N', '0', 'System', '2017-01-01');"
                ElseIf id = 2 Then

                End If

            Case "Hak Akses Pengguna"
                If id = 1 Then  ' Select Area Functional Combo
                    QueryString = "SELECT Stext,FunctionalArea FROM grpr000 WHERE FlagDelete = 0 AND current_date() BETWEEN StartDate AND EndDate;"
                ElseIf id = 2 Then  ' Select Sub Area By Area
                    QueryString = "SELECT Stext,FunctionalSubarea FROM grpr001 WHERE FlagDelete = 0 AND current_date() BETWEEN StartDate AND EndDate AND FunctionalArea = 'ES';"
                ElseIf id = 3 Then  ' Select Type
                    QueryString = "SELECT FunctionalType, Stext FROM grpr002 WHERE FlagDelete = 0 AND current_date() BETWEEN StartDate AND EndDate;"
                ElseIf id = 4 Then ' Save
                    QueryString = "INSERT INTO `uspr001` (`UserID`, `StartDate`, `EndDate`, `MenuID`, `Create`, `Edit`, `Delete`, `Display`, `Approve`, `Cancel`, `Print`, `Upload`, `FlagDelete`, `Creator`, `CreateDate`) VALUES ('IME-HAYKAL', '2017-01-01', '9999-12-31', 'DB000', '1', '1', '1', '1', '1', '1', '1', '1', '0', 'System', '2017-01-01');"
                End If

            Case "Master Area"
                Dim AreaInput As New CustomModel.AreaInput
                If Not IsNothing(obj) Then AreaInput = obj

                If id = 0 Then
                    QueryString = "Select PID, FunctionalArea, StartDate, EndDate, Stext, Description FROM grpr000 WHERE  PID LIKE '%" & parameter & "%'"
                ElseIf id = 1 Then  'Select Area
                    QueryString = "SELECT PID, FunctionalArea, StartDate, EndDate, Stext, Description FROM grpr000 WHERE PID = '" & parameter & "';"
                ElseIf id = 2 Then  'Save Area
                    QueryString = "INSERT INTO `grpr000` (`FunctionalArea`, `StartDate`, `EndDate`, `Stext`, `Description`, `FlagDelete`, `Creator`, `CreateDate`) VALUES ('" & AreaInput.functional_area & "', '" & AreaInput.start_date.ToString("yyyy-MM-dd hh:mm:ss") & "', '" & AreaInput.end_date.ToString("yyyy-MM-dd hh:mm:ss") & "', '" & AreaInput.stext & "', '" & AreaInput.ltext & "', '0', 'Admin', '" & Now.Date.ToString("yyyy-MM-dd hh:mm:ss") & "');"
                ElseIf id = 3 Then  'UPDATE
                    QueryString = "UPDATE `grpr000` SET `FunctionalArea` = '" & AreaInput.functional_area & "'where `pid` = '" & AreaInput.area_id & "';"
                End If

            Case "Daftar Menu"
                QueryString = "INSERT INTO `grpr004` (`MenuID`, `StartDate`, `EndDate`, `MenuSeq`, `FunctionalArea`, `FunctionalSubArea`, `FunctionalType`, `Stext`, `Description`, `Level`, `ParentID`, `UrlPath`, `FlagDelete`, `Creator`, `CreateDate`) VALUES ('DB0000', '2017-01-01 00:00:00', '9999-12-31 00:00:00', '01', null, null, null, 'Dashboard', 'Menu Dashboard', '1', null, null, '0', 'System', '2017-01-01 00:00:00');"

            Case "Mastertipebank"
                Dim MastertypebankInput As New CustomModel.MastertypebankInput
                If Not IsNothing(obj) Then MastertypebankInput = obj
                If id = 1 Then
                    QueryString = "SELECT PID as 'id', CompanyCode as 'name', Ltext as 'desc'  FROM hrom001;"
                ElseIf id = 2 Then 'Save Mastertypebank
                    QueryString = "INSERT INTO `fiba001` (`CompanyCode`, `BankTypeCode`, `StartDate`, `EndDate`, `SText`, `LText`, `FlagDelete`, `Creator`, `Createdate`, `Editor`, `EditDate`) VALUES ('" & MastertypebankInput.Companycode & "', '" & MastertypebankInput.jenis_rekening & "', '" & MastertypebankInput.start_date.ToString("yyyy-MM-dd hh:mm:ss") & "', '" & MastertypebankInput.end_date.ToString("yyyy-MM-dd hh:mm:ss") & "', '" & MastertypebankInput.stext & "', '" & MastertypebankInput.ltext & "', '0', 'ADMIN', '" & Now.Date.ToString("yyyy-MM-dd hh:mm:ss") & "', '0', '" & Now.Date.ToString("yyyy-MM-dd hh:mm:ss") & "');"
                ElseIf id = 3 Then
                    QueryString = "SELECT PID, BankTypeCode,StartDate,EndDate,CompanyCode,SText,LText  FROM FIBA001 WHERE PID LIKE '%" & parameter & "%'"
                ElseIf id = 4 Then  'UPDATE
                    QueryString = "UPDATE `FIBA001` SET `EndDate` = '" & MastertypebankInput.end_date.ToString("yyyy-MM-dd") & "', `BankTypeCode` = '" & MastertypebankInput.jenis_rekening & "', `SText` = '" & MastertypebankInput.stext & "', `LText` = '" & MastertypebankInput.ltext & "' where `pid` = '" & MastertypebankInput.mastertypebak_id & "';"
                ElseIf id = 5 Then
                    QueryString = "SELECT PID, BankTypeCode,StartDate,EndDate,CompanyCode,SText,LText  FROM FIBA001 WHERE  PID = '" & parameter & "'"
                End If
            Case "View Tipe Bank"
                Dim SearchInput As New CustomModel.SearchInput
                If Not IsNothing(obj) Then SearchInput = obj
                If id = 1 Then
                    QueryString = "SELECT PID, BankTypeCode,StartDate,EndDate,CompanyCode,SText,LText  FROM FIBA001 WHERE PID LIKE '%" & SearchInput.id & "%' and '" & SearchInput.start_date.ToString("yyyy-MM-dd") & "' BETWEEN StartDate AND EndDate;"
                End If
            Case "daftarbank"
                Dim daftarbankInput As New CustomModel.DaftarbankInput
                If Not IsNothing(obj) Then daftarbankInput = obj
                If id = 1 Then
                    QueryString = "SELECT PID as 'id', CompanyCode as 'name', Ltext as 'desc'  FROM hrom001;"
                ElseIf id = 2 Then 'Save 
                    QueryString = "INSERT INTO `fiba002` (`CompanyCode`, `BankKeyCode`, `StartDate`, `EndDate`, `SText`, `LText`,`BankCode`, `FlagDelete`, `Creator`, `Createdate`, `Editor`, `EditDate`) VALUES ('" & daftarbankInput.Companycode & "', '" & daftarbankInput.KodeBankKey & "', '" & daftarbankInput.start_date.ToString("yyyy-MM-dd hh:mm:ss") & "', '" & daftarbankInput.end_date.ToString("yyyy-MM-dd hh:mm:ss") & "', '" & daftarbankInput.stext & "', '" & daftarbankInput.ltext & "', '" & daftarbankInput.KodeBI & "', '0', 'ADMIN', '" & Now.Date.ToString("yyyy-MM-dd hh:mm:ss") & "', '0', '" & Now.Date.ToString("yyyy-MM-dd hh:mm:ss") & "');"
                ElseIf id = 3 Then
                    QueryString = "SELECT PID, CompanyCode,BankKeyCode,StartDate,EndDate,BankCode,SText,LText  FROM FIBA002 WHERE PID LIKE '%" & parameter & "%'"
                ElseIf id = 4 Then  'UPDATE
                    QueryString = "UPDATE `FIBA002` SET `EndDate` = '" & daftarbankInput.end_date.ToString("yyyy-MM-dd") & "', `BankCode` = '" & daftarbankInput.KodeBI & "', `SText` = '" & daftarbankInput.stext & "', `LText` = '" & daftarbankInput.ltext & "' where `pid` = '" & daftarbankInput.daftarbankinput_id & "';"
                ElseIf id = 5 Then
                    QueryString = "Select PID, CompanyCode,BankKeyCode,StartDate,EndDate,SText,LText,BankCode FROM FIBA002 WHERE  PID = '" & parameter & "'"

                End If
            Case "View Daftar Bank"
                Dim SearchInput As New CustomModel.SearchInput
                If Not IsNothing(obj) Then SearchInput = obj
                If id = 1 Then
                    QueryString = "SELECT PID, CompanyCode,BankKeyCode,StartDate,EndDate,BankCode,SText,LText  FROM FIBA002 WHERE PID LIKE '%" & SearchInput.id & "%' and '" & SearchInput.start_date.ToString("yyyy-MM-dd") & "' BETWEEN StartDate AND EndDate;"
                End If

            Case "Mastertipeaktifitas"
                Dim MastertypeactivityInput As New CustomModel.MastertypeactivityInput
                If Not IsNothing(obj) Then MastertypeactivityInput = obj
                If id = 1 Then
                    'QueryString = "SELECT PID as 'id', CompanyCode as 'name', Ltext as 'desc'  FROM fiba007;"
                    'QueryString = "SELECT A.PID as 'id', A.CompanyCode as 'name', B.Ltext as 'desc'  FROM fiba007 A Left Join hrom001 B ON A.CompanyCode = B.CompanyCode;"
                    QueryString = "SELECT PID as 'id', CompanyCode as 'name', Ltext as 'desc'  FROM hrom001;"
                ElseIf id = 2 Then 'Save Mastertypeactivity
                    QueryString = "INSERT INTO `fiba007` (`CompanyCode`, `ComodityCode`, `ActivityGroup`, `StartDate`, `EndDate`, `SText`, `LText`, `FlagDelete`, `Creator`, `Createdate`, `Editor`, `EditDate`) VALUES ('" & MastertypeactivityInput.Companycode & "', '" & MastertypeactivityInput.jenis_komoditi & "', '" & MastertypeactivityInput.grup_aktifitas & "', '" & MastertypeactivityInput.start_date.ToString("yyyy-MM-dd hh:mm:ss") & "', '" & MastertypeactivityInput.end_date.ToString("yyyy-MM-dd hh:mm:ss") & "', '" & MastertypeactivityInput.stext & "', '" & MastertypeactivityInput.ltext & "', '0', 'ADMIN', '" & Now.Date.ToString("yyyy-MM-dd hh:mm:ss") & "', '0', '" & Now.Date.ToString("yyyy-MM-dd hh:mm:ss") & "');"
                ElseIf id = 3 Then
                    QueryString = "SELECT PID, ComodityCode, ActivityGroup, StartDate, EndDate, CompanyCode, SText, LText  FROM FIBA007 WHERE PID LIKE '%" & parameter & "%'"
                ElseIf id = 4 Then  'UPDATE
                    QueryString = "UPDATE `FIBA007` SET `EndDate` = '" & MastertypeactivityInput.end_date.ToString("yyyy-MM-dd") & "', `ComodityCode` = '" & MastertypeactivityInput.jenis_komoditi & "', `ActivityGroup` = '" & MastertypeactivityInput.grup_aktifitas & "', `SText` = '" & MastertypeactivityInput.stext & "', `LText` = '" & MastertypeactivityInput.ltext & "' where `pid` = '" & MastertypeactivityInput.mastertypeaktif_id & "';"
                ElseIf id = 5 Then
                    QueryString = "SELECT PID, ComodityCode, ActivityGroup, StartDate, EndDate, CompanyCode ,SText ,LText  FROM FIBA007 WHERE  PID = '" & parameter & "'"
                End If



        End Select



        GetQuery = QueryString
    End Function
End Class

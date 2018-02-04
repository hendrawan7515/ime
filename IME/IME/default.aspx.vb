Imports System.Data
Imports IME.DataModel
Imports IME.CustomModel
Imports System.Web.Services

Public Class _default
    Inherits System.Web.UI.Page

    Public Shared SQLQuery As New QueryList
    Public Shared UserID As New HttpCookie("UserID")



    <WebMethod>
    Public Shared Function CheckAccountLock() As String




        Return SQLQuery.GetScalar("", 1,)
    End Function

    <WebMethod>
    Public Shared Function CheckPassword() As String

        Dim ds As New DataSet
        'ds = SQLQuery.GetDataSet("Site Master", 1, MenuInput)
        Return ""
    End Function

    <WebMethod>
    Public Shared Function CheckFirstLogin() As String


        'ds = SQLQuery.GetDataSet("Site Master", 1, MenuInput)
        Return ""
    End Function

End Class
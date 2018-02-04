Imports System.Data
Imports IME.DataModel
Imports IME.CustomModel
Imports System.Web.Services

Public Class hak_akses
    Inherits System.Web.UI.Page

    Public Shared SQLQuery As New QueryList
    Public Shared UserID As New HttpCookie("UserID")





    <WebMethod>
    Public Shared Function SaveArea(input As Master_Area) As Integer
        Dim return_int As Integer
        return_int = SQLQuery.ExecuteQuery("Master Area", 2, input)

        Return return_int
    End Function

End Class
Public Class test
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


    <System.Web.Services.WebMethod()>
    Public Shared Function GetCurrentTime(name As String) As String
        Dim message As String = "Hello "
        message &= name
        message &= vbCrLf & "Current Time: "
        message &= DateTime.Now.ToString()
        Return message
    End Function


End Class
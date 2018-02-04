Public Class logout
    Inherits System.Web.UI.Page
    Private SQLQuery As New QueryList

#Region "Function"
    Private Sub RemoveToken(ByVal Token As String)
        SQLQuery.ExecuteQuery("Logout", 1,, Token)
    End Sub
#End Region

#Region "Event"
#Region "Page"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        On Error Resume Next
        Dim _UserID As HttpCookie = Request.Cookies("UserID")
        RemoveToken(_UserID.Value)
        _UserID.Value = ""
        _UserID.Expires = DateTime.Now.AddHours(-1.0)
        Response.Cookies.Add(_UserID)

        Response.Redirect("default.aspx", False)
    End Sub
#End Region
#End Region


End Class
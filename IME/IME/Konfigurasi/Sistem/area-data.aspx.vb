Imports System.Data
Imports IME.DataModel
Imports IME.CustomModel
Imports System.Web.Services

Public Class area_data
    Inherits System.Web.UI.Page
    Public Shared SQLQuery As New QueryList
    Public Shared UserID As New HttpCookie("UserID")
    Public Shared id As String = ""

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            id = Request.Params("id")
        End If
    End Sub

    <WebMethod>
    Public Shared Function InitializeData() As AreaInput
        Dim data As New AreaInput
        If id <> "" Then

            Dim ds As New DataSet
            ds = SQLQuery.GetDataSet("Master Area", 1, , id)

            For Each Row As DataRow In ds.Tables(0).Rows
                data.area_id = id
                data.functional_area = Row.Item("FunctionalArea")
                data.stext = Row.Item("SText")
                data.ltext = Row.Item("Description")
                data.start_date = Row.Item("StartDate").ToString
                data.end_date = Row.Item("EndDate").ToString
            Next
        End If
        Return data
    End Function

    <WebMethod>
    Public Shared Function SaveArea(input As AreaInput) As Integer
        Dim return_int As Integer
        If id Is Nothing Then
            return_int = SQLQuery.ExecuteQuery("Master Area", 2, input)
        Else
            return_int = SQLQuery.ExecuteQuery("Master Area", 3, input)
        End If

        Return return_int
    End Function

    <WebMethod>
    Public Shared Function DeleteArea(input As List(Of AreaInput)) As Integer
        Dim return_int As Integer
        'loop id

        Dim ids As String = ""
        return_int = SQLQuery.ExecuteQuery("Master Area", 2, , ids)

        Return return_int
    End Function



End Class
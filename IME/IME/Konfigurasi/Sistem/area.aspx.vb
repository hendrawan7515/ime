Imports System.Data
Imports IME.DataModel
Imports IME.CustomModel
Imports System.Web.Services

Public Class area
    Inherits System.Web.UI.Page
    Public Shared SQLQuery As New QueryList
    Public Shared UserID As New HttpCookie("UserID")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


    <WebMethod>
    Public Shared Function InitializeData() As List(Of AreaInput)
        Dim datas As New List(Of AreaInput)

        Dim ds As New DataSet
        ds = SQLQuery.GetDataSet("Master Area", 0)

        For Each Row As DataRow In ds.Tables(0).Rows
            Dim data As New AreaInput

            data.area_id = Row.Item("PID")
            data.functional_area = Row.Item("FunctionalArea")
            data.stext = Row.Item("SText")
            data.ltext = Row.Item("Description")
            data.start_date = Row.Item("StartDate")
            data.end_date = Row.Item("EndDate")

            datas.Add(data)
        Next
        Return datas
    End Function

    <WebMethod>
    Public Shared Function SearchData(id As String) As List(Of AreaInput)
        Dim datas As New List(Of AreaInput)

        Dim ds As New DataSet
        ds = SQLQuery.GetDataSet("Master Area", 0,, id)

        For Each Row As DataRow In ds.Tables(0).Rows
            Dim data As New AreaInput

            data.area_id = Row.Item("PID")
            data.functional_area = Row.Item("FunctionalArea")
            data.stext = Row.Item("SText")
            data.ltext = Row.Item("Description")
            data.start_date = Row.Item("StartDate")
            data.end_date = Row.Item("EndDate")

            datas.Add(data)
        Next
        Return datas
    End Function

End Class
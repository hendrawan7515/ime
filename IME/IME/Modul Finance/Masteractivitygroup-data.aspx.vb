Imports System.Data
Imports IME.DataModel
Imports IME.CustomModel
Imports System.Web.Services

Public Class Masteractivitygroup_data
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
    Public Shared Function GetComboData() As List(Of ComboData)
        Dim datas As New List(Of ComboData)


        Dim ds As New DataSet
        ds = SQLQuery.GetDataSet("Mastertipeaktifitas", 1)

        For Each Row As DataRow In ds.Tables(0).Rows
            Dim data As New ComboData
            data.id = Row.Item("name")
            data.name = Row.Item("name") + ":" + Row.Item("desc")
            datas.Add(data)
        Next
        Return datas
    End Function

    <WebMethod>
    Public Shared Function Save(input As MastertypeactivityInput) As Integer
        Dim return_int As Integer
        If id Is Nothing Then
            return_int = SQLQuery.ExecuteQuery("Mastertipeaktifitas", 2, input)
        Else
            return_int = SQLQuery.ExecuteQuery("Mastertipeaktifitas", 4, input)
        End If
        Return return_int
    End Function
    <WebMethod>
    Public Shared Function InitializeData() As MastertypeactivityInput
        Dim data As New MastertypeactivityInput
        If id <> "" Then

            Dim ds As New DataSet
            ds = SQLQuery.GetDataSet("Mastertipeaktifitas", 5, , id)

            For Each Row As DataRow In ds.Tables(0).Rows
                data.mastertypeaktif_id = id
                data.jenis_komoditi = Row.Item("ComodityCode")
                data.grup_aktifitas = Row.Item("ActivityGroup")
                'data.Companycode = Row.Item("CompanyCode")
                data.stext = Row.Item("SText")
                data.ltext = Row.Item("LText")
                data.start_date = Row.Item("StartDate").ToString
                data.end_date = Row.Item("EndDate").ToString
            Next
        End If
        Return data
    End Function



End Class
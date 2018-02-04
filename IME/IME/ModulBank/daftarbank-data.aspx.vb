Imports System.Data
Imports IME.DataModel
Imports IME.CustomModel
Imports System.Web.Services

Public Class daftarbank_data
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
    Public Shared Function InitializeData() As DaftarbankInput
        Dim data As New DaftarbankInput
        If id <> "" Then

            Dim ds As New DataSet
            ds = SQLQuery.GetDataSet("daftarbank", 5, , id)

            For Each Row As DataRow In ds.Tables(0).Rows
                data.daftarbankinput_id = id
                data.Companycode = Row.Item("CompanyCode")
                data.KodeBankKey = Row.Item("BankKeyCode")
                data.KodeBI = Row.Item("BankCode")
                data.stext = Row.Item("SText")
                data.ltext = Row.Item("LText")
                data.start_date = Row.Item("StartDate").ToString
                data.end_date = Row.Item("EndDate").ToString
            Next
        End If
        Return data
    End Function
    <WebMethod>
    Public Shared Function GetComboData() As List(Of ComboData)
        Dim datas As New List(Of ComboData)


        Dim ds As New DataSet
        ds = SQLQuery.GetDataSet("daftarbank", 1)

        For Each Row As DataRow In ds.Tables(0).Rows
            Dim data As New ComboData
            data.id = Row.Item("name")
            data.name = Row.Item("name") + ":" + Row.Item("desc")
            datas.Add(data)
        Next
        Return datas
    End Function
    <WebMethod>
    Public Shared Function Save(input As DaftarbankInput) As Integer
        Dim return_int As Integer
        If id Is Nothing Then
            return_int = SQLQuery.ExecuteQuery("daftarbank", 2, input)
        Else
            return_int = SQLQuery.ExecuteQuery("daftarbank", 4, input)
        End If
        Return return_int
    End Function
End Class


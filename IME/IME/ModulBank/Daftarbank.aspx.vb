Imports System.Data
Imports IME.DataModel
Imports IME.CustomModel
Imports System.Web.Services

Public Class Daftarbank
    Inherits System.Web.UI.Page
    Public Shared SQLQuery As New QueryList
    Public Shared UserID As New HttpCookie("UserID")
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    <WebMethod>
    Public Shared Function InitializeData() As List(Of DaftarbankInput)
        Dim datas As New List(Of DaftarbankInput)

        Dim ds As New DataSet
        ds = SQLQuery.GetDataSet("daftarbank", 3)

        For Each Row As DataRow In ds.Tables(0).Rows
            Dim data As New DaftarbankInput

            data.daftarbankinput_id = Row.Item("PID")
            data.Companycode = Row.Item("Companycode")
            data.KodeBankKey = Row.Item("BankKeyCode")
            data.KodeBI = Row.Item("BankCode")
            data.stext = Row.Item("SText")
            data.ltext = Row.Item("LText")
            data.start_date = Row.Item("StartDate")
            data.end_date = Row.Item("EndDate")

            datas.Add(data)
        Next
        Return datas
    End Function

    <WebMethod>
    Public Shared Function SearchData(input As SearchInput) As List(Of DaftarbankInput)
        Dim datas As New List(Of DaftarbankInput)

        Dim ds As New DataSet
        'ds = SQLQuery.GetDataSet("Mastertipebank", 3, input)
        ds = SQLQuery.GetDataSet("View Daftar Bank", 1, input)
        For Each Row As DataRow In ds.Tables(0).Rows
            Dim data As New DaftarbankInput

            data.daftarbankinput_id = Row.Item("PID")
            data.Companycode = Row.Item("Companycode")
            data.KodeBankKey = Row.Item("BankKeyCode")
            data.KodeBI = Row.Item("BankCode")
            data.stext = Row.Item("SText")
            data.ltext = Row.Item("LText")
            data.start_date = Row.Item("StartDate")
            data.end_date = Row.Item("EndDate")


            datas.Add(data)
        Next
        Return datas
    End Function
End Class
Imports IME.DataModel
Imports IME.CustomModel
Imports System.Web.Services

Public Class Site
    Inherits System.Web.UI.MasterPage
    Private SQLQuery As New QueryList
    Private UserID As New HttpCookie("UserID")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            GetParent()
        End If
    End Sub

    Private Function GetParent() As List(Of ParentMenuList)
        Dim username As String
        username = "IME-HAYKAL"

        Dim menuInput As New MenuInput
        menuInput.UserName = username

        Dim ds As New DataSet
        ds = SQLQuery.GetDataSet("Site Master", 1, menuInput)

        Dim parents As New List(Of ParentMenuList)
        For Each Row As DataRow In ds.Tables(0).Rows
            Dim parent As New ParentMenuList
            parent.name = Row.Item("SText")
            parent.url = Row.Item("UrlPath")

            Dim childMenu As New MenuInput
            childMenu.ParentID = Row.Item("MenuID")
            childMenu.UserName = username

            Dim dsChild As New DataSet
            dsChild = SQLQuery.GetDataSet("Site Master", 2, childMenu)

            Dim childs As New List(Of ChildMenuList)
            For Each cRow As DataRow In dsChild.Tables(0).Rows
                Dim child As New ChildMenuList
                child.name = cRow.Item("SText")
                child.url = cRow.Item("UrlPath")

                Dim gchildMenu As New MenuInput
                childMenu.ParentID = cRow.Item("MenuID")
                childMenu.UserName = username

                Dim dsGChild As New DataSet
                dsGChild = SQLQuery.GetDataSet("Site Master", 3, gchildMenu)

                Dim gchilds As New List(Of GChildMenuList)
                For Each cgRow As DataRow In dsGChild.Tables(0).Rows
                    Dim gchild As New GChildMenuList
                    gchild.name = cgRow.Item("SText")
                    gchild.url = cgRow.Item("UrlPath")

                    Dim ggchildMenu As New MenuInput
                    ggchildMenu.ParentID = cgRow.Item("MenuID")
                    ggchildMenu.UserName = username

                    Dim dsGGChild As New DataSet
                    dsGGChild = SQLQuery.GetDataSet("Site Master", 4, ggchildMenu)

                    Dim ggchilds As New List(Of GGChildMenuList)
                    For Each cggRow As DataRow In dsGGChild.Tables(0).Rows
                        Dim ggchild As New GGChildMenuList
                        ggchild.name = cggRow.Item("SText")
                        ggchild.url = cggRow.Item("UrlPath")

                        ggchilds.Add(ggchild)
                    Next
                    gchild.ggchild = ggchilds
                    gchilds.Add(gchild)
                Next
                child.gchild = gchilds
                childs.Add(child)
            Next
            parent.child = childs
            parents.Add(parent)
        Next
        Return parents
    End Function
End Class
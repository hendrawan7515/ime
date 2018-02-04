
Imports System
Imports System.Collections.Generic


Namespace DataModel
    Partial Public Class Master_Menu
        Public Property menu_id As Integer
        Public Property menu_name As String
        Public Property menu_level As Nullable(Of SByte)
        Public Property menu_parent_id As Nullable(Of Integer)
        Public Property menu_order As Nullable(Of SByte)
        Public Property module_id As Nullable(Of Integer)
        Public Property menu_url As String
        Public Property isActive As Nullable(Of Boolean)
    End Class

    Partial Public Class Master_AccessRight
        Public Property access_right_id As Integer
        Public Property access_right As String
        Public Property description As String
        Public Property isActive As Nullable(Of Boolean)
    End Class

    Partial Public Class Master_Area
        Public Property area_id As Integer
        Public Property functional_area As String
        Public Property stext As String
        Public Property ltext As String
        Public Property start_date As DateTime
        Public Property end_date As DateTime
    End Class


    Partial Public Class ParentMenuList
        Public Property name As String
        Public Property url As String
        Public Property style As String
        Public Property child As List(Of ChildMenuList)
    End Class

    Partial Public Class ChildMenuList
        Public Property name As String
        Public Property url As String
        Public Property gchild As List(Of GChildMenuList)
    End Class

    Partial Public Class GChildMenuList
        Public Property name As String
        Public Property url As String
        Public Property ggchild As List(Of GGChildMenuList)
    End Class

    Partial Public Class GGChildMenuList
        Public Property name As String
        Public Property url As String
    End Class

End Namespace
Namespace CustomModel
    Partial Public Class ErrorLogInput
        Public Property modulename As Integer
        Public Property subname As String
        Public Property errormsg As String
        Public Property sqlmsg As Integer
        Public Property username As String
        Public Property ip As String
    End Class

    Partial Public Class LoginInput
        Public Property username As String
        Public Property password As String
    End Class

    Partial Public Class MenuInput
        Public Property UserName As String
        Public Property ParentID As String
    End Class

    Partial Public Class ComboData
        Public Property id As String
        Public Property name As String
        Public Property company As String
    End Class

    Partial Public Class SearchInput
        Public Property id As String
        Public Property start_date As Date
        Public Property end_date As Date
    End Class

    Partial Public Class AreaInput
        Public Property area_id As Integer
        Public Property functional_area As String
        Public Property stext As String
        Public Property ltext As String
        Public Property start_date As DateTime
        Public Property end_date As DateTime
    End Class
    Partial Public Class DaftarbankInput
        Public Property daftarbankinput_id As Integer
        Public Property Companycode As String
        Public Property KodeBankKey As String
        Public Property KodeBI As String
        Public Property stext As String
        Public Property ltext As String
        Public Property start_date As DateTime
        Public Property end_date As DateTime
    End Class
    Partial Public Class MastertypebankInput
        Public Property mastertypebak_id As Integer
        Public Property Companycode As String
        Public Property jenis_rekening As String
        Public Property stext As String
        Public Property ltext As String
        Public Property start_date As DateTime
        Public Property end_date As DateTime
    End Class
    Partial Public Class MastertypeactivityInput
        Public Property mastertypeaktif_id As Integer
        Public Property Companycode As String
        Public Property jenis_komoditi As String
        Public Property grup_aktifitas As String
        Public Property stext As String
        Public Property ltext As String
        Public Property start_date As DateTime
        Public Property end_date As DateTime
    End Class
End Namespace


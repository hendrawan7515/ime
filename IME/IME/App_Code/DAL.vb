Imports System.Data
Imports System.Configuration
Imports System.Data.SqlClient.SqlConnection
Imports MySql.Data.MySqlClient

Public Class DAL
    Private Key As String = "k*&83u8J(*h6G^&WD98oj2"
    'Public MySQLConnection As String = DecryptData(ConfigurationManager.ConnectionStrings("AppsConnection").ConnectionString, Key)
    Public MySQLConnection As String = ConfigurationManager.ConnectionStrings("AppsConnection").ConnectionString


#Region "MySQL"
    Public Function ExecuteNonQuery(ByVal QueryString As String) As Integer
        Dim ResultInteger As Integer = 0
        Using ConnectionMySQL As New MySqlConnection(MySQLConnection)
            Using Command As New MySqlCommand(QueryString)
                ConnectionMySQL.Open()
                Using Transaction As MySqlTransaction = ConnectionMySQL.BeginTransaction()
                    Command.Connection = ConnectionMySQL
                    Command.Transaction = Transaction

                    Try
                        ResultInteger = Command.ExecuteNonQuery()
                        Transaction.Commit()
                    Catch sql As MySqlException
                        Transaction.Rollback()
                        CreateErrorLog("DAL", "ExecuteNonQuery(" & QueryString & ") As Boolean",, sql.Message)
                    Catch ex As Exception
                        Transaction.Rollback()
                        CreateErrorLog("DAL", "ExecuteNonQuery(" & QueryString & ") As Boolean", ex.Message)
                    Finally
                        If ConnectionMySQL.State = ConnectionState.Open Then ConnectionMySQL.Close()
                    End Try
                End Using
            End Using
        End Using
        Return ResultInteger
    End Function


    Public Async Function ExecuteNonQueryAsync(ByVal QueryString As String) As Threading.Tasks.Task(Of Integer)
        Dim ResultInteger As Integer = 0
        Using ConnectionMySQL As New MySqlConnection(MySQLConnection)
            Using Command As New MySqlCommand(QueryString)
                ConnectionMySQL.Open()
                Using Transaction As MySqlTransaction = ConnectionMySQL.BeginTransaction()
                    Command.Connection = ConnectionMySQL
                    Command.Transaction = Transaction

                    Try
                        ResultInteger = Await Command.ExecuteNonQueryAsync()
                        Transaction.Commit()
                    Catch sql As MySqlException
                        Transaction.Rollback()
                        CreateErrorLog("DAL", "ExecuteNonQueryAsync(" & QueryString & ") As Threading.Tasks.Task(Of Integer)",, sql.Message)
                    Catch ex As Exception
                        Transaction.Rollback()
                        CreateErrorLog("DAL", "ExecuteNonQueryAsync(" & QueryString & ") As Threading.Tasks.Task(Of Integer)", ex.Message)
                    Finally
                        If ConnectionMySQL.State = ConnectionState.Open Then ConnectionMySQL.Close()
                    End Try
                End Using
            End Using
        End Using
        Return ResultInteger
    End Function

    Public Function GetScalar(ByVal QueryString As String) As String
        Dim ResultString = ""
        Using ConnectionMySQL As New MySqlConnection(MySQLConnection)
            Using Command As New MySqlCommand(QueryString)
                ConnectionMySQL.Open()
                Command.Connection = ConnectionMySQL

                Try
                    Using dr As MySqlDataReader = Command.ExecuteReader
                        While dr.Read
                            ResultString = dr(0).ToString
                        End While
                    End Using
                Catch sql As MySqlException
                    CreateErrorLog("DAL", "GetScalar(" & QueryString & ") As String",, sql.Message)
                Catch ex As Exception
                    CreateErrorLog("DAL", "GetScalar(" & QueryString & ") As String", ex.Message)
                Finally
                    If ConnectionMySQL.State = ConnectionState.Open Then ConnectionMySQL.Close()
                End Try
            End Using
        End Using
        Return ResultString
    End Function

    Public Function GetDataSet(ByVal QueryString As String) As DataSet
        Dim ResultDataSet As New DataSet
        Using ConnectionMySQL As New MySqlConnection(MySQLConnection)
            ConnectionMySQL.Open()
            Try
                Dim DBAdapter As New MySqlDataAdapter(QueryString, ConnectionMySQL)
                DBAdapter.Fill(ResultDataSet)
            Catch sql As MySqlException
                CreateErrorLog("DAL", "GetDataSet(" & QueryString & ") As DataSet",, sql.Message)
            Catch ex As Exception
                CreateErrorLog("DAL", "GetDataSet(" & QueryString & ") As DataSet", ex.Message)
            Finally
                If ConnectionMySQL.State = ConnectionState.Open Then ConnectionMySQL.Close()
            End Try
        End Using
        Return ResultDataSet
    End Function
#End Region

End Class

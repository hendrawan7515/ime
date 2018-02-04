Imports System.Security.Cryptography

Module GlobalModule
    Private SQLQuery As New QueryList

#Region "Encrypt TripleDes"
    Private Sub GenerateKeyIV(ByVal key As String, ByRef TripleDes As TripleDESCryptoServiceProvider)
        'Initialize the crypto provider
        TripleDes.Key = TruncateHash(key, TripleDes.KeySize / 8)
        TripleDes.IV = TruncateHash("", TripleDes.BlockSize / 8)
    End Sub

    Private Function TruncateHash(ByVal key As String, ByVal length As Integer) As Byte()
        Dim sha1 As New SHA1CryptoServiceProvider

        'Hash the key
        Dim keyBytes() As Byte = Encoding.Unicode.GetBytes(key)
        Dim hash() As Byte = sha1.ComputeHash(keyBytes)

        'Truncate or Pad the hash
        ReDim Preserve hash(length - 1)
        Return hash
    End Function

    Public Function EncryptData(ByVal plaintext As String, ByVal key As String) As String
        Try
            Dim TripleDes As New TripleDESCryptoServiceProvider
            GenerateKeyIV(key, TripleDes)

            'Convert plain text string to a byte array
            Dim plaintextByte() As Byte = Encoding.Unicode.GetBytes(plaintext)

            'Create the stream
            Dim ms As New System.IO.MemoryStream

            'Create the encoder to write to the stream
            Dim encStream As New CryptoStream(ms, TripleDes.CreateEncryptor(), CryptoStreamMode.Write)

            'Use the crypto stream to write the byte array to the stream
            encStream.Write(plaintextByte, 0, plaintextByte.Length)
            encStream.FlushFinalBlock()

            'Convert encrypted stream to a printable string
            Return Convert.ToBase64String(ms.ToArray)
        Catch ex As Exception
            CreateErrorLog("TripleDes", "EncryptData(" & plaintext & ", " & key & ") As String", ex.Message)
            Return ""
        End Try
    End Function

    Public Function DecryptData(ByVal encryptedtext As String, ByVal key As String) As String
        Try
            Dim TripleDes As New TripleDESCryptoServiceProvider
            GenerateKeyIV(key, TripleDes)

            ' Convert the encrypted text string to a byte array.
            Dim encryptedBytes() As Byte = Convert.FromBase64String(encryptedtext)

            ' Create the stream.
            Dim ms As New System.IO.MemoryStream
            ' Create the decoder to write to the stream.
            Dim decStream As New CryptoStream(ms,
                TripleDes.CreateDecryptor(),
                System.Security.Cryptography.CryptoStreamMode.Write)

            ' Use the crypto stream to write the byte array to the stream.
            decStream.Write(encryptedBytes, 0, encryptedBytes.Length)
            decStream.FlushFinalBlock()

            ' Convert the plaintext stream to a string.
            Return System.Text.Encoding.Unicode.GetString(ms.ToArray)
        Catch ex As Exception
            CreateErrorLog("TripleDes", "DecryptData(" & encryptedtext & ", " & key & ") As String", , ex.Message)
            Return ""
        End Try
    End Function

#End Region

    Public Sub CreateErrorLog(ByVal ModuleName As String, ByVal SubName As String, Optional ByVal ErrorMessage As String = "", Optional ByVal SQLErrorMessage As String = "", Optional ByVal UserName As String = "System", Optional ByVal IP As String = "::1")
        Dim ErrorInput As New CustomModel.ErrorLogInput
        Try
            With ErrorInput
                .modulename = ModuleName
                .subname = SubName
                .errormsg = ErrorMessage
                .sqlmsg = SQLErrorMessage
                .username = UserName
                .ip = IP
            End With

            SQLQuery.ExecuteQuery("ErrorLog", 1, ErrorInput)
        Catch ex As Exception
            ' Throws a new exception.
            Throw New System.Exception(ex.Message)
        End Try
    End Sub

End Module

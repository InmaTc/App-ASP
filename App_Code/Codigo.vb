Imports System.Data.SqlClient
Imports System.Data

Public Class Codigo

    ' Procedimiento para obtener un DataTable con todos los datos del usuario, a partir de su id
    ' El DataTable puede devolverse a Nothing, lo que implica que no ha sido posible encontrar los datos del usuario (no existe).
    Public Shared Function DataUser(ByVal id As String) As DataTable
        Return DataUser(id, Nothing)
    End Function


    ' Procedimiento para obtener un DataTable con todos los datos del usuario, a partir de su login y password.
    Public Shared Function DataUser(ByVal dato As String, ByVal pass As String) As DataTable
        Dim cnx As New SqlConnection(ConfigurationManager.ConnectionStrings("cervezasArtesanasCnx").ToString)
        Dim cmd As New SqlCommand() With {.Connection = cnx}

        cmd.CommandText = "select * from Usuario where login=@usuario and password=@pass"
        cmd.Parameters.AddWithValue("@usuario", dato)
        cmd.Parameters.Add("@pass", SqlDbType.VarChar, 20).Value = pass

        Dim dt As New DataTable
        Try
            Dim adt As New SqlDataAdapter(cmd)
            adt.Fill(dt)
        Catch
            dt = Nothing
        Finally
            cnx.Close()
            cnx.Dispose()
        End Try
        Return dt
    End Function

    ''' <summary>
    ''' Gestión de los roles
    ''' </summary>
    ''' 
    Public Shared Sub setRoles()
        ' Se llama desde el Global.asax, al comenzar la aplicación.
        ' Carga los roles disponibles desde la bbdd oretube a la base de datos aspnetdb.
        Dim conexion As String = ConfigurationManager.ConnectionStrings("cervezasArtesanasCnx").ToString
        Dim sentencia As String = "select id from Rol"
        Dim cnx As New SqlConnection(conexion)
        Dim dr As SqlDataReader
        Try
            Dim cmd As New SqlCommand(sentencia, cnx)
            cnx.Open()
            dr = cmd.ExecuteReader()
            While dr.Read
                If Not Roles.RoleExists(dr.GetInt32(0)) Then Roles.CreateRole(dr.GetInt32(0))
            End While
        Catch ex As SystemException
            Throw New System.Exception(ex.Message)
        Finally
            cnx.Close()
            cnx.Dispose()
        End Try
    End Sub

    Public Shared Function usuarioINrol(ByVal usuario As String, ByVal rol As String) As Boolean
        ' Añade un usuario a un rol.
        Dim ok As Boolean = True
        Try
            If Not My.User.IsInRole(rol) Then Roles.AddUserToRole(usuario, rol)
        Catch ex As Exception
            ok = False
        End Try
        Return ok
    End Function

    Public Shared Function removeUsuarioyRoles(ByVal usuario As String, ByVal _roles() As String) As Boolean
        ' Se elimina al usuario y a sus roles de la base de datos aspdbnet.
        Dim ok As Boolean = True
        Try
            Roles.RemoveUserFromRoles(usuario, _roles)
            Membership.DeleteUser(usuario)
        Catch ex As Exception
            ok = False
        End Try
        Return ok
    End Function


    Public Shared Function Redireccion(ByVal funcion As String) As String
        ' Se redirecciona a la página de inicio de cada rol.
        Dim pagina As String = Nothing
        Select Case funcion
            Case 4
                pagina = "~/PaginaPrincipal.aspx"
            Case 2
                pagina = "~/contenidos" & "/" & "publico" & "/" & "Productos.aspx"
            Case 1
                pagina = "~/contenidos" & "/" & "publico" & "/" & "Productos.aspx"
        End Select
        Return pagina
    End Function


    Public Shared Sub Salir()
        ' Se ejecuta al hacer clic sobre los botones "Cerrar Sesión" en las distintas páginas.

        ' Se elimina al usuario y a sus roles de aspdbnet.
        Codigo.removeUsuarioyRoles(HttpContext.Current.User.Identity.Name, Roles.GetRolesForUser(HttpContext.Current.User.Identity.Name))

        ' Se elimina el tique de validación.
        FormsAuthentication.SignOut()
        ' Se cancela la sesión actual.
        HttpContext.Current.Session.Clear()
        HttpContext.Current.Session.Abandon()

        ' A la página que contiene el formulario de inicio de sesión.
        ' HttpContext.Current.Response.Redirect("~/login.aspx")
        FormsAuthentication.RedirectToLoginPage()
    End Sub

End Class

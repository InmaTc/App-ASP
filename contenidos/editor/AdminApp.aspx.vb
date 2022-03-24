
Partial Class OcultoAdminApp
    Inherits System.Web.UI.Page

    Protected WithEvents miMaster As _Basica



    Private Sub OcultoAdminApp_Load(sender As Object, e As EventArgs) Handles Me.Load
        miMaster = Master

        miMaster.miMenu.Items.Clear() ' Limpiamos el existente
        gvEditarProductos.ChangeMode(FormViewMode.Insert)

        Dim opcion As New MenuItem
        opcion.Text = "Volver"
        opcion.NavigateUrl = "~/contenidos/publico/Productos.aspx"
        miMaster.miMenu.Items.Add(opcion)

        Dim cerrarSesion As New MenuItem
        cerrarSesion.Text = "Cerrar sesión"
        cerrarSesion.Value = "salir"
        miMaster.miMenu.Items.Add(cerrarSesion)


    End Sub

    Private Sub SqlDsEditarProductos_Inserting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDsEditarProductos.Inserting
        Dim editarNombre As TextBox = gvEditarProductos.FindControl("tbNombre")
        Dim editarDescripcion As TextBox = gvEditarProductos.FindControl("tbDesc")
        Dim editarUrlImg As TextBox = gvEditarProductos.FooterRow.FindControl("tbUrl")
        Dim urlImgVacia As String = "../../imagenes/productos/sp.jpg"

        e.Command.Parameters("@nombre").Value = editarNombre.Text
        e.Command.Parameters("@descripcion").Value = editarDescripcion.Text

        'Asignamos una imagen de avatar sin definir por si no nos introduce ninguna
        If editarUrlImg.Text = "" Then
            e.Command.Parameters("@url").Value = urlImgVacia
        Else
            e.Command.Parameters("@url").Value = "../../imagenes/productos/" & editarUrlImg.Text
        End If
    End Sub

    Private Sub SqlDsEditarProductos_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDsEditarProductos.Inserted
        Response.Redirect("~/contenidos/publico/Productos.aspx")
    End Sub

End Class

Imports System.Data
Partial Class OcultoProducto
    Inherits System.Web.UI.Page

    Protected WithEvents miMaster As _Basica

    Private Sub OcultoProducto_Load(sender As Object, e As EventArgs) Handles Me.Load

        'Guardo Session para recoger el id del producto seleccionado en la página anterior
        Session("idProducto") = Request.Params.Item("pasaridProducto").ToString()
        'Session("idProducto2") = Request.Params.Item("pasaridProducto").ToString()
        'fvProductoAmpliado.ChangeMode(FormViewMode.Insert)
        Session("dUsuario").Rows(0).item("idRol")

        'imgAvatarUsuarioActivo.ImageUrl = "~/imagenes/avatares/" & Session("avatar")


        fvGuardarComentarios.ChangeMode(FormViewMode.Insert)

        miMaster = Master

        miMaster.miMenu.Items.Clear() ' Limpiamos el existente

        Dim opcion As New MenuItem
        opcion.Text = "Volver"
        opcion.NavigateUrl = "~/contenidos/publico/Productos.aspx"
        miMaster.miMenu.Items.Add(opcion)


        Dim cerrarSesion As New MenuItem
        cerrarSesion.Text = "Cerrar sesión"
        cerrarSesion.Value = "salir"
        miMaster.miMenu.Items.Add(cerrarSesion)

    End Sub

    Private Sub fvGuardarComentarios_ItemInserted(sender As Object, e As FormViewInsertedEventArgs) Handles fvGuardarComentarios.ItemInserted
        Response.Redirect("~/contenidos/publico/Producto.aspx?pasaridProducto=" & Session("idProducto"))
    End Sub

    Protected Sub btGuardarComentario_Click(sender As Object, e As EventArgs)
        sqlDsGuardarComentario.Insert()
    End Sub

    Private Sub sqlDsGuardarComentario_Inserting(sender As Object, e As SqlDataSourceCommandEventArgs) Handles sqlDsGuardarComentario.Inserting
        Dim comentario As TextBox = fvGuardarComentarios.FindControl("tbComentario")
        e.Command.Parameters("@fecha").Value = Date.Now
        e.Command.Parameters("@texto").Value = comentario.Text
        e.Command.Parameters("@idProducto").Value = Session("idProducto")
        e.Command.Parameters("@idUsuario").Value = Session("dUsuario").Rows(0).item("id")
    End Sub

    Private Sub sqlDsGuardarComentario_Inserted(sender As Object, e As SqlDataSourceStatusEventArgs) Handles sqlDsGuardarComentario.Inserted
        'Response.Redirect(Request.RawUrl)
        Response.Redirect("~/contenidos/publico/Producto.aspx?pasaridProducto=" & Session("idProducto"))
    End Sub



End Class

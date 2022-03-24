
Partial Class OcultoRegistroUsuario
    Inherits System.Web.UI.Page

    Private Sub OcultoRegistroUsuario_Load(sender As Object, e As EventArgs) Handles Me.Load
        fvRegistro.ChangeMode(FormViewMode.Insert)
    End Sub


    Private Sub _Default_Init(sender As Object, e As EventArgs) Handles Me.Init
        If Request.IsAuthenticated Then ' Se recibe la cookie de validación permanente, previamente almacenada en el cliente.
            Response.Redirect("~/contenidos/publico/Productos.aspx")
        End If
    End Sub

    Private Sub fvRegistro_ItemInserted(sender As Object, e As FormViewInsertedEventArgs) Handles fvRegistro.ItemInserted
        Response.Redirect("~/contenidos/publico/Productos.aspx")
    End Sub

End Class

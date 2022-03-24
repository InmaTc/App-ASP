Imports System.Data
Partial Class OcultoProductos
    Inherits System.Web.UI.Page

    Protected WithEvents miMaster As _Basica

    Private Sub _Default_Load(sender As Object, e As EventArgs) Handles Me.Load
        miMaster = Master

        miMaster.miMenu.Items.Clear() ' Limpiamos el existente

        Dim cerrarSesion As New MenuItem
        cerrarSesion.Text = "Cerrar sesión"
        cerrarSesion.Value = "salir"
        miMaster.miMenu.Items.Add(cerrarSesion)
        If Session("dUsuario").Rows.Count > 0 Then
            If Session("dUsuario").Rows(0).item("idRol") = 2 Then
                Dim opcion As New MenuItem
                opcion.Text = "Añadir nuevo producto"
                opcion.NavigateUrl = "~/contenidos/editor/AdminApp.aspx"
                miMaster.miMenu.Items.Add(opcion)

            End If
        End If
    End Sub

End Class

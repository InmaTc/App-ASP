
Partial Class OcultoInicioSesion
    Inherits System.Web.UI.Page

    Private Sub Login_Init(sender As Object, e As EventArgs) Handles Me.Init
        If Request.IsAuthenticated Then
            Response.Redirect(Codigo.Redireccion(Roles.GetRolesForUser(User.Identity.Name)(0)))
        End If
    End Sub

    Protected Sub cvOk_ServerValidate(source As Object, args As ServerValidateEventArgs)
        Session("dUsuario") = Codigo.DataUser(tbUser.Text, tbPass.Text) ' Recuperación de los datos del usuario que intenta autenticarse. 
        ' Todos los datos del usuario se encuentran disponibles en el DataTable (Session("dUsuario"))
        If Session("dUsuario").Rows.Count > 0 Then ' Si el DataTable se devuelve con datos.
            Dim us = Session("dUsuario").Rows(0).item("id").ToString ' Guid a String. El GUID del usuario, almacenado en la base de datos, se utiliza como nombre de usuario en el vale de autenticacion con FormsAuthentication.

            ' Antes de empezar a trabajar, se borran sus datos anteriores de aspdbnet por si quedan residuos.
            Codigo.removeUsuarioyRoles(us, Roles.GetRolesForUser(us))

            args.IsValid = True ' Ok al CustomValidator.

            FormsAuthentication.RedirectFromLoginPage(us, ckRecordar.Checked)

            ' Añadimos el usuario al rol elegido (aspdbnet)
            Codigo.usuarioINrol(us, Session("dUsuario").Rows(0).item("idRol"))

            ' Redirección a su zona de trabajo en base a su rol
            Response.Redirect(Codigo.Redireccion(Roles.GetRolesForUser(us)(0)))
        Else
            args.IsValid = False ' No se encuentra al usuario, no se valida el formulario de inicio de sesión.
        End If
    End Sub

    Private Sub Login_Error(sender As Object, e As EventArgs) Handles Me.[Error]
        Server.ClearError()
        FormsAuthentication.RedirectToLoginPage()
    End Sub
End Class

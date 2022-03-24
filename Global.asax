<%@ Application Language="VB" %>

<script runat="server">

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        Codigo.setRoles()
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)

        If Request.IsAuthenticated Then
            If Session("dUsuario") = Nothing Then
                Session("dUsuario") = Codigo.DataUser(User.Identity.Name)
                ' Añadimos el usuario al rol elegido (aspdbnet)
                Codigo.usuarioINrol(User.Identity.Name, Session("dUsuario").Rows(0).item("idRol"))

                ' Redirección a su zona de trabajo en base a su rol
                Response.Redirect(Codigo.Redireccion(Roles.GetRolesForUser(User.Identity.Name)(0)))

                If Session("dUsuario").Rows.Count = 0 Then
                    Response.Redirect("~/contenidos/anonimo/InicioSesion.aspx")
                End If
            End If
        End If
    End Sub

</script>
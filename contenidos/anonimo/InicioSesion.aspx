<%@ Page Title="" Language="VB" MasterPageFile="~/basica.master" AutoEventWireup="false" CodeFile="InicioSesion.aspx.vb" Inherits="OcultoInicioSesion" %>


<asp:Content ID="Content2" ContentPlaceHolderID="barra" Runat="Server">
     <script>
       
       fetch('https://www.el-tiempo.net/api/json/v2/provincias/23')
           .then(resp => resp.json())
           .then((data) => {
               alert(` ${data.title}\n Tiempo de hoy: ${data.today.p} \nTiempo de mañana: ${data.tomorrow.p}`);
           });
              
       
     </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="principal" Runat="Server">
     <div>
        <asp:Label ID="lUser" runat="server" Text="Usuario:"></asp:Label>
        <asp:TextBox ID="tbUser" runat="server" MaxLength="15" placeholder="Tu usuario..."></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvUser" runat="server" Display="Dynamic" ControlToValidate="tbUser" ErrorMessage="Introduzca el nombre de usuario." />
        <asp:RegularExpressionValidator ID="reUser" runat="server" Display="Dynamic" ControlToValidate="tbUser" ErrorMessage="El nombre de usuario debe tener 3 y 20 caracteres."
            ValidationExpression="\w{3,20}" />
        <br />

        <asp:Label ID="lPass" runat="server" Text="Contraseña:" MaxLength="20"></asp:Label>
        <asp:TextBox ID="tbPass" runat="server" TextMode="Password" placeholder="Tu contraseña..."></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvPass" runat="server" Display="Dynamic" ControlToValidate="tbPass" ErrorMessage="Introduzca la contraseña." />
        <asp:RegularExpressionValidator ID="rePass" runat="server" Display="Dynamic" ControlToValidate="tbPass" ErrorMessage="La contraseña debe tener entre 3 y 20 caracteres."
            ValidationExpression="\w{3,20}" />
        <asp:CustomValidator ID="cvOk" runat="server" Display="Dynamic"
            ErrorMessage="Lo sentimos, no tiene permiso para acceder."
            OnServerValidate="cvOk_ServerValidate" />
        <br />
        <asp:CheckBox ID="ckRecordar" runat="server" Text="Recordar en este equipo" />
        <br />
        <asp:Button ID="btValidar" runat="server" Text="Entrar" CausesValidation="true" />
    </div>
</asp:Content>


<%@ Page Title="" Language="VB" MasterPageFile="~/basica.master" AutoEventWireup="false" CodeFile="RegistroUsuario.aspx.vb" Inherits="OcultoRegistroUsuario" %>


<asp:Content ID="Content2" ContentPlaceHolderID="barra" Runat="Server">
   
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="principal" Runat="Server">

   <asp:FormView ID="fvRegistro" runat="server" DataKeyNames="id" DataSourceID="SqlDSRegUsuarios">
       
        <InsertItemTemplate>
            <asp:Calendar ID="Calendar1" runat="server" SelectedDate='<%# Bind("fecha") %>'
            BackColor="White" BorderColor="#3366CC"  CellPadding="1" DayNameFormat="Shortest"
            Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="200px" 
            Width="250px" >
            <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
            <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
            <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
            <WeekendDayStyle BackColor="#CCCCFF" />
            <OtherMonthDayStyle ForeColor="#999999" />
            <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
            <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
            <TitleStyle BackColor="#003399" BorderColor="#3366CC" 
                BorderWidth="1px" Font-Bold="True"
                Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
            </asp:Calendar>
            <br />
            Usuario:
            <asp:TextBox ID="loginTextBox" runat="server" Text='<%# Bind("login") %>' />
            <br />
            Contraseña:
            <asp:TextBox ID="passwordTextBox" TextMode="Password" runat="server" Text='<%# Bind("password") %>' />
            <br />
            Email:
            <asp:TextBox ID="emailTextBox" runat="server" Text='<%# Bind("email") %>' />
            <br />
            Nombre:
            <asp:TextBox ID="nombreTextBox" runat="server" Text='<%# Bind("nombre") %>' />
            <br />
            Avatar:
            <asp:TextBox ID="avatarTextBox" runat="server" Text='<%# Bind("avatar") %>' />
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insertar" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancelar" />
        </InsertItemTemplate>
        
    </asp:FormView>
    <asp:SqlDataSource ID="SqlDSRegUsuarios" runat="server" ConnectionString="<%$ ConnectionStrings:cervezasArtesanasCnx %>" 
        InsertCommand="INSERT INTO [Usuario] ([fecha], [login], [password], [email], [nombre], [idRol], [avatar], [activado]) VALUES (@fecha, @login, @password, @email, @nombre, 1, @avatar, 2 )"
        OldValuesParameterFormatString="original_{0}"
        SelectCommand="SELECT * FROM [Usuario]"
        >
   
        <InsertParameters>
            <asp:Parameter Name="fecha" Type="DateTime" />
            <asp:Parameter Name="login" Type="String" />
            <asp:Parameter Name="password" Type="String" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="nombre" Type="String" />
            <asp:Parameter Name="idRol" Type="Int32" />
            <asp:Parameter Name="avatar" Type="String" />
            <asp:Parameter Name="activado" Type="Boolean" />
        </InsertParameters>
    
        
    </asp:SqlDataSource>
</asp:Content>





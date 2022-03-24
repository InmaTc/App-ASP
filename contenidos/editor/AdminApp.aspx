<%@ Page Title="" Language="VB" MasterPageFile="~/basica.master" AutoEventWireup="false" CodeFile="AdminApp.aspx.vb" Inherits="OcultoAdminApp" %>

<asp:Content ID="Content2" ContentPlaceHolderID="barra" Runat="Server">
   
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="principal" Runat="Server">

    <%-- Panel para modificar productos por editor --%>
    <asp:Panel ID="panelEditor" runat="server">
        <asp:FormView ID="gvEditarProductos" runat="server" DataKeyNames="id" DataSourceID="SqlDsEditarProductos">
            
            <InsertItemTemplate>
                nombre:
                <asp:TextBox ID="tbNombre" runat="server" Text='<%# Bind("nombre") %>' />
                <br />
                descripcion:
                <asp:TextBox ID="tbDesc" TextMode="MultiLine" runat="server" Text='<%# Bind("descripcion") %>' />
                <br />
                url:
                <asp:TextBox ID="tbUrl" runat="server" Text='<%# Bind("url") %>' />
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insertar" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancelar" />
            </InsertItemTemplate>
            
        </asp:FormView>

        <%-- SQL de productos para poder editarlos --%>
        <asp:SqlDataSource ID="SqlDsEditarProductos" runat="server" ConnectionString="<%$ ConnectionStrings:cervezasArtesanasCnx %>" 
            DeleteCommand="DELETE FROM [Producto] WHERE [id] = @id" 
            InsertCommand="INSERT INTO [Producto] ([nombre], [descripcion], [url]) VALUES (@nombre, @descripcion, @url)" 
            SelectCommand="SELECT * FROM [Producto]" 
            UpdateCommand="UPDATE [Producto] SET [nombre] = @nombre, [descripcion] = @descripcion, [url] = @url WHERE [id] = @id"
            >
            <DeleteParameters>
                <asp:Parameter Name="id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="nombre" Type="String" />
                <asp:Parameter Name="descripcion" Type="String" />
                <asp:Parameter Name="url" Type="String" />
            </InsertParameters>
            
        </asp:SqlDataSource>
    </asp:Panel>
</asp:Content>


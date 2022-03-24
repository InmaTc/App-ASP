<%@ Page Title="" Language="VB" MasterPageFile="~/basica.master" AutoEventWireup="false" CodeFile="Productos.aspx.vb" Inherits="OcultoProductos" %>


<asp:Content ID="Content2" ContentPlaceHolderID="barra" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="principal" Runat="Server">
    <asp:ListView ID="lvProductos" runat="server" DataSourceID="SqlDsProductos" DataKeyNames="id" GroupItemCount="3">

        <EmptyDataTemplate>
            <table runat="server" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>No hay cervezas disponibles en este momento.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <EmptyItemTemplate>
            <td runat="server" />
        </EmptyItemTemplate>
        <GroupTemplate>
            <tr id="itemPlaceholderContainer" runat="server">
                <td id="itemPlaceholder" runat="server"></td>
            </tr>
        </GroupTemplate>
        <ItemTemplate>
            <td runat="server" style="">
                <asp:ImageButton ID="imgProducto" runat="server" ImageUrl='<%# IIf(Convert.IsDBNull(Eval("url")), "../../imagenes/productos/0.jpg", Eval("url", "{0}")) %>' Width="300px" height="300px" PostBackUrl='<%# Eval("id", "~/contenidos/publico/Producto.aspx?pasaridProducto={0}") %>' />          
                <br />
                Nombre:
                <asp:Label ID="lbNombreProd" runat="server" Text='<%# Eval("nombre") %>' />
                <br />
            </td>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table id="groupPlaceholderContainer" runat="server" border="1" style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr id="groupPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" style="text-align: center;background-color: #5D7B9D;font-family: Verdana, Arial, Helvetica, sans-serif;color: #FFFFFF">
                    </td>
                </tr>
            </table>
        </LayoutTemplate>

    </asp:ListView>
    <asp:SqlDataSource ID="SqlDsProductos" runat="server" ConnectionString="<%$ ConnectionStrings:cervezasArtesanasCnx %>" SelectCommand="SELECT * FROM [Producto] ORDER BY [nombre]"></asp:SqlDataSource>
</asp:Content>




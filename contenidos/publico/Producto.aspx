<%@ Page Title="" Language="VB" MasterPageFile="~/basica.master" AutoEventWireup="false" CodeFile="Producto.aspx.vb" Inherits="OcultoProducto" %>

<asp:Content ID="Content2" ContentPlaceHolderID="barra" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="principal" Runat="Server">
    
    <%-- Panel para visualizar el producto de forma ampliada y ver su descripción --%>
    <asp:Panel ID="panelProductoAmpliado" runat="server">
        <asp:GridView ID="gvProductoAmpliado" runat="server" DataSourceID="SqlDsProducto" AutoGenerateColumns="False" DataKeyNames="id">
            <Columns>            
                <asp:TemplateField HeaderText="CERVEZA" >
                    <ItemTemplate>
                        <br />
                        Nombre:
                        <asp:Label ID="lbNombreProd" runat="server" Text='<%# Eval("nombre") %>' />
                        <asp:ImageButton ID="imgProducto" runat="server" ImageUrl='<%# IIf(Convert.IsDBNull(Eval("url")), "../../imagenes/productos/0.jpg", Eval("url", "{0}")) %>' Width="500px" height="400px" PostBackUrl='<%# Eval("id", "~/contenidos/publico/Producto.aspx?pasaridProducto={0}") %>' />          
                    
                        <br />                    
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="descripcion" HeaderText="Descripción del producto" SortExpression="descripcion" />
            </Columns>
        </asp:GridView>
    </asp:Panel>

    <%--Panel para que el usuario que está conectado pueda realizar un comentario en este producto--%>
    <asp:Panel ID="panelComentar" runat="server">
        <br />        <br />        <br />        <br />
        <asp:Image ID="imgAvatarUsuarioActivo" runat="server" ImageUrl="../../imagenes/avatares/sn.png" />
        <asp:FormView ID="fvGuardarComentarios" runat="server" DataSourceID="sqlDsGuardarComentario">
            <InsertItemTemplate>                 
                Comentario: <br />
                <asp:TextBox ID="tbComentario" runat="server" ClientIDMode="Static"  Text='<%# Bind("texto") %>'
                       placeholder="Estás realizando un comentario en este producto" TextMode ="MultiLine" MaxLength="256"  Height="58px" Width="900px" style="margin-left:10px;font-size:12px;" />
                <asp:RequiredFieldValidator ID="rfvComentario" runat="server" Display="Dynamic" ErrorMessage="" ControlToValidate ="tbComentario" />            
            </InsertItemTemplate>
        </asp:FormView>
    </asp:Panel>
    <asp:Panel ID="panelBotonesComentar" runat="server"  style="text-align:right;width:85%" >
        <asp:Button ID="btCancelarComentario" runat="server" Text="CANCELAR" Font-Size="13px" CausesValidation="false"
                 OnClientClick="document.getElementById('tbComentario').value='';return false;"/>
        <asp:Button ID="btGuardarComentario" runat="server" Text="GUARDAR" Font-Size="13px" CausesValidation="true"
                OnClientClick="var a=document.getElementById('tbComentario').value;if (a.length>0 &&  a.length<=256){var ok=confirm('¿Está seguro?');if (!ok) {document.getElementById('tbComentario').value='';return ok;}} else {return false;}"
                OnClick="btGuardarComentario_Click"/>
        <br />        <br />
    </asp:Panel>

    <%--  Panel para ver los comentarios que hay sobre este producto--%>
    <asp:Panel ID="panelComentarios" runat="server">
        <asp:GridView ID="gvComentarios" runat="server" AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="sqlDsComentarios">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Image ID="AvatarEnGv" runat="server" Width="75px" ImageUrl='<%#  IIf(Convert.IsDBNull(Eval("avatar")), "../../imagenes/avatares/sn.png", "../../imagenes/avatares/" & Eval("avatar")) %>' />
                        <br />                     
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="nombre"  />
                <asp:BoundField DataField="texto" HeaderText="texto" SortExpression="texto" />
                <asp:BoundField DataField="fecha"  />
            </Columns>
        </asp:GridView>
    </asp:Panel>

    <%-- SQL para mostrar datos de la tabla COMENTARIO con join de la tabla USUARIO --%>
    <asp:SqlDataSource ID="sqlDsComentarios" runat="server" ConnectionString="<%$ ConnectionStrings:cervezasArtesanasCnx %>" SelectCommand="SELECT * FROM [Comentario] JOIN Usuario on Comentario.idUsuario=Usuario.id WHERE ([idProducto] = @idProducto)">
        <SelectParameters>
            <asp:SessionParameter Name="idProducto" SessionField="idProducto" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <%-- SQL para realizar la insercción en la base de datos de la tabla COMENTARIO --%>
    <asp:SqlDataSource ID="sqlDsGuardarComentario" runat="server" ConnectionString="<%$ ConnectionStrings:cervezasArtesanasCnx %>" 
        InsertCommand="INSERT INTO [Comentario] ([fecha], [texto], [idUsuario], [idProducto]) VALUES (@fecha, @texto, @idUsuario, @idProducto)">
  
        <InsertParameters>
            <asp:Parameter Name="fecha" Type="DateTime" />
            <asp:Parameter Name="texto" Type="String" />
            <asp:Parameter Name="idUsuario" Type="Int32" />
            <asp:Parameter Name="idProducto" Type="Int32" />
        </InsertParameters>
      
    </asp:SqlDataSource>

    <%-- SQL para mostrar datos de la tabla PRODUCTO --%>
    <asp:SqlDataSource ID="SqlDsProducto" runat="server" ConnectionString="<%$ ConnectionStrings:cervezasArtesanasCnx %>" SelectCommand="SELECT * FROM [Producto] WHERE ([id] = @id)">
        <SelectParameters>
            <asp:SessionParameter Name="id" SessionField="idProducto" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>


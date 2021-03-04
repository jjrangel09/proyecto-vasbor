<%@ Page Title="" Language="C#" MasterPageFile="~/view/AdminCatalogoInvitado.master" AutoEventWireup="true" CodeFile="~/Controller/CatalogoInvitado.aspx.cs" Inherits="view_CatalogoInvitado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="row" style="padding-top:50px">
        <div class="col-sm-12 col-md-12" >
            <label class="col-xs-11 center espacio_cajas "  >Buscar Nombre Producto</label>
            <asp:TextBox class="form-control" runat="server" ID="TB_Filtro"   placeholder="Buscar Plato" TextMode="Search" AutoPostBack="True"></asp:TextBox> 
            <asp:RegularExpressionValidator runat="server" ErrorMessage="Ingrese solo letras" style="color: #990000" ID="error_nombres" ControlToValidate="TB_Filtro" ValidationExpression="[A-Za-z ]*"></asp:RegularExpressionValidator>
            <label class="col-xs-11 center espacio_cajas"  >Buscar Tipo Producto </label>
            <asp:DropDownList class="form-control" ID="DropDownList1" runat="server" DataSourceID="ODSCategoria" DataTextField="Categorias" DataValueField="Id" AutoPostBack="True"></asp:DropDownList>
             <asp:ObjectDataSource ID="ODSCategoria" runat="server" SelectMethod="obtenerCategoria" TypeName="DAOCategorias"></asp:ObjectDataSource>
             <hr />
        <br />
        </div>
       
     <asp:Repeater ID="DCatalogo" runat="server" DataSourceID="Catalogo">
   <ItemTemplate>
       <div class="col-sm-3 col-md-3">
           <a href="Ingresar.aspx">
           <div class="thumbnail">
                 <asp:Image  ImageUrl='<%#Eval("Imagen") %>' runat="server" />
                   <div class="caption">
                   <div class="proNameView divDet1"><%# Eval("Nombre") %></div>
                   <h5 class="h5Size divDet1 " runat="server" >Categoria</h5>
                   <div><%# Eval(" Categorrias") %></div>
                   <h5 class="h5Size divDet1 " runat="server" >Subcategoria</h5>
                   <div><%# Eval("Subcategorias") %></div>
                   <h5 class="h5Size divDet1 " runat="server" >Descripcion</h5>
                   <div class="proName  "><%# Eval("Descripcion") %></div>
                    <h5 class="h5Size divDet1 " runat="server" >Pecio</h5>
                   <div class="proPriceDiscountView">
                       <asp:Label ID="lb_precio" Text='<%# Eval("Precio","{0:C}") %>' runat="server" />
                   </div>
               </div>
           </div>
               </a>
       </div>
 </ItemTemplate>
          <FooterTemplate>
           <h1>Fin Productos</h1>
         </FooterTemplate> 
</asp:Repeater> 

        <asp:ObjectDataSource ID="Catalogo" runat="server" SelectMethod="obtenerProductoCantidadActual" TypeName="DAOProducto">
            <SelectParameters>
                <asp:ControlParameter ControlID="TB_Filtro" Name="nombreF" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="DropDownList1" Name="cate" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
</div>
   
</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/view/AdminCatalogoEmpleado.master" AutoEventWireup="true" CodeFile="~/Controller/DetalleCarritoEmpleado.aspx.cs" Inherits="view_DetalleCarritoEmpleado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <div style="padding-top:20px;">
        <div class="col-md-9">
            <h5 class="proNameViewCart"> Numero De Productos: <asp:Label ID="lb_Con"   runat="server" /></h5>
            <asp:Repeater ID="DCatalogo" runat="server" DataSourceID="ODSEmpleado" OnItemCommand="DCatalogo_ItemCommand"  >
                 <ItemTemplate>
            <div class="media " style="border:1px solid #eaeaec;">
                <div class="media-left">
                    <asp:Image class="media-object" ImageUrl='<%#Eval("Imagen") %>' runat="server" width="200px"  />
                </div>
                <div class="media-body">
                    <h5 class="media-heading proNameViewCart"><%# Eval("NombreProducto") %></h5>
                    <span class="proPriceView" >Categoria: </span>
                     <span ><%# Eval("Categoria") %></span>
                    <p></p>
                     <span class="proPriceView" >SubCategoria: </span>
                     <span ><%# Eval("Subcategoria") %> </span>
                     <p></p>
                     <span class="proPriceView" >Precio: </span>
                     <span ><asp:Label ID="lb_precio" class="priceGreen" Text='<%# Eval("Precio","{0:C}") %>' runat="server" /></span> 
                    <p></p>
                     <span class="proPriceView" >Cantidad: </span>
                     <span ><asp:Label ID="lb_cantidad" class="priceGray" Text='<%# Eval("Cantidad") %>' runat="server" /></span> 
                    <p></p>
                     <span class="proPriceView" >Total Producto: </span>
                     <span ><asp:Label ID="lb_total_producto" class="priceGray" Text='<%# Eval("Total","{0:C}") %>' runat="server" /></span> 
                    <p>
                      <asp:Button CssClass="removeButton" Text="Eliminar" CommandArgument='<%# Eval("Id") %>' runat="server"/>
                    </p>
                </div>
            </div>
           
             </ItemTemplate>
                
                </asp:Repeater>
            <asp:ObjectDataSource ID="ODSEmpleado" runat="server" SelectMethod="obtenerProductosCarritoE" TypeName="DAOEmpleado">
                <SelectParameters>
                    <asp:SessionParameter Name="empleadoId" SessionField="id_empleado" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
        </div>
        <div class="col-md-3">
            <div style="border-bottom:1px solid #eaeaec;">
                 <h5 class="proNameViewCart">Detalles Compra</h5>
                <div>
                    <asp:Label CssClass="proPriceView"   runat="server" >Precio carrito</asp:Label>
                   <span class="pull-right priceGray"><asp:Label ID="lb_precioT" CssClass="proPriceView" runat="server"></asp:Label></span>
                </div>
                  <div class="proPriceView">
                   <label>Descuento</label>
                    <span class="pull-right priceGreen "> <asp:Label Text="0" runat="server" /></span>
                </div>
            </div>
            <div class="proPriceView">
                <label>Total</label>
                 <span class="pull-right priceGray"><asp:Label ID="lb_total" CssClass="proPriceView" runat="server"></asp:Label></span>
            </div>
            <div>
                     <asp:Button ID="btncomprar"  CssClass="buyNowBtn"  Text="Continuar" runat="server" OnClick="btncomprar_Click" />
                </div>
        </div>
          
    </div>
</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/view/AdminCatalogoEmpleado.master" AutoEventWireup="true" CodeFile="~/Controller/PedidoEspera.aspx.cs" Inherits="view_PedidoEspera" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div style="padding-top:20px;">
    <div class="col-md-9">
    <div class="form-horizontal">
        <div class="form-group">
            <hr />
            <hr />
            <h2>Pedidos En Espera Por Factura</h2>
            <hr />
            <div class="center">
                 <h4>Numero De Pedidos En Espera</h4>
            <span class="priceGray"><asp:Label ID="lb_pedido" CssClass="proPriceView" runat="server"></asp:Label></span>
            </div>
           
        </div>
          
          <div class="form-group">
                    <asp:Label ID="lb_mesa" runat="server" CssClass="col-md-2 control-label" Text="Factura Pendiente Mesa"></asp:Label>
                    <div class="col-md-7">
                        <asp:DropDownList ID="mesa_pendiente" runat="server" CssClass="form-control" DataSourceID="ODSPedidos" DataTextField="Nom_mesa" DataValueField="Id"></asp:DropDownList>
                        <asp:ObjectDataSource ID="ODSPedidos" runat="server" SelectMethod="obtenerPedidosxEmpleado" TypeName="DAOEmpleado">
                            <SelectParameters>
                                <asp:SessionParameter Name="empleadoid" SessionField="id_empleado" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:RequiredFieldValidator ID="vacio_categoria" CssClass="text-danger" runat="server" ErrorMessage="Es necesario !" ControlToValidate="mesa_pendiente" InitialValue="0">*</asp:RequiredFieldValidator>
                    </div>
                </div>
          <div class="form-group">
                    <div class="col-md-2"></div>
                    <div class="col-md-6">
                        <asp:Button ID="btn_añadir" runat="server" Text="Generar factura" OnClick="btn_añadir_Click" CssClass="btn btn-success" />
                        <asp:Label ID="lb_mensaje" runat="server" Text=""></asp:Label>
                    </div>
                </div>
              </div>
        </div>
         </div>
</asp:Content>


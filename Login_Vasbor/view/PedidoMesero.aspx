<%@ Page Title="" Language="C#" MasterPageFile="~/view/AdminCatalogoEmpleado.master" AutoEventWireup="true" CodeFile="~/Controller/PedidoMesero.aspx.cs" Inherits="view_PedidoMesero" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <div style="padding-top:20px;">
    <div class="col-md-9">
    <div class="form-horizontal">
        <div class="form-group">
            <hr />
            <hr />
            <h2>Descripcion Pedido</h2>
            <hr />
            <div class="center">
                 <h4>Total Compra</h4>
            <span class="priceGray"><asp:Label ID="lb_total" CssClass="proPriceView" runat="server"></asp:Label></span>
            </div>
           
        </div>
          <div class="form-group">
                    <asp:Label ID="lb_mesa" runat="server" CssClass="col-md-2 control-label" Text="Lugar Pedido"></asp:Label>
                    <div class="col-md-7">
                        <asp:DropDownList ID="tipo_mesa"  CssClass="form-control" runat="server" DataSourceID="ODSMesa" DataTextField="Descripcion" DataValueField="Id"></asp:DropDownList>
                        <asp:ObjectDataSource ID="ODSMesa" runat="server" SelectMethod="obtenerMesa" TypeName="DAOEmpleado"></asp:ObjectDataSource>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="text-danger" runat="server" ErrorMessage="Es necesario El Lugar !" ControlToValidate="tipo_mesa" InitialValue="0">*</asp:RequiredFieldValidator>
                    </div>
                </div>
        <div class="form-group">
                    <asp:Label ID="lb_pago" runat="server" CssClass="col-md-2 control-label" Text="Metodo De Pago"></asp:Label>
                    <div class="col-md-7">
                        <asp:DropDownList ID="tipo_pago"  CssClass="form-control" runat="server" DataSourceID="ODSPago" DataTextField="Descripcion" DataValueField="Id"></asp:DropDownList>
                        <asp:ObjectDataSource ID="ODSPago" runat="server" SelectMethod="obtenerPagos" TypeName="DAOFactura"></asp:ObjectDataSource>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" CssClass="text-danger" runat="server" ErrorMessage="Es necesario el Tipo de pago !" ControlToValidate="tipo_pago" InitialValue="0">*</asp:RequiredFieldValidator>
                    </div>
                </div>
          <div class="form-group">
                    <div class="col-md-2"></div>
                    <div class="col-md-6">
                        <asp:Button ID="btn_añadir" runat="server" Text="Añadir" CssClass="btn btn-success" OnClick="btn_añadir_Click" />
                        <asp:Label ID="lb_mensaje" runat="server" Text=""></asp:Label>
                    </div>
                </div>
              </div>
        </div>
         </div>
</asp:Content>


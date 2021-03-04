<%@ Page Title="" Language="C#" MasterPageFile="~/view/AdminCatalogo.master" AutoEventWireup="true" CodeFile="~/Controller/Pedido.aspx.cs" Inherits="view_Pedido" %>

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
                    <asp:Label ID="lb_pago" runat="server" CssClass="col-md-2 control-label" Text="Metodo De Pago"></asp:Label>
                    <div class="col-md-7">
                        <asp:DropDownList ID="tipo_pago"  CssClass="form-control" runat="server" DataSourceID="ODSPago" DataTextField="Descripcion" DataValueField="Id"></asp:DropDownList>
                        <asp:ObjectDataSource ID="ODSPago" runat="server" SelectMethod="obtenerPagos" TypeName="DAOFactura"></asp:ObjectDataSource>
                        <asp:RequiredFieldValidator ID="vacio_categoria" CssClass="text-danger" runat="server" ErrorMessage="Es necesario el Tipo de pago !" ControlToValidate="tipo_pago" InitialValue="0">*</asp:RequiredFieldValidator>
                    </div>
                </div>
             <div class="form-group">
                    <asp:Label ID="lb_estadoD" runat="server" CssClass="col-md-2 control-label" Text="Direccion"></asp:Label>
                    <div class="col-md-7">
                        <asp:DropDownList ID="tipo_domicilio"  CssClass="form-control" runat="server" DataSourceID="ODSDireccion" DataTextField="Direccion" DataValueField="Id" ></asp:DropDownList>
                        <asp:ObjectDataSource ID="ODSDireccion" runat="server" SelectMethod="ObtenerDirreccionUsuario" TypeName="DAOFactura">
                            <SelectParameters>
                                <asp:SessionParameter Name="userId" SessionField="id_usuario" Type="Int32" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="text-danger" runat="server" ErrorMessage="Es necesario El Tipo De Domicilio !" ControlToValidate="tipo_domicilio" InitialValue="0">*</asp:RequiredFieldValidator>
                    </div>
                </div>
          <div class="form-group">
                    <div class="col-md-2"></div>
                    <div class="col-md-6">
                        <asp:Button ID="btn_añadir" runat="server" Text="Siguiente" CssClass="btn btn-success"  OnClick="btn_añadir_Click"/>
                        <asp:Label ID="lb_mensaje" runat="server" Text=""></asp:Label>
                    </div>
                </div>
              </div>
        </div>
         </div>
</asp:Content>


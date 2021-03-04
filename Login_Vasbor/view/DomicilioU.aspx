<%@ Page Title="" Language="C#" MasterPageFile="~/view/AdminCatalogo.master" AutoEventWireup="true" CodeFile="~/Controller/DomicilioU.aspx.cs" Inherits="view_DomicilioU" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div style="padding-top:20px;">
    <div class="col-md-9">
    <div class="form-horizontal">
        <div class="form-group">
            <hr />
            <hr />
            <h2>Descripcion Domicilio</h2>
            <hr />
            <asp:Label ID="lb_direccion" runat="server" CssClass="col-md-2 control-label" Text="Direccion"></asp:Label>
            <div class="col-md-7">
                <asp:TextBox ID="txt_direccion" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" CssClass="text-danger" runat="server" ErrorMessage="" ControlToValidate="txt_direccion">*</asp:RequiredFieldValidator>
            </div>
        </div>
         <div class="form-group">
            <asp:Label ID="lb_pais" runat="server" CssClass="col-md-2 control-label" Text="Pais"></asp:Label>
            <div class="col-md-7">
                <asp:TextBox ID="txt_pais" CssClass="form-control" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" CssClass="text-danger" runat="server" ErrorMessage="" ControlToValidate="txt_pais">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Ingrese solo letras" style="color: #990000" ID="RegularExpressionValidator1" ControlToValidate="txt_pais" ValidationExpression="[A-Za-z ]*"></asp:RegularExpressionValidator>
            </div>
        </div>
         <div class="form-group">
            <asp:Label ID="lb_ciudad" runat="server" CssClass="col-md-2 control-label" Text="Ciudad"></asp:Label>
            <div class="col-md-7">
                <asp:TextBox ID="txt_ciudad"  CssClass="form-control" runat="server" style="margin-left: 0"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" CssClass="text-danger" runat="server" ErrorMessage="" ControlToValidate="txt_ciudad">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator runat="server" ErrorMessage="Ingrese solo letras" style="color: #990000" ID="error_nombres" ControlToValidate="txt_ciudad" ValidationExpression="[A-Za-z ]*"></asp:RegularExpressionValidator>
            </div>
        </div>
          <div class="form-group">
            <asp:Label ID="lb_codigop" runat="server" CssClass="col-md-2 control-label" Text="Codigo postal"></asp:Label>
            <div class="col-md-7">
                <asp:TextBox ID="txt_postal"  CssClass="form-control" runat="server" TextMode="Number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="text-danger" runat="server" ErrorMessage="" ControlToValidate="txt_postal">*</asp:RequiredFieldValidator>
            </div>
        </div>
         <div class="form-group">
                    <div class="col-md-2"></div>
                    <div class="col-md-6">
                        <asp:Button ID="btn_guardar" CssClass="btn btn-success" Text="Guardar" OnClick="btn_guardar_Click" runat="server" />
                        <asp:Button ID="btn_cancelar" CssClass="btn btn-primary" Text="Cancelar" OnClick="btn_cancelar_Click" runat="server" CausesValidation="false"/>
                        <asp:Button ID="btn_añadir" runat="server" Text="Añadir Nueva Direccion" CssClass="btn btn-success" OnClick="btn_añadir_Click" CausesValidation="false"/>
                        <asp:Button ID="btn_omitir" runat="server" Text="Siguiente" CssClass="btn btn-primary" OnClick="btn_omitir_Click" CausesValidation="False"/>
                        <asp:Label ID="lb_mensaje" runat="server" Text=""></asp:Label>
                    </div>
                </div>
          <div class="form-group">
              <h1 class="center">Direcciones registradas</h1>
                      <asp:DataList ID="direccion_data" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" DataSourceID="ODSDireccion" ForeColor="Black" GridLines="Horizontal" Height="322px" RepeatColumns="3" RepeatDirection="Horizontal" ShowFooter="False" ShowHeader="False" Width="1101px">
                        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                        <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                        <ItemTemplate>
                            Direccion:
                            <asp:Label ID="DireccionLabel" runat="server" Text='<%# Eval("Direccion") %>' />
                            <br />
                            Pais:
                            <asp:Label ID="PaisLabel" runat="server" Text='<%# Eval("Pais") %>' />
                            <br />
                            Ciudad:
                            <asp:Label ID="CiudadLabel" runat="server" Text='<%# Eval("Ciudad") %>' />
                            <br />
                            Codigop:
                            <asp:Label ID="CodigopLabel" runat="server" Text='<%# Eval("Codigop") %>' />
                            <br />
                            <br />
                        </ItemTemplate>
                        <SelectedItemStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                    </asp:DataList>

                    <asp:ObjectDataSource ID="ODSDireccion" runat="server" SelectMethod="ObtenerDirreccionUsuario2" TypeName="DAOFactura">
                        <SelectParameters>
                            <asp:SessionParameter Name="userId" SessionField="id_usuario" Type="Int32" />
                        </SelectParameters>
                    </asp:ObjectDataSource>

            </div>
        </div>
        </div>
    </div>
</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/view/AdminMaster.master" AutoEventWireup="true" CodeFile="~/Controller/Administrador.aspx.cs" Inherits="view_Administrador" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1> Administrador</h1>
      <link href="css/centrar-Cs.css" rel="stylesheet" />
    <div class="container">
        <div class="form-horizontal">
                <div class="form-group">
                    <hr />
                    <hr />
                    <h2>Añadir Administrador</h2>
                    <hr />
                    <asp:Label ID="lb_nombre" runat="server" CssClass="col-md-2 control-label" Text="Nombres"></asp:Label>
                    <div class="col-md-3" style="left: 0px; top: 9px">
                        <asp:TextBox ID="txt_nombre" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="vacio_nombres" CssClass="text-danger" runat="server" ErrorMessage="Es necesario el nombre" ControlToValidate="txt_nombre">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" ErrorMessage="Ingrese solo letras" style="color: #990000" ID="error_nombres" ControlToValidate="txt_nombre" ValidationExpression="[A-Za-z ]*"></asp:RegularExpressionValidator>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="lb_apellido" runat="server" CssClass="col-md-2 control-label" Text="Apellidos"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_apellido" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="vacio_apellidos" CssClass="text-danger" runat="server" ErrorMessage="Es necesario el apellido" ControlToValidate="txt_apellido">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" ErrorMessage="Ingrese solo letras" style="color: #990000" ID="error_apellido" ControlToValidate="txt_apellido" ValidationExpression="[A-Za-z ]*"></asp:RegularExpressionValidator>
                    </div>
                </div>
              <div class="form-group">
                    <asp:Label ID="lb_correo" runat="server" CssClass="col-md-2 control-label" Text="Correo"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_correo" CssClass="form-control" runat="server" TextMode="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="text-danger" runat="server" ErrorMessage="Es necesario el correo" ControlToValidate="txt_correo">*</asp:RequiredFieldValidator>
                    </div>
                </div>
              <div class="form-group">
                    <asp:Label ID="lb_identi" runat="server" CssClass="col-md-2 control-label" Text="Identificacion"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_identi" CssClass="form-control" runat="server" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="vacio_identificacion" CssClass="text-danger" runat="server" ErrorMessage="Es necesario la identificacion" ControlToValidate="txt_identi">*</asp:RequiredFieldValidator>
                        <asp:Label ID="lb_mensajeI" runat="server"></asp:Label>
                    </div>
                </div>
              <div class="form-group">
                    <asp:Label ID="lb_username" runat="server" CssClass="col-md-2 control-label" Text="Nombre De Usuario"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_username" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="vacio_username" CssClass="text-danger" runat="server" ErrorMessage="Es necesario el nombre de usuario" ControlToValidate="txt_username">*</asp:RequiredFieldValidator>
                    </div>
                </div>
              <div class="form-group">
                    <asp:Label ID="lb_clave" runat="server" CssClass="col-md-2 control-label" Text="Contraseña"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_clave" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="vacio_contraseña" CssClass="text-danger" runat="server" ErrorMessage="Es necesario la contraseña" ControlToValidate="txt_clave">*</asp:RequiredFieldValidator>
                    </div>
                </div>
             <div class="form-group">
                    <div class="col-md-2"></div>
                    <div class="col-md-6">
                        <asp:Button ID="btn_añadir" runat="server" Text="Añadir" CssClass="btn btn-primary" OnClick="btn_añadir_Click"/>
                        <asp:Label ID="lb_mensaje" runat="server" Text=""></asp:Label>
                    </div>
                </div>
            </div>
        <h1>Gestionar Administrador</h1>
        <hr />
        <div class="container">
            <div class="table-responsive">
                 <asp:GridView CssClass="table table-bordered table-hover" ID="Gadmin" runat="server" AllowPaging="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="ODSAdministrador" ForeColor="#333333" GridLines="None" Width="857px" DataKeyNames="Id,Clave,Id_rol" >
                     <AlternatingRowStyle BackColor="White" />
                     <Columns>
                         <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                         <asp:BoundField DataField="Apellido" HeaderText="Apellido" SortExpression="Apellido" />
                         <asp:BoundField DataField="Correo" HeaderText="Correo" SortExpression="Correo" />
                         <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
                         <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                         <asp:CommandField CausesValidation="False" ShowEditButton="True" />
                         <asp:CommandField CausesValidation="False" ShowDeleteButton="True" />
                     </Columns>
                     <EditRowStyle BackColor="#2461BF" />
                     <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                     <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                     <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                     <RowStyle BackColor="#EFF3FB" />
                     <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                     <SortedAscendingCellStyle BackColor="#F5F7FB" />
                     <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                     <SortedDescendingCellStyle BackColor="#E9EBEF" />
                     <SortedDescendingHeaderStyle BackColor="#4870BE" />
                 </asp:GridView>
                 <asp:ObjectDataSource ID="ODSAdministrador" runat="server" DataObjectTypeName="Administrador" SelectMethod="obtenerAdnimistrador" TypeName="DAOAdministrador" UpdateMethod="actualizar" DeleteMethod="eliminar"></asp:ObjectDataSource>
            </div>
        </div>
       
        </div>
</asp:Content>


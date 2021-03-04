<%@ Page Title="" Language="C#" MasterPageFile="~/view/AdminMaster.master" AutoEventWireup="true" CodeFile="~/Controller/Usuario.aspx.cs" Inherits="view_Usuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Usuario</h1>
      <link href="css/centrar-Cs.css" rel="stylesheet" />
    <div class="container">
        <div class="form-horizontal">
                <div class="form-group">
                    <hr />
                    <hr />
                    <h2>Añadir Usuario</h2>
                    <hr />
                    <asp:Label ID="lb_nombre" runat="server" CssClass="col-md-2 control-label" Text="Nombre"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_nombre" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="error_codigo" CssClass="text-danger" runat="server" ErrorMessage="" ControlToValidate="txt_nombre">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" ErrorMessage="Ingrese solo letras" style="color: #990000" ID="error_nombres" ControlToValidate="txt_nombre" ValidationExpression="[A-Za-z ]*"></asp:RegularExpressionValidator>                   
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="lb_apellido" runat="server" CssClass="col-md-2 control-label" Text="Apellido"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_apellido" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="error_categoria" CssClass="text-danger" runat="server" ErrorMessage="" ControlToValidate="txt_apellido">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" ErrorMessage="Ingrese solo letras" style="color: #990000" ID="RegularExpressionValidator1" ControlToValidate="txt_apellido" ValidationExpression="[A-Za-z ]*"></asp:RegularExpressionValidator>
                    </div>
                </div>
              <div class="form-group">
                    <asp:Label ID="lb_correo" runat="server" CssClass="col-md-2 control-label" Text="Correo"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_correo" CssClass="form-control" runat="server" TextMode="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="text-danger" runat="server" ErrorMessage="" ControlToValidate="txt_correo">*</asp:RequiredFieldValidator>
                    </div>
                </div>
              <div class="form-group">
                    <asp:Label ID="lb_identi" runat="server" CssClass="col-md-2 control-label" Text="Identificacion"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_identi" CssClass="form-control" runat="server" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" CssClass="text-danger" runat="server" ErrorMessage="" ControlToValidate="txt_identi">*</asp:RequiredFieldValidator>
                        <asp:Label ID="lb_mensajeI" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="lb_telefono" runat="server" CssClass="col-md-2 control-label" Text="Telefono"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_telefono" CssClass="form-control" runat="server" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" CssClass="text-danger" runat="server" ErrorMessage="" ControlToValidate="txt_telefono">*</asp:RequiredFieldValidator>
                        <asp:Label ID="lb_mensajeI0" runat="server"></asp:Label>
                    </div>
                </div>
              <div class="form-group">
                    <asp:Label ID="lb_username" runat="server" CssClass="col-md-2 control-label" Text="Nombre De Usuario"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_username" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" CssClass="text-danger" runat="server" ErrorMessage="" ControlToValidate="txt_username">*</asp:RequiredFieldValidator>
                    </div>
                </div>
              <div class="form-group">
                    <asp:Label ID="lb_clave" runat="server" CssClass="col-md-2 control-label" Text="Contraseña"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_clave" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" CssClass="text-danger" runat="server" ErrorMessage="" ControlToValidate="txt_clave">*</asp:RequiredFieldValidator>
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
          <h1 class="centrar">Gestionar Usuario</h1>
        <hr />
          <div class="centrar" >
            <div >
                <h3 class="centrar">Tipo de estado</h3>
                <asp:GridView CssClass="table table-bordered table-hover table-responsive" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="ODSEstado" ForeColor="#333333" GridLines="None">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="Codigo Estado" SortExpression="Id" />
                        <asp:BoundField DataField="Descripcion_rol" HeaderText="Estado" SortExpression="Descripcion_rol" />
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
                <asp:ObjectDataSource ID="ODSEstado" runat="server" SelectMethod="obtenerEstado" TypeName="DAOPersona"></asp:ObjectDataSource>
            </div>
            <hr />
        </div>
        <h1>Gestionar Usuarios</h1>
        <hr />
        <div class="container">
        <div class="table-responsive " >
             <h3 class="centrar">Resgistros</h3>
        <asp:GridView CssClass="table table-bordered table-hover table-responsive" ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="ODSUsuario" ForeColor="#333333" GridLines="None" Width="802px" DataKeyNames="Id,Clave,Id_rol,Descripcion_Rol" AllowPaging="True" >
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" SortExpression="Identificacion" />
                <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                <asp:BoundField DataField="Apellido" HeaderText="Apellido" SortExpression="Apellido" />
                <asp:BoundField DataField="Correo" HeaderText="Correo" SortExpression="Correo" />
                <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
                <asp:BoundField DataField="Telefono" HeaderText="Telefono" SortExpression="Telefono" />
                <asp:BoundField DataField="Estado_id" HeaderText="Estado_id" SortExpression="Estado_id" />
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
            <asp:ObjectDataSource ID="ODSUsuario" runat="server" DataObjectTypeName="EPersona" DeleteMethod="eliminar" SelectMethod="obtenerUsuarios" TypeName="DAOPersona" UpdateMethod="ActualizarUsuario"></asp:ObjectDataSource>
        </div>
       </div>
        
        </div>
</asp:Content>


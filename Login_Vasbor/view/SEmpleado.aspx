<%@ Page Title="" Language="C#" MasterPageFile="~/view/AdminCatalogoEmpleado.master" AutoEventWireup="true" CodeFile="~/Controller/SEmpleado.aspx.cs" Inherits="view_SEmpleado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div class="centrar">
    <h1>Bienvenido</h1>
    <h1><asp:Label ID="lb_sesion" Text="text" runat="server" /></h1>
        </div>
           <div class="container">
        <div class="form-horizontal">
                <div class="form-group">
                    <hr />
                    <hr />
                    <h2>Perfil Empleado</h2>
                    <hr />
                    <asp:Label ID="lb_username" runat="server" CssClass="col-md-2 control-label" Text="Nombre"></asp:Label>
                    
                    <div class="col-md-3">
                        <asp:Label ID="l_nombre" runat="server" CssClass="col-md-2 control-label" ></asp:Label>
                        <asp:TextBox ID="txt_Pnombre" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="vacio_Pnombre" CssClass="text-danger" runat="server" ErrorMessage="Es necesario el nombre del producto" ControlToValidate="txt_Pnombre">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="error_nombre" runat="server" ControlToValidate="txt_Pnombre" CssClass="auto-style1" ErrorMessage="Ingresar solo letras" ValidationExpression="[A-Za-z ]*"></asp:RegularExpressionValidator>
                    </div>
                </div>
              <div class="form-group">
                    <asp:Label ID="Label1" runat="server" CssClass="col-md-2 control-label" Text="Apellido"></asp:Label>
                    <div class="col-md-3">
                          <asp:Label ID="l_apellido" runat="server" CssClass="col-md-2 control-label" ></asp:Label>
                        <asp:TextBox ID="txt_apellido" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="text-danger" runat="server" ErrorMessage="Es necesario el nombre del producto" ControlToValidate="txt_apellido">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txt_apellido" CssClass="auto-style1" ErrorMessage="Ingresar solo letras" ValidationExpression="[A-Za-z ]*"></asp:RegularExpressionValidator>
                    </div>
                </div>
               <div class="form-group">
                    <asp:Label ID="Label4" runat="server" CssClass="col-md-2 control-label" Text="UserName"></asp:Label>
                    <div class="col-md-3">
                          <asp:Label ID="l_username" runat="server" CssClass="col-md-2 control-label" ></asp:Label>
                        <asp:TextBox ID="txt_username" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" CssClass="text-danger" runat="server" ErrorMessage="Es necesario el nombre del producto" ControlToValidate="txt_username">*</asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-6">
                        <asp:Button ID="btn_editar" runat="server" Text="Editar" CssClass="btn btn-primary" OnClick="btn_editar_Click"/>
                         <asp:Button ID="btn_guardar" runat="server" Text="Guardar" CssClass="btn btn-primary" OnClick="btn_guardar_Click"/>
                         <asp:Button ID="btn_cancelar" runat="server" Text="Cancelar" CssClass="btn btn-primary" OnClick="btn_cancelar_Click"/>
                     <asp:Label ID="lb_mensaje" runat="server" Text=""></asp:Label>
                    </div>
                </div>
           </div>
       </div>
</asp:Content>


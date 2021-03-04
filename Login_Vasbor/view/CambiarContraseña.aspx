<%@ Page Title="" Language="C#" MasterPageFile="~/view/AdminCatalogo.master" AutoEventWireup="true" CodeFile="~/Controller/CambiarContraseña.aspx.cs" Inherits="view_CambiarContraseña" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
            <div class=" form-horizontal">
                <h2>Cambiar Contraseña</h2>
                <hr />
                    <div class="form-group">
                    <asp:Label ID="lb_anterior" runat="server" CssClass="col-md-2 control-label" Text="Anterior contraseña"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_anterior" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="error" CssClass="text-danger" runat="server" ErrorMessage="Es necesario La Contraseña" ControlToValidate="txt_anterior">*</asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="Lb_nueva" runat="server" CssClass="col-md-2 control-label" Text="Ingresar nueva  contraseña"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_nueva" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="text-danger" runat="server" ErrorMessage="Es necesario La Contraseña" ControlToValidate="txt_nueva">*</asp:RequiredFieldValidator>

                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="Lb_confirmar" runat="server" CssClass="col-md-2 control-label" Text="Confirmar nueva contraseña"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_confirmar" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" CssClass="text-danger" runat="server" ErrorMessage="Es necesario La Contraseña" ControlToValidate="txt_confirmar">*</asp:RequiredFieldValidator>

                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-3">
                        <asp:Button ID="btn_cambiar" CssClass="btn btn-primary" Text="Cambiar" runat="server" OnClick="btn_cambiar_Click" CausesValidation="false" />
                        <asp:Button ID="btn_confirmar" CssClass="btn btn-primary" Text="Guardar" runat="server" OnClick="btn_confirmar_Click" />
                        <asp:Button Text="Volver" ID="btn_volver" CssClass="btn btn-success" runat="server" OnClick="btn_volver_Click" CausesValidation="false"/>
                        <asp:Label  ID="lb_mensaje" Text="" runat="server" />
                    </div>
                </div>
               
            </div>
        </div>
</asp:Content>


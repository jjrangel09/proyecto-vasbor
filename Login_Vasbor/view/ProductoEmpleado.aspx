<%@ Page Title="" Language="C#" MasterPageFile="~/view/AdminCatalogoEmpleado.master" AutoEventWireup="true" CodeFile="~/Controller/ProductoEmpleado.aspx.cs" Inherits="view_ProductoEmpleado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div class="container">
        <div class="form-horizontal">
                <div class="form-group">
                    <hr />
                    <hr />
                    <h2>Añadir Producto</h2>
                    <hr />
                    <asp:Label ID="lb_username" runat="server" CssClass="col-md-2 control-label" Text="Nombre"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_Pnombre" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="vacio_Pnombre" CssClass="text-danger" runat="server" ErrorMessage="Es necesario el nombre del producto" ControlToValidate="txt_Pnombre">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="error_Pnombre" runat="server" ControlToValidate="txt_Pnombre" ErrorMessage="Ingrese solo el letras" style="color: #990000" ValidationExpression="[A-Za-z ]*"></asp:RegularExpressionValidator>
                    </div>
                </div>
               <div class="form-group">
                    <asp:Label ID="lb_categoria" runat="server" CssClass="col-md-2 control-label" Text="Categoria"></asp:Label>
                    <div class="col-md-3">
                        <asp:DropDownList ID="lista_categoria"  CssClass="form-control" runat="server" DataSourceID="OSCategoria" DataTextField="Categorias" DataValueField="Id"></asp:DropDownList>
                        <asp:ObjectDataSource ID="OSCategoria" runat="server" SelectMethod="obtenerCategoria" TypeName="DAOCategorias"></asp:ObjectDataSource>
                        <asp:RequiredFieldValidator ID="vacio_categoria" CssClass="text-danger" runat="server" ErrorMessage="Es necesario la categoria del producto !" ControlToValidate="lista_categoria" InitialValue="0">*</asp:RequiredFieldValidator>
                    </div>
                </div>
            <div class="form-group">
                    <asp:Label ID="lb_subcategoria" runat="server" CssClass="col-md-2 control-label" Text="Subcategoria"></asp:Label>
                    <div class="col-md-3">
                        <asp:DropDownList ID="lista_sub" CssClass="form-control" runat="server" DataSourceID="ODPsubcategoria" DataTextField="Subcategorias" DataValueField="Id"></asp:DropDownList>
                        <asp:ObjectDataSource ID="ODPsubcategoria" runat="server" SelectMethod="obtenerPsubcategorias" TypeName="DAOSubcategoria"></asp:ObjectDataSource>
                        <asp:RequiredFieldValidator ID="vacio_subcategoria" CssClass="text-danger" runat="server" ErrorMessage="Es necesario la categoria del producto" ControlToValidate="lista_sub" InitialValue="0">*</asp:RequiredFieldValidator>
                    </div>
                </div>
               <div class="form-group">
                    <asp:Label ID="lb_precio" runat="server" CssClass="col-md-2 control-label" Text="Precio Venta"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_precio" CssClass="form-control" runat="server" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="vacion_precio" CssClass="text-danger" runat="server" ErrorMessage="Es necesario el precio del producto" ControlToValidate="txt_precio">*</asp:RequiredFieldValidator>
                    </div>
                </div>
              <div class="form-group">
                    <asp:Label ID="lb_cantidad" runat="server" CssClass="col-md-2 control-label" Text="Cantidad"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_cantidad" CssClass="form-control" runat="server" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="vacio_cantidad" CssClass="text-danger" runat="server" ErrorMessage="Es necesario la cantidad del producto" ControlToValidate="txt_cantidad">*</asp:RequiredFieldValidator>
                    </div>
                </div>
              <div class="form-group">
                    <asp:Label ID="lb_descripcion" runat="server" CssClass="col-md-2 control-label" Text="Descripcion"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_descripcion" TextMode="MultiLine" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="vacio_descripcion" CssClass="text-danger" runat="server" ErrorMessage="Es necesario el precio del producto" ControlToValidate="txt_descripcion">*</asp:RequiredFieldValidator>
                    </div>
                </div>

              <div class="form-group">
                    <asp:Label ID="lb_imagen" runat="server" CssClass="col-md-2 control-label" Text="Imagen"></asp:Label>
                    <div class="col-md-3">
                        <asp:FileUpload ID="subir_imagen" CssClass="form-control" runat="server" />
                        <asp:RequiredFieldValidator ID="vacio_imagen" CssClass="text-danger" runat="server" ErrorMessage="Es necesario la imagen del producto" ControlToValidate="subir_imagen">*</asp:RequiredFieldValidator>
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
    </div>
     
         
</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/view/AdminMaster.master" AutoEventWireup="true" CodeFile="~/Controller/Categoria.aspx.cs" Inherits="view_Categoria" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <link href="css/centrar-Cs.css" rel="stylesheet" />
    <div class="container">
        <div class="form-horizontal">
                <div class="form-group">
                     <hr />
                    <hr />
                    <h2>Añadir Categoria</h2>
                    <hr />
                    <asp:Label ID="lb_categoria" runat="server" CssClass="col-md-2 control-label" Text="Categoria"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_categoria" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="vacio_categoria" CssClass="text-danger" runat="server" ErrorMessage="Es necesario el nombre de la categoria" ControlToValidate="txt_categoria">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" ErrorMessage="Ingrese solo letras" style="color: #990000" ID="error_codigo" ControlToValidate="txt_categoria" ValidationExpression="[A-Za-z ]*"></asp:RegularExpressionValidator>
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
        <h1>Categorias</h1>
        <hr />
        <div class="container">

      
        <div class="center">
        <asp:GridView CssClass="table table-bordered table-hover table-responsive" ID="DCategorias" runat="server" CellPadding="4" DataSourceID="ODSCategoria" ForeColor="#333333" GridLines="None" Width="672px" AutoGenerateColumns="False" DataKeyNames="Id">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="Categorias" HeaderText="Categorias" SortExpression="Categorias" />
                <asp:CommandField ShowEditButton="True" CausesValidation="False" />
                <asp:CommandField ShowDeleteButton="True" CausesValidation="False" />
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
             <asp:ObjectDataSource ID="ODSCategoria" runat="server" SelectMethod="obtenerCategoria2" TypeName="DAOCategorias" DataObjectTypeName="Categoria" DeleteMethod="CategoriaEliminar" UpdateMethod="ActualizarCategoria"></asp:ObjectDataSource>
             </div>
              </div>
           
        </div>
</asp:Content>


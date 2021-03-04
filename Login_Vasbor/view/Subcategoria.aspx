<%@ Page Title="" Language="C#" MasterPageFile="~/view/AdminMaster.master" AutoEventWireup="true" CodeFile="~/Controller/Subcategoria.aspx.cs" Inherits="view_Subcategoria" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="container">
        <div class="form-horizontal">      
                <div class="form-group">
                    <hr />
                    <hr />
                    <h2>Añadir Subcategoria</h2>
                    <hr />     
             <asp:Label ID="All_categoria" runat="server" CssClass="col-md-2 control-label" Text="Todas Las Categoria"></asp:Label>
                      <div class="col-md-3">
                        <asp:DropDownList ID="lista_categoria"  CssClass="form-control" runat="server" DataSourceID="ODCategoria" DataTextField="Categorias" DataValueField="Id"> </asp:DropDownList>                      
                        <asp:ObjectDataSource ID="ODCategoria" runat="server" SelectMethod="obtenerCategoria" TypeName="DAOCategorias"></asp:ObjectDataSource>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="text-danger" runat="server" ErrorMessage="*" ControlToValidate="lista_categoria" InitialValue="0"></asp:RequiredFieldValidator>
                    </div>
                </div>
               <div class="form-group">
                    <asp:Label ID="lb_categoria" runat="server" CssClass="col-md-2 control-label" Text="Subcategoria"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_categoria" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="error_categoria" CssClass="text-danger" runat="server" ErrorMessage="" ControlToValidate="txt_categoria">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" ErrorMessage="Ingrese solo letras" style="color: #990000" ID="error_nombres" ControlToValidate="txt_categoria" ValidationExpression="[A-Za-z ]*"></asp:RegularExpressionValidator>
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
         <h1>Subcategorias</h1>
        <hr />
        
         <asp:GridView CssClass="table table-bordered table-hover table-responsive" ID="DCategorias" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id,Id_categoria" DataSourceID="ODSsub" ForeColor="#333333" GridLines="None" Width="406px">
             <AlternatingRowStyle BackColor="White" />
             <Columns>
                 <asp:BoundField DataField="Subcategorias" HeaderText="Subcategoria" SortExpression="Subcategorias" />
                 <asp:TemplateField HeaderText="Categoria" SortExpression="Descripcion">
                     <EditItemTemplate>
                         <asp:Label ID="TextBox1" runat="server" Text='<%# Bind("Descripcion") %>'></asp:Label>
                     </EditItemTemplate>
                     <ItemTemplate>
                         <asp:Label ID="Label1" runat="server" Text='<%# Bind("Descripcion") %>'></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:CommandField CausesValidation="False" ShowEditButton="True" />
                 <asp:CommandField ShowDeleteButton="True" />
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
         <asp:ObjectDataSource ID="ODSsub" runat="server" SelectMethod="obtenerSubcategoria" TypeName="DAOSubcategoria" DataObjectTypeName="Subcategoria" DeleteMethod="SubCategoriaEliminar" UpdateMethod="ActualizarSubCategoria"></asp:ObjectDataSource>
        </div>
</asp:Content>


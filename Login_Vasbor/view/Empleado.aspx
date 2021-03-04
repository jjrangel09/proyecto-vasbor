<%@ Page Title="" Language="C#" MasterPageFile="~/view/AdminMaster.master" AutoEventWireup="true" CodeFile="~/Controller/Empleado.aspx.cs" Inherits="view_Empleado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Empleado</h1>
       
      <link href="css/centrar-Cs.css" rel="stylesheet" />
    <div class="container">
        <div class="form-horizontal">
                <div class="form-group">
                    <hr />
                    <hr />
                    <h2>Añadir Empleado</h2>
                    <hr />
                    <asp:Label ID="lb_nombre" runat="server" CssClass="col-md-2 control-label" Text="Nombre"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_nombre" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="vacio_nombres" CssClass="text-danger" runat="server" ErrorMessage="Es necesario el nombre" ControlToValidate="txt_nombre">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" ErrorMessage="Ingrese solo letras" style="color: #990000" ID="error_nombres" ControlToValidate="txt_nombre" ValidationExpression="[A-Za-z ]*"></asp:RegularExpressionValidator>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="lb_apellido" runat="server" CssClass="col-md-2 control-label" Text="Apellido"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_apellido" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="vacio_apellidos" CssClass="text-danger" runat="server" ErrorMessage="Es necesario el apellido" ControlToValidate="txt_apellido">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" ErrorMessage="Ingrese solo apellidos" style="color: #990000" ID="error_apellido" ControlToValidate="txt_apellido" ValidationExpression="[A-Za-z ]*"></asp:RegularExpressionValidator>
                    </div>
                </div>
              <div class="form-group">
                    <asp:Label ID="lb_correo" runat="server" CssClass="col-md-2 control-label" Text="Telefono"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_telefono" CssClass="form-control" runat="server" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="vacio_telefono" CssClass="text-danger" runat="server" ErrorMessage="Es necesario el telefono" ControlToValidate="txt_telefono">*</asp:RequiredFieldValidator>
                    </div>
                </div>
              <div class="form-group">
                    <asp:Label ID="lb_identi" runat="server" CssClass="col-md-2 control-label" Text="Codigo"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_identi" CssClass="form-control" runat="server" TextMode="Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="vacio_codigo" CssClass="text-danger" runat="server" ErrorMessage="Es necesario un codigo" ControlToValidate="txt_identi">*</asp:RequiredFieldValidator>
                    </div>
                </div>
              <div class="form-group">
                    <asp:Label ID="lb_username" runat="server" CssClass="col-md-2 control-label" Text="Nombre de usuario"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_username" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="vacio_username" CssClass="text-danger" runat="server" ErrorMessage="Es necesario el nombre de usuario" ControlToValidate="txt_username">*</asp:RequiredFieldValidator>
                    </div>
                </div>
              <div class="form-group">
                    <asp:Label ID="lb_clave" runat="server" CssClass="col-md-2 control-label" Text="Contraseña"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_clave" CssClass="form-control" runat="server"></asp:TextBox>
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
         <h1 class="centrar">Gestionar Empleado</h1>
        <hr />
        <div class="centrar" >
            <div >
                <h3 class="centrar">Tipo de estado</h3>
                <asp:GridView CssClass="table table-bordered table-hover" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="ODSEstado" ForeColor="#333333" GridLines="None">
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
        <hr />
        <div class="container">
            <div class=" table-responsive">
                <h3 class="centrar">Resgistros</h3>
                 <asp:GridView CssClass="table table-bordered table-hover" ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="ODSEmpleado" ForeColor="#333333" GridLines="None" Width="804px" DataKeyNames="Id,Id_rol,Descripcion_Rol,Clave" AllowPaging="True" >
                     <AlternatingRowStyle BackColor="White" />
                     <Columns>
                         <asp:TemplateField HeaderText="Nombre" SortExpression="Nombre">
                             <EditItemTemplate>
                                 <asp:TextBox ID="txt_editarNombre" runat="server" Text='<%# Bind("Nombre") %>'></asp:TextBox>
                                 <asp:Label ID="LB_editarNombre" runat="server" Text=""></asp:Label>
                             </EditItemTemplate>
                             <ItemTemplate>
                                 <asp:Label ID="Label1" runat="server" Text='<%# Bind("Nombre") %>'></asp:Label>
                             </ItemTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="Apellido" SortExpression="Apellido">
                             <EditItemTemplate>
                                 <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Apellido") %>'></asp:TextBox>
                             </EditItemTemplate>
                             <ItemTemplate>
                                 <asp:Label ID="Label2" runat="server" Text='<%# Bind("Apellido") %>'></asp:Label>
                             </ItemTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="Telefono" SortExpression="Telefono">
                             <EditItemTemplate>
                                 <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Telefono") %>'></asp:TextBox>
                             </EditItemTemplate>
                             <ItemTemplate>
                                 <asp:Label ID="Label3" runat="server" Text='<%# Bind("Telefono") %>'></asp:Label>
                             </ItemTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="Codigo" SortExpression="Id_codigo">
                             <EditItemTemplate>
                                 <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Id_codigo") %>'></asp:TextBox>
                             </EditItemTemplate>
                             <ItemTemplate>
                                 <asp:Label ID="Label4" runat="server" Text='<%# Bind("Id_codigo") %>'></asp:Label>
                             </ItemTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="Username" SortExpression="Username">
                             <EditItemTemplate>
                                 <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Username") %>'></asp:TextBox>
                             </EditItemTemplate>
                             <ItemTemplate>
                                 <asp:Label ID="Label5" runat="server" Text='<%# Bind("Username") %>'></asp:Label>
                             </ItemTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="Codigo Estado" SortExpression="Estado_id">
                             <EditItemTemplate>
                                 <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("Estado_id") %>'></asp:TextBox>
                             </EditItemTemplate>
                             <ItemTemplate>
                                 <asp:Label ID="Label6" runat="server" Text='<%# Bind("Estado_id") %>'></asp:Label>
                             </ItemTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField ShowHeader="False">
                             <EditItemTemplate>
                                 <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Actualizar"></asp:LinkButton>
                                 &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancelar"></asp:LinkButton>
                             </EditItemTemplate>
                             <ItemTemplate>
                                 <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Editar"></asp:LinkButton>
                             </ItemTemplate>
                         </asp:TemplateField>
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
                 <asp:ObjectDataSource ID="ODSEmpleado" runat="server" SelectMethod="obtenerEmpleados" TypeName="DAOEmpleado" DataObjectTypeName="Empleado" UpdateMethod="ActualizarEmpleado" DeleteMethod="eliminar"></asp:ObjectDataSource>
            </div>
        </div> 
        </div>
</asp:Content>


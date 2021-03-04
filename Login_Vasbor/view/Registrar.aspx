<%@ Page Language="C#" AutoEventWireup="true" CodeFile="~/Controller/Registrar.aspx.cs" Inherits="view_js_Registrar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Registrate</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet"/>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style type="text/css">
        .auto-style1 {
            color: #990000;
        }
        .auto-style2 {
            left: 0px;
            top: 0px;
        }
        .auto-style3 {
            position: relative;
            min-height: 1px;
            float: left;
            width: 91.66666667%;
            left: 0px;
            top: -1px;
            padding-left: 15px;
            padding-right: 15px;
        }
    </style>
  </head>
<body>
    <form id="form1" runat="server">
        <div>
             <div class="navbar navbar-default navbar-fixed-top" role="navigation" style="left: 0; right: 0; top: 0">
                <div class="container">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="Inicio.aspx"><span>
                        <img alt="Logo" src="../imagenes/vasbor.png" height="30" /></span>Vasbor</a>
                    </div>
                    <div class="navbar-collapse collapse">
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="Inicio.aspx">Inicio</a></li>
                            <li><a href="Nosotros.aspx">Nosotros</a></li>
                            <li><a href="Contactenos.aspx">Contactenos</a></li>
                            <li><a href="CatalogoInvitado.aspx"> Menus</a></li>
                            <li class="active"><a href="Registrar.aspx">Registrarse</a></li>
                             <li >
                                <asp:Button ID="btn_ingresar" CssClass="btn btn-default navbar-btn" Text="Ingresar" runat="server" OnClick="btn_ingresar_Click" CausesValidation="false" />
                                
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <link href="css/centrar-Cs.css" rel="stylesheet" />
        <!--Registro-->
        <div class="centrar-pagina">
            <label class="col-xs-11" >Nombre Usuario</label>
            <div class="col-xs-11">
            <asp:TextBox  ID="txt_username"  runat="server" Class="form-control"  placeholder="Ingresar Usuario" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="vacio_username" runat="server" ControlToValidate="txt_username" CssClass="auto-style1" ErrorMessage="Es necesario el nombre de usuario">*</asp:RequiredFieldValidator>
            </div>
             <label class="auto-style2" >&nbsp;&nbsp;&nbsp; Contraseña</label>
            <div class="auto-style3">
            <asp:TextBox  ID="txt_contraseña"  runat="server" Class="form-control"  placeholder="Contraseña" TextMode="Password" ValidationGroup="confirmar"></asp:TextBox>
                <asp:RequiredFieldValidator ID="vacio_clave" runat="server" ControlToValidate="txt_contraseña" Display="Dynamic" ErrorMessage="Es necesaria una contraseña" CssClass="auto-style1">*</asp:RequiredFieldValidator>
            </div>
             <label class="col-xs-11 espacio_cajas" >Confirmar Contraseña</label>
            <div class="col-xs-11">                
            <asp:TextBox  ID="txt_confirmar"  runat="server" Class="form-control"  placeholder="Confirmar Contraseña" TextMode="Password" ValidationGroup="confirmar"></asp:TextBox>
                <asp:RequiredFieldValidator ID="vacio_confirmar" runat="server" ControlToValidate="txt_confirmar" Display="Dynamic" ErrorMessage="Es necesario una confirmacion de contraseña" CssClass="auto-style1">*</asp:RequiredFieldValidator>
            </div>
             <label class="col-xs-11 espacio_cajas" >Nombre</label>
            <div class="col-xs-11">
            <asp:TextBox  ID="txt_nombre"  runat="server" Class="form-control"  placeholder="Nombres Completo"></asp:TextBox>
                <asp:RequiredFieldValidator ID="vacio_nombre" runat="server" ControlToValidate="txt_nombre" CssClass="auto-style1" ErrorMessage="El necesario el nombre">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="error_nombre" runat="server" ControlToValidate="txt_nombre" CssClass="auto-style1" ErrorMessage="Ingresar solo letras" ValidationExpression="[A-Za-z ]*"></asp:RegularExpressionValidator>
            </div>
             <label class="col-xs-11 espacio_cajas" >Apellido</label>
            <div class="col-xs-11">
            <asp:TextBox  ID="txt_apellido"  runat="server" Class="form-control"  placeholder="Apellidos Completo"></asp:TextBox>
                <asp:RequiredFieldValidator ID="vacio_apellido" runat="server" ControlToValidate="txt_apellido" CssClass="auto-style1" ErrorMessage="Es necesario el apellido">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="error_apellido" runat="server" ControlToValidate="txt_apellido" CssClass="auto-style1" ErrorMessage="Ingresar solo letras" ValidationExpression="[A-Za-z ]*"></asp:RegularExpressionValidator>
            </div>
             <label class="col-xs-11 espacio_cajas" >Identificacion</label>
            <div class="col-xs-11">
            <asp:TextBox  ID="txt_identificacion"  runat="server" Class="form-control"  placeholder="Identificacion" TextMode="Number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="vacio_identi" runat="server" ControlToValidate="txt_identificacion" CssClass="auto-style1" ErrorMessage="Es necesario una identificacion">*</asp:RequiredFieldValidator>
            </div>
             <label class="col-xs-11 espacio_cajas" >Telefono/Celular</label>
            <div class="col-xs-11">
            <asp:TextBox  ID="txt_telefono"  runat="server" Class="form-control"  placeholder="Telefono" TextMode="Number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="vacio_telefono" runat="server" ControlToValidate="txt_telefono" CssClass="auto-style1" ErrorMessage="Es necesario un telefono">*</asp:RequiredFieldValidator>
                
            </div>
             <label class="col-xs-11 espacio_cajas" >Correo</label>
            <div class="col-xs-11">
            <asp:TextBox  ID="txt_correo"  runat="server" Class="form-control"  placeholder="Correo" TextMode="Email"></asp:TextBox>
                <asp:RequiredFieldValidator ID="vacio_correo" runat="server" ControlToValidate="txt_correo" CssClass="auto-style1" ErrorMessage="Es necesario un correo">*</asp:RequiredFieldValidator>
            </div>
            <div class=" col-xs-11 espacio_boton">
            <asp:Button ID="btn_registrar" Class="btn btn-success" Text="Registrate" runat="server" OnClick="btn_registrar_Click" />
                <asp:Label ID="lb_mensaje" runat="server" Text=""></asp:Label>
            </div>
        </div>
           <!--- Sign in end  -->
           <hr />
        <footer class="piepagina_posicion">
            <div class="container">
                <p class="pull-right"><a href="#">De regreso</a></p>
                <p>&copy; 2020 Vasbor S.A.S &middot; <a href="Inicio.aspx">Inicio</a> &middot; <a href="#">Contactanos</a> &middot;<a href="Nosotros.aspx">Nosotros</a></p>
            </div>
        </footer>
    </form>
     <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
</body>
</html>

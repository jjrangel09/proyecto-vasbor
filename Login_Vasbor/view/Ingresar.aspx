<%@ Page Language="C#" AutoEventWireup="true" CodeFile="~/Controller/Ingresar.aspx.cs" Inherits="Ingresar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Ingresar</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet"/>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="navbar navbar-default navbar-fixed-top" role="navigation">
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
                             <li>
                               <asp:Button Text="Manual De Usuario" CssClass="btn btn-primary navbar-btn" runat="server" OnClick="Unnamed_Click"/>
                           </li> 
                            <li><a href="Inicio.aspx">Inicio</a></li>
                            <li><a href="Nosotros.aspx">Nosotros</a></li>
                            <li><a href="Contactenos.aspx">Contactenos</a></li>
                            <li><a href="CatalogoInvitado.aspx">Menus</a> </li>
                            <li><a href="Registrar.aspx">Registrate</a> </li>
                            <li >
                                <asp:Button ID="Button1" CssClass="btn btn-default navbar-btn" Text="Ingresar" runat="server" OnClick="btn_ingresar_Click" CausesValidation="false" />
                            </li>             
                        </ul>
                    </div>
                </div>
            </div>
            
    <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
        <!--- Sign in start  -->
        <div class="container">
            <div class="form-horizontal">
                <hr />
                <div class="form-group">
                
                <h2>Login</h2>
                <hr />
                    <asp:Label ID="lb_username" runat="server" CssClass="col-md-2 control-label" Text="Nombre Usuario"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_username" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="vacio_username" CssClass="text-danger" runat="server" ErrorMessage="Es necesario el nombre de usuario" ControlToValidate="txt_username">*</asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <asp:Label ID="lb_contraseña" runat="server" CssClass="col-md-2 control-label" Text="Contraseña"></asp:Label>
                    <div class="col-md-3">
                        <asp:TextBox ID="txt_contraseña" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="vacio_contraseña" CssClass="text-danger" runat="server" ErrorMessage="Es necesario la contraseña" ControlToValidate="txt_contraseña">*</asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-2"></div>
                    <div class="col-md-6">
                        <asp:CheckBox ID="CheckBox1" runat="server" />
                        <asp:Label ID="Label3" runat="server" CssClass="control-label" Text="¿Recordarme?"></asp:Label>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-2"></div>
                    <div class="col-md-6">
                        <asp:Button ID="btn_ingresar" runat="server" Text="Ingresar" CssClass="btn btn-primary" OnClick="btn_ingresar_Click"  />
                        <asp:LinkButton ID="LinkButton1" runat="server"  PostBackUrl="~/view/Registrar.aspx" CausesValidation="False">Registrate</asp:LinkButton>                     
                    </div>
                </div>
                   <div class="form-group">
                    <div class="col-md-2"></div>
                    <div class="col-md-6"> 
                        <asp:LinkButton ID="olvidar" Text="¿Olvido Su Contraseña?" runat="server" PostBackUrl="~/view/olvido_clave.aspx" CausesValidation="false"/>
                    </div>
                </div>
               <div class="form-group">
                    <div class="col-md-2"></div>
                    <div class="col-md-6"> 
                        <asp:Label ID="lb_error" runat="server" CssClass="text-danger" Text=""></asp:Label>
                    </div>
                </div>
               
            </div>
        </div>
        <!--- Sign in end  -->
           <hr />
        <footer class="piepagina_posicion">
            <div class="container">
                <p class="pull-right"><a href="#">De regreso</a></p>
                <p>&copy; 2020 Vasbor S.A.S &middot; <a href="Inicio.aspx">Inicio</a> &middot; <a href="Contactenos.aspx">Contactanos</a> &middot;<a href="Nosotros.aspx">Nosotros</a></p>
            </div>
        </footer>
    </form>
     <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
</body>
</html>

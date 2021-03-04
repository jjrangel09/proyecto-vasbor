using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_Catalogo : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["validar_sesion_usuario"] != null && ((EPersona)Session["validar_sesion_usuario"]).Id_rol == 3)
        {

        }
        else
        {
            Response.Redirect("Ingresar.aspx");
        }

        lb_Concar.Text = new DAOProducto().obtenerCantidadProductoxUser(((EPersona)Session["validar_sesion_usuario"]).Id).ToString();
    }

    protected void btn_ingresa_Click(object sender, EventArgs e)
    {
       // Session["validar_sesion"] = null;
        Response.Redirect("Ingresar.aspx");
    }

    protected void btn_cerrarusuario_Click(object sender, EventArgs e)
    {
        Session["validar_sesion_usuario"] = null;
        Response.Redirect("Inicio.aspx");
    }

    protected void btn_cart_Click(object sender, EventArgs e)
    {
        Response.Redirect("DetalleCarrito.aspx");
    }
}

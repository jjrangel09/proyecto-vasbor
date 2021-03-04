using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_js_SAdministrador : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["validar_sesion_administrador"] != null && ((Administrador)Session["validar_sesion_administrador"]).Id_rol == 1)
        {
            lb_sesion.Text = ((Administrador)Session["validar_sesion_administrador"]).Nombre.ToString() + " " + ((Administrador)Session["validar_sesion_administrador"]).Apellido.ToString();
        }
        else
        {
            Response.Redirect("Ingresar.aspx");
        }
    }
}
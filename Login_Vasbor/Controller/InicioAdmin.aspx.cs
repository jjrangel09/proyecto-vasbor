using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_InicioAdmin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        EPersona eUser = new EPersona();
        if (Session["validar_sesion"] != null )
        {

        }
        else
        {
            Response.Redirect("Ingresar.aspx");
        }
    }

    protected void btn_cerraradmin_Click(object sender, EventArgs e)
    {
        Session["validar_sesion"] = null;
        Response.Redirect("Inicio.aspx");
    }
}
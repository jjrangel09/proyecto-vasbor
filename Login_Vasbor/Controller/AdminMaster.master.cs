using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["validar_sesion_administrador"] != null && ((Administrador)Session["validar_sesion_administrador"]).Id_rol == 1 )
        {

        }
        else
        {
            Response.Redirect("Ingresar.aspx");
        }
    }
        

    protected void btn_cerraradmin_Click(object sender, EventArgs e)
    {
        Session["validar_sesion_administrador"] = null;
        Response.Redirect("Inicio.aspx");
    }
}

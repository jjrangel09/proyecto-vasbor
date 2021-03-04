using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Inicio : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }
   

    protected void btn_ingresar_Click(object sender, EventArgs e)
    {
        Response.Redirect("Ingresar.aspx");
    }

    protected void Unnamed_Click(object sender, EventArgs e)
    {
        Response.Write("<script> window.open('" + "ManualUsuarioU.pdf" + "','_blank'); </script>");
    }
}
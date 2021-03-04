using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_Contactenos : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Unnamed_Click(object sender, EventArgs e)
    {
        Response.Write("<script> window.open('https://www.facebook.com/VasborRestaurante','_blank'); </script>");
    }

    protected void Unnamed_Click1(object sender, EventArgs e)
    {
        Response.Write("<script> window.open('https://www.instagram.com/vasbor11/','_blank'); </script>");
    
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_DetalleCarrito : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lb_Con.Text = new DAOProducto().obtenerCantidadProductoxUser(((EPersona)Session["validar_sesion_usuario"]).Id).ToString();
        tot();
    }

    private void tot()
    {
        lb_precioT.Text= string.Format("{0:C}", new DAOProducto().obtenerProductosCarrito(int.Parse(Session["id_usuario"].ToString())).Sum(x => x.Total));
        lb_total.Text = string.Format("{0:C}", new DAOProducto().obtenerProductosCarrito(int.Parse(Session["id_usuario"].ToString())).Sum(x => x.Total));
    }


    protected void DCatalogo_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int id = int.Parse(e.CommandArgument.ToString());
        int id_usuario = int.Parse(Session["id_usuario"].ToString());
        new DAOProducto().borrarProductoCarro(id, id_usuario);


        Response.Redirect("DetalleCarrito.aspx");
    }

    protected void btncomprar_Click(object sender, EventArgs e)
    {
        if (lb_Con.Text == "0")
        {
            return;
        }
        else
        {
            Response.Redirect("DomicilioU.aspx");
        }
    }
}
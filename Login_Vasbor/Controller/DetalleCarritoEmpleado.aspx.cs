using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_DetalleCarritoEmpleado : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lb_Con.Text = new DAOEmpleado().obtenerCantidadProductoxEmpleado(((Empleado)Session["validar_sesion_empleado"]).Id).ToString();
        tot();
    }

     private void tot()
    {
        lb_precioT.Text = string.Format("{0:C}", new DAOEmpleado().obtenerProductosCarritoE(int.Parse(Session["id_empleado"].ToString())).Sum(x => x.Total));
        lb_total.Text = string.Format("{0:C}", new DAOEmpleado().obtenerProductosCarritoE(int.Parse(Session["id_empleado"].ToString())).Sum(x => x.Total));
    }
    protected void DCatalogo_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int id = int.Parse(e.CommandArgument.ToString());
        int id_empleado = int.Parse(Session["id_empleado"].ToString());
        new DAOEmpleado().borrarProductoCarroEmpleado(id, id_empleado);


        Response.Redirect("DetalleCarritoEmpleado.aspx");
    }

    protected void btncomprar_Click(object sender, EventArgs e)
    {
        if (lb_Con.Text == "0")
        {
            return;
        }
        else
        {
            Response.Redirect("PedidoMesero.aspx");
        }
    }
}
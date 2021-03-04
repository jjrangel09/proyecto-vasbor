using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_AdminCatalogoEmpleado : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lb_Concar.Text = new DAOEmpleado().obtenerCantidadProductoxEmpleado(((Empleado)Session["validar_sesion_empleado"]).Id).ToString();
        lb_pedido.Text= new DAOEmpleado().obtenerCantidadPedidosxEmpleado(((Empleado)Session["validar_sesion_empleado"]).Id).ToString();
        if (Session["validar_sesion_empleado"] != null && ((Empleado)Session["validar_sesion_empleado"]).Id_rol == 2)
        {

        }
        else
        {
            Response.Redirect("Ingresar.aspx");
        }
    }


    protected void btn_cerrarusuario_Click(object sender, EventArgs e)
    {
        Session["validar_sesion_empleado"] = null;
        Response.Redirect("Inicio.aspx");
    }

    protected void btn_cart_Click(object sender, EventArgs e)
    {
        Response.Redirect("DetalleCarritoEmpleado.aspx");
    }

    protected void btn_pedido_Click(object sender, EventArgs e)
    {
        Response.Redirect("PedidoEspera.aspx");
    }
}

using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_PedidoEspera : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lb_pedido.Text = new DAOEmpleado().obtenerCantidadPedidosxEmpleado(((Empleado)Session["validar_sesion_empleado"]).Id).ToString();
    }

    protected void btn_añadir_Click(object sender, EventArgs e)
    {
        if (lb_pedido.Text == "0" )
        {
            return;
        }
        else
        {
            int idpedido = int.Parse(mesa_pendiente.SelectedValue);
            Session["id_pedido"] = idpedido;
            PedidoM P = new PedidoM();
            P = (new DAOEmpleado().ObtenerPedidoE(int.Parse(Session["id_pedido"].ToString())));
            int idFactura = P.Id;
            long total = P.Total;
            string pedido = P.Detalle;
            int pago = P.Id_pago;
            int cantidad = P.Cantidad;
            DetallePedidoM detalle = new DetallePedidoM();
            detalle.Id_pedido = idpedido;
            detalle.Cantidad = cantidad;
            detalle.Total = total;
            detalle.Fecha = DateTime.Now;
            detalle.Id_mesero = int.Parse(Session["id_empleado"].ToString());
            detalle.Detalle = pedido;
            detalle.Id_pago = pago;
            new DAOEmpleado().InsertarDetalleEmpleado(detalle);
            new DAOEmpleado().borrarPedidoPendiente(int.Parse(Session["id_pedido"].ToString()));
            Response.Redirect("FacturaCompraEmpleado.aspx");
        }
      
    }
}
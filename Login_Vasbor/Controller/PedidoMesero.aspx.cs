using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_PedidoMesero : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lb_total.Text = string.Format("{0:C}", new DAOEmpleado().obtenerProductosCarritoE(int.Parse(Session["id_empleado"].ToString())).Sum(x => x.Total));
    }

    protected void btn_añadir_Click(object sender, EventArgs e)
    {
        ClientScriptManager cm = this.ClientScript;
        string seguridad= (new DAOEmpleado().obtenerProductosCarritoE(int.Parse(Session["id_empleado"].ToString())).Sum(x => x.Total).ToString());
        long verificar = long.Parse(seguridad);
        if (verificar == 0)
        {
            return;
        }
        else
        {
            List<CarritoE> car = new DAOEmpleado().obtenerProductosCarritoE(int.Parse(Session["id_empleado"].ToString()));
            for (int i = 0; i <= car[i].Cantidad; i++)
            {
                Producto p = new DAOProducto().VerificarProducto(car[i].Producto_id);
                string nom = car[i].NombreProducto;
                if (car[i].Cantidad <= p.Cantidad)
                {
                    string total = string.Format(new DAOEmpleado().obtenerProductosCarritoE(int.Parse(Session["id_empleado"].ToString())).Sum(x => x.Total).ToString());
                    PedidoM pedido = new PedidoM();
                    pedido.Id_mesero = int.Parse(Session["id_empleado"].ToString());
                    pedido.Id_mesa = int.Parse(tipo_mesa.SelectedValue);
                    pedido.Total = long.Parse(total);
                    pedido.Fecha = DateTime.Now;
                    List<CarritoE> lista = new DAOEmpleado().obtenerProductosCarritoE(int.Parse(Session["id_empleado"].ToString()));
                    pedido.Detalle = JsonConvert.SerializeObject(lista, Formatting.Indented, new JsonSerializerSettings
                    {
                        NullValueHandling = NullValueHandling.Ignore
                    });
                    pedido.Id_pago = int.Parse(tipo_pago.SelectedValue);
                    pedido.Cantidad = int.Parse(new DAOEmpleado().obtenerCantidadProductoxEmpleado(int.Parse(Session["id_empleado"].ToString())).ToString());
                    ReporteGM reporte = new ReporteGM();
                    reporte.Id_mesero = int.Parse(Session["id_empleado"].ToString());
                    reporte.Total = long.Parse(total);
                    reporte.Fecha = DateTime.Now;
                    new DAOAdministrador().InsertarReporteMesero(reporte);
                    new DAOEmpleado().InsertarPedidoEmpleado(pedido);
                    new DAOEmpleado().ActulizarCantidad(int.Parse(Session["id_empleado"].ToString()));
                    new DAOEmpleado().borrarCarroEmpleado(int.Parse(Session["id_empleado"].ToString()));
                    Response.Redirect("CatalogoEmpleado.aspx");
                }
                else if (car[0].Cantidad > p.Cantidad)
                {
                    cm.RegisterClientScriptBlock(this.GetType(), "", "<script type='text/javascript'>alert('Cantidad No Disponible De:" + nom + ".Error:');</script>");
                    return;
                }
                else
                {

                    cm.RegisterClientScriptBlock(this.GetType(), "", "<script type='text/javascript'>alert('Error No Identificado  .Error:');</script>");
                    Session["id_empleado"] = null;
                    Response.Redirect("Ingresar.aspx");
                }
            }
              
                
        }
       // detallepedidoM();
    }
    public void detallepedidoM()
    {
      /*  PedidoM P  = new PedidoM();
        P =(new DAOEmpleado().ObtenerPedidoE(int.Parse(Session["id_empleado"].ToString())));
        int idFactura = P.Id;
        string total = string.Format(new DAOEmpleado().obtenerProductosCarritoE(int.Parse(Session["id_empleado"].ToString())).Sum(x => x.Total).ToString());
        DetallePedidoM detalle = new DetallePedidoM();
        detalle.Id_pedido = idFactura;
        detalle.Cantidad = int.Parse(new DAOEmpleado().obtenerCantidadProductoxEmpleado(int.Parse(Session["id_empleado"].ToString())).ToString());
        detalle.Total = long.Parse(total);
        detalle.Fecha = DateTime.Now;
        detalle.Id_mesero= int.Parse(Session["id_empleado"].ToString());
        List<CarritoE> listaP = new DAOEmpleado().obtenerProductosCarritoE(int.Parse(Session["id_empleado"].ToString()));
        detalle.Detalle = JsonConvert.SerializeObject(listaP, Formatting.Indented, new JsonSerializerSettings
        {
            NullValueHandling = NullValueHandling.Ignore
        });
        detalle.Id_pago = int.Parse(tipo_pago.SelectedValue);
      
        new DAOEmpleado().InsertarDetalleEmpleado(detalle);
        new DAOEmpleado().ActulizarCantidad(int.Parse(Session["id_empleado"].ToString()));
        new DAOEmpleado().borrarCarroEmpleado(int.Parse(Session["id_empleado"].ToString()));
        Response.Redirect("CatalogoEmpleado.aspx");*/
    }

}
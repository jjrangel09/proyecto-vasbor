using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_Pedido : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lb_total.Text = string.Format("{0:C}", new DAOProducto().obtenerProductosCarrito(int.Parse(Session["id_usuario"].ToString())).Sum(x => x.Total));
    }

    protected void btn_añadir_Click(object sender, EventArgs e)
    {
        ClientScriptManager cm = this.ClientScript;
        string seguridad = (new DAOProducto().obtenerProductosCarrito(int.Parse(Session["id_usuario"].ToString())).Sum(x => x.Total)).ToString();
        long verificar = long.Parse(seguridad);
        if (verificar == 0)
        {
            return;
        }
        else
        {
            List<Carrito> car = new DAOProducto().obtenerProductosCarrito(int.Parse(Session["id_usuario"].ToString()));
           
            for (int i = 0; i <=car[i].Cantidad; i++)
            {
                Producto p = new DAOProducto().VerificarProducto(car[i].Producto_id);
                string nom = car[i].NombreProducto;
                if (car[i].Cantidad <= p.Cantidad)
                {
                    string total = (new DAOProducto().obtenerProductosCarrito(int.Parse(Session["id_usuario"].ToString())).Sum(x => x.Total)).ToString();
                    Pedido pedido = new Pedido();
                    pedido.Id_usuario = int.Parse(Session["id_usuario"].ToString());
                    pedido.Id_pago = int.Parse(tipo_pago.SelectedValue);
                    pedido.Id_domicilio = int.Parse(tipo_domicilio.SelectedValue);
                    pedido.Total = long.Parse(total);
                    pedido.Fecha = DateTime.Now;
                    Session["idDomicilio"] = int.Parse(pedido.Id_domicilio.ToString());
                    ReporteG reporte = new ReporteG();
                    reporte.Id_persona = int.Parse(Session["id_usuario"].ToString());
                    reporte.Total = long.Parse(total);
                    reporte.Fecha = DateTime.Now;
                    new DAOAdministrador().InsertarReporteUsuario(reporte);
                    new DAOFactura().InsertarPedido(pedido);
                    detallepedido();

                }
                else if (car[0].Cantidad > p.Cantidad)
                {
                    cm.RegisterClientScriptBlock(this.GetType(), "", "<script type='text/javascript'>alert('Cantidad No Disponible De:"+nom +".Error:');</script>");
                    return;
                }
                else
                {

                    cm.RegisterClientScriptBlock(this.GetType(), "", "<script type='text/javascript'>alert('Error No Identificado  .Error:');</script>");
                    Session["id_usuario"] = null;
                    Response.Redirect("Ingresar.aspx");
                }
            }
            
            
           
           

       
        }
       
            
            }

    public void detallepedido()
    {
        string total = (new DAOProducto().obtenerProductosCarrito(int.Parse(Session["id_usuario"].ToString())).Sum(x => x.Total)).ToString();
        DetallePedido detalle = new DetallePedido();
        detalle.Id_usuario = int.Parse(Session["id_usuario"].ToString());
        detalle.Cantidad = int.Parse(new DAOProducto().obtenerCantidadProductoxUser(((EPersona)Session["validar_sesion_usuario"]).Id).ToString());
        detalle.Fecha = DateTime.Now;
        detalle.Total = long.Parse(total);
        List<Pedido> P = new List<Pedido>();
        P = (new DAOFactura().ObtenerPedidoU(int.Parse(Session["id_usuario"].ToString())).ToList());
        int idFactura = P[0].Id;
        detalle.Id_pedido = idFactura;
        List<Carrito> listaP = new DAOProducto().obtenerProductosCarrito(int.Parse(Session["id_usuario"].ToString()));
        detalle.Detalle = JsonConvert.SerializeObject(listaP, Formatting.Indented, new JsonSerializerSettings
        {
            NullValueHandling = NullValueHandling.Ignore
        });
        detalle.Idpago= int.Parse(tipo_pago.SelectedValue);
        Session["id_pedido"] = idFactura;
      new DAOFactura().InsertarDetallePedido(detalle);
        Response.Redirect("FacturaCompra.aspx");
       
       
    }
}
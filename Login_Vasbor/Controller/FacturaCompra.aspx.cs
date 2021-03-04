using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_FacturaCompra : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ImprimirReporte();
        new DAOFactura().eliminarPedidos(int.Parse(Session["id_usuario"].ToString()));
        new DAOFactura().EliminarActulizar(int.Parse(Session["id_usuario"].ToString()));
      //  Session["id_pedido"] = null;

    }
    private void ImprimirReporte()
    {
        CR_S.ReportDocument.SetDataSource(InformacionReporte());
        CR_V.ReportSource = CR_S;
    }

    private FacturaActualizada InformacionReporte()
    {

       /// List<Domicilio> FacturaC = new DAOFactura().facturaCompra(int.Parse(Session["id_usuario"].ToString()));
        DomicilioU domi = new DAOFactura().obtenerDireccion(int.Parse(Session["idDomicilio"].ToString()));
        string domicilio =domi.Direccion;
       // Pedido pedido = new DAOProducto().obtenerUltimoPedido(int.Parse(Session["id_usuario"].ToString()));
       // int idPedido = pedido.Id;

        DetallePedido nom = new DAOProducto().obtenerDatosFactura(int.Parse(Session["id_pedido"].ToString()), int.Parse(Session["id_usuario"].ToString()), domicilio);

       // FacturaCompra informe = new FacturaCompra();
        FacturaActualizada informe2 = new FacturaActualizada();
        DataTable datosFinal = informe2.FacturaA;
        DataRow fila;
        if (nom!=null)
        {
            foreach (DetallePedido registro in JsonConvert.DeserializeObject<List<DetallePedido>>(nom.Detalle))
            {
                fila = datosFinal.NewRow();
                fila["nombreusuario"] = nom.Nombre_usuario;
                fila["nombreproducto"] = registro.NombreProducto;
                fila["precio"] = registro.Precio;
                fila["cantidad"] = registro.Cantidad;
                fila["total"] = registro.Total;
                fila["pago"] = nom.Form;
                fila["direccion"] = nom.Direccion;
                fila["factura"] = nom.Id_pedido;
                fila["imagen"] = obtenerImagen(registro.Imagen);
                fila["fecha"] = nom.Fecha;
                datosFinal.Rows.Add(fila);
            }
            
        }
        return informe2;
    }

    protected byte[] obtenerImagen(String url)
    {
        String urlImagen = Server.MapPath(url);

        if (!System.IO.File.Exists(urlImagen))
        {
            urlImagen = Server.MapPath("~\\Imagenes\\Sistema\\" + "NoDisponible.png");
        }

        byte[] fileBytes = System.IO.File.ReadAllBytes(urlImagen);

        return fileBytes;

    }


}
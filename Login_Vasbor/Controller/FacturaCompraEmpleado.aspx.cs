using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_FacturaCompraEmpleado : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       ImprimirReporte();
      
        
       
    }
    private void ImprimirReporte()
    {
        CR_S.ReportDocument.SetDataSource(InformacionReporte());
        CR_V.ReportSource = CR_S;
    }
    private FacturaCompraEmpleado InformacionReporte()
    {

        int id_pedido = int.Parse(Session["id_pedido"].ToString());
        DetallePedidoM nom = new DAOEmpleado().obtenerFacturaEmpleado(int.Parse(Session["id_pedido"].ToString()), int.Parse(Session["id_empleado"].ToString()));   
        FacturaCompraEmpleado informe = new FacturaCompraEmpleado();
        DataTable datosFinal = informe.FacturaEmpleado;
        DataRow fila;
        if (nom != null)
        {
            foreach (DetallePedidoM registro in JsonConvert.DeserializeObject<List<DetallePedidoM>>(nom.Detalle))
            {
                fila = datosFinal.NewRow();
                fila["Factura"] = nom.Id_pedido;
                fila["Fecha"] = registro.Fecha;
                fila["NombreEmpleado"] = nom.Nombre_empleado;
                fila["Total"] = registro.Total;
                fila["ProductoNombre"] = registro.NombreProducto;
                fila["precio"] = registro.Precio;
                fila["Cantidad"] = registro.Cantidad;
                fila["Pago"] = nom.Form;
                fila["imagen"] = obtenerImagen(registro.Imagen);
                datosFinal.Rows.Add(fila);
            }        
        }
     //   new DAOEmpleado().borrarPedidoPendiente(int.Parse(Session["id_pedido"].ToString()));
        return informe;    
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
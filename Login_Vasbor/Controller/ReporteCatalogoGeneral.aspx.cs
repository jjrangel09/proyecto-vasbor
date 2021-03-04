using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_ReporteCatalogoGeneral : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ImprimirReporte();
    }
    private void ImprimirReporte()
    {
        Report_CatalogoS.ReportDocument.SetDataSource(InformacionReporte());
        Report_CatalogoV.ReportSource = Report_CatalogoS;
    }
    protected General_Producto InformacionReporte()
    {
        List<Producto> ListaProductos = new DAOProducto().obtenerProductoReporte();
        General_Producto informe = new General_Producto();
        DataTable datosFinal = informe.Producto;
        DataRow fila;

        foreach (Producto registro in ListaProductos)
        {
            fila = datosFinal.NewRow();
            fila["ProductoId"] = registro.Id;
            fila["ProductoNombre"] = registro.Nombre;
            fila["ProductoCategoria"] = registro.Categorrias;
            fila["ProductoSubcategoria"] = registro.Subcategorias;
            fila["ProductoPrecio"] = registro.Precio;
            fila["ProductoImagen"] = obtenerImagen(registro.Imagen);
            fila["ProductoDescripcion"] = registro.Descripcion;
            fila["ProductoCantidad"] = registro.Cantidad;
            datosFinal.Rows.Add(fila);
        }

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
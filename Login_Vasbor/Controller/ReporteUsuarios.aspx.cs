using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_ReporteUsuarios : System.Web.UI.Page
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
    protected ReporteMonetario InformacionReporte()
    {
        List<ReporteG> Lista = new DAOFactura().obtenerReporteUsuarios();
        ReporteMonetario informe = new ReporteMonetario();
        DataTable datosFinal = informe.ReporteUsuario;
        DataRow fila;

        foreach (ReporteG registro in Lista)
        {
            fila = datosFinal.NewRow();
            fila["Codigo"] = registro.Id;
            fila["Codigo_Usuario"] = registro.Id_persona;
            fila["Total"] = registro.Total;
            fila["Fecha"] = registro.Fecha;
            fila["Nombre_Usuario"] = registro.Nombre_usuario;
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
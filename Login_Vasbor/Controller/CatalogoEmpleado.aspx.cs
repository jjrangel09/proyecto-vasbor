using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_CatalogoEmpleado : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void DCatalogo_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (int.Parse(((TextBox)e.Item.FindControl("txt_cantidad")).Text) <= 0)
        {
            ((Label)e.Item.FindControl("lb_mensaje")).ForeColor = Color.Red;
            ((Label)e.Item.FindControl("lb_mensaje")).Text = "Ingrese numeros mayores a 0";
            return;
        }
        ClientScriptManager cm = this.ClientScript;
        int stock = int.Parse(((Label)e.Item.FindControl("lb_cantidad")).Text);
        double precio = double.Parse(((Label)e.Item.FindControl("lb_precio")).Text.Replace("$", ""));
        int cantidadSolicitada = int.Parse(((TextBox)e.Item.FindControl("txt_cantidad")).Text);
        int cantidadDisponible = new DAOEmpleado().obtenerCantidadxProducto(int.Parse(e.CommandArgument.ToString()));
        if (e.Item.FindControl("txt_cantidad") != null || cantidadSolicitada > cantidadDisponible)
        {
            if (cantidadSolicitada > stock)
            {
                cm.RegisterClientScriptBlock(this.GetType(), "", "<script type='text/javascript'>alert('Cantidad No disponible. Disponible:');</script>");
                //this.RegisterStartupScript("mensaje", "<script type='text/javascript'>alert('Cantidad No disponible. Disponible: '" + cantidadDisponible.ToString() + "');</script>");
                return;
            }
            CarritoE agregar = new CarritoE();
            agregar.Producto_id = int.Parse(e.CommandArgument.ToString());
            agregar.Id_mesero = ((Empleado)Session["validar_sesion_empleado"]).Id;
            agregar.Cantidad = cantidadSolicitada;
            agregar.Fecha = DateTime.Now;
            agregar.Precio = precio;
            new DAOEmpleado().agregarCarritoEmpleado(agregar);
            cm.RegisterClientScriptBlock(this.GetType(), "", "<script type='text/javascript'>alert('Producto Agregado');</script>");
            Response.Redirect("CatalogoEmpleado.aspx");

        }
    }
}
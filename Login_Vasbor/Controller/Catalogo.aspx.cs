using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_Catalogo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["validar_sesion_usuario"] !=null && ((EPersona)Session["validar_sesion_usuario"]).Id_rol==3)
          {
              
          }
          else
          {
              Response.Redirect("Ingresar.aspx");
          }
        //Session["validar_sesion_usuario"]= 3;
       
    }

    protected void DCatalogo_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        ClientScriptManager cm = this.ClientScript;
        if (int.Parse(((TextBox)e.Item.FindControl("txt_cantidad")).Text) <= 0)
        {
            ((Label)e.Item.FindControl("lb_mensaje")).ForeColor = Color.Red;
            ((Label)e.Item.FindControl("lb_mensaje")).Text = "Ingrese numeros mayores a 0";
            return;
        }
        int cantidadSolicitada = int.Parse(((TextBox)e.Item.FindControl("txt_cantidad")).Text);
        int cantidadDisponible = new DAOProducto().obtenerCantidadxProducto(int.Parse(e.CommandArgument.ToString()));
       
        int stock = int.Parse(((Label)e.Item.FindControl("lb_cantidad")).Text);
        double precio = double.Parse(((Label)e.Item.FindControl("lb_precio")).Text.Replace("$", ""));
      
        if (e.Item.FindControl("txt_cantidad") != null || cantidadSolicitada > cantidadDisponible)
        {
            if (cantidadSolicitada > stock )
            {
                cm.RegisterClientScriptBlock(this.GetType(), "", "<script type='text/javascript'>alert('Cantidad No disponible. Disponible:');</script>");
                //this.RegisterStartupScript("mensaje", "<script type='text/javascript'>alert('Cantidad No disponible. Disponible: '" + cantidadDisponible.ToString() + "');</script>");
                return;
            }
            Carrito agregar = new Carrito();
            agregar.Producto_id = int.Parse(e.CommandArgument.ToString());
            agregar.Usuario_id = ((EPersona)Session["validar_sesion_usuario"]).Id;
            agregar.Cantidad = cantidadSolicitada;
            agregar.Fecha = DateTime.Now;
            agregar.Precio = precio;
            new DAOProducto().agregarCarrito(agregar);

            cm.RegisterClientScriptBlock(this.GetType(), "", "<script type='text/javascript'>alert('Producto Agregado');</script>");
            Response.Redirect("Catalogo.aspx");

        }
    }

    
}
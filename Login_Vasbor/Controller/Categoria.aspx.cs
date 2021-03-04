using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_Categoria : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (Session["validar_sesion_administrador"] != null )
        {

        }
        else
        {
            Response.Redirect("Ingresar.aspx");
        }
    }



    protected void btn_añadir_Click(object sender, EventArgs e)
    {
        Categoria categoria = new Categoria();
        categoria.Categorias = txt_categoria.Text;

        categoria = new DAOCategorias().BuscarCategoria(categoria);
        
        if (categoria == null)
        {
            if (txt_categoria.Text != "")
            {
                Categoria user = new Categoria();
                user.Categorias = txt_categoria.Text;
                new DAOCategorias().InsertarCategoria(user);
                DCategorias.DataBind();
                lb_mensaje.ForeColor = Color.Green;
                lb_mensaje.Text = "Registro Exitoso";
                txt_categoria.Text = string.Empty;
            }
            else
            {
                lb_mensaje.ForeColor = Color.Red;
                lb_mensaje.Text = "Dato No Registrado";
            }
        }
        else if (categoria.Categorias.ToLower().Trim() == txt_categoria.Text.ToLower().Trim())
        {
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "Categoria ya registrada";
        }
    }
}

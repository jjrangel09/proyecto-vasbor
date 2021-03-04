using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_js_Registrar : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString.Count > 0)
        {
            EPersona user = new DAOPersona().BuscarToken(Request.QueryString[0] == null ? "" : Request.QueryString[0]);

            if (user == null)
                this.RegisterStartupScript("mensaje", "<script type='text/javascript'>alert('El Token es invalido. Genere uno nuevo');window.location=\"Inicio.aspx\"</script>");
            else if (user.VencimientoToken < DateTime.Now)
                this.RegisterStartupScript("mensaje", "<script type='text/javascript'>alert('El Token esta vencido. Genere uno nuevo');window.location=\"Inicio.aspx\"</script>");
            else
                Session["user_id"] = user;
        }

        else
            Response.Redirect("Inicio.aspx");

    }

    protected void btn_registrar_Click(object sender, EventArgs e)
    {
        EPersona user = (EPersona)Session["user_id"];

        if (txt_contraseña.Text != "" && txt_confirmar.Text != "" && txt_contraseña.Text == txt_confirmar.Text)
        {
            user.Clave = txt_contraseña.Text;
            user.Estado_id = 1;
            user.Token = null;
            user.VencimientoToken = null;
            user.Session = user.Username;
            new DAOPersona().ActualizarUsuario(user);
            lb_mensaje.ForeColor = Color.Green;
            lb_mensaje.Text = "Contraseña ha sido actualizada";
            Response.Redirect("Ingresar.aspx");
        }
        else if (txt_contraseña.Text != txt_confirmar.Text)
        {
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "Contraseñas no son iguales";
        }
        else
        {
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "Error campos vacios";
        }
    } 
}


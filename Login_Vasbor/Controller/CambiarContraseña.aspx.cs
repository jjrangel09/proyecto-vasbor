using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_CambiarContraseña : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        txt_anterior.Enabled= false;
        txt_confirmar.Enabled = false;
        txt_nueva.Enabled = false;
        lb_anterior.Enabled = false;
        Lb_confirmar.Enabled = false;
        Lb_nueva.Enabled = false;
        btn_confirmar.Enabled = false;
        btn_volver.Enabled = false;
    }

    protected void btn_volver_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.ToString());
    }

    protected void btn_confirmar_Click(object sender, EventArgs e)
    {
        EPersona user = new EPersona();
        user.Clave = txt_anterior.Text;

        user = new DAOPersona().cambiarClave(user);

        if (user.Clave == txt_anterior.Text)
        {
            if (txt_nueva.Text == txt_confirmar.Text)
            {
                EPersona user2 = new EPersona();
                user2.Id = int.Parse(Session["id_usuario"].ToString());
                user2.Clave = txt_confirmar.Text;
                new DAOPersona().ActualizaClaveUsuario(user2);
                txt_confirmar.Text = string.Empty;
                txt_nueva.Text = string.Empty;
                txt_anterior.Text = string.Empty;
                txt_anterior.Enabled = true;
                txt_confirmar.Enabled = true;
                txt_nueva.Enabled = true;
                lb_anterior.Enabled = true;
                Lb_confirmar.Enabled = true;
                Lb_nueva.Enabled = true;
                btn_confirmar.Enabled = true;
                btn_volver.Enabled = true;
                btn_cambiar.Enabled = false;
                lb_mensaje.ForeColor = Color.Green;
                lb_mensaje.Text = "Contraseña actualizada";
               // Response.Redirect(Request.Url.ToString());
            }
            else
            {
                txt_anterior.Enabled = true;
                txt_confirmar.Enabled = true;
                txt_nueva.Enabled = true;
                lb_anterior.Enabled = true;
                Lb_confirmar.Enabled = true;
                Lb_nueva.Enabled = true;
                btn_confirmar.Enabled = true;
                btn_volver.Enabled = true;
                btn_cambiar.Enabled = false;
                lb_mensaje.ForeColor = Color.Red;
                lb_mensaje.Text = "Nueva contraseña no coincide";
            }
        }
        else
        { 
            txt_confirmar.Text = string.Empty;
            txt_nueva.Text = string.Empty;
            txt_anterior.Text = string.Empty;
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "La contraseña ingresada no coincide con la registrada";
        }
    }

    protected void btn_cambiar_Click(object sender, EventArgs e)
    {
        txt_anterior.Enabled = true;
        txt_confirmar.Enabled = true;
        txt_nueva.Enabled = true;
        lb_anterior.Enabled = true;
        Lb_confirmar.Enabled = true;
        Lb_nueva.Enabled = true;
        btn_confirmar.Enabled = true;
        btn_volver.Enabled = true;
        btn_cambiar.Enabled = false;
    }
}
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_Administrador : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["validar_sesion_administrador"] != null && ((Administrador)Session["validar_sesion_administrador"]).Username.ToString() == "hperez")
        {
           
        }
        else
        {
            Response.Redirect("SAdministrador.aspx");
        }
    }

    protected void btn_añadir_Click(object sender, EventArgs e)
    {
        Administrador administrador = new Administrador();
        administrador.Username = txt_username.Text;
        administrador.Correo = txt_correo.Text;
        administrador.Identificacion = long.Parse(txt_identi.Text);

        administrador = new DAOAdministrador().BuscarUsername(administrador);

        if (long.Parse(txt_identi.Text) <= 0)
        {
            lb_mensajeI.ForeColor = Color.Red;
            lb_mensajeI.Text = "Ingrese numeros mayores a 0";
        }
        else if (administrador == null)
        {
            if (txt_identi.Text != "" && txt_nombre.Text != "" && txt_apellido.Text != "" && txt_correo.Text != "" && txt_username.Text != "" && txt_clave.Text != "")
            {
                Administrador user = new Administrador();
                user.Identificacion = long.Parse(txt_identi.Text);
                user.Nombre = txt_nombre.Text;
                user.Apellido = txt_apellido.Text;
                user.Correo = txt_correo.Text;
                user.Username = txt_username.Text;
                user.Clave = txt_clave.Text;
                user.Clave = txt_clave.Text;
                user.Session = Session.SessionID.ToString();
                user.Id_rol = 1;
                new DAOAdministrador().InsertarAdministrador(user);
                Gadmin.DataBind();
                txt_nombre.Text = string.Empty;
                txt_apellido.Text = string.Empty;
                txt_identi.Text = string.Empty;
                txt_username.Text = string.Empty;
                txt_clave.Text = string.Empty;
                txt_correo.Text = string.Empty;
                lb_mensaje.ForeColor = Color.Green;
                lb_mensaje.Text = "Registro Exitoso";
            }
            else
            {
                lb_mensaje.ForeColor = Color.Red;
                lb_mensaje.Text = "Error Campos Vacios";
            }

            if (lb_mensaje.Text == "Registro Exitoso")
            {
                lb_mensajeI.Text = "";
            }
        }
        else if (administrador.Username == txt_username.Text)
        {
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "Usuario ya registrado";
        }
        else if (administrador.Correo == txt_correo.Text)
        {
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "Correo ya registrado";
        }
        else if (administrador.Identificacion == long.Parse(txt_identi.Text))
        {
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "Identificacion ya registrada";
        }
    }
}
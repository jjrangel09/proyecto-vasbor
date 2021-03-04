using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_Usuario : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btn_añadir_Click(object sender, EventArgs e)
    {
        EPersona persona = new EPersona();
        persona.Username = txt_username.Text;
        persona.Correo = txt_correo.Text;
        persona.Identificacion = long.Parse(txt_identi.Text);

        persona = new DAOPersona().BuscarUsername(persona);

        if (long.Parse(txt_identi.Text) <= 0)
        {
            lb_mensajeI.ForeColor = Color.Red;
            lb_mensajeI.Text = "Ingrese numeros mayores a 0";
        }
        else if (long.Parse(txt_telefono.Text) <= 0)
        {
            lb_mensajeI0.ForeColor = Color.Red;
            lb_mensajeI0.Text = "Ingrese numeros mayores a 0";
        }
        else if (persona == null)
        {
            if (txt_identi.Text != "" && txt_nombre.Text != "" && txt_apellido.Text != "" && txt_telefono.Text != "" && txt_username.Text != "" && txt_clave.Text != "")
            {
                EPersona user = new EPersona();
                user.Identificacion = long.Parse(txt_identi.Text);
                user.Nombre = txt_nombre.Text;
                user.Apellido = txt_apellido.Text;
                user.Telefono = long.Parse(txt_telefono.Text);
                user.Correo = txt_correo.Text;
                user.Username = txt_username.Text;
                user.Clave = txt_clave.Text;
                user.Id_rol = 2;
                user.Session = Session.SessionID.ToString();
                user.LastModifify = DateTime.Now;
                user.Estado_id = 1;
                new DAOPersona().InsertarUsuario(user);
                GridView1.DataBind();
                lb_mensaje.ForeColor = Color.Green;
                lb_mensaje.Text = "Registro Exitoso";
            }
            else
            {
                lb_mensaje.ForeColor = Color.Red;
                lb_mensaje.Text = "Error Campos Vacios";
            }
        }
        else if (persona.Username == txt_username.Text)
        {
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "Usuario ya registrado";
        }
        else if (persona.Identificacion == long.Parse(txt_identi.Text))
        {
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "Codigo ya registrado";
        }
        else if (persona.Correo == txt_correo.Text)
        {
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "Telefono ya registrado";
        }
        else
        {
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "Error campos vacios";
        }
    }
}
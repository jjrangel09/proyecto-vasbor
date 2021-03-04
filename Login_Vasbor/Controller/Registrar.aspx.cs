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

    }

    protected void btn_registrar_Click(object sender, EventArgs e)
    {
        EPersona persona = new EPersona();
        persona.Username = txt_username.Text;
        persona.Correo = txt_correo.Text;
        persona.Identificacion = long.Parse(txt_identificacion.Text);

        persona = new DAOPersona().BuscarUsername(persona);
        if (long.Parse(txt_telefono.Text) <= 0 || long.Parse(txt_identificacion.Text) <= 0)
        {
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "Ingrese numeros mayores a 0";
        }
        else if (persona == null)
        {
            if (txt_identificacion.Text != "" && txt_nombre.Text != "" && txt_apellido.Text != "" && txt_correo.Text != "" && txt_telefono.Text != "" && txt_username.Text != "" && txt_contraseña.Text != "" && txt_confirmar.Text != "" && txt_contraseña.Text == txt_confirmar.Text)
            {
                EPersona user = new EPersona();
                user.Identificacion = long.Parse(txt_identificacion.Text);
                user.Nombre = txt_nombre.Text;
                user.Apellido = txt_apellido.Text;
                user.Correo = txt_correo.Text;
                user.Telefono = long.Parse(txt_telefono.Text);
                user.Username = txt_username.Text;
                user.Clave = txt_contraseña.Text;
                user.Id_rol = 3;
                user.Estado_id = 1;
                new DAOPersona().InsertarUsuario(user);
                lb_mensaje.ForeColor = Color.Green;
                lb_mensaje.Text = "Registro Exitoso";
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
                lb_mensaje.Text = "Error Campos Vacios";
            }
        }
        else if (persona.Username == txt_username.Text)
        {
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "Usuario ya registrado";
        }
        else if (persona.Correo == txt_correo.Text)
        {
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "Correo ya registrado";
        }
        else if (persona.Identificacion == long.Parse(txt_identificacion.Text))
        {
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "Identificacion ya registrada";
        }
        else
        {
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "Error campos vacios";
        }
    }

    protected void btn_ingresar_Click(object sender, EventArgs e)
    {
        Response.Redirect("Ingresar.aspx");
    }
}
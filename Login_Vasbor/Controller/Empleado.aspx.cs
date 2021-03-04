using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_Empleado : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btn_añadir_Click(object sender, EventArgs e)
    {
        Empleado empleado = new Empleado();
        empleado.Username = txt_username.Text;
        empleado.Id_codigo = long.Parse(txt_identi.Text);
        empleado.Telefono = long.Parse(txt_telefono.Text);

        empleado = new DAOEmpleado().BuscarUsername(empleado);

        if (long.Parse(txt_telefono.Text) <= 0 || long.Parse(txt_identi.Text) <= 0)
        {
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "Ingrese numeros mayores a 0";
        }
        else if (empleado == null)
        {
            if (txt_identi.Text != "" && txt_nombre.Text != "" && txt_apellido.Text != "" && txt_telefono.Text != "" && txt_username.Text != "" && txt_clave.Text != "")
            {
                Empleado user = new Empleado();
                user.Id_codigo = long.Parse(txt_identi.Text);
                user.Nombre = txt_nombre.Text;
                user.Apellido = txt_apellido.Text;
                user.Telefono = long.Parse(txt_telefono.Text);
                user.Username = txt_username.Text;
                user.Clave = txt_clave.Text;
                user.Session = Session.SessionID.ToString();
                user.LastModifify = DateTime.Now;
                user.Id_rol = 2;
                user.Estado_id = 1;
                new DAOEmpleado().InsertarEmpleado(user);
                txt_nombre.Text = string.Empty;
                txt_apellido.Text = string.Empty;
                txt_identi.Text = string.Empty;
                txt_telefono.Text = string.Empty;
                txt_username.Text = string.Empty;
                txt_clave.Text = string.Empty;
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
        else if (empleado.Username == txt_username.Text)
        {
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "Nombre De Usuario ya registrado";
        }
        else if (empleado.Id_codigo == long.Parse(txt_identi.Text))
        {
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "Codigo ya registrado";
        }
        else if (empleado.Telefono == long.Parse(txt_telefono.Text))
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
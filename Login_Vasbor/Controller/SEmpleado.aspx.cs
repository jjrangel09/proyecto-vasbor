using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_SEmpleado : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
            Empleado empleado = new Empleado();
            empleado = new DAOEmpleado().obtenerEmpleadoPerfil(((Empleado)Session["validar_sesion_empleado"]).Id);
            lb_sesion.Text = empleado.Nombre + " " + empleado.Apellido; //((EPersona)Session["validar_sesion_usuario"]).Nombre.ToString() + " "+((EPersona)Session["validar_sesion_usuario"]).Apellido.ToString();

            l_nombre.Text = empleado.Nombre;
            l_apellido.Text = empleado.Apellido;
            l_username.Text = empleado.Username;

        if (txt_Pnombre.Text.Equals(""))
            {
                txt_Pnombre.Text = empleado.Nombre;
                txt_apellido.Text = empleado.Apellido;
                txt_username.Text = empleado.Username;
                txt_Pnombre.Visible = false;
                txt_apellido.Visible = false;
                txt_username.Visible = false;
            }

            btn_guardar.Visible = false;
            btn_cancelar.Visible = false;
        
    }

    protected void btn_editar_Click(object sender, EventArgs e)
    {
        l_nombre.Visible = false;
        l_apellido.Visible = false;
        l_username.Visible = false;

        txt_Pnombre.Visible = true;
        txt_apellido.Visible = true;
        txt_username.Visible = true;
        btn_editar.Visible = false;
        btn_guardar.Visible = true;
        btn_cancelar.Visible = true;
    }

    protected void btn_guardar_Click(object sender, EventArgs e)
    {
        Empleado empleado = new Empleado();
        empleado.Id = int.Parse(Session["id_empleado"].ToString());
        empleado.Nombre = txt_Pnombre.Text;
        empleado.Apellido = txt_apellido.Text;
        empleado.Username = txt_username.Text;
        new DAOEmpleado().ActualizarEmpleadoPerfil(empleado);
        Response.Redirect(Request.Url.ToString());
    }

    protected void btn_cancelar_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.ToString());
    }
}
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_SusuarioRegistrado : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["validar_sesion_usuario"] != null && ((EPersona)Session["validar_sesion_usuario"]).Id_rol == 3)
        {
            EPersona usuario = new EPersona();
            usuario = new DAOPersona().obtenerUsuario(((EPersona)Session["validar_sesion_usuario"]).Id);
            lb_sesion.Text= usuario.Nombre +" "+ usuario.Apellido; //((EPersona)Session["validar_sesion_usuario"]).Nombre.ToString() + " "+((EPersona)Session["validar_sesion_usuario"]).Apellido.ToString();

            l_nombre.Text = usuario.Nombre;
            l_apellido.Text = usuario.Apellido;
            l_username.Text = usuario.Username;
            l_correo.Text = usuario.Correo;
            l_telefono.Text = (usuario.Telefono).ToString();


            if (txt_Pnombre.Text.Equals(""))
            {
                txt_Pnombre.Text = usuario.Nombre;
                txt_apellido.Text = usuario.Apellido;
                txt_username.Text = usuario.Username;
                txt_telefono.Text = (usuario.Telefono).ToString();
                txt_correo.Text = usuario.Correo;
                txt_Pnombre.Visible = false;
                txt_apellido.Visible = false;
                txt_username.Visible = false;
                txt_correo.Visible = false;
                txt_telefono.Visible = false;
            }
                btn_guardar.Visible = false;
                btn_cancelar.Visible = false;
        }
        else
        {
            Response.Redirect("Ingresar.aspx");
        }
    }

    protected void btn_editar_Click(object sender, EventArgs e)

    {
        l_nombre.Visible = false;
        l_apellido.Visible = false;
        l_username.Visible = false;
        l_correo.Visible = false;
        l_telefono.Visible = false;

        txt_Pnombre.Visible = true;
        txt_apellido.Visible = true;
        txt_username.Visible = true;
        txt_correo.Visible = true;
        txt_telefono.Visible = true;
        btn_editar.Visible = false;
        btn_guardar.Visible = true;
        btn_cancelar.Visible = true;
    }

    protected void btn_guardar_Click(object sender, EventArgs e)
    {
        if (long.Parse(txt_telefono.Text) <= 0)
        {
            btn_editar.Visible = false;
            btn_guardar.Visible = true;
            btn_cancelar.Visible = true;
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "Ingrese numeros mayores a 0";
        }
        else
        {
            EPersona user = new EPersona();
            user.Id = int.Parse(Session["id_usuario"].ToString());
            user.Nombre = txt_Pnombre.Text;
            user.Apellido = txt_apellido.Text;
            user.Username = txt_username.Text;
            user.Correo = txt_correo.Text;
            user.Telefono = long.Parse(txt_telefono.Text);
            new DAOPersona().ActualizarUsuarioPerfil(user);
            Response.Redirect(Request.Url.ToString());
        }
        
    }

    protected void btn_cancelar_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.ToString());
    }
}
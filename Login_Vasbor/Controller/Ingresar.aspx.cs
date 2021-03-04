using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Ingresar : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (! IsPostBack)
        {
            if (Request.Cookies["usern"]!=null && Request.Cookies["pass"] !=null )
            {
                txt_username.Text = Request.Cookies["usern"].Value;
                txt_contraseña.Attributes["value"] = Request.Cookies["pass"].Value;
                CheckBox1.Checked = true;
            }
        }
    }

    protected void btn_ingresar_Click(object sender, EventArgs e)
    {
        EPersona eUser = new EPersona();
        eUser.Username = txt_username.Text;
        eUser.Clave = txt_contraseña.Text;

        Empleado empleado = new Empleado();
        empleado.Username = txt_username.Text;
        empleado.Clave = txt_contraseña.Text;

        Administrador administrador = new Administrador();
        administrador.Username = txt_username.Text;
        administrador.Clave = txt_contraseña.Text;


        eUser = new DAOPersona().Login_Vasbor(eUser);
        empleado = new DAOEmpleado().Login_Vasbor(empleado);
        administrador = new DAOAdministrador().Login_Vasbor(administrador);



        if (administrador == null)
        {

            ((Label)lb_error).Text = ("Usuario o clave incorrecta");

        }
        else if (administrador.Id_rol == 1)
        {
            if (CheckBox1.Checked)
            {
                Response.Cookies["usern"].Value = txt_username.Text;
                Response.Cookies["pass"].Value = txt_contraseña.Text;

                Response.Cookies["usern"].Expires = DateTime.Now.AddDays(15);
                Response.Cookies["pass"].Expires = DateTime.Now.AddDays(15);

            }
            else
            {
                Response.Cookies["usern"].Expires = DateTime.Now.AddDays(-1);
                Response.Cookies["pass"].Expires = DateTime.Now.AddDays(-1);
            }
            Session["validar_sesion_administrador"] = administrador;
            Response.Redirect("SAdministrador.aspx");
            txt_username.Text = string.Empty;
            txt_contraseña.Text = string.Empty;
        }

        if (empleado == null)
        {

            ((Label)lb_error).Text = ("Usuario o clave incorrecta");

        }
        else if (empleado != null && empleado.Estado_id == 3)
        {
            ((Label)lb_error).Text = ("Empleado Inhabilitado");
        }
        else if (empleado != null && empleado.Estado_id == 2)
        {
            ((Label)lb_error).Text = ("Recuperacion De Contraseña");

        }
        else if (empleado != null && empleado.Id_rol == 2 && empleado.Estado_id == 1)
        {
            if (CheckBox1.Checked)
            {
                Response.Cookies["usern"].Value = txt_username.Text;
                Response.Cookies["pass"].Value = txt_contraseña.Text;

                Response.Cookies["usern"].Expires = DateTime.Now.AddDays(15);
                Response.Cookies["pass"].Expires = DateTime.Now.AddDays(15);

            }
            else
            {
                Response.Cookies["usern"].Expires = DateTime.Now.AddDays(-1);
                Response.Cookies["pass"].Expires = DateTime.Now.AddDays(-1);
            }
            Session["validar_sesion_empleado"] = empleado;
            Session["id_empleado"] = empleado.Id;
            Response.Redirect("CatalogoEmpleado.aspx");
            txt_username.Text = string.Empty;
            txt_contraseña.Text = string.Empty;
        }

        if (eUser == null && empleado==null)
        {

            ((Label)lb_error).Text = ("Usuario o clave incorrecta");

        }
        else if (eUser != null && eUser.Estado_id==3 )
        {
            ((Label)lb_error).Text = ("Usuario Inhabilitado");
        }
        else if (eUser != null && eUser.Estado_id == 2)
        {
            ((Label)lb_error).Text = ("Recuperacion De Contraseña");
        }
        else if (eUser != null && eUser.Id_rol == 3 && eUser.Estado_id == 1)
        {
           
            if (CheckBox1.Checked)
            {
                Response.Cookies["usern"].Value = txt_username.Text;
                Response.Cookies["pass"].Value = txt_contraseña.Text;

                Response.Cookies["usern"].Expires = DateTime.Now.AddDays(15);
                Response.Cookies["pass"].Expires = DateTime.Now.AddDays(15);

            }
            else
            {
                Response.Cookies["usern"].Expires = DateTime.Now.AddDays(-1);
                Response.Cookies["pass"].Expires = DateTime.Now.AddDays(-1);
            }
            if (eUser.Estado_id == 2)
            {

                ((Label)lb_error).Text = ("Usted esta en proceso de recuperacion de contraseña");
                return;
            }
            Session["validar_sesion_usuario"] = eUser;
            Session["id_usuario"] = eUser.Id;
            Response.Redirect("Catalogo.aspx");
            txt_username.Text = string.Empty;
            txt_contraseña.Text = string.Empty;
        }
    }

    protected void Unnamed_Click(object sender, EventArgs e)
    {
        Response.Write("<script> window.open('" + "ManualUsuarioU.pdf" + "','_blank'); </script>");
    }
}
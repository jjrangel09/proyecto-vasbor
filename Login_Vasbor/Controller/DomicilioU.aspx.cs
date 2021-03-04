using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_DomicilioU : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        txt_direccion.Visible = false;
        txt_pais.Visible = false;
        txt_ciudad.Visible = false;
        txt_postal.Visible = false;
        btn_guardar.Visible = false;
        btn_cancelar.Visible = false;
        lb_direccion.Visible = false;
        lb_pais.Visible = false;
        lb_codigop.Visible = false;
        lb_ciudad.Visible = false;
    }

    protected void btn_añadir_Click(object sender, EventArgs e)
    {
             txt_direccion.Visible = true;
             txt_pais.Visible = true;
             txt_ciudad.Visible = true;
             txt_postal.Visible = true;
             btn_guardar.Visible = true;
             btn_cancelar.Visible = true;
             lb_direccion.Visible = true;
             lb_pais.Visible = true;
             lb_codigop.Visible = true;
             lb_ciudad.Visible = true;
             btn_añadir.Visible = false;
             btn_omitir.Visible = false;
    }       

    protected void btn_omitir_Click(object sender, EventArgs e)
    {
        Response.Redirect("Pedido.aspx");
    }

    protected void btn_guardar_Click(object sender, EventArgs e)
    {
        DomicilioU direccion = new DomicilioU();
        direccion.Direccion = txt_direccion.Text;

        direccion = new DAOFactura().BuscarDireccion(direccion);

        if (long.Parse(txt_postal.Text) <= 0)
        {
            txt_direccion.Visible = true;
            txt_pais.Visible = true;
            txt_ciudad.Visible = true;
            txt_postal.Visible = true;
            btn_guardar.Visible = true;
            btn_cancelar.Visible = true;
            lb_direccion.Visible = true;
            lb_pais.Visible = true;
            lb_codigop.Visible = true;
            lb_ciudad.Visible = true;
            btn_añadir.Visible = false;
            btn_omitir.Visible = false;
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "Ingrese numeros mayores a 0";
        }
        else if (direccion == null)
        {            
            DomicilioU domicilioU = new DomicilioU();
            domicilioU.Id_usuario = int.Parse(Session["id_usuario"].ToString());
            domicilioU.Direccion = txt_direccion.Text;
            domicilioU.Pais = txt_pais.Text;
            domicilioU.Ciudad = txt_ciudad.Text;
            domicilioU.Codigop = int.Parse(txt_postal.Text);
            new DAOFactura().InsertarDomiciliou(domicilioU);
            txt_direccion.Text = string.Empty;
            txt_pais.Text = string.Empty;
            txt_postal.Text = string.Empty;
            txt_ciudad.Text = string.Empty;
            direccion_data.DataBind();
            Response.Redirect(Request.Url.ToString());
        }
        else if (direccion.Direccion.ToLower().Trim() == txt_direccion.Text.ToLower().Trim())
        {
            txt_direccion.Visible = true;
            txt_pais.Visible = true;
            txt_ciudad.Visible = true;
            txt_postal.Visible = true;
            btn_guardar.Visible = true;
            btn_cancelar.Visible = true;
            lb_direccion.Visible = true;
            lb_pais.Visible = true;
            lb_codigop.Visible = true;
            lb_ciudad.Visible = true;
            btn_añadir.Visible = false;
            btn_omitir.Visible = false;
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "direccion ya registrada";
        }
    }

    protected void btn_cancelar_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.ToString());
    }
}
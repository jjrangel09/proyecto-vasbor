using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class view_olvido_clave : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btn_olvido_Click(object sender, EventArgs e)
    {
        EPersona persona = new DAOPersona().BuscarCorreo(txt_correo.Text);
        ClientScriptManager csm = this.ClientScript;
        /*if(persona.Clave == null)
        {
            //Response.Redirect("Ingresar.aspx");
            //csm.RegisterClientScriptBlock(this.GetType(), " ", "<script type='text/javascript'>alert('Correo no encontrado');</script>");
            return;
        }*/
        if (persona == null)
        {
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "Correo no encontrado";
        }
        else if(persona.Id_rol == 3)
        {
            persona.Estado_id = 2;
            persona.Token = encriptar(JsonConvert.SerializeObject(persona));
            persona.VencimientoToken = DateTime.Now.AddDays(1);
            persona.Session = persona.Session = "Sistema";

            new Correo().enviarCorreo(persona.Correo, persona.Token, "");
            new DAOPersona().ActualizarUsuario(persona);
            txt_correo.Text = string.Empty;
            lb_mensaje.ForeColor = Color.Green;
            lb_mensaje.Text = "Validacion exitosa. Revisar correo";
        } 
    }

    private string encriptar(string input)
    {
        SHA256CryptoServiceProvider provider = new SHA256CryptoServiceProvider();
        byte[] inputBytes = Encoding.UTF8.GetBytes(input);
        byte[] hashedBytes = provider.ComputeHash(inputBytes);
        StringBuilder output = new StringBuilder();
        for (int i = 0; i < hashedBytes.Length; i++)
            output.Append(hashedBytes[i].ToString("x2").ToLower());
        return output.ToString();
    }

    protected void btn_volver_Click(object sender, EventArgs e)
    {
        Response.Redirect("Ingresar.aspx");
    }
}
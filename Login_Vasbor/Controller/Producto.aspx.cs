using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Image = System.Web.UI.WebControls.Image;

public partial class view_Producto : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (Session["validar_sesion_administrador"] != null )
        {
      
        }
        else
        {
            Response.Redirect("Ingresar.aspx");
        }
       
    }

    protected void btn_añadir_Click(object sender, EventArgs e)
    {
        Producto producto = new Producto();
        producto.Nombre = txt_Pnombre.Text;

        producto = new DAOProducto().BuscarProducto(producto);

        if (long.Parse(txt_precio.Text) <= 0 || long.Parse(txt_cantidad.Text) <= 0)
        {
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "Ingrese numeros mayores a 0";
        }
        else if (producto == null)
        {
            if (txt_Pnombre.Text != "" && txt_precio.Text != "" && txt_descripcion.Text != "")
            {
                ClientScriptManager cm = this.ClientScript;
                string nombreArchivo = System.IO.Path.GetFileName(subir_imagen.PostedFile.FileName);
                string extension = System.IO.Path.GetExtension(subir_imagen.PostedFile.FileName);
                string saveLocation = Server.MapPath("~\\imagenes\\Productos\\") + nombreArchivo;
                if (!(extension.Equals(".jpg") || extension.Equals(".gif") || extension.Equals(".jpge") || extension.Equals(".png")))
                {

                    cm.RegisterClientScriptBlock(this.GetType(), "", "<script type='text/javascript'>alert('Formato Seleccionado No es Una Imagen.Error:');</script>");
                    return;
                }
                if (System.IO.File.Exists(saveLocation))
                {
                    cm.RegisterClientScriptBlock(this.GetType(), "", "<script type='text/javascript'>alert('Imagen Ya Existe.Error:');</script>");
                    return;
                }
                try
                {
                    Producto user = new Producto();
                    user.Nombre = txt_Pnombre.Text;
                    user.Categoria = int.Parse(lista_categoria.SelectedValue);
                    user.Subcategoria = int.Parse(lista_sub.SelectedValue);
                    user.Precio = double.Parse(txt_precio.Text);
                    user.Descripcion = txt_descripcion.Text;
                    user.Imagen = "~\\imagenes\\Productos\\" + nombreArchivo;
                    user.Cantidad = int.Parse(txt_cantidad.Text);
                    user.Session = Session.SessionID.ToString();
                    user.LastModifify = DateTime.Now;
                    new DAOProducto().InsertarProducto(user);
                    grProducto.DataBind();
                    lista_categoria.SelectedValue = "0";
                    lista_sub.SelectedValue = "0";
                    lb_mensaje.ForeColor = Color.Green;
                    lb_mensaje.Text = "Registro Exitoso";
                    txt_precio.Text = string.Empty;
                    txt_descripcion.Text = string.Empty;
                    txt_cantidad.Text = string.Empty;
                    txt_Pnombre.Text = string.Empty;

                    subir_imagen.PostedFile.SaveAs(saveLocation);
                    cm.RegisterClientScriptBlock(this.GetType(), "", "<script type='text/javascrip'>alert('El archivo ha sido cargado');</scrip");
                }
                catch (Exception exc)
                {
                    cm.RegisterClientScriptBlock(this.GetType(), "", "<script type='text/javascrip'>alert('Error');</scrip");
                    return;
                }

            }
            else
            {
                lb_mensaje.ForeColor = Color.Red;
                lb_mensaje.Text = "Error Campos Vacios";
            }
        }
        else if (producto.Nombre.ToLower().Trim() == txt_Pnombre.Text.ToLower().Trim())
        {
            lb_mensaje.ForeColor = Color.Red;
            lb_mensaje.Text = "producto ya registrado";
        }
    }



    protected void grProducto_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridViewRow row = grProducto.Rows[e.RowIndex];
        FileUpload F_Editar = ((FileUpload)row.FindControl("F_EDITAR"));
        ClientScriptManager cm = this.ClientScript;
        string nuevoarchivourl = ((Image)row.FindControl("id_imagen")).ImageUrl;
        string nombreArchivo = System.IO.Path.GetFileName(F_Editar.PostedFile.FileName);
        string extension = System.IO.Path.GetExtension(F_Editar.PostedFile.FileName);
        string saveLocation = Server.MapPath("~\\imagenes\\Productos\\") + nombreArchivo;
        if (F_Editar.PostedFile.FileName != "")
        {
            if (!(extension.Equals(".jpg") || extension.Equals(".gif") || extension.Equals(".jpge") || extension.Equals(".png")))
            {

                cm.RegisterClientScriptBlock(this.GetType(), "", "<script type='text/javascript'>alert('Formato Seleccionado No es Una Imagen.Error:');</script>");
                e.Cancel = true;
            }
            if (System.IO.File.Exists(saveLocation))
            {
                cm.RegisterClientScriptBlock(this.GetType(), "", "<script type='text/javascript'>alert('Imagen Ya Existe.Error:');</script>");
                e.Cancel = true;
            }
            try
            {
                File.Delete(Server.MapPath(nuevoarchivourl));
                F_Editar.PostedFile.SaveAs(saveLocation);
                e.NewValues["Imagen"] = "~\\imagenes\\Productos\\" + nombreArchivo;
            }
            catch (Exception exc)
            {
                cm.RegisterClientScriptBlock(this.GetType(), "", "<script type='text/javascrip'>alert('Error');</scrip");
                return;
            }


        }
        else
        {
            e.NewValues["Imagen"] = nuevoarchivourl;
         //   e.NewValues.Add("imagen", ((Image)row.FindControl("IM_EditPro")).ImageUrl);
        }
    }

}
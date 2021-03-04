using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;
/// <summary>
/// Descripción breve de Carrito
/// </summary>
/// 
[Serializable]
[Table("carrito", Schema = "restaurante")]
public class Carrito
{
    private int id, producto_id, usuario_id,id_factura;
    private  Nullable<int>cantidad;
    private DateTime fecha;
    private string nombreProducto, imagen,categoria,subcategoria;
    private double precio,total,total2;
    private string nombreu;
    private string form,direccion;
    [Key]
    [Column("id")]
    public int Id { get => id; set => id = value; }
    [Column("producto_id")]
    public int Producto_id { get => producto_id; set => producto_id = value; }
    [Column("usuario_id")]
    public int Usuario_id { get => usuario_id; set => usuario_id = value; }
    [Column("cantidad")]
    public Nullable<int> Cantidad { get => cantidad; set => cantidad = value; }
    [Column("fecha")]
    public DateTime Fecha { get => fecha; set => fecha = value; }
    [Column("precio")]
    public double Precio { get => precio; set => precio = value; }
    [NotMapped]
    public string Nombreu { get => nombreu; set => nombreu = value; }
    [NotMapped]
    public double Total { get => total; set => total = value; }
    [NotMapped]
    public string NombreProducto { get => nombreProducto; set => nombreProducto = value; }
    [NotMapped]
    public string Imagen { get => imagen; set => imagen = value; }
    [NotMapped]
    public string Categoria { get => categoria; set => categoria = value; }
    [NotMapped]
    public string Subcategoria { get => subcategoria; set => subcategoria = value; }
    [NotMapped]
    public string Form { get => form; set => form = value; }
    [NotMapped]
    public string Direccion { get => direccion; set => direccion = value; }
    [NotMapped]
    public double Total2 { get => total2; set => total2 = value; }
    [NotMapped]
    public int Id_factura { get => id_factura; set => id_factura = value; }
}
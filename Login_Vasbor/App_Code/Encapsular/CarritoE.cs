using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;
/// <summary>
/// Descripción breve de CarritoE
/// </summary>
/// 
[Serializable]
[Table("carrito_empleado", Schema = "restaurante")]
public class CarritoE
{
    private int id, producto_id, id_mesero;
    private Nullable<int> cantidad;
    private DateTime fecha;
    private double precio;
    private string nombreempleado, nombreProducto, imagen, categoria, subcategoria;
    private string form, nom_mesa;
    private double total;
    [Key]
    [Column("id")]
    public int Id { get => id; set => id = value; }
    [Column("producto_id")]
    public int Producto_id { get => producto_id; set => producto_id = value; }
    [Column("id_mesero")]
    public int Id_mesero { get => id_mesero; set => id_mesero = value; }
    [Column("cantidad")]
    public Nullable<int> Cantidad { get => cantidad; set => cantidad = value; }
    [Column("fecha")]
    public DateTime Fecha { get => fecha; set => fecha = value; }
    [Column("precio")]
    public double Precio { get => precio; set => precio = value; }
    [NotMapped]
    public string Nombreempleado { get => nombreempleado; set => nombreempleado = value; }
    [NotMapped]
    public string Form { get => form; set => form = value; }
    [NotMapped]
    public string Nom_mesa { get => nom_mesa; set => nom_mesa = value; }
    [NotMapped]
    public string NombreProducto { get => nombreProducto; set => nombreProducto = value; }
    [NotMapped]
    public string Imagen { get => imagen; set => imagen = value; }
    [NotMapped]
    public string Categoria { get => categoria; set => categoria = value; }
    [NotMapped]
    public string Subcategoria { get => subcategoria; set => subcategoria = value; }
    [NotMapped]
    public double Total { get => total; set => total = value; }
}
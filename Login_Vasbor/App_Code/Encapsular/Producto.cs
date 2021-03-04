using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Producto
/// </summary>
/// 
[Serializable]
[Table("producto", Schema = "restaurante")]
public class Producto
{
    private int id,categoria,subcategoria,cantidad;
    private double precio;
    private string nombre, descripcion, imagen,categorrias,subcategorias,session;
    private Nullable<DateTime> lastModifify;
    [Key]
    [Column("id")]
    public int Id { get => id; set => id = value; }
    [Column("nombre")]
    public string Nombre { get => nombre; set => nombre = value; } 
    [Column("categoria")]
    public int Categoria { get => categoria; set => categoria = value; }  
    [Column("subcategoria")]
    public int Subcategoria { get => subcategoria; set => subcategoria = value; }  
    [Column("precio")]
    public double Precio { get => precio; set => precio = value; }
    [Column("descripcion")]
    public string Descripcion { get => descripcion; set => descripcion = value; }
    [Column("imagen")]
    public string Imagen { get => imagen; set => imagen = value; }
    [Column("cantidad")]
    public int Cantidad { get => cantidad; set => cantidad = value; }
    [Column("session")]
    public string Session { get => session; set => session = value; }
    [Column("last_modifity")]
    public DateTime? LastModifify { get => lastModifify; set => lastModifify = value; }
    [NotMapped]
    public string Categorrias { get => categorrias; set => categorrias = value; }
    [NotMapped]
    public string Subcategorias { get => subcategorias; set => subcategorias = value; }
}
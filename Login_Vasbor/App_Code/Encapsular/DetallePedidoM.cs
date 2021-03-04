using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;
/// <summary>
/// Descripción breve de DetallePedidoM
/// </summary>
/// 
[Serializable]
[Table("detalle_pedido_mesero", Schema = "restaurante")]
public class DetallePedidoM
{
    private int id, id_pedido, cantidad, id_mesero,id_pago;
    private long total;
    private DateTime fecha;
    private double precio;
    private string detalle,nombre_empleado,form, nombreproducto, imagen;
    [Key]
    [Column("id")]
    public int Id { get => id; set => id = value; }
    [Column("id_pedido")]
    public int Id_pedido { get => id_pedido; set => id_pedido = value; }
    [Column("cantidad")]
    public int Cantidad { get => cantidad; set => cantidad = value; }
    [Column("total")]
    public long Total { get => total; set => total = value; }
    [Column("fecha")]
    public DateTime Fecha { get => fecha; set => fecha = value; }
    [Column("id_mesero")]
    public int Id_mesero { get => id_mesero; set => id_mesero = value; }
    [Column("detalleP")]
    public string Detalle { get => detalle; set => detalle = value; }
    [Column("id_pago")]
    public int Id_pago { get => id_pago; set => id_pago = value; }
    [NotMapped]
    public string Nombre_empleado { get => nombre_empleado; set => nombre_empleado = value; }
    [NotMapped]
    public string Form { get => form; set => form = value; }
    [NotMapped]
    public double Precio { get => precio; set => precio = value; }
    [NotMapped]
    public string NombreProducto { get => nombreproducto; set => nombreproducto = value; }
    [NotMapped]
    public string Imagen { get => imagen; set => imagen = value; }
}
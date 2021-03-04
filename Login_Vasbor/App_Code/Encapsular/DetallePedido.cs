using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;
/// <summary>
/// Descripción breve de DetallePedido
/// </summary>
/// 
[Serializable]
[Table("detalle_pedido", Schema = "restaurante")]
public class DetallePedido
{
    private int id, id_pedido, cantidad,id_usuario,idpago;
    private long total;
    private DateTime fecha;
    private string detalle, nombre_usuario , form,direccion,nombreproducto,imagen;
    private double precio;
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
    [Column("id_usuario")]
    public int Id_usuario { get => id_usuario; set => id_usuario = value; }
    [Column("detalle")]
    public string Detalle { get => detalle; set => detalle = value; }
    [Column("id_pago")]
    public int Idpago { get => idpago; set => idpago = value; }
    [NotMapped]
    public string Nombre_usuario { get => nombre_usuario; set => nombre_usuario = value; }
    [NotMapped]
    public string Form { get => form; set => form = value; }
    [NotMapped]
    public string Direccion { get => direccion; set => direccion = value; }
    [NotMapped]
    public string NombreProducto { get => nombreproducto; set => nombreproducto = value; }
    [NotMapped]
    public double Precio { get => precio; set => precio = value; }
    [NotMapped]
    public string Imagen { get => imagen; set => imagen = value; }
}
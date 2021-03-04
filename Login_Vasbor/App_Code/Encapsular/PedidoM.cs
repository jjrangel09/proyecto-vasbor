using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de PedidoM
/// </summary>
/// 
[Serializable]
[Table("pedido_mesero", Schema = "restaurante")]
public class PedidoM
{
    private int id, id_mesero, id_pago,id_mesa,cantidad;
    private DateTime fecha;
    private string detalle, nombreempleado, form,nom_mesa;
    private long total;
    [Key]
    [Column("id")]
    public int Id { get => id; set => id = value; }
    [Column("id_mesero")]
    public int Id_mesero { get => id_mesero; set => id_mesero = value; }
    [Column("id_mesa")]
    public int Id_mesa { get => id_mesa; set => id_mesa = value; }
    [Column("total")]
    public long Total { get => total; set => total = value; }
    [Column("fecha")]
    public DateTime Fecha { get => fecha; set => fecha = value; }
    [Column("detalle")]
    public string Detalle { get => detalle; set => detalle = value; }
    [Column("id_pago")]
    public int Id_pago { get => id_pago; set => id_pago = value; }
    [Column("cantidad")]
    public int Cantidad { get => cantidad; set => cantidad = value; }
    [NotMapped]
    public string Nombreempleado { get => nombreempleado; set => nombreempleado = value; }
    [NotMapped]
    public string Form { get => form; set => form = value; }
    [NotMapped]
    public string Nom_mesa { get => nom_mesa; set => nom_mesa = value; }
    
}
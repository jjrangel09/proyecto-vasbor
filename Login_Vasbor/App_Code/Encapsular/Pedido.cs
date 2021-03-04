using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Pedido
/// </summary>
/// 
[Serializable]
[Table("pedido", Schema = "restaurante")]
public class Pedido
{
    private int id, id_usuario, id_pago, id_domicilio;
    private long total;
    private DateTime fecha;
    [Key]
    [Column("id")]
    public int Id { get => id; set => id = value; }
    [Column("id_usuario")]
    public int Id_usuario { get => id_usuario; set => id_usuario = value; }
    [Column("id_pago")]
    public int Id_pago { get => id_pago; set => id_pago = value; }
    [Column("id_domicilio")]
    public int Id_domicilio { get => id_domicilio; set => id_domicilio = value; }
    [Column("total")]
    public long Total { get => total; set => total = value; }
    [Column("fecha")]
    public DateTime Fecha { get => fecha; set => fecha = value; }
}
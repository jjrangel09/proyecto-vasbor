using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Factura
/// </summary>
/// 
[Serializable]
[Table("metodo_pago", Schema = "restaurante")]

public class Pago
{
    private int id;
    private string descripcion;
    [Key]
    [Column("id")]
    public int Id { get => id; set => id = value; }
    [Column("descripcion")]
    public string Descripcion { get => descripcion; set => descripcion = value; }
}
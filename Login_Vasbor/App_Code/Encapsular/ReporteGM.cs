using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

[Serializable]
[Table("reporte_monetario_m", Schema = "restaurante")]

/// <summary>
/// Descripción breve de ReporteGM
/// </summary>
public class ReporteGM
{
    private int id;
    private long total;
    private DateTime fecha;
    private string nombre_mesero;
    private long id_mesero;
    [Key]
    [Column("id")]
    public int Id { get => id; set => id = value; }
    [Column("id_mesero")]
    public long Id_mesero { get => id_mesero; set => id_mesero = value; }
    [Column("total")]
    public long Total { get => total; set => total = value; }
    [Column("fecha")]
    public DateTime Fecha { get => fecha; set => fecha = value; }
    [NotMapped]
    public string Nombre_Mesero { get => nombre_mesero; set => nombre_mesero = value; }
}
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

[Serializable]
[Table("reporte_monetario", Schema = "restaurante")]

/// <summary>
/// Descripción breve de ReporteG
/// </summary>
public class ReporteG
{
    private int id, id_persona;
    private long total;
    private DateTime fecha;
    private string nombre_usuario;
    [Key]
    [Column("id")]
    public int Id { get => id; set => id = value; }
    [Column("id_persona")]
    public int Id_persona { get => id_persona; set => id_persona = value; }
    [Column("total")]
    public long Total { get => total; set => total = value; }
    [Column("fecha")]
    public DateTime Fecha { get => fecha; set => fecha = value; }
    [NotMapped]
    public string Nombre_usuario { get => nombre_usuario; set => nombre_usuario = value; }
}
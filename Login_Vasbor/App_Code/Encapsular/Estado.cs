using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Estado
/// </summary>
/// 
[Serializable]
[Table("estado_registro", Schema = "restaurante")]
public class Estado
{
    private int id;
    private string descripcion;
    [Key]
    [Column("id")]
    public int Id { get => id; set => id = value; }
    [Column("descripcion")]
    public string Descripcion_rol { get => descripcion; set => descripcion = value; }
}
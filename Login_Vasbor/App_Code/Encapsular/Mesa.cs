using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Categoria
/// </summary>
[Serializable]
[Table("mesas", Schema = "restaurante")]
public class Mesa
{
    private int id;
    private string descripcion;
    [Key]
    [Column("id")]
    public int Id { get => id; set => id = value; }
    [Column("descripcion_mesa")]
    public string Descripcion { get => descripcion; set => descripcion = value; }
}
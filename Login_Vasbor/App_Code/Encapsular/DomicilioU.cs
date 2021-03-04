using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de DomicilioU
/// </summary>
/// 
[Serializable]
[Table("domiciliou", Schema = "restaurante")]
public class DomicilioU
{
    private int id, id_usuario, codigop;
    private string direccion,pais,ciudad;
    [Key]
    [Column("id")]
    public int Id { get => id; set => id = value; }
    [Column("id_usuario")]
    public int Id_usuario { get => id_usuario; set => id_usuario = value; }
    [Column("direccion")]
    public string Direccion { get => direccion; set => direccion = value; }
    [Column("pais")]
    public string Pais { get => pais; set => pais = value; }
    [Column("ciudad")]
    public string Ciudad { get => ciudad; set => ciudad = value; }
    [Column("codigop")]
    public int Codigop { get => codigop; set => codigop = value; }
    
}
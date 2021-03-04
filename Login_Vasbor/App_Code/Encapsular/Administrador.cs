using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Administrador
/// </summary>
/// 
[Serializable]
[Table("registro_administrador", Schema = "restaurante")]
public class Administrador
{
    private int id, id_rol;
    private long identificacion;
    private string correo;
    private string nombre, username, apellido, clave, descripcion_Rol, session;
    private Nullable<DateTime> lastModifify;
    [Key]
    [Column("id")]
    public int Id { get => id; set => id = value; }
    [Column("nombre")]
    public string Nombre { get => nombre; set => nombre = value; }
    [Column("apellido")]
    public string Apellido { get => apellido; set => apellido = value; }
    [Column("correo")]
    public string Correo { get => correo; set => correo = value; }
    [Column("username")]
    public string Username { get => username; set => username = value; }
    [Column("clave")]
    public string Clave { get => clave; set => clave = value; }
    [Column("identificacion")]
    public long Identificacion { get => identificacion; set => identificacion = value; }
    [Column("id_rol")]
    public int Id_rol { get => id_rol; set => id_rol = value; }
    [Column("session")]
    public string Session { get => session; set => session = value; }
    [Column("last_modifity")]
    public DateTime? LastModifify { get => lastModifify; set => lastModifify = value; }
    [NotMapped]
    public string Descripcion_Rol { get => descripcion_Rol; set => descripcion_Rol = value; }
   
}
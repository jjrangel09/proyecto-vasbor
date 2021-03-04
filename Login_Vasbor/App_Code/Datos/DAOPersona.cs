using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using Npgsql;

/// <summary>
/// Descripción breve de DAOPersona
/// </summary>
public class DAOPersona
{
    public EPersona BuscarUsername(EPersona persona)
    {
        using (var db = new Mapeo())
        {
            return db.persona.Where(x => x.Username.Equals(persona.Username) || x.Correo.Equals(persona.Correo) || x.Identificacion.Equals(persona.Identificacion)).FirstOrDefault();
        }
    }
    public EPersona BuscarCorreo(String correo)
    {
        using (var db = new Mapeo())
        {
            return db.persona.Where(x => x.Correo.Equals(correo)).FirstOrDefault();
        }
    }
    public EPersona BuscarToken(String token)
    {
        using (var db = new Mapeo())
        {

            return db.persona.Where(x => x.Token.Equals(token) && x.Estado_id == 2).FirstOrDefault();
        }
    }
    public EPersona Login_Vasbor(EPersona user)
    {
        using (var db = new Mapeo())
        {

            return db.persona.Where(x => x.Username.Equals(user.Username) && x.Clave.Equals(user.Clave)).FirstOrDefault();
        }
    }
    public EPersona cambiarClave(EPersona user)
    {
        using (var db = new Mapeo())
        {

            return db.persona.Where(x=> x.Clave.Equals(user.Clave)).FirstOrDefault();
        }
    }
    public List<Estado> obtenerEstado()
    {
        using (var db = new Mapeo())
        {
            return db.estado.ToList();
        }

    }
    public void InsertarUsuario(EPersona user)
    {
        using (var db = new Mapeo())
        {
            db.persona.Add(user);
            db.SaveChanges();
            
        }
        
    }
    public List<EPersona> obtenerUsuarios()
    {
        using (var db = new Mapeo())
        {
            return (from uu in db.persona
                    join rol in db.rol on uu.Id_rol equals rol.Id

                    select new
                    {
                        uu,
                        rol
                    }).ToList().Select(m => new EPersona
                    {
                        Id=m.uu.Id,
                        Identificacion = m.uu.Identificacion,
                        Nombre = m.uu.Nombre,
                        Apellido = m.uu.Apellido,
                        Telefono = m.uu.Telefono,
                        Username = m.uu.Username,
                        Clave = m.uu.Clave,
                        Correo = m.uu.Correo,
                        Descripcion_Rol = m.rol.Descripcion_rol,
                        Estado_id=m.uu.Estado_id,
                        Id_rol = m.uu.Id_rol


                        
                    }).ToList();
        }

    }
    public void ActualizarUsuario(EPersona user)
    
{
        using (var db = new Mapeo())
        {

            EPersona user2 = db.persona.Where(x => x.Id == user.Id).First();
            user2.Identificacion = user.Identificacion;
            user2.Nombre = user.Nombre;
            user2.Apellido = user.Apellido;
            user2.Telefono = user.Telefono;
            user2.Username = user.Username;
            user2.Clave = user.Clave;
            user2.Correo = user.Correo;
            user2.Estado_id = user.Estado_id;
            user2.Descripcion_Rol = user.Descripcion_Rol;
            user2.Id_rol = user.Id_rol;
            user2.Token = user.Token;
            user2.VencimientoToken = user.VencimientoToken;
            user2.Session = user.Session;
            user2.LastModifify = System.DateTime.Now;

            db.persona.Attach(user2);

            var entry = db.Entry(user2);
            entry.State = EntityState.Modified;
            db.SaveChanges();
        }
    }

    public void ActualizaClaveUsuario(EPersona user)

    {
        using (var db = new Mapeo())
        {

            EPersona user2 = db.persona.Where(x => x.Id == user.Id).First();
            user2.Clave = user.Clave;
            db.persona.Attach(user2);
            var entry = db.Entry(user2);
            entry.State = EntityState.Modified;
            db.SaveChanges();
        }
    }
    public void ActualizarUsuarioPerfil(EPersona user)

    {
        using (var db = new Mapeo())
        {

            EPersona user2 = db.persona.Where(x => x.Id == user.Id).First();
            user2.Nombre = user.Nombre;
            user2.Apellido = user.Apellido;
            user2.Telefono = user.Telefono;
            user2.Username = user.Username;
            user2.Correo = user.Correo;
            db.persona.Attach(user2);

            var entry = db.Entry(user2);
            entry.State = EntityState.Modified;
            db.SaveChanges();
        }
    }
    public void eliminar(EPersona user)
    {
        using (var db = new Mapeo())
        {
            db.persona.Attach(user);
            var entry = db.Entry(user);
            entry.State = EntityState.Deleted;
            db.SaveChanges();
        }
    }
    public EPersona obtenerUsuario(int idusuario )
    {
        using (var db = new Mapeo())
        {
            return (from uu in db.persona
                    join rol in db.rol on uu.Id_rol equals rol.Id
                    where uu.Id == idusuario
                    select new
                    {
                        uu,
                        rol
                    }).ToList().Select(m => new EPersona
                    {
                        Id = m.uu.Id,
                        Identificacion = m.uu.Identificacion,
                        Nombre = m.uu.Nombre,
                        Apellido = m.uu.Apellido,
                        Telefono = m.uu.Telefono,
                        Username = m.uu.Username,
                        Clave = m.uu.Clave,
                        Correo = m.uu.Correo,
                    }).FirstOrDefault();
        }

    }

}

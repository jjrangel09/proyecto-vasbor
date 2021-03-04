using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Administrador
/// </summary>
public class DAOAdministrador
{
    public Administrador BuscarUsername(Administrador admin)
    {
        using (var db = new Mapeo())
        {
            return db.administrado.Where(x => x.Username.Equals(admin.Username) || x.Correo.Equals(admin.Correo) || x.Identificacion.Equals(admin.Identificacion)).FirstOrDefault();
        }
    }
    public Administrador Login_Vasbor(Administrador admin)
    {
        using (var db = new Mapeo())
        {

            return db.administrado.Where(x => x.Username.Equals(admin.Username) && x.Clave.Equals(admin.Clave)).FirstOrDefault();
        }
    }
    public List<Administrador> obtenerAdnimistrador()
    {
        using (var db = new Mapeo())
        {
            return (from uu in db.administrado
                    join rol in db.rol on uu.Id_rol equals rol.Id

                    select new
                    {
                        uu,
                        rol
                    }).ToList().Select(m => new Administrador
                    {
                        Id=m.uu.Id,
                        Identificacion = m.uu.Identificacion,
                        Nombre = m.uu.Nombre,
                        Apellido = m.uu.Apellido,
                        Username = m.uu.Username,
                        Clave = m.uu.Clave,
                        Correo = m.uu.Correo,
                        Descripcion_Rol = m.rol.Descripcion_rol,
                        Id_rol = m.uu.Id_rol



                    }).ToList();
        }
    }
    public void actualizar(Administrador user)
    {
        using (var db = new Mapeo())


        {
            Administrador euser = db.administrado.Where(x => x.Id == user.Id).First();
            euser.Nombre = user.Nombre;
            euser.Apellido = user.Apellido;
            euser.Correo = user.Correo;
            euser.Username = user.Username;
            euser.Identificacion = user.Identificacion;
            euser.Descripcion_Rol = user.Descripcion_Rol;
            euser.Clave = user.Clave;
            euser.Id_rol = 1;
            euser.Session = user.Session;
            euser.LastModifify = System.DateTime.Now;
            db.administrado.Attach(euser);
            var entry = db.Entry(euser);
            entry.State = EntityState.Modified;
            db.SaveChanges();
        }
    }
    public void InsertarAdministrador(Administrador admin)
    {
        using (var db = new Mapeo())
        {
            db.administrado.Add(admin);
            db.SaveChanges();

        }

    }
    public void eliminar(Administrador user)
    {
        using (var db = new Mapeo())


        {
            db.administrado.Attach(user);
            var entry = db.Entry(user);
            entry.State = EntityState.Deleted;
            db.SaveChanges();
        }
    }
    public void InsertarReporteUsuario(ReporteG user)
    {
        using (var db = new Mapeo())
        {
            db.reporteg.Add(user);
            db.SaveChanges();

        }

    }
    public void InsertarReporteMesero(ReporteGM mesero)
    {
        using (var db = new Mapeo())
        {
            db.reportegm.Add(mesero);
            db.SaveChanges();

        }

    }
}
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using Npgsql;

/// <summary>
/// Descripción breve de DAOSubcategoria
/// </summary>
public class DAOSubcategoria
{
    public Subcategoria BuscarSubCategoria(Subcategoria subcategoria)
    {
        using (var db = new Mapeo())
        {
            return db.subcategoria.Where(x => x.Subcategorias.ToLower().Trim().Equals(subcategoria.Subcategorias.ToLower().Trim())).FirstOrDefault();
        }
    }
    public void InsertarSubcategoria(Subcategoria user)
    {
        using (var db = new Mapeo())
        {
            db.subcategoria.Add(user);
            db.SaveChanges();

        }

    }
    public List<Subcategoria> obtenerPsubcategorias()
    {
        List<Subcategoria> x = new List<Subcategoria>();
        Subcategoria y = new Subcategoria();
        y.Id = 0;
        y.Descripcion = "--Seleccione--";
        using (var db = new Mapeo())
        {
            x = db.subcategoria.ToList();
           
        }
        x.Add(y);
        return x.OrderBy(z => z.Id).ToList();


    }
    public List<Subcategoria> obtenerSubcategoria()
    {
       
        using (var db = new Mapeo())
        {
            return (from uu in db.subcategoria
                    join Cat in db.categoria on uu.Id_categoria equals Cat.Id

                    select new
                    {
                        uu,
                        Cat
                    }).ToList().Select(m => new Subcategoria

                    {
                        Id = m.uu.Id,
                        Subcategorias = m.uu.Subcategorias,
                        Id_categoria = m.Cat.Id,
                        Descripcion=m.Cat.Categorias
                    }).ToList();
        }
        

    }
    public void SubCategoriaEliminar(Subcategoria subcategoria)
    {
        using (var db = new Mapeo())
        {
            db.subcategoria.Attach(subcategoria);
            var entry = db.Entry(subcategoria);
            entry.State = EntityState.Deleted;
            db.SaveChanges();
        }
    }
    public void ActualizarSubCategoria(Subcategoria scategoria)
    {
        using (var db = new Mapeo())
        {
            Subcategoria categoria2 = db.subcategoria.Where(x => x.Id == scategoria.Id).First();
            categoria2.Descripcion = scategoria.Descripcion;
            categoria2.Subcategorias = scategoria.Subcategorias;
            db.subcategoria.Attach(categoria2);
            var entry = db.Entry(categoria2);
            entry.State = EntityState.Modified;
            db.SaveChanges();
        }
    }
}
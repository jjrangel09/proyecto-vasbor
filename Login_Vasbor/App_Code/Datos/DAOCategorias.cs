using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using Npgsql;

/// <summary>
/// Descripción breve de DAOCategorias
/// </summary>
public class DAOCategorias
{
    public Categoria BuscarCategoria(Categoria categoria)
    {
        using (var db = new Mapeo())
        {
            return db.categoria.Where(x => x.Categorias.ToLower().Trim().Equals(categoria.Categorias.ToLower().Trim())).FirstOrDefault();
        }
    }
    public void InsertarCategoria(Categoria user)
    {
        using (var db = new Mapeo())
        {
            db.categoria.Add(user);
            db.SaveChanges();

        }

    }
    public List<Categoria> obtenerCategoria()
    {
        List<Categoria> x = new List<Categoria>();
        Categoria y = new Categoria();
        y.Id = 0;
        y.Categorias = "--Seleccione--";
        using (var db = new Mapeo())
        {
        x= db.categoria.ToList();
        }
        x.Add(y);
        return x.OrderBy(z => z.Id).ToList();
    }
    public List<Categoria> obtenerCategoria2()
    {
        List<Categoria> x = new List<Categoria>();
        using (var db = new Mapeo())
        {
            x= db.categoria.ToList();
        }
        return x.OrderBy(z => z.Id).ToList();
    }
    public void CategoriaEliminar(Categoria categoria)
    {
        using (var db = new Mapeo())
        {
            db.categoria.Attach(categoria);
            var entry = db.Entry(categoria);
            entry.State = EntityState.Deleted;
            db.SaveChanges();
        }
    }
    public void ActualizarCategoria(Categoria categoria)
    {
        using (var db = new Mapeo())
        {
            Categoria categoria2 = db.categoria.Where(x => x.Id == categoria.Id).First();
            categoria2.Id = categoria.Id;
            categoria2.Categorias = categoria.Categorias;
            db.categoria.Attach(categoria2);
            var entry = db.Entry(categoria2);
            entry.State = EntityState.Modified;
            db.SaveChanges();
        }
    }
}
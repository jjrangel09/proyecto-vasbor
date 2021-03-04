using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using Npgsql;

/// <summary>
/// Descripción breve de DAOProducto
/// </summary>
public class DAOProducto
{
    public Producto BuscarProducto(Producto producto)
    {
        using (var db = new Mapeo())
        {
            return db.producto.Where(x => x.Nombre.ToLower().Trim().Equals(producto.Nombre.ToLower().Trim())).FirstOrDefault();
        }
    }
    public void InsertarProducto(Producto user)
    {
        using (var db = new Mapeo())
        {
            db.producto.Add(user);
            db.SaveChanges();

        }

    }
    /*public void borrarProductoCarro(Carrito carrito)
    {
        using (var db = new Mapeo())
        {
            Carrito carro = db.carrito.Where(x => x.Usuario_id == carrito.Usuario_id && x.Producto_id == carrito.Producto_id).FirstOrDefault();
            db.carrito.Attach(carro);
            var entry = db.Entry(carro);
            entry.State = EntityState.Deleted;
            db.SaveChanges();
        }
    }*/
    public void agregarCarrito(Carrito carrito)
    {

        using (var db = new Mapeo())

        {

            List<Carrito> carro = db.carrito.Where(x => x.Usuario_id == carrito.Usuario_id && x.Producto_id == carrito.Producto_id).ToList();
            for (int i = 0; i < carro.Count; i++)
            {
                if (carro[i].Producto_id == carrito.Producto_id)
                {
                    carro[i].Cantidad = carrito.Cantidad + carro[i].Cantidad;

                    db.carrito.Attach(carro[i]);
                    var entry = db.Entry(carro[i]);
                    entry.State = EntityState.Modified;
                    db.SaveChanges();
                }
                else
                {
                    db.carrito.Add(carrito);
                    db.SaveChanges();
                }

            }
            if (carro.Count == 0)
            {
                db.carrito.Add(carrito);
                db.SaveChanges();
            }

        }

    }
    public int obtenerCantidadxProducto(int productoId)
    {
        using (var db = new Mapeo())
        {
            Nullable<int> carrito = db.carrito.Where(x => x.Producto_id == productoId).Sum(x => x.Cantidad);
            int cantidad = db.producto.Where(x => x.Id == productoId).Select(x => x.Cantidad).First();
            return cantidad - (carrito !=null? carrito.Value:0);
        }

    }
    public List<Carrito> obtenerProductosCarrito(int userId)
    {
        using (var db = new Mapeo())
        {
            return (from uu in db.carrito
                    join p in db.producto on uu.Producto_id equals p.Id
                    join Cat in db.categoria on p.Categoria equals Cat.Id
                    join sub in db.subcategoria on p.Subcategoria equals sub.Id
                    where uu.Usuario_id == userId

                    select new
                    {
                        uu,
                        Cat,
                        sub,
                        p
                    }).ToList().Select(m => new Carrito

                    {
                        Id = m.uu.Id,
                        Usuario_id = m.uu.Usuario_id,
                        Producto_id = m.uu.Producto_id,
                        NombreProducto = m.p.Nombre,
                        Precio = m.p.Precio,
                        Imagen = m.p.Imagen,
                        Cantidad = m.uu.Cantidad,
                        Categoria = m.Cat.Categorias,
                        Subcategoria = m.sub.Subcategorias,
                        Fecha = DateTime.Now,
                        Total =m.p.Precio * m.uu.Cantidad.Value
                      
                    }).ToList();
        }

    }
    public List<Producto> obtenerProducto()
    {
        using (var db = new Mapeo())
        {
            return (from uu in db.producto
                    join Cat in db.categoria on uu.Categoria equals Cat.Id
                    join sub in db.subcategoria on uu.Subcategoria equals sub.Id
                    select new
                    {
                        uu,
                        Cat,
                        sub
                        
                    }).ToList().Select(m => new Producto

                    {
                        Id = m.uu.Id,
                        Nombre=m.uu.Nombre,
                        Categoria=m.Cat.Id,
                        Subcategoria=m.sub.Id,
                        Precio=m.uu.Precio,
                        Descripcion=m.uu.Descripcion,
                        Imagen=m.uu.Imagen,
                        Cantidad=m.uu.Cantidad
                    }).ToList();
        }

    }
    public List<Carrito> obtenerProductosCarritox2(int userId)
    {
        using (var db = new Mapeo())
        {
            return (from uu in db.carrito
                    join p in db.producto on uu.Producto_id equals p.Id
                    join user in db.persona on userId equals user.Id
                    join per in db.pedido on userId equals per.Id_usuario
                    join pag in db.pago on per.Id_pago equals pag.Id
                    join pagg in db.domiciliou on userId  equals pagg.Id_usuario
                    where uu.Usuario_id == userId

                    select new
                    {
                        uu,
                        p,
                        user,
                        per,
                        pag,
                        pagg
                        
                    }).ToList().Select(m => new Carrito
                    {
                        Total=m.per.Total,
                        Nombreu=m.user.Nombre,
                        Producto_id = m.uu.Producto_id,
                        NombreProducto = m.p.Nombre,
                        Form=m.pag.Descripcion,
                        Direccion=m.pagg.Direccion
                        

                    }).ToList();
        }

    }
    public List<Carrito> obtenerProductosCarritox3(int userId, string direccionu)
    {
        using (var db = new Mapeo())
        {
            return (from uu in db.carrito
                    join p in db.producto on uu.Producto_id equals p.Id
                    join Cat in db.categoria on p.Categoria equals Cat.Id
                    join sub in db.subcategoria on p.Subcategoria equals sub.Id
                    join user in db.persona on userId equals user.Id
                    join per in db.pedido on userId equals per.Id_usuario
                    join pag in db.pago on per.Id_pago equals pag.Id
                    join pagg in db.domiciliou on userId equals pagg.Id_usuario
                    where uu.Usuario_id == userId && pagg.Direccion==direccionu

                    select new
                    {
                        uu,
                        Cat,
                        sub,
                        p,
                        user,
                        per,
                        pag,
                        pagg
                    }).ToList().Select(m => new Carrito

                    {
                        Id = m.uu.Id,
                        Usuario_id = m.uu.Usuario_id,
                        Producto_id = m.uu.Producto_id,
                        NombreProducto = m.p.Nombre,
                        Precio = m.p.Precio,
                        Imagen = m.p.Imagen,
                        Cantidad = m.uu.Cantidad,
                        Categoria = m.Cat.Categorias,
                        Subcategoria = m.sub.Subcategorias,
                        Total = m.p.Precio * m.uu.Cantidad.Value,
                        Nombreu = m.user.Nombre,
                        Total2=m.per.Total,
                        Form=m.pag.Descripcion,
                        Direccion = m.pagg.Direccion,
                        Fecha=m.per.Fecha,
                        Id_factura=m.per.Id
                        
                        
                        
                    }).ToList();
        }

    
    }
    public DetallePedido obtenerDatosFactura(int idpedido, int userId, string direccionu)
    {
        using (var db = new Mapeo())
        {
            return (from uu in db.detallepedido
                    join user in db.persona on userId equals user.Id
                    join pagg in db.domiciliou on userId equals pagg.Id_usuario
                    join pag in db.pago on uu.Idpago equals pag.Id
                    where uu.Id_pedido == idpedido && pagg.Direccion == direccionu

                    select new
                    {
                        uu,
                        user,
                        pagg,
                        pag
                    }).ToList().Select(m => new DetallePedido

                    {
                        Id = m.uu.Id,
                        Id_usuario = m.uu.Id_usuario,
                        Id_pedido=m.uu.Id_pedido,
                        Cantidad = m.uu.Cantidad,
                        Fecha = m.uu.Fecha,
                        Nombre_usuario = m.user.Nombre,
                        Form = m.pag.Descripcion,
                        Direccion = m.pagg.Direccion,
                        Detalle=m.uu.Detalle
                    }).FirstOrDefault();
        }


    }
    public Pedido obtenerUltimoPedido(int id)
    {
        List<Pedido> pedido = new List<Pedido>();
        using (var db = new Mapeo())
        {
            pedido = db.pedido.Where(x => x.Id_usuario == id).ToList();
            int valor = pedido.Count;
            return pedido[valor];
        }
    }
    public int obtenerCantidadProductoxUser(int userId)
    {
        using (var db = new Mapeo())
        {
           
           
            return db.carrito.Where(x => x.Usuario_id == userId).Count();
        }

    }
    public List<Categoria> obtenerCategorias()
    {
        using (var db = new Mapeo())
        {
            return (db.categoria.ToList());
        }
    }
    public List<Producto> obtenerProductom()
    {

        using (var db = new Mapeo())
        {
            return (from uu in db.producto
                    join Cat in db.categoria on uu.Categoria equals Cat.Id
                    join sub in db.subcategoria on uu.Subcategoria equals sub.Id
                    orderby uu.Id
                   
            select new
                    {
                        uu,
                        Cat,
                        sub
                    }).ToList().Select(m => new Producto

                    {
                        Id = m.uu.Id,
                        Nombre = m.uu.Nombre,
                        Categoria = m.uu.Categoria,
                        Subcategoria = m.uu.Subcategoria,
                        Precio = m.uu.Precio,
                        Descripcion = m.uu.Descripcion,
                        Imagen = m.uu.Imagen,
                        Cantidad = m.uu.Cantidad,
                        Categorrias = m.Cat.Categorias,
                        Subcategorias = m.sub.Subcategorias,
                    }).ToList();
        }


    }
    public void ActualizarProducto(Producto producto)
    {
        using (var db = new Mapeo())
        {
            Producto producto2 = db.producto.Where(x => x.Id == producto.Id).First();
            producto2.Nombre = producto.Nombre;
            producto2.Categoria = producto.Categoria;
            producto2.Subcategoria = producto.Subcategoria;
            producto2.Precio = producto.Precio;
            producto2.Descripcion = producto.Descripcion;
            producto2.Cantidad = producto.Cantidad;
            producto2.Imagen = producto.Imagen;
            producto2.Session = producto.Session;
            producto2.LastModifify = System.DateTime.Now;
            db.producto.Attach(producto2);
           
            var entry = db.Entry(producto2);
            entry.State = EntityState.Modified;
            db.SaveChanges();
        }
    }
    public void ProductoEliminar(Producto producto)
    {
        using (var db = new Mapeo())
        {
            db.producto.Attach(producto);
            var entry = db.Entry(producto);
            entry.State = EntityState.Deleted;
            db.SaveChanges();
        }
    }
    public List<Producto> obtenerProductoCantidadActual(string nombreF, int cate)
    {
        List<Producto> productoVacio = new List<Producto>();
        using (var db = new Mapeo())
        {
            if (nombreF == null && cate == 0)
            {
                return (from uu in db.producto
                        join Cat in db.categoria on uu.Categoria equals Cat.Id
                        join sub in db.subcategoria on uu.Subcategoria equals sub.Id
                        let _cantCarrito = (from ii in db.carrito where ii.Producto_id == uu.Id select ii.Cantidad).Sum()
                        where uu.Cantidad >0.0 
                        select new
                        {
                            uu,
                            Cat,
                            sub,
                            _cantCarrito
                        }).ToList().Select(m => new Producto

                        {
                            Id = m.uu.Id,
                            Nombre = m.uu.Nombre,
                            Categoria = m.uu.Categoria,
                            Subcategoria = m.uu.Subcategoria,
                            Precio = m.uu.Precio,
                            Descripcion = m.uu.Descripcion,
                            Imagen = m.uu.Imagen,
                            Cantidad = m.uu.Cantidad - (m._cantCarrito.HasValue ? m._cantCarrito.Value : 0),
                            Categorrias = m.Cat.Categorias,
                            Subcategorias = m.sub.Subcategorias,
                        }).ToList();
            }
            else if (nombreF != null && cate == 0)
            {
                return (from uu in db.producto
                        join Cat in db.categoria on uu.Categoria equals Cat.Id
                        join sub in db.subcategoria on uu.Subcategoria equals sub.Id
                        let _cantCarrito = (from ii in db.carrito where ii.Producto_id == uu.Id select ii.Cantidad).Sum()
                        where (uu.Nombre.ToLower().Contains(nombreF.ToLower())) && uu.Cantidad > 0.0
                        select new
                        {
                            uu,
                            Cat,
                            sub,
                            _cantCarrito
                        }).ToList().Select(m => new Producto

                        {
                            Id = m.uu.Id,
                            Nombre = m.uu.Nombre,
                            Categoria = m.uu.Categoria,
                            Subcategoria = m.uu.Subcategoria,
                            Precio = m.uu.Precio,
                            Descripcion = m.uu.Descripcion,
                            Imagen = m.uu.Imagen,
                            Cantidad = m.uu.Cantidad - (m._cantCarrito.HasValue ? m._cantCarrito.Value : 0),
                            Categorrias = m.Cat.Categorias,
                            Subcategorias = m.sub.Subcategorias,
                        }).ToList();
            }
            else if (nombreF != null && cate != 0)
            {
                return (from uu in db.producto
                        join Cat in db.categoria on uu.Categoria equals Cat.Id
                        join sub in db.subcategoria on uu.Subcategoria equals sub.Id
                        let _cantCarrito = (from ii in db.carrito where ii.Producto_id == uu.Id select ii.Cantidad).Sum()
                        where (uu.Nombre.ToLower().Contains(nombreF.ToLower()) && uu.Categoria == cate) && uu.Cantidad > 0.0
                        select new
                        {
                            uu,
                            Cat,
                            sub,
                            _cantCarrito
                        }).ToList().Select(m => new Producto

                        {
                            Id = m.uu.Id,
                            Nombre = m.uu.Nombre,
                            Categoria = m.uu.Categoria,
                            Subcategoria = m.uu.Subcategoria,
                            Precio = m.uu.Precio,
                            Descripcion = m.uu.Descripcion,
                            Imagen = m.uu.Imagen,
                            Cantidad = m.uu.Cantidad - (m._cantCarrito.HasValue ? m._cantCarrito.Value : 0),
                            Categorrias = m.Cat.Categorias,
                            Subcategorias = m.sub.Subcategorias,
                        }).ToList();
            }
            else if (nombreF == null && cate != 0)
            {
                return (from uu in db.producto
                        join Cat in db.categoria on uu.Categoria equals Cat.Id
                        join sub in db.subcategoria on uu.Subcategoria equals sub.Id
                        let _cantCarrito = (from ii in db.carrito where ii.Producto_id == uu.Id select ii.Cantidad).Sum()
                        where (uu.Categoria == cate) && uu.Cantidad > 0.0
                        select new
                        {
                            uu,
                            Cat,
                            sub,
                            _cantCarrito
                        }).ToList().Select(m => new Producto

                        {
                            Id = m.uu.Id,
                            Nombre = m.uu.Nombre,
                            Categoria = m.uu.Categoria,
                            Subcategoria = m.uu.Subcategoria,
                            Precio = m.uu.Precio,
                            Descripcion = m.uu.Descripcion,
                            Imagen = m.uu.Imagen,
                            Cantidad = m.uu.Cantidad - (m._cantCarrito.HasValue ? m._cantCarrito.Value : 0),
                            Categorrias = m.Cat.Categorias,
                            Subcategorias = m.sub.Subcategorias,
                        }).ToList();
            }
            else
                return productoVacio;
        }
    }
    public List<Producto> obtenerProductoReporte()
    {

        using (var db = new Mapeo())
        {
            return (from uu in db.producto
                    join Cat in db.categoria on uu.Categoria equals Cat.Id
                    join sub in db.subcategoria on uu.Subcategoria equals sub.Id
                    //where uu.Categoria== 1 

                    select new
                    {
                        uu,
                        Cat,
                        sub
                    }).ToList().Select(m => new Producto
                    
                    {
                        Id = m.uu.Id,
                        Nombre = m.uu.Nombre,
                        Categoria = m.uu.Categoria,
                        Subcategoria = m.uu.Subcategoria,
                        Precio = m.uu.Precio,
                        Descripcion = m.uu.Descripcion,
                        Imagen = m.uu.Imagen,
                        Cantidad = m.uu.Cantidad,
                        Categorrias = m.Cat.Categorias,
                        Subcategorias = m.sub.Subcategorias,
                    }).ToList();
        }


    }
    public void borrarProductoCarro(int id, int id_usario)
    {
        using (var db = new Mapeo())
        {
            Carrito carro = db.carrito.Where(x => x.Id == id && x.Usuario_id == id_usario).FirstOrDefault();
            db.carrito.Attach(carro);
            var entry = db.Entry(carro);
            entry.State = EntityState.Deleted;
            db.SaveChanges();
        }
    }
    public Producto VerificarProducto( int idproducto)
    {

        using (var db = new Mapeo())
        {
            return (from uu in db.producto
                    where uu.Id == idproducto
                    select new
                     
                    {
                        uu
                     
                    }).ToList().Select(m => new Producto

                    {
                        Cantidad = m.uu.Cantidad,
                    }).FirstOrDefault();
        }


    }
}
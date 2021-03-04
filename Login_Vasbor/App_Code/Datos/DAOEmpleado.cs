using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de DAOEmpleado
/// </summary>
public class DAOEmpleado
{
    public Empleado BuscarUsername(Empleado empleado)
    {
        using (var db = new Mapeo())
        {
            return db.empleado.Where(x => x.Username.Equals(empleado.Username) || x.Id_codigo.Equals(empleado.Id_codigo) || x.Telefono.Equals(empleado.Telefono)).FirstOrDefault();
        }
    }
    public Empleado BuscarId_codigo(String codigo)
    {
        using (var db = new Mapeo())
        {
            return db.empleado.Where(x => x.Id_codigo.Equals(codigo)).FirstOrDefault();
        }
    }
    public Empleado Login_Vasbor(Empleado empleado)
    {
        using (var db = new Mapeo())
        {

            return db.empleado.Where(x => x.Username.Equals(empleado.Username) && x.Clave.Equals(empleado.Clave)).FirstOrDefault();
        }
    }
    public List<Empleado> obtenerEmpleados()
    {
        using (var db = new Mapeo())
        {
            return (from uu in db.empleado
                    join rol in db.rol on uu.Id_rol equals rol.Id

                    select new
                    {
                        uu,
                        rol
                    }).ToList().Select(m => new Empleado
                    {
                        Id=m.uu.Id,
                        Telefono=m.uu.Telefono,
                        Id_codigo = m.uu.Id_codigo,
                        Nombre = m.uu.Nombre,
                        Apellido = m.uu.Apellido,
                        Username = m.uu.Username,
                        Clave = m.uu.Clave,
                        Estado_id=m.uu.Estado_id,
                        Descripcion_Rol = m.rol.Descripcion_rol,
                        Id_rol = m.uu.Id_rol



                    }).ToList();
        }

    }
    public void InsertarEmpleado(Empleado user)
    {
        using (var db = new Mapeo())
        {
            db.empleado.Add(user);
            db.SaveChanges();
        }

    }
    public void ActualizarEmpleado(Empleado user)
    {
        using (var db = new Mapeo())
        {
            Empleado user2 = db.empleado.Where(x => x.Id == user.Id).First();
            user2.Nombre = user.Nombre;
            user2.Apellido = user.Apellido;
            user2.Telefono = user.Telefono;
            user2.Username = user.Username;
            user2.Clave = user.Clave;
            user2.Estado_id = user.Estado_id;
            user2.Id_codigo = user.Id_codigo;
            user2.Descripcion_Rol = user.Descripcion_Rol;
            user2.Id_rol = user.Id_rol;
            user2.Session = user.Session;
            user2.LastModifify = System.DateTime.Now;

            db.empleado.Attach(user2);

            var entry = db.Entry(user2);
            entry.State = EntityState.Modified;
            db.SaveChanges();
        }
    }
    public void eliminar(Empleado user)
    {
        using (var db = new Mapeo())
        {
            db.empleado.Attach(user);
            var entry = db.Entry(user);
            entry.State = EntityState.Deleted;
            db.SaveChanges();
        }
    }
    public List<CarritoE> obtenerProductosCarritoE(int empleadoId)
    {
        using (var db = new Mapeo())
        {
            return (from uu in db.carritoe
                    join p in db.producto on uu.Producto_id equals p.Id
                    join Cat in db.categoria on p.Categoria equals Cat.Id
                    join sub in db.subcategoria on p.Subcategoria equals sub.Id
                    where uu.Id_mesero == empleadoId

                    select new
                    {
                        uu,
                        Cat,
                        sub,
                        p
                    }).ToList().Select(m => new CarritoE

                    {
                        Id = m.uu.Id,
                        Id_mesero = m.uu.Id_mesero,
                        Producto_id = m.uu.Producto_id,
                        NombreProducto = m.p.Nombre,
                        Precio = m.p.Precio,
                        Imagen = m.p.Imagen,
                        Fecha = DateTime.Now,
                        Cantidad = m.uu.Cantidad,
                        Categoria = m.Cat.Categorias,
                        Subcategoria = m.sub.Subcategorias,
                        Total = m.p.Precio * m.uu.Cantidad.Value
                    }).ToList();
        }

    }
    public int obtenerCantidadProductoxEmpleado(int empleadoId)
    {
        using (var db = new Mapeo())
        {


            return db.carritoe.Where(x => x.Id_mesero == empleadoId).Count();
        }

    }
    public int obtenerCantidadPedidosxEmpleado(int empleadoId)
    {
        using (var db = new Mapeo())
        {


            return db.pedidom.Where(x => x.Id_mesero == empleadoId).Count();
        }

    }
    public void borrarProductoCarroEmpleado(int id, int id_empleado)
    {
        using (var db = new Mapeo())
        {
            CarritoE carroe = db.carritoe.Where(x => x.Id == id && x.Id_mesero == id_empleado).FirstOrDefault();
            db.carritoe.Attach(carroe);
            var entry = db.Entry(carroe);
            entry.State = EntityState.Deleted;
            db.SaveChanges();
        }
    }
    public void agregarCarritoEmpleado(CarritoE carritoe)
    {

        using (var db = new Mapeo())

        {

            List<CarritoE> carro = db.carritoe.Where(x => x.Id_mesero == carritoe.Id_mesero && x.Producto_id == carritoe.Producto_id).ToList();
            for (int i = 0; i < carro.Count; i++)
            {
                if (carro[i].Producto_id == carritoe.Producto_id)
                {
                    carro[i].Cantidad = carritoe.Cantidad + carro[i].Cantidad;

                    db.carritoe.Attach(carro[i]);

                    var entry = db.Entry(carro[i]);
                    entry.State = EntityState.Modified;
                    db.SaveChanges();
                }
                else
                {
                    db.carritoe.Add(carritoe);
                    db.SaveChanges();
                }

            }
            if (carro.Count == 0)
            {
                db.carritoe.Add(carritoe);
                db.SaveChanges();
            }

        }

    }
    public List<Mesa> obtenerMesa()
    {
        List<Mesa> x = new List<Mesa>();
        Mesa y = new Mesa();
        y.Id = 0;
        y.Descripcion = "--Seleccione--";
        using (var db = new Mapeo())
        {
            x = db.mesa.ToList();
        }
        x.Add(y);
        return x.OrderBy(z => z.Id).ToList();
    }
    public void InsertarPedidoEmpleado(PedidoM pedido)
    {
        using (var db = new Mapeo())
        {
            db.pedidom.Add(pedido);
            db.SaveChanges();
        }
    }
    public void InsertarDetalleEmpleado(DetallePedidoM detalle)
    {
        using (var db = new Mapeo())
        {
            db.detallepedidom.Add(detalle);
            db.SaveChanges();

        }

    }
    public void borrarCarroEmpleado( int id_empleado)
    {
        using (var db = new Mapeo())
        {
          List<CarritoE> carroe = db.carritoe.Where(x => x.Id_mesero == id_empleado).ToList();

            foreach (CarritoE item in carroe)
            {
              
               db.Entry(item).State = EntityState.Deleted;
        
            }
            db.SaveChanges();
        }
    }
    public DetallePedidoM obtenerFacturaEmpleado(int idpedido ,int idmesero)
    {
        using (var db = new Mapeo())
        {
            return (from uu in db.detallepedidom
                    join emp in db.empleado on uu.Id_mesero equals emp.Id
                    join pag in db.pago on uu.Id_pago equals pag.Id
                    where uu.Id_pedido == idpedido && uu.Id_mesero== idmesero

                    select new
                    {
                        uu,
                        pag,
                        emp
                    }).ToList().Select(m => new DetallePedidoM

                    {
                        Id=m.uu.Id,
                        Id_pedido=m.uu.Id_pedido,
                        Nombre_empleado=m.emp.Nombre,
                        Form = m.pag.Descripcion,
                        Detalle=m.uu.Detalle,
                        Fecha=m.uu.Fecha
                    }).FirstOrDefault();
        }


    }
    public int obtenerCantidadxProducto(int productoId)
    {
        using (var db = new Mapeo())
        {
            Nullable<int> carrito = db.carritoe.Where(x => x.Producto_id == productoId).Sum(x => x.Cantidad);
            int cantidad = db.producto.Where(x => x.Id == productoId).Select(x => x.Cantidad).First();
            return cantidad - (carrito != null ? carrito.Value : 0);
        }

    }
    public List<Producto> obtenerProductoCantidadActualE(string nombreF, int cate)
    {
        List<Producto> productoVacio = new List<Producto>();
        using (var db = new Mapeo())
        {
            if (nombreF == null && cate == 0)
            {
                return (from uu in db.producto
                        join Cat in db.categoria on uu.Categoria equals Cat.Id
                        join sub in db.subcategoria on uu.Subcategoria equals sub.Id
                        let _cantCarrito = (from ii in db.carritoe where ii.Producto_id == uu.Id select ii.Cantidad).Sum()
                        where uu.Cantidad > 0.0
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
                        let _cantCarrito = (from ii in db.carritoe where ii.Producto_id == uu.Id select ii.Cantidad).Sum()
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
                        let _cantCarrito = (from ii in db.carritoe where ii.Producto_id == uu.Id select ii.Cantidad).Sum()
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
                        let _cantCarrito = (from ii in db.carritoe where ii.Producto_id == uu.Id select ii.Cantidad).Sum()
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
    public PedidoM ObtenerPedidoE(int pedidoid)
    {

        using (var db = new Mapeo())
        {

            // string pa;
            // pa =db.pedido.Where(x => x.Id_usuario == userId).ToList().Select(x => x.Id).ToString();
            //return db.pedido.Where(x => x.Id_usuario == userId).ToList();
            return (from uu in db.pedidom
                    where uu.Id == pedidoid
                    select new
                    {
                        uu
                    }).ToList().Select(m => new PedidoM
                    {
                        Id = m.uu.Id,
                        Total=m.uu.Total,
                        Id_pago=m.uu.Id_pago,
                        Detalle=m.uu.Detalle,
                        Cantidad=m.uu.Cantidad
                        
                    }).FirstOrDefault();
            //  return pa;
        }


    }
    public List<PedidoM> obtenerPedidosxEmpleado( int empleadoid)
    {
        List<PedidoM> x = new List<PedidoM>();
        PedidoM y = new PedidoM();
        y.Id = 0;
        y.Nom_mesa ="--Seleccione--";
        using (var db = new Mapeo())
        {
            x= (from uu in db.pedidom
                    join mes in db.mesa on uu.Id_mesa equals mes.Id
                    where uu.Id_mesero == empleadoid
                    select new
                    {
                        uu,
                        mes
                    }).ToList().Select(m => new PedidoM
                    {
                        Id = m.uu.Id,
                        Nom_mesa=m.mes.Descripcion
                        
                    }).ToList();
        }
        x.Add(y);
        return x.OrderBy(z => z.Id).ToList();
    }
    public void borrarPedidoPendiente(int idpedido)
    {
        using (var db = new Mapeo())
        {
            
        List<PedidoM> pedidomesero = db.pedidom.Where(x => x.Id == idpedido).ToList();

            foreach (PedidoM item in pedidomesero)
            {

                db.Entry(item).State = EntityState.Deleted;

            }
            db.SaveChanges();
        }
    }
    public void ActulizarCantidad(int emleadoid)
    {
        using (var db = new Mapeo())
        {

            List<CarritoE> carro = new List<CarritoE>();
            Producto produc = new Producto();

            carro = db.carritoe.Where(x => x.Id_mesero == emleadoid).ToList();

            for (int i = 0; i < carro.Count; i++)
            {
                int id_pro = carro[i].Producto_id;
                produc = db.producto.Where(x => x.Id == id_pro).First();
                produc.Cantidad = produc.Cantidad - (carro[i].Cantidad.HasValue ? carro[i].Cantidad.Value : 0);
                db.producto.Attach(produc);
                var entry = db.Entry(produc);
                entry.State = EntityState.Modified;
            }
            db.SaveChanges();
        }
    }
    public Empleado obtenerEmpleadoPerfil(int idempleado)
    {
        using (var db = new Mapeo())
        {
            return (from uu in db.empleado
                    join rol in db.rol on uu.Id_rol equals rol.Id
                    where uu.Id == idempleado
                    select new
                    {
                        uu,
                        rol
                    }).ToList().Select(m => new Empleado
                    {
                        Id = m.uu.Id,
                        Id_codigo = m.uu.Id_codigo,
                        Nombre = m.uu.Nombre,
                        Apellido = m.uu.Apellido,
                        Telefono = m.uu.Telefono,
                        Username = m.uu.Username,
                        Clave = m.uu.Clave,
                    }).FirstOrDefault();
        }

    }
    public void ActualizarEmpleadoPerfil(Empleado empleado)

    {
        using (var db = new Mapeo())
        {

            Empleado user2 = db.empleado.Where(x => x.Id == empleado.Id).First();
            user2.Nombre = empleado.Nombre;
            user2.Apellido = empleado.Apellido;
            user2.Username = empleado.Username;
            db.empleado.Attach(user2);
            var entry = db.Entry(user2);
            entry.State = EntityState.Modified;
            db.SaveChanges();
        }
    }
}

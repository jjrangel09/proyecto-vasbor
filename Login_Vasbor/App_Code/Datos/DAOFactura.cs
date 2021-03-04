using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using Npgsql;


/// <summary>
/// Descripción breve de DAOFactura
/// </summary>
public class DAOFactura
{
    public DomicilioU BuscarDireccion(DomicilioU direccion)
    {
        using (var db = new Mapeo())
        {
            return db.domiciliou.Where(x => x.Direccion.ToLower().Trim().Equals(direccion.Direccion.ToLower().Trim())).FirstOrDefault();
        }
    }
    public List<Pago> obtenerPagos()
    {
        List<Pago> x = new List<Pago>();
        Pago y = new Pago();
        y.Id = 0;
        y.Descripcion = "--Seleccione--";
        using (var db = new Mapeo())
        {
            x = db.pago.ToList();
        }
        x.Add(y);
        return x.OrderBy(z => z.Id).ToList();
    }
    public void InsertarDetalle(DetallePedido detallePedido)
    {
        using (var db = new Mapeo())
        {
            List<Carrito> carro = new List<Carrito>();
            Producto produc = new Producto();
            db.detallepedido.Add(detallePedido);
            carro = db.carrito.Where(x => x.Usuario_id == detallePedido.Id_usuario).ToList();
        }
    }
    public void InsertarDomiciliou(DomicilioU domiciliou)
    {
        using (var db = new Mapeo())
        {
            db.domiciliou.Add(domiciliou);
            db.SaveChanges();

        }

    }
    public void InsertarPedido(Pedido pedido)
    {
        using (var db = new Mapeo())
        {
            db.pedido.Add(pedido);
            db.SaveChanges();

        }

    }
    public void InsertarDetallePedido(DetallePedido detalle)
    {
        using (var db = new Mapeo())
        {
            db.detallepedido.Add(detalle);
            db.SaveChanges();

        }

    }
    public List<Pedido> ObtenerPedidoU(int userId)
    {
    
        using (var db = new Mapeo())
        {
           
           // string pa;
           // pa =db.pedido.Where(x => x.Id_usuario == userId).ToList().Select(x => x.Id).ToString();
            //return db.pedido.Where(x => x.Id_usuario == userId).ToList();
            return (from uu in db.pedido
                    where uu.Id_usuario == userId
                    select new
                    {
                        uu
                    }).ToList().Select(m => new Pedido
                    {
                        Id=m.uu.Id
                    }).ToList();
          //  return pa;
        }


    }
    public List<DomicilioU> ObtenerDirreccionUsuario(int userId)
    {
        List<DomicilioU> x = new List<DomicilioU>();
        DomicilioU y = new DomicilioU();
        y.Id = 0;
        y.Direccion = "---Seleccione---";
        using (var db = new Mapeo())
        {
          
            x=(from uu in db.domiciliou
                    
                    where uu.Id_usuario == userId

                    select new
                    {
                        uu
                       
                    }).ToList().Select(m => new DomicilioU

                    {
                        Id=m.uu.Id,
                        Direccion=m.uu.Direccion,
                        Pais=m.uu.Pais,
                        Ciudad=m.uu.Ciudad,
                        Codigop=m.uu.Codigop

                    }).ToList();
        }
        x.Add(y);
        return x.OrderBy(z => z.Id).ToList();

    }
    public List<DomicilioU> ObtenerDirreccionUsuario2(int userId)
    {
      
       
      
        using (var db = new Mapeo())
        {

            return (from uu in db.domiciliou

                 where uu.Id_usuario == userId
                 orderby uu.Id

                 select new
                 {
                     uu

                 }).ToList().Select(m => new DomicilioU

                 {
                     Id = m.uu.Id,
                     Direccion = m.uu.Direccion,
                     Pais = m.uu.Pais,
                     Ciudad = m.uu.Ciudad,
                     Codigop = m.uu.Codigop

                 }).ToList();
        }
      
   

    }
    public DomicilioU obtenerDireccion(int id)
    {
        using (var db = new Mapeo())
        {
            return db.domiciliou.Where(x => x.Id == id).FirstOrDefault();
        }
    }
    public List<ReporteG> obtenerReporteUsuarios()
    {

        using (var db = new Mapeo())
        {
            return (from uu in db.reporteg
                    join user in db.persona on uu.Id_persona equals user.Id
                    select new
                    {
                        uu,
                        user,
                    }).ToList().Select(m => new ReporteG

                    {
                        Id = m.uu.Id,
                        Nombre_usuario = m.user.Nombre,
                        Id_persona=m.uu.Id_persona,
                        Total=m.uu.Total,
                        Fecha=m.uu.Fecha
                    }).ToList();
        }
    }
    public List<ReporteGM> obtenerReporteMeseros()
    {

        using (var db = new Mapeo())
        {
            return (from uu in db.reportegm
                    join mesero in db.empleado on uu.Id_mesero equals mesero.Id
                    select new
                    {
                        uu,
                        mesero,
                    }).ToList().Select(m => new ReporteGM

                    {
                        Id = m.uu.Id,
                        Nombre_Mesero = m.mesero.Nombre,
                        Id_mesero = m.mesero.Id_codigo,
                        Total = m.uu.Total,
                        Fecha = m.uu.Fecha
                    }).ToList();
        }
    }
    public void eliminarDPedidos(int idUser)
    {
        using (var db = new Mapeo())
        {
            List<DetallePedido> detalleP = db.detallepedido.Where(x => x.Id_usuario == idUser).ToList();
            List<DetallePedido> detallePEliminar = new List<DetallePedido>();
            for (int i=0; i<detalleP.Count-1;i++)
            {
                detallePEliminar.Add(detalleP[i]);
            }
            for (int i=0; i<detallePEliminar.Count;i++)
            {
                db.detallepedido.Attach(detallePEliminar[i]);
                var entry = db.Entry(detallePEliminar[i]);
                entry.State = EntityState.Deleted;
            }
            db.SaveChanges();
        }
    }
    public void eliminarPedidos(int idUser)
    {
        using (var db = new Mapeo())
        {
            List<Pedido> pedido = db.pedido.Where(x => x.Id_usuario == idUser).ToList();
            for (int i = 0; i < pedido.Count; i++)
            {
                db.pedido.Attach(pedido[i]);
                var entry = db.Entry(pedido[i]);
                entry.State = EntityState.Deleted;
            }
            db.SaveChanges();
        }
    }
    public void EliminarActulizar(int userId)
    {
        using (var db = new Mapeo())
        {

            List<Carrito> carro = new List<Carrito>();
            Producto produc = new Producto();

            carro = db.carrito.Where(x => x.Usuario_id == userId).ToList();

            for (int i = 0; i < carro.Count; i++)
            {
                int id_pro = carro[i].Producto_id;
                produc = db.producto.Where(x => x.Id == id_pro).First();
                produc.Cantidad = produc.Cantidad - (carro[i].Cantidad.HasValue ? carro[i].Cantidad.Value : 0);
                db.producto.Attach(produc);
                var entry = db.Entry(produc);
                entry.State = EntityState.Modified;
            }
            foreach (Carrito item in carro)
            {
                db.carrito.Attach(item);
                var entry1 = db.Entry(item);
                entry1.State = EntityState.Deleted;
            }
            db.SaveChanges();
        }
    }
}
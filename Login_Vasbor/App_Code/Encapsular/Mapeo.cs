using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Mapeo
/// </summary>
public class Mapeo : DbContext
{
    static Mapeo()
    {
        Database.SetInitializer<Mapeo>(null);
    }
    private readonly string schema = "restaurante";
    public Mapeo()
        : base("name=Conexion")
    {

    }
    public DbSet<DetallePedidoM> detallepedidom { get; set; }
    public DbSet<Mesa> mesa { get; set; }
    public DbSet<PedidoM> pedidom { get; set; }
    public DbSet<CarritoE> carritoe { get; set; }
    public DbSet<DetallePedido> detallepedido { get; set; }
    public DbSet<Pedido> pedido { get; set; }
    public DbSet<DomicilioU> domiciliou { get; set; }
    public DbSet<ReporteGM> reportegm { get; set; }
    public DbSet<ReporteG> reporteg { get; set; }
    public DbSet<Pago> pago { get; set; }
    public DbSet<Estado> estado { get; set; }
    public DbSet<EPersona> persona { get; set; }
    public DbSet<ERol> rol { get; set; }
    public DbSet<Categoria> categoria { get; set; }
    public DbSet<Subcategoria> subcategoria { get; set; }
    public DbSet<Producto> producto { get; set; }
    public DbSet<Empleado> empleado { get; set; }
    public DbSet<Administrador> administrado { get; set; }
    public DbSet<Carrito> carrito { get; set; }


    protected override void OnModelCreating(DbModelBuilder builder)
    {
        builder.HasDefaultSchema(this.schema);
        base.OnModelCreating(builder);
    }
}
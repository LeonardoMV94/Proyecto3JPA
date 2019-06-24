/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cl.model;

import cl.entities.Categoria;
import cl.entities.Detalle;
import cl.entities.Producto;
import cl.entities.Usuario;
import cl.entities.Venta;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author sistemas
 */
@Stateless
public class Servicio implements ServicioLocal {

    @PersistenceContext(unitName = "EjemploJPA2019PU")
    private EntityManager em;

    @Override
    public void insertar(Object o) {
        em.persist(o);
    }

    @Override
    public void sincronizar(Object o) {
        em.merge(o);
        em.flush();
    }

    @Override
    public Categoria buscarCategoria(int codigo) {
        return em.find(Categoria.class, codigo);
    }

    @Override
    public void editarCategoria(int codigo, int estado) {
        Categoria cat = buscarCategoria(codigo);
        cat.setEstado(estado);
        em.merge(cat);
        em.flush();
        em.refresh(cat);
    }

    @Override
    public List<Categoria> getCategorias() {
        return em.createQuery("select c from Categoria c").getResultList();
    }

    @Override
    public Usuario buscarUsuario(String rut) {
        return em.find(Usuario.class, rut);
                
    }

    @Override
    public void editarUsuario(String rut, String clave) {
        Usuario user = buscarUsuario(rut);
        user.setClave(clave);
        em.merge(user);
        em.flush();
        em.refresh(user);
    }

    @Override
    public List<Usuario> getUsuarios() {
        return em.createQuery("select u from Usuario u").getResultList();
    }

    @Override
    public Producto buscarProducto(int codigo) {
       return em.find(Producto.class, codigo);
    }

    @Override
    public void editarProducto(int codigo, int precio, int stock, int estado) {
        Producto p = buscarProducto(codigo);
        p.setPrecio(precio);
        p.setStock(stock);
        p.setEstado(estado);
        em.merge(p);
        em.flush();
        em.refresh(p);
        
    }
    @Override
    public List<Producto> getProductos() {
        return em.createQuery("select p from Producto p").getResultList();
    }

    @Override
    public Usuario iniciarSesion(String rut, String clave) {
        Usuario user = buscarUsuario(rut);
        
        return (user != null && user.getClave().equals(clave))?user:null;
    }

    @Override
    public void compra(String rut, ArrayList<String> lista) throws TransactionException {
        ArrayList<Detalle> dtList = new ArrayList<>();
        
        Usuario usr = this.buscarUsuario(rut);
        Venta nuevaVenta= new Venta();
        
        nuevaVenta.setRutcliente(usr);
        nuevaVenta.setEstado(1);
        nuevaVenta.setFecha(new Date());
        
        int codigo, unidad, suma=0;
        for (String s : lista) {
            String []x =s.split(",");
            codigo = Integer.parseInt(x[0]);
            unidad = Integer.parseInt(x[1]);
            
            Producto p = this.buscarProducto(codigo);
            
            if (p.getStock()< unidad) {
                throw new TransactionException();
            }
            
            p.setStock(p.getStock()-unidad);
            em.merge(p);
            
            Detalle dt = new Detalle();
            dt.setCodigoproducto(p);
            dt.setCodigoventa(nuevaVenta);
            dt.setEstado(1);
            dt.setPrecio(p.getPrecio());
            dt.setStock(unidad);
            
            dtList.add(dt);
            
            suma =+ p.getPrecio()*unidad;
            
        }
        
        nuevaVenta.setTotal(suma);
        em.persist(nuevaVenta);
        //asociar la venta con cada detalle
        nuevaVenta.setDetalleList(dtList);
        em.merge(nuevaVenta);
        //asociar el usuario con cada venta
        usr.getVentaList().add(nuevaVenta);
        em.merge(usr);
        //sincronizar
        em.flush();
        
        
    }

    
    
    
}

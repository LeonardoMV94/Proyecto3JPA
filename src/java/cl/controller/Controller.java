package cl.controller;

import cl.model.ServicioLocal;
import java.io.IOException;
import java.io.PrintWriter;
import cl.entities.*;
import cl.model.TransactionException;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.mail.Session;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Leonardo
 */
@WebServlet(name = "Controller", urlPatterns = {"/control.do"})
public class Controller extends HttpServlet {

    @EJB
    private ServicioLocal servicio;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bt = request.getParameter("bt");
        switch (bt) {
            case "addcat":
                addcat(request, response);
                break;
            case "editcat":
                editcat(request, response);
                break;
            case "adduser":
                this.adduser(request, response);
                break;
            case "addprod":
                this.addprod(request, response);
                break;
            case "editprodes":
                this.editarEstadoProducto(request, response);
                break;
            case "iniciar":
                this.iniciarSesion(request, response);
                break;
            case "addcar":
                this.addcar(request, response);
                break;

            //DETALLECARRO.JSP   
            //boton comprar
            case "compra":
                this.compra(request, response);
                break;
            //boton eliminar del carro
            case "deletecar":
                //crear metodo
                this.eliminarProductoCarro(request, response);
                break;
            //CLIENTECAMBIACLAVE.JSP
            //BOTON CAMBIO DE CLAVE
            case "cambiarclave":
                //crear metodo para cambio de clave
                this.cambiarClaveCliente(request, response);
                break;

            case "updtprod":
                this.editarProducto(request, response);
                break;

        }

    }

    protected void eliminarProductoCarro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String codigo = request.getParameter("codigo");
        Producto prod = servicio.buscarProducto(Integer.parseInt(codigo));

        ArrayList<Producto> carro = (ArrayList) request.getSession().getAttribute("carro");

        carro.remove(prod);

        request.getSession().setAttribute("carro", carro);
        response.sendRedirect("detallecarro.jsp");
    }

    protected void addcar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String codigo = request.getParameter("codigo");
        Producto p = servicio.buscarProducto(Integer.parseInt(codigo));

        ArrayList<Producto> carro = (ArrayList) request.getSession().getAttribute("carro");

        if (carro == null) {
            carro = new ArrayList<>();
        }

        if (!carro.contains(p)) {
            carro.add(p);
            request.getSession().setAttribute("carro", carro);
        }

        response.sendRedirect("venta.jsp");

    }

    protected void cambiarClaveCliente(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String clave = request.getParameter("claveanterior");
        String clavenueva = request.getParameter("clavenueva");
        String clavenueva2 = request.getParameter("clavenueva2");

        HttpSession misession = (HttpSession) request.getSession();
        Usuario cli = (Usuario) misession.getAttribute("cliente");

        Usuario usr = (Usuario) servicio.buscarUsuario(cli.getRut());

        //validador de campos vacios
        if (clave.equals("") || clavenueva.equals("") || clavenueva2.equals("")) {
            request.setAttribute("msg", "debe ingresar datos en todos los campos");
            request.getRequestDispatcher("clientecambiaclave.jsp").forward(request, response);
        } else {
            //validador de igualdad en clave actual con la nueva segun input
            if (clave.equals(clavenueva)) {
                request.setAttribute("msg", "la nueva contraseña debe ser distinta a la actual");
                request.getRequestDispatcher("clientecambiaclave.jsp").forward(request, response);
            } else {
                //validador de coincidencia de clave nueva con la de repeticion
                if (clavenueva == null ? clavenueva2 != null : !clavenueva.equals(clavenueva2)) {
                    request.setAttribute("msg", "las nuevas contraseñas deben coincidir");
                    request.getRequestDispatcher("clientecambiaclave.jsp").forward(request, response);

                } else {
                    //validador de coincidencia de clave actual con la nueva segun la bd
                    if (usr.getRut() == null ? clave != null : !usr.getRut().equals(clave)) {
                        servicio.editarUsuario(cli.getRut(), Hash.md5(clavenueva));

                        request.setAttribute("msg", "Clave actualizada exitosamente" + "<i class=\"large material-icons\">check</i>");
                        request.getRequestDispatcher("clientecambiaclave.jsp").forward(request, response);
                    } else {
                        //mensaje de coincidencia encontrada 
                        request.setAttribute("msg", "la contraseña actual y la nueva no debe coincidir");
                        request.getRequestDispatcher("clientecambiaclave.jsp").forward(request, response);
                    }

                }

            }

        }

    }

    protected void iniciarSesion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String rut = request.getParameter("rut");
        String clave = request.getParameter("clave");

        Usuario user = servicio.iniciarSesion(rut, Hash.md5(clave));

        if (user != null) {

            if (user.getTipo().equals("cliente")) {
                request.getSession().setAttribute("cliente", user);
                response.sendRedirect("cliente.jsp");
            } else if (user.getTipo().equals("vendedor")) {
                request.getSession().setAttribute("vendedor", user);
                response.sendRedirect("vendedor.jsp");
            } else {
                request.getSession().setAttribute("admin", user);
                response.sendRedirect("admin.jsp");
            }
        } else {
            request.setAttribute("msg", "usuario o contraseña incorrecta");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }

    }

    protected void addprod(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombre = request.getParameter("nombre");
        String precio = request.getParameter("precio");
        String stock = request.getParameter("stock");
        String codcat = request.getParameter("codcat");

        Categoria cat = servicio.buscarCategoria(Integer.parseInt(codcat));

        Producto newprod = new Producto();
        newprod.setNombre(nombre);
        newprod.setPrecio(Integer.parseInt(precio));
        newprod.setStock(Integer.parseInt(stock));
        newprod.setEstado(1);
        newprod.setCodigocategoria(cat);
        servicio.insertar(newprod);

        cat.getProductoList().add(newprod);
        servicio.sincronizar(cat);

        response.sendRedirect("producto.jsp");

    }

    protected void editarEstadoProducto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cod = request.getParameter("codigo");
        String est = request.getParameter("estado");
        String pre = request.getParameter("precio");

        int codigo = Integer.parseInt(cod);
        int estado = Integer.parseInt(est);
        int precio = Integer.parseInt(pre);

        servicio.editarProducto(codigo, precio, 0, estado);
        
        request.setAttribute("msg", "Se modificó el estado del producto exitosamente!");
        response.sendRedirect("producto.jsp");

    }

    protected void adduser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String rut = request.getParameter("rut");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String email = request.getParameter("email");
        String clave = request.getParameter("clave");
        String tipo = request.getParameter("tipo");

        if (servicio.buscarUsuario(rut) == null) {
            Usuario newUser = new Usuario();
            newUser.setRut(rut);
            newUser.setNombre(nombre);
            newUser.setApellido(apellido);
            newUser.setEmail(email);
            newUser.setTipo(tipo);
            newUser.setClave(Hash.md5(clave));
            servicio.insertar(newUser);
            response.sendRedirect("usuario.jsp");
        } else {
            request.setAttribute("msg", "Rut ya ingresado");
            request.getRequestDispatcher("usuario.jsp").forward(request, response);
        }

    }

    protected void addcat(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombre = request.getParameter("nombre");
        String desc = request.getParameter("desc");

        Categoria newCat = new Categoria();
        newCat.setNombre(nombre);
        newCat.setDescripcion(desc);
        newCat.setEstado(1);

        servicio.insertar(newCat);

        response.sendRedirect("categoria.jsp");

    }

    protected void editcat(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cod = request.getParameter("codigo");
        String est = request.getParameter("estado");

        int codigo = Integer.parseInt(cod);
        int estado = Integer.parseInt(est);

        servicio.editarCategoria(codigo, estado);

        response.sendRedirect("categoria.jsp");

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void compra(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String rut = request.getParameter("rut");

        Usuario usr = servicio.buscarUsuario(rut);
        ArrayList<Producto> carro = (ArrayList) request.getSession().getAttribute("carro");
        
        if (carro.isEmpty()==false) {
            
        if (usr != null && usr.getTipo().equals("cliente")) {

            ArrayList<String> datos = new ArrayList<>();
            for (Producto producto : carro) {
                String unidad = request.getParameter("unidades" + producto.getCodigoproducto());

                datos.add(producto.getCodigoproducto() + "," + unidad);
            }

            try {
                servicio.compra(rut, datos);

                request.setAttribute("msg", "Compra realizada con exito! ");
                //limpiar el carrito
                carro.clear();
                request.getRequestDispatcher("detallecarro.jsp").forward(request, response);
            } catch (TransactionException ex) {
                request.setAttribute("msg", "Error de Stock al realizar la compra, Verifique stock");
                //actualizar carro
                this.sincronizarSesionCarro(request, response);
                request.getRequestDispatcher("detallecarro.jsp").forward(request, response);
            }

        } else {

            request.setAttribute("msg", "no se encuentra usuario con rut [" + rut + "] en el sistema");
            request.getRequestDispatcher("detallecarro.jsp").forward(request, response);
        }
        }else{
            request.setAttribute("msg", "no hay productos en el carro!");
            request.getRequestDispatcher("detallecarro.jsp").forward(request, response);
            
        }
        

    }

    protected void sincronizarSesionCarro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<Producto> carro = (ArrayList<Producto>) request.getSession().getAttribute("carro");
        ArrayList<Producto> carro2 = new ArrayList();

        //recorre la lista de productos de la sesion y la actualiza con la de la BD
        for (Producto p : carro) {
            Producto pp = servicio.buscarProducto(p.getCodigoproducto());
            carro2.add(pp);
        }
        request.getSession().setAttribute("carro", carro2);

    }

    protected void editarProducto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        
        String nombre = request.getParameter("nombre");
        int codigo = Integer.parseInt(request.getParameter("cod"));
        int precio = Integer.parseInt(request.getParameter("precio"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        
        Producto p = servicio.buscarProducto(codigo);
        
        int codBd = p.getCodigoproducto();
        
        if (codBd >0 && nombre != null && precio > 0 && stock >= 1) {
            
                servicio.editarProducto2(codigo, nombre, precio, stock, 1);
                request.setAttribute("msg", "Producto se actualizó exitosamente!");
                request.getRequestDispatcher("producto.jsp").forward(request, response);
            

        } else {

            request.setAttribute("msg", "problema al actualizar producto");
            request.getRequestDispatcher("producto.jsp").forward(request, response);

        }

    }

}

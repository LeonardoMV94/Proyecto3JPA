<%-- 
    Document   : listarventa
    Created on : 25-06-2019, 3:23:15
    Author     : Leonardo
--%>

<%@page import="cl.entities.Venta"%>
<%@page import="java.util.List"%>
<%@page import="cl.entities.Categoria"%>
<%@page import="cl.entities.Producto"%>
<%@page import="cl.model.ServicioLocal"%>
<%@page import="javax.naming.InitialContext"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! ServicioLocal servicio;%>
<%
    InitialContext ctx = new InitialContext();
    servicio = (ServicioLocal) ctx.lookup("java:global/EjemploJPA2019/Servicio!cl.model.ServicioLocal");
    List<Venta> listav = servicio.getVentas();
    List<Producto> listap = servicio.getProductos();
    
%>


<!DOCTYPE html>
<html>
    <head>
        <!--Import Google Icon Font-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>

        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    </head>

    <body class>

        <c:if test="${not empty vendedor}">
            <c:import url="menu.jsp"/>
            <div class="row valign-wrapper">
                <div class="col s6 offset-s3">
                    <div class="row">
                        <div class="input-field">
                            <div class ="card-panel">
                               
                                <form action="control.do" method="POST">
                                    <div class="input-field">
                                        <input id="rut" type="text" name="rut">
                                        <label for="rut">Buscar Cliente</label>
                                    </div>      
                                    <div class="card-action right-align">
                                    <button class="btn " name="bt" value="buscarcliente" type="submit">
                                        Buscar
                                    </button>
                                    </div>
                                </form>
                            </div>
                            
                            Nombre cliente:
                            
                            <div class="card-panel"> 
                                
                                <u><b>Fecha de venta:</b></u>
                                <table class="bordered">
                                  
                                    <tbody>

                                        <tr>
                                            <th>Producto</th>
                                            <th>Unidad</th>
                                            <th>Precio</th>
                                            <th>Total</th>
                                        </tr>

                                    </tbody>
                                </table>
                                <h5 class="right-align"> <b>Total:</b></h5>
                            </div>



                        </div>
                    </div>
              
            </div>










        </c:if>
        <c:if test="${empty vendedor}">
            <div class="row valign-wrapper">
                <div class="col s6 offset-s3">
                    <div class="card-panel">

                        <h1>Acceso Denegado</h1>
                        <br> <img src="http://www.doingresearchinclusively.org/wp-content/uploads/2012/06/stop-300x300.png" alt="Descripción de la imagen">
                        <br> <h5>No eres vendedor! <br> Seras redireccionado en <span id="countdowntimer">5</span> segundos </h5>

                        <script type="text/javascript">
                            var timeleft = 5;
                            var downloadTimer = setInterval(function () {
                                timeleft--;
                                document.getElementById("countdowntimer").textContent = timeleft;
                                if (timeleft <= 0)
                                    clearInterval(downloadTimer);
                            }, 1000);
                        </script>

                        <meta http-equiv="refresh" content="5;url=index.jsp">
                    </div>
                </div>
            </div>
        </c:if>






        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script type="text/javascript" src="js/materialize.min.js"></script>
    </body>
</html>
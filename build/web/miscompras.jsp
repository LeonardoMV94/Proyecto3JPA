<%-- 
    Document   : miscompras
    Created on : 25-06-2019, 0:38:38
    Author     : Leonardo
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="cl.entities.*"%>
<%@page import="java.util.List"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="cl.model.ServicioLocal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! ServicioLocal servicio;%>
<%
    // InitialContext ctx = new InitialContext();
    // servicio = (ServicioLocal) ctx.lookup("java:global/EjemploJPA2019/Servicio!cl.model.ServicioLocal");
    //buscar ventas y almacenarlas en un ArrayList
    // List<Venta> lista = servicio.getVentas();


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

    <body>

        <c:if test="${not empty cliente}">
            <c:import url="menu.jsp"/>

            <h5>Detalle de Compra</h5>

            <ul class="collapsible" data-collapsible="accordion">
                <li>
                    <div class="collapsible-header"><i class="material-icons">shopping_basket</i>
                        Fecha:
                    </div>
                    
                    <div class="collapsible-body">
                        <span>
                          
                     Lorem ipsum dolor sit amet.
                        
                     </span>
                    </div>
                </li>
                
            </ul>


        </c:if>
        <c:if test="${empty cliente}">
            <div class="row valign-wrapper">
                <div class="col s6 offset-s3">
                    <div class="card-panel center-align">

                        <h1>Acceso Denegado</h1>
                        <br> <img src="http://www.doingresearchinclusively.org/wp-content/uploads/2012/06/stop-300x300.png" alt="Descripción de la imagen">
                        <br> <h5>No eres cliente! <br> Seras redireccionado en <span id="countdowntimer">5</span> segundos </h5>

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

        $(document).ready(function(){
        $('.collapsible').collapsible();
        });
    </body>
</html>
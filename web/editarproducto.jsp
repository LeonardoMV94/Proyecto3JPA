<%-- 
    Document   : editarproducto
    Created on : 22-06-2019, 22:42:32
    Author     : Leonardo
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

        <c:if test="${not empty admin}">
            <c:import url="menu.jsp"/>

            <%

                int codigo = Integer.parseInt(request.getParameter("codigo"));
                String nombre = request.getParameter("nombre");
                int precio = Integer.parseInt(request.getParameter("precio"));
                int stock = Integer.parseInt(request.getParameter("stock"));


            %>
            <div class="row">
                <div class="col s6 offset-s3">
                    <h3>Productos</h3>
                    <form action="control.do" method="POST">

                        <div class="input-field">
                            <input id="cod" type="text" name="cod" readonly="readonly"  value="<%=codigo%>">
                            <label for="cod">Codigo del producto</label>
                        </div>    
                        <div class="input-field">
                            <input id="nombre" type="text" name="nombre" value="<%=nombre%>">
                            <label for="nombre">Nombre</label>
                        </div>
                        <div class="input-field">
                            <input id="precio" type="text" name="precio" value="<%=precio%>">
                            <label for="precio">Precio</label>
                        </div>

                        <div class="input-field">
                            <input id="stock" type="text" name="stock" value="<%=stock%>">
                            <label for="stock">Stock</label>
                        </div>


                        <button class="btn right" name="bt" value="updtprod" type="submit">
                            Actualizar
                        </button>

                    </form>
                    ${msg}  
                </div>

            </div>


        </c:if>


        <c:if test="${empty admin}">
            <div class="row valign-wrapper">
                <div class="col s6 offset-s3">
                    <div class="card-panel center-align">

                        <h1>Acceso Denegado</h1>
                        <br> <img src="http://www.doingresearchinclusively.org/wp-content/uploads/2012/06/stop-300x300.png" alt="Descripción de la imagen">
                        <br> <h5>No eres administrador! <br> Seras redireccionado en <span id="countdowntimer">5</span> segundos </h5>

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

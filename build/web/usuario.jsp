<%--
    Document   : usuario
    Created on : 04-06-2019, 21:31:34
    Author     : sistemas
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="cl.entities.*"%>
<%@page import="java.util.List"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="cl.model.ServicioLocal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! ServicioLocal servicio;%>
<%
    InitialContext ctx = new InitialContext();
    servicio = (ServicioLocal) ctx.lookup("java:global/EjemploJPA2019/Servicio!cl.model.ServicioLocal");
    List<Usuario> lista = servicio.getUsuarios();
%>

<c:set scope="page" var="lista" value="<%=lista%>"/>
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

            <div class="row">
                <div class="col s6">
                    <h3>Usuarios</h3>
                    <form action="control.do" method="POST">

                        <div class="input-field">
                            <input id="rut" type="text" name="rut">
                            <label for="rut">Rut</label>
                        </div>
                        <div class="input-field">
                            <input id="nombre" type="text" name="nombre">
                            <label for="nombre">Nombre</label>
                        </div>

                        <div class="input-field">
                            <input id="apellido" type="text" name="apellido">
                            <label for="apellido">Apellido</label>
                        </div>

                        <div class="input-field">
                            <input id="email" type="email" name="email">
                            <label for="email">Email</label>
                        </div>

                        <div class="input-field">
                            <input id="clave" type="password" name="clave">
                            <label for="clave">Clave</label>
                        </div>
                        <div class="input-field">
                            <select name="tipo">
                                <option >vendedor</option>
                                <option >cliente</option>
                                <option value="admin">administrador</option>
                            </select>
                            <label>Tipo de Usuario</label>
                        </div>
                        <button class="btn" name="bt" value="adduser" type="submit">
                            Guardar
                        </button>

                    </form>
                    <br><br>
                    ${msg}
                    <br><br>
                    <table class="bordered">
                        <tr>
                            <th>RUT</th>
                            <th>NOMBRE</th>
                            <th>APELLIDO</th>
                            <th>EMAIL</th>
                            <th>CLAVE</th>
                            <th>TIPO</th>

                        </tr>

                        <c:forEach items="${lista}" var="u">
                            <tr>
                                <td>${u.rut}</td>
                                <td>${u.nombre}</td>
                                <td>${u.apellido}</td>
                                <td>${u.email}</td>
                                <td>${u.clave}</td>
                                <td>${u.tipo}</td>

                            </tr>
                        </c:forEach>
                    </table>
                    <br>
                    

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
        <script type="text/javascript" >
            $(document).ready(function () {
                $('select').material_select();
            });
        </script>
    </body>
</html>

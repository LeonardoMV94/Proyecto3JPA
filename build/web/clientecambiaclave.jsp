<%-- 
    Document   : clientecambiaclave
    Created on : 22-06-2019, 17:59:45
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

        <c:if test="${not empty cliente}">
            <c:import url="menu.jsp"/>
        </c:if>
        <c:if test="${empty cliente}">
            <div class="row valign-wrapper">
                <div class="col s6 offset-s3">
                    <div class="card-panel center-align">

                        <h1>Acceso Denegado</h1>
                        <br> <img src="http://www.doingresearchinclusively.org/wp-content/uploads/2012/06/stop-300x300.png" alt="Descripción de la imagen">
                        <br> <h5>No eres Cliente! <br> Seras redireccionado en <span id="countdowntimer">5</span> segundos </h5>

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


        <div class="row valign-wrapper">
            <div class="col s6 offset-s3">
                <div class="card-panel">
                    <h4>Cambiar Clave</h4>
                   
                    <br>
                    <form action="control.do" method="POST">
                       <div class="input-field">
                            <input id="claveanterior" type="password" name="claveanterior">
                            <label for="claveanterior">Contraseña anterior</label>

                        <div class="input-field">
                            <input id="clavenueva" type="password" name="clavenueva">
                            <label for="clavenueva">Nueva contraseña</label>
                        </div>
                        <div class="input-field">
                            <input id="clavenueva2" type="password" name="clavenueva2">
                            <label for="clavenueva2">Reingrese nueva contraseña</label>
                        </div>
                        
                        <button class="btn" name="bt" value="cambiarclave" type="submit">
                            Actualizar
                        </button>
                    </form>
                    
                    <br>
                    ${msg}
                </div>
            </div>
        </div>



        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script type="text/javascript" src="js/materialize.min.js"></script>
    </body>
</html>

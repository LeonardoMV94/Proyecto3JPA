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
            Error no eres cliente, seras redireccionado en 5 segundos
            <meta http-equiv="refresh" content="5;url=index.jsp">
        </c:if>


        <div class="row valign-wrapper">
            <div class="col s6 offset-s3">
                <div class="card-panel">
                    <h4>Cambiar Clave</h4>
                    <form action="control.do" method="POST">
                       <div class="input-field">
                            <input id="clave" type="password" name="clave-anterior">
                            <label for="clave">Contraseña anterior</label>

                        <div class="input-field">
                            <input id="clave" type="password" name="clave1">
                            <label for="clave">Nueva contraseña</label>
                        </div>
                        <div class="input-field">
                            <input id="clave" type="password" name="clave2">
                            <label for="clave">Reingrese nueva contraseña</label>
                        </div>
                        
                        <button class="btn" name="bt" value="cambiarclave" type="submit">
                            Actualizar
                        </button>
                    </form>
                    ${msg}
                </div>
            </div>
        </div>



        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script type="text/javascript" src="js/materialize.min.js"></script>
    </body>
</html>

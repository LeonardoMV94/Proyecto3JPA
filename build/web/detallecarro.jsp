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
            <div class="container">
                <div class="row valign-wrapper">
                    <div class="col s6 offset-s3 valign">
                        <div class="card-panel">
                            <form action="control.do" method="post">
                                <h5>Detalle de Compra</h5>
                                <button class="btn-floating right pulse" type="submit" name="bt" value="compra">
                                    <i class="material-icons">shopping_cart</i>
                                </button>
                                <input type="text" name="rut" placeholder="Rut de Cliente"/>
                                <br>
                                <table class="bordered">
                                    <tr>
                                        <td>NOMBRE</td>
                                        <td>PRECIO</td>
                                        <td>UNIDADES</td>
                                        <td></td>
                                    </tr>
                                    <c:forEach items="${carro}" var="p">
                                        <tr>
                                            <td>${p.nombre}</td>
                                            <td>${p.precio}</td>
                                            <td class="col s3">
                                                <select name="unidades${p.codigoproducto}">
                                                    <c:forEach begin="1" end="${p.stock}" var="i">
                                                        <option>${i}</option>
                                                    </c:forEach>

                                                </select>
                                            </td>
                                            <td>
                                                <a href="control.do?bt=deletecar&codigo=${p.codigoproducto}"
                                                   class="btn-floating red">
                                                    <i class="material-icons">delete</i>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>


                                </table>
                                <br>
                                ${msg}
                            </form>

                        </div>
                    </div>
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

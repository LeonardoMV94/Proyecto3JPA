
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="blue darken-3">
    <div class="nav-wrapper">
        <a href="#" class="brand-logo">
            <c:if test ="${not empty admin}">
                Hola ${admin.nombre} ${admin.apellido}
            </c:if>
            <c:if test ="${not empty vendedor}">
                Hola ${vendedor.nombre} ${vendedor.apellido}
            </c:if>
            <c:if test ="${not empty cliente}">
                Hola ${cliente.nombre} ${cliente.apellido}
            </c:if>

        </a>
        <ul id="nav-mobile" class="right hide-on-med-and-down">
            <c:if test ="${not empty admin}">
                <li><a href="producto.jsp">Gestion de productos</a></li>
                <li><a href="usuario.jsp">Crear usuarios</a></li>
                <li><a href="categoria.jsp">Gestion de categorías</a></li>
                <li><a href="venta.jsp">Gestion de ventas</a></li>
                    
               
                <c:if test="${carro.size() > 0}">
                    <li><a href="detallecarro.jsp"><i class="small material-icons left">shopping_cart</i>(${carro.size()})</a></li> 
                    </c:if>
                
                
                
                
                <li><a href="salir.jsp"><i class="small material-icons">exit_to_app</i></a></li>
            </c:if>
            <c:if test ="${not empty vendedor}">
                <li><a href="venta.jsp">Venta</a></li>
                <li><a href="salir.jsp"><i class="small material-icons">exit_to_app</i></a></li>
                
            </c:if>
            <c:if test ="${not empty cliente}">
                
                <li><a href="clientecambiaclave.jsp">Cambiar Clave</a></li>
                <li><a href="miscompras.jsp">Mis Compras</a></li>
                <li><a href="salir.jsp"><i class="small material-icons">exit_to_app</i></a></li>
                
            </c:if>
        </ul>
    </div>
</nav>
package cl.entities;

import cl.entities.Detalle;
import cl.entities.Usuario;
import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2019-06-18T20:56:55")
@StaticMetamodel(Venta.class)
public class Venta_ { 

    public static volatile SingularAttribute<Venta, Date> fecha;
    public static volatile SingularAttribute<Venta, Integer> total;
    public static volatile SingularAttribute<Venta, Integer> estado;
    public static volatile ListAttribute<Venta, Detalle> detalleList;
    public static volatile SingularAttribute<Venta, Usuario> rutcliente;
    public static volatile SingularAttribute<Venta, Integer> codigoventa;

}
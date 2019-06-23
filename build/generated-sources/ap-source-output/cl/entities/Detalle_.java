package cl.entities;

import cl.entities.Producto;
import cl.entities.Venta;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2019-06-18T20:56:55")
@StaticMetamodel(Detalle.class)
public class Detalle_ { 

    public static volatile SingularAttribute<Detalle, Integer> precio;
    public static volatile SingularAttribute<Detalle, Integer> estado;
    public static volatile SingularAttribute<Detalle, Producto> codigoproducto;
    public static volatile SingularAttribute<Detalle, Integer> codigodetalle;
    public static volatile SingularAttribute<Detalle, Venta> codigoventa;
    public static volatile SingularAttribute<Detalle, Integer> stock;

}
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cl.model;

import javax.ejb.ApplicationException;

/**
 *
 * @author Leonardo
 */
@ApplicationException(rollback = true)
public class Transacciones extends Exception {

    public Transacciones() {
        super();
    }
    
    
    
    
    
    
}

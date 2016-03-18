/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.Util;

/**
 *
 * @author Beckpalmx No7palmx
 */
public class Decimal_Place {
    
    public static float Round(Double Rval, int Rpl) {

        float p = (float) Math.pow(10, Rpl);
        //JOptionPane.showConfirmDialog(null, p);
        System.out.println("P = " + p);
        Rval = Rval * p;
        //JOptionPane.showConfirmDialog(null, Rval);
        System.out.println("Rval = " + Rval + " Replace = " + Rpl);
        float tmp = Math.round(Rval);
        //JOptionPane.showConfirmDialog(null, tmp);
        System.out.println("tmp = " + tmp);
        System.out.println("tmp/p = " + tmp / p);
        return (float) tmp / p;

    }    
    
}

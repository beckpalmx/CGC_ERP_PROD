package com.cgc.Util;

import java.io.UnsupportedEncodingException;

public class String_Util {

    /*
     public static void main(String[] args) {
     String str = "GD13-1";
     int strlong = str.length() - 1;
     System.out.println("strlong = " + strlong);

     System.out.println("str = " + str.substring(strlong));

     }
     */
    public String SubLastString(String strinput, int pos) throws UnsupportedEncodingException {
        int strlong = strinput.length() - pos;
        return strinput.substring(strlong);
    }

}

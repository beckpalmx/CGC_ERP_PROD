/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 *
 * @author beckpalmx
 */
public class db_server_test2 {

    public static void main(String[] args) {

        Properties prop = new Properties();
        InputStream input = null;

        try {

            input = new FileInputStream("config.properties");

            // load a properties file
            prop.load(input);

            // get the property value and print it out
            System.out.println(prop.getProperty("db_postgres_server"));
            System.out.println(prop.getProperty("db_postgres_username"));
            System.out.println(prop.getProperty("db_postgres_password"));

        } catch (IOException ex) {
            ex.printStackTrace(System.out);
        } finally {
            if (input != null) {
                try {
                    input.close();
                } catch (IOException e) {
                    e.printStackTrace(System.out);
                }
            }
        }

    }

}

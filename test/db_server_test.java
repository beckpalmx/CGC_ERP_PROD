/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bw.DB;

import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Iterator;

import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.Properties;

/**
 *
 * @author beckpalmx
 */
public class db_server_test {


  public static void main(String[] args) {
 
	Properties prop = new Properties();
	OutputStream output = null;
 
	try {
 
		output = new FileOutputStream("config.properties");
 
		// set the properties value
		prop.setProperty("db_postgres_server", "localhost:5432/");
		prop.setProperty("db_postgres_username", "");
		prop.setProperty("db_postgres_password", "");
 
		// save properties to project root folder
                
		prop.store(output, null);
                
                System.out.println("output = " + output);                
 
	} catch (IOException io) {
		io.printStackTrace(System.out);
	} finally {
		if (output != null) {
			try {
				output.close();
			} catch (IOException e) {
				e.printStackTrace(System.out);
			}
		}
 
	}
  }

}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.Util;

import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Iterator;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 *
 * @author beckpalmx
 */
public class db_server {

    public static void readJson(String file) {
        JSONParser parser = new JSONParser();

        try {
            System.out.println("Reading JSON file from Java program");
            FileReader fileReader = new FileReader(file);
            JSONObject json = (JSONObject) parser.parse(fileReader);

            String server = (String) json.get("server");
            String user = (String) json.get("user");
            String password = (String) json.get("password");

            System.out.println("Server: " + server);
            System.out.println("User: " + user);
            System.out.println("Password: " + password);

            /*            
             JSONArray characters = (JSONArray) json.get("characters");
             Iterator i = characters.iterator();

             System.out.println("characters: ");
             while (i.hasNext()) {
             System.out.println(" " + i.next());
             }
             */
        } catch (Exception ex) {
            ex.printStackTrace(System.out);
        }
    }

}

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
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ProgressDisplay
        extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Random r = new Random();
        try {
            int pval = Integer.parseInt(request.getParameter("pval"));

            float randomval = r.nextFloat();
            int seedval = (int) (10.0F * randomval);
            out.print(pval + seedval);
        } finally {
            out.close();
        }
    }
}

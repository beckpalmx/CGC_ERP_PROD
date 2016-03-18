/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.report;

import com.cgc.DB.DBConnect;
import java.lang.Exception;
import javax.servlet.ServletException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.HashMap;
import java.io.*;  
import javax.servlet.*;  
import javax.servlet.http.*;  

import net.sf.jasperreports.engine.JasperRunManager;

/**
 *
 * @author beckpalmx
 */

public class Print_Report_Class {
    

  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException
  {
    ServletOutputStream servletOutputStream = response.getOutputStream();
    //InputStream reportStream = getServletConfig().getServletContext()
    //    .getResourceAsStream("/reports/Simple_Report.jasper");

    //try
    {
     // JasperRunManager.runReportToPdfStream(reportStream, servletOutputStream,
         // new HashMap(), new JREmptyDataSource());

      response.setContentType("application/pdf");
      servletOutputStream.flush();
      servletOutputStream.close();
    }
    //catch (JRException e)
    {
      //handle the exception
    }
  }    
    
}

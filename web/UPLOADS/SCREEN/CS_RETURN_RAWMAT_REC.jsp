<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
    <head>
        <title>Question & Answer Page</title>
    </head>
    <body>

        <h2><center>Return Document คืนเอกสารการรับถ่านวัตถุดิบ</center></h2>
        <%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <%@ page import = "java.lang.*,java.io.*,java.util.*" %>
        <input type="hidden" name="doc_type" id="doc_type" value="<%=request.getParameter("doc_type")%>">
        <%

        // variables for connecting to the flat file data source
        // Note: this is set up to look in the same directory as the jsp file.
            String fileName = "data_rawmat_rec.txt";
            BufferedReader br = null;
            FileReader fr;

        //String inputPath = application.getRealPath("/") + File.separatorChar;
            String inputPath = "D:\\CGC_FILE\\";

            System.out.println("inputPath = " + inputPath);

            try {

        // open a bufferedreader to read the file
        // get the current path of the jsp under the application server.
        // 'application' is a freebie from the parent servlet.
                fr = new FileReader(new File(inputPath + fileName));
                br = new BufferedReader(fr);
                String line = br.readLine();

                while (line != null) {
                    out.println("update d_rawmatt_receive set complete_flag = 'N' where doc_id = '" + line + "' ;");
                    out.println("<BR>");
        %>
        <%
                    line = br.readLine();
                }

                br.close();

            } catch (Exception e) {

            }


        %>


    </body>
</html>

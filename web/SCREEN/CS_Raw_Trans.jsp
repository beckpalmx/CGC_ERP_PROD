<%-- 
    Document   : CS_Raw_Trans
    Created on : Feb 16, 2014, 10:24:56 AM
    Author     : Witsanu
--%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.Util.Serchselect" %>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.DB.DBConnect"%>
<%@page import="java.text.DecimalFormat" %>
<%@ page import="com.cgc.cDate.LastDate" %>

<!DOCTYPE html>
<html>
    <head>
        <style type="text/css">
            <!--
            .Table1 {
                width: inherit; /* table width */
                color: inherit; /* text color */
                font-family: MS Sans Serif; /* font name */
                /* 	font-size: small;font size */
                border: 0px outset; /* border */
                border-collapse: collapse;
                padding: 0px; /* cell padding */
                border: 1px solid; /* cell spacing */
                margin: auto ;  
            }
            .Table1 td {
                /* padding: 4px; cell padding */
                border: 1px solid; /* cell spacing */
                border-color: #CCCCCC;  /* table background color */
            }
            .Table2 {

                color: inherit; /* text color */
                font-family: MS Sans Serif; /* font name */
                /* 	font-size: small;font size */
                /*    border: 0px outset; border */
                border-collapse: collapse;
                padding: 0px; /* cell padding */
                border: 0px solid; /* cell spacing */

            }


            -->
        </style>
        <title>JSP Page</title>
    </head>
    <body>
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <input type="hidden" name="type_report" value="1">
            <input type="hidden" name="report_code" value="RP_024">
            <input type="hidden" name="price_year" value="2557">        

            
            <%

                Statement stm = null;
                Statement stmData = null;
                try {
                    // รับค่าจากฟอร์มเพื่อแปลงค่าไปมาระหว่าง ปี คศ. กับ ปี พศ.
                    int year_th = Integer.parseInt(request.getParameter("price_year"));
                    int year_en = year_th - 543;
                    int month = Integer.parseInt(request.getParameter("month_id"));
                    String wh_no = (request.getParameter("location_id"));

                    int x_sum = 0;
                    String x_location = "";
                    String x_product_id = "";
                    String x_location_id = "";
                    int x_bag = 0;
                    int x_carbon = 0;
                    int x_weight = 0;
                    int x_weight_friction = 0;

                    DecimalFormat dc = new DecimalFormat();
                    dc.applyPattern("###,###.##");
                    

                    String sql1, sql_where = "";
                    

                    // เชื่อมต่อฐานข้อมูล            
                    UtiDatabase objut = new UtiDatabase();
                    DBConnect db = new DBConnect();
                    Connection Conn = db.openNewConnection();
                    
                    String sqlDeleteSeq = "ALTER SEQUENCE seq_tmp_rawmatt_recive RESTART WITH 1";
                    stmData = Conn.createStatement();
                    stmData.execute(sqlDeleteSeq);                        

                    System.out.println("Conn First : " + Conn);
                    String sqlDelete = "DELETE FROM tmp_rawmatt_recive";
                    stmData = Conn.createStatement();
                    System.out.println("Conn 2 : " + Conn);
                    System.out.println("sqlDelete 2 : " + sqlDelete);
                    stmData.execute(sqlDelete);
            %>

            <tr>
                <td colspan='2' class='blankspace' align="right">                                              
                    <input type="button" name="myBut" value=" พิมพ์รายงาน  " onClick="javascript:document.report.submit();"/>
                    <input type=button value="ปิด" onClick="javascript:window.close();">
                </td>
            </tr>        
            <center>
                <h2>  
                    รายงานสรุป รับ / เบิกวัตถุดิบ  ประจำเดือน .......<%=month%>/<%=year_th%>........... <br>
                </h2>
            </center>
            <center>
                <!--h3>
                    สถานที่เก็บ/โรงสี <%=wh_no%>
                </h3-->
            </center>



            <table align='center"' class="Table1">
                <tr align="center">
                    <td width ="50">วันที่</td>
                    <td width="80">ชนิดถ่าน</td>
                    <td width="80">เลขกอง</td>
                    <td width="100">จำนวนกระสอบ</td>
                    <td width="100">นน.วัตถุดิบเข้า</td>
                    <td width="100">นน.เบิกเข้าสี</td>
                    <td width="100">นน.ถ่านสี</td>
                    <td width="150">วัตถุดิบคงเหลือสุทธิ</td>
                </tr>
                <%

                    LastDate SendDate = new LastDate();
                    int varLastDate = SendDate.LastDate(month, year_en);
                    int iCount = 0;

                    if (!wh_no.equals("") && !wh_no.equals(null) && !wh_no.equals("-")) {
                        sql_where = sql_where + " AND position_no = '" + wh_no + "' ";
                    }

                    System.out.println("SQL WHERE : " + sql_where);

                    for (iCount = 1; iCount <= varLastDate; iCount++) {
                        sql1 = "SELECT * FROM vd_rawmatt_receive_group_month "
                                + " WHERE to_date(format_date(doc_date),'YYYY-MM-DD') = '"
                                + year_en + "-" + month + "-" + iCount + "'"
                                + sql_where
                                + " ORDER BY doc_date,wh_in,position_no";
                        stm = Conn.createStatement();
                        ResultSet rec = stm.executeQuery(sql1);
                        System.out.println(sql1);

                %>
                <tr>
                    <td align="center"><%=iCount%></td>  
                    <td colspan="7">
                        <%
                            String SqlInsert = "INSERT INTO tmp_rawmatt_recive(date_no) VALUES ('" + iCount + "') ";
                            stmData = Conn.createStatement();
                            stmData.execute(SqlInsert);
                            System.out.println(SqlInsert);

                            while ((rec != null) && (rec.next())) {
                                x_location = rec.getString("position_no");
                                x_product_id = rec.getString("product_id");
                                x_bag = rec.getInt("sum_bag_total"); // น้ำหนักกระสอบ
                                x_carbon = rec.getInt("sum_carbon_net"); // น้ำหนักวัตถุดิบเข้า
                                x_weight = rec.getInt("sum_weight"); //น้ำหนักเบิกเข้าสี
                                x_weight_friction = rec.getInt("sum_weight_friction"); // น้ำหนักถ่านสี
                                // วัตถุดิบคงเหลือ = วัตถุดิบคงเหลือยกมา + น้ำหนักวัตถุดิบ - น้ำหนักถ่านสี
                                x_sum = x_sum + (x_carbon - x_weight_friction);
                        %>   
                        <table  class="Table1"  ><tr>
                                <td width="80"><%=x_product_id%></td>
                                <td width="80"><%=rec.getString("position_no")%></td>

                                <td width="100"align="right"><%=dc.format(x_bag)%></td>
                                <td width="100"align="right"><%=dc.format(x_carbon)%></td>
                                <td width="100"align="right"><%=dc.format(x_weight)%></td>
                                <td width="100"align="right"><%=dc.format(x_weight_friction)%></td>
                                <td width="150"align="right"><%=dc.format(x_sum)%></td>
                            </tr></table>
                            <%
                                // Insert data to tempolary table
                                String SqlUpdate;
        //******************************************************  ท่อนที่ต้องแก้ไข
                                SqlUpdate = " UPDATE tmp_rawmatt_recive SET  product_id  = '" + x_product_id + "' ,location_id ='" + rec.getString("position_no") + "' ,sum_bag =" + x_bag
                                        + ",sum_carbon_net = " + x_carbon + ", sum_weight =" + x_weight + ", sum_weight_friction =" + x_weight_friction
                                        + ",sum_total = " + x_sum + " WHERE date_no = '" + iCount + "' ";
                                System.out.println("Update" + SqlUpdate);
                                stmData = Conn.createStatement();
                                stmData.execute(SqlUpdate);
        // ย้านตัวตัดมา
                                if (rec.getString("position_no").equals(x_location_id) || x_location_id.equals("")) {
                                    x_location_id = rec.getString("position_no");
                                } else {
                                    x_sum = 0;
                                    x_location_id = "";
                                }
        //******************************************************  

                            %> 

                        <% } // end while %>    



                    </td>
                </tr>

                <% } // end for%>

            </table>     



            <%
                } catch (Exception e) {
                    // TODO Auto-generated catch block
                    out.println(e.getMessage());
                    e.printStackTrace();
                }


                try {
                    if (stm != null) {
                        stm.close();
                        //Conn.close();
                    }
                } catch (SQLException e) {
                    // TODO Auto-generated catch block
                    out.println(e.getMessage());
                    e.printStackTrace();
                }
            %>
        </form>
    </body>
</html>

<%-- 
    Document   : CS_dRawmatt_month
    Created on : Feb 18, 2014, 8:29:33 AM
    Author     : Witsanu Injabok
--%>
<%@page import="java.util.ArrayList"%>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">
        <title>Process ...</title><style type="text/css">

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
                font-size: small; 
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
    </head>
    <body>
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <input type="hidden" name="type_report" value="1">
            <input type="hidden" name="report_code" value="RP_024_1">
            <input type="hidden" name="price_year" value="">    

            <%

                // รับค่าจากฟอร์มเพื่อแปลงค่าไปมาระหว่าง ปี คศ. กับ ปี พศ.
                int year_th = Integer.parseInt(request.getParameter("price_year"));
                int year_en = year_th - 543;
                int month = Integer.parseInt(request.getParameter("month_id"));
                String month_id = request.getParameter("month_id");
                System.out.println("year_th = " + year_th);
                System.out.println("month = " + month);
                String wh_no = (request.getParameter("location_id"));
                System.out.println("wh_no = " + wh_no);

                String sql_where_1 = "";

                if (!wh_no.equals("") && !wh_no.equals(null) && !wh_no.equals("-")) {
                    sql_where_1 = " WHERE location_id = '" + wh_no + "' ";
                }

                // เอาไว้ทดสอบ
                //wh_no = "GD1";
                //year_th = 2557;
                //month = 1;
                int shortYear; // ไว้ตัดเอาตัวย่อของปี ไปหา Location ที่ลงท้ายด้วยปีนั้น ๆ 
                shortYear = year_th - 2500;
                int iCount = 0; // ไว้นับจำนวน
                Double tmpRaw = 0.0; // ไว้เป็นค่าพักของวัตถุดิบคงเหลือ

                Statement stm = null;
                Statement stmData = null;

                DecimalFormat dc = new DecimalFormat();
                dc.applyPattern("###,###.##");
                DecimalFormat dcMonth = new DecimalFormat();
                dcMonth.applyPattern("00");

                String sql, sql1, sql2, sql_where = "";
                // เชื่อมต่อฐานข้อมูล            
                UtiDatabase objut = new UtiDatabase();
                DBConnect db = new DBConnect();
                Connection Conn = db.openNewConnection();

                String product = "";

                String product2 = "";

                String sqlDelete = "TRUNCATE TABLE tmp_rawmatt_recive";
                stmData = Conn.createStatement();
                stmData.execute(sqlDelete);
                // หาจำนวนกองในปีนั้น ๆ เก็บใส่ Array          
                ArrayList arrLocation = new ArrayList();

                //sql = "SELECT * FROM mlocation WHERE location_id LIKE '%/" + shortYear + "'";
                sql = "SELECT * FROM mlocation " + sql_where_1;

                System.out.println(sql);
                stm = Conn.createStatement();
                ResultSet rec = stm.executeQuery(sql);
                iCount = 1;
                while ((rec != null) && (rec.next())) {
                    arrLocation.add(rec.getString("location_id"));
                } // end while for loop  
            %>       

            <tr>
                <td colspan='2' class='blankspace' align="left">                                              
                    <!--input type="button" name="myBut" value=" พิมพ์รายงาน  " onClick="javascript:document.report.submit();"/>
                    <input type=button value="ปิด" onClick="javascript:window.close();"-->
                    <a href="#" onClick="javascript:document.report.submit();" class="cgcButton">พิมพ์รายงาน</a>
                    <a href="#" onClick="javascript:window.close();" class="cgcButton">ปิด</a>
                </td>
            </tr>               

            <!--table  class="Table1"> 
                 
                <tr>
            <!--
            <td>วันที่</td>
            -->
            <!--/tr>
            <%
                for (int m = 1; m <= 12; m++) {

                    LastDate SendDate = new LastDate();
                    int varLastDate = SendDate.LastDate(month, year_en);
                    for (int i = 1; i <= varLastDate; i++) {
            %>
            <tr>
                <td valign="top">
            <!--    <%=dcMonth.format(i)%> -->
        </td> 
        <%


        %>  
        <!--       
               <td>
                   <table border ="0">
                       <td>เลขกอง </td>
                       <td>ชนิดถ่าน </td>
                       <td>จำนวนกระสอบ </td>
                       <td>จำนวนวัตถุดิบเข้า </td>
                       <td>เบิกเข้าสี </td>
                       <td>ถ่านสี </td>
                       <td>วัตถุดิบคงเหลือ</td>
        -->
        <% for (int j = 0; j < arrLocation.size(); j++) {%>
        <tr>         
            <td width="100"> <!-- เลขกอง  -->                               
                <!--    <%=arrLocation.get(j)%> -->
            </td>
            <%
                //Double.parseDouble
                String sum_bag = "0";
                String sum_carbon_net = "0";
                String sum_weight = "0";
                String sum_friction = "0";
                //sql_where = " WHERE doc_date = '" + dcMonth.format(i) + "-" + dcMonth.format(month) + "-" + year_th + "'";
                sql_where = " WHERE doc_date = '" + dcMonth.format(i) + "-" + dcMonth.format(m) + "-" + year_th + "'";

                // หาจำนวนกระสอบ / น้ำหนักวัตถุดิบเข้าจากตาราง d_rawmatt_recive
                // เงื่อนไข doc_date, position_no[array], wh_in[form]
                sql = " SELECT position_no,doc_date, product_id, "
                        + " sum(to_number(bag_total::TEXT,'999999.99'::TEXT)) as Sum_Bag_Total, "
                        + " sum(to_number(carbon_net::TEXT,'999999.99'::TEXT))  as Sum_Carbon_Net "
                        + " FROM d_rawmatt_receive "
                        + sql_where
                        + " AND position_no = '" + arrLocation.get(j) + "' "
                        + " AND delete_flag <> 'Y' "
                        + " GROUP BY  doc_date, position_no, product_id"
                        + " ORDER BY  doc_date, position_no,product_id";
                //System.out.println(sql);
                stm = Conn.createStatement();
                ResultSet rec2 = stm.executeQuery(sql);
                while ((rec2 != null) && (rec2.next())) {
                    sum_bag = (rec2.getString("sum_bag_total"));
                    sum_carbon_net = (rec2.getString("sum_carbon_net"));
                    product = rec2.getString("product_id");
                }
            %>
            <!--    
                <td><%=product%></td>
                <td  align="right" width="100"><%=sum_bag%></td>
                <td  align="right" width="100"><%=sum_carbon_net%></td> -->

            <%
                sql = "SELECT SUM(to_number(weight::TEXT,'999999.99'::TEXT)) as sum_weight "
                        + "  FROM vd_rawmatt_withdraw_detail"
                        + sql_where
                        + " AND location_id = '" + arrLocation.get(j) + "' "
                        + " GROUP BY  doc_date, location_id, product_id"
                        + " ORDER BY  doc_date, location_id,product_id";
                stm = Conn.createStatement();
                ResultSet rec3 = stm.executeQuery(sql);
                while ((rec3 != null) && (rec3.next())) {
                    sum_weight = (rec3.getString("sum_weight"));
                }
            %>                                                                                 
            <!-- น้ำหนักเบิกเข้าสี -->
            <td align="right" width="100"><!--<%=sum_weight%> --></td>
            <!-- น้ำหนักถ่านสี -->
            <%
                sql = "SELECT doc_date,product_id,SUM(to_number(laps_total::TEXT,'999999.99'::TEXT)) as sum_friction "
                        + "  FROM vd_carbon_friction_withdraw_detail "
                        + sql_where
                        + " AND location_id = '" + arrLocation.get(j) + "' "
                        + " GROUP BY  doc_date, location_id, product_id"
                        + " ORDER BY  doc_date, location_id,product_id";
                //System.out.println("SQL : " + sql);
                stm = Conn.createStatement();
                ResultSet rec4 = stm.executeQuery(sql);
                while ((rec4 != null) && (rec4.next())) {
                    sum_friction = (rec4.getString("sum_friction"));
                    product2 = rec4.getString("product_id");
                }
            %> 

            <td  align="right"  width="100"><!-- <%=sum_friction%> --></td>
            <!-- วัตถุดิบคงเหลือ -->
            <%
                //Double.parseDouble
                // วัตถุดิบคงเหลือ = วัตถุดิบคงเหลือยกมา + น้ำหนักวัตถุดิบ - น้ำหนักถ่านสี
                // tmpRaw  = tmpRaw +  Double.parseDouble(sum_carbon_net)  - Double.parseDouble(sum_friction) ;
                if ((sum_carbon_net) != "") {
                    tmpRaw += Double.parseDouble(sum_carbon_net) - Double.parseDouble(sum_friction);
                }
            %>                           
            <!--td  align="right" > 
            <%=dc.format(tmpRaw)%>
      </td-->
        </tr>
        <%
            System.out.println("product id = " + product + " : " + product2 + " | " + sum_carbon_net);
            String product_id_insert = "";
            if (!sum_carbon_net.equals("0")) {
                product_id_insert = product;
            } else {
                product_id_insert = product2;
            }
            System.out.println("product id = " + product + " : " + product2 + " | " + sum_carbon_net + " : " + product_id_insert);

            sql = "INSERT INTO tmp_rawmatt_recive(date_no,product_id,location_id,sum_carbon_net,sum_weight,sum_weight_friction,sum_total,sum_bag,month_id,year)"
                    + "  VALUES ( "
                    + " '" + dcMonth.format(i) + "'  , '" + product_id_insert + "'  ,'"
                    + arrLocation.get(j) + "',  " + sum_carbon_net + "," + sum_weight + "," + sum_friction
                    + ", " + tmpRaw + "," + sum_bag + ",'" + month_id + "'," + year_th + ")";
            //+ ", " + tmpRaw + "," + sum_bag + ",'" + month_id + "'," + year_th + ",'" + product2 + "')";
            System.out.println(sql);
            System.out.println("month = " + month_id);
            stmData = Conn.createStatement();
            stmData.execute(sql);
        %>.    
        <% } // end loop location %>            
    </table>
</td>
</td>
</tr>

<%
    // insert section          

%>          

<% }
    }// end for loop date %>         

<font color="red"><b>สร้างข้อมูล 100%</b></font>

</table>
</form>
</body>
</html>

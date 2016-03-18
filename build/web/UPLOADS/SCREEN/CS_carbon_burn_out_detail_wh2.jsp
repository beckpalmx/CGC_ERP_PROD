<%-- 
    Document   : CS_carbon_burn_out_detail_wh2
    Created on : Feb 19, 2014, 8:31:37 AM
    Author     : witsanu injabok
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.lang.String"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.Util.Serchselect" %>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.DB.DBConnect"%>
<%@page import="java.text.DecimalFormat" %>
<%@ page import="com.cgc.cDate.LastDate" %>
<%@ page import="java.lang.String" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%!  String sql, sql1, sql2, sql_where = "";
            String varMonth, varYear, varBurn = "";
            int varSize = 0;
            String varI2 = "";
            int varWeight = 0;


        %>
        <%
            // กำหนดค่าสำหรับทดสอบ
            varYear = "2556";


            Statement stm = null;
            Statement stmData = null;

            DecimalFormat dc = new DecimalFormat();
            dc.applyPattern("###,###.##");

            DecimalFormat cd2Digit = new DecimalFormat();
            cd2Digit.applyPattern("00");

            // เชื่อมต่อฐานข้อมูล            
            UtiDatabase objut = new UtiDatabase();
            DBConnect db = new DBConnect();
            Connection Conn = db.openNewConnection();

            ArrayList<String> v4_i = new ArrayList<String>();
            ArrayList<String> v4_size = new ArrayList<String>();
            ArrayList<String> v4_w = new ArrayList<String>();



            ArrayList v4x8_i = new ArrayList();
            ArrayList v4x8_size = new ArrayList();
            ArrayList v4x8_w = new ArrayList();

            ArrayList v8x3_i = new ArrayList();
            ArrayList v8x3_size = new ArrayList();
            ArrayList v8x3_w = new ArrayList();

            ArrayList v30_i = new ArrayList();
            ArrayList v30_size = new ArrayList();
            ArrayList v30_w = new ArrayList();

            ArrayList vdust_i = new ArrayList();
            ArrayList vdust_size = new ArrayList();
            ArrayList vdust_w = new ArrayList();

            ArrayList vBurn = new ArrayList();


            String v4I2, v4W = "";
            String v4x8I2, v4x8W = "";
            String v8x30I2, v8x30W = "";
            String v30I2, v30W = "";
            String vDustI2, vDustW, vRock = "";

            // Burn No
            // Month
            // Year

            for (int iMonth = 1; iMonth <= 12; iMonth++) {
                // สคริปหาจำนวนเตา ในแต่ละเดือน
                //select DISTINCT(burn_no) from vd_carbon_burn_out_detail_wh_complete_month 
                // where month = '01';
                sql2 = "SELECT DISTINCT(burn_no) FROM vd_carbon_burn_out_detail_wh_complete_month "
                        + " WHERE month = '" + cd2Digit.format(iMonth) + "' ";
                stm = Conn.createStatement();
                ResultSet rec2 = stm.executeQuery(sql2);
                while ((rec2 != null) && (rec2.next())) {
                    vBurn.add(rec2.getString("burn_no"));
                    // คำนวนหาเดือน cMonth.format(iMonth) ของเตา vBurn.get(iBurn)
                    for (int iBurn = 0; iBurn < vBurn.size(); iBurn++) {

                        // loop หาค่าในแต่ละเตา
                        // varBurn =  vBurn.get(iBurn) ;
                        sql = " SELECT month,year,rawmatt_id,burn_no,size_id,ctc_i2, name_t,weight "
                                + " FROM vd_carbon_burn_out_detail_wh_complete_month "
                                + " INNER JOIN m_carbon_size_out "
                                + " ON vd_carbon_burn_out_detail_wh_complete_month.size = m_carbon_size_out.name_t "
                                + " WHERE month = '"
                                + cd2Digit.format(iMonth) + "' AND year = '" + varYear + "' AND burn_no='" + rec2.getString("burn_no") + "' ";
                        stm = Conn.createStatement();
                        ResultSet rec = stm.executeQuery(sql);
                        System.out.println("SQL = " + sql);
                        while ((rec != null) && (rec.next())) {
                            varSize = rec.getInt("size_id");
                            varI2 = rec.getString("ctc_i2");
                            System.out.println("varSize Value - > :  " + varSize);
                            System.out.println("varI2 Value - > :  " + varI2);
                            System.out.println("iBrun Value - > :  " + iBurn);

                            //       v4_i.get(0) = rec2.getString("burn_no");

                            switch (varSize) {
                                case 1:
                                    //v4I2 = rec2.getString("ctc_i2");
                                    v4W = rec2.getString("weight");
                                    System.out.println("1");
                                    break;
                                case 2:
                                    //v4x8I2 = rec2.getString("ctc_i2");
                                    v4x8W = rec2.getString("weight");
                                    System.out.println("2");
                                    break;
                                case 3:
                                    //v8x30I2 = rec2.getString("ctc_i2");
                                    v8x30W = rec2.getString("weight");
                                    System.out.println("3");
                                    break;
                                case 4:
                                    //v30I2 = rec2.getString("ctc_i2");
                                    v30W = rec2.getString("weight");
                                    System.out.println("4");
                                    break;
                                case 5:
                                    //vDustI2 = rec2.getString("ctc_i2");
                                    vDustW = rec2.getString("weight");
                                    System.out.println("5");
                                    break;
                                default:
                                    System.out.println("error");
                            }


        %>
        <table border="1">
            <tr>
                <td><%=varYear%></td>
                <td><%=cd2Digit.format(iMonth)%></td>
                <td><%=rec.getString("burn_no")%></td>
            </tr>

        </table>

        <%

                        } // end while

                    } // end for
                } // end while
                // System.out.println(sql);


            } // end for loop month

        %>     





    </body>
</html>

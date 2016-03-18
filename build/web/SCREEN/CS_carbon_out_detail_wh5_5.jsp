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
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">
        <title>Process ...</title>        
        <title>JSP Page</title>
    </head>
    <%        // เชื่อมต่อฐานข้อมูล            
        // เชื่อมต่อฐานข้อมูล            
        UtiDatabase objut = new UtiDatabase();
        DBConnect db = new DBConnect();
        Connection Conn = db.openNewConnection();


    %>
    <body> 
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <input type="hidden" name="type_report" value="1">
            <input type="hidden" name="report_code" value="RP_025_1">
            <input type="hidden" name="price_year" value="">
            <tr>
                <td colspan='2' class='blankspace' align="left">                                              
                    <!--input type="button" name="myBut" value=" พิมพ์รายงาน  " onClick="javascript:document.report.submit();"/>
                    <input type=button value="ปิด" onClick="javascript:window.close();"-->
                    <a href="#" onClick="javascript:document.report.submit();" class="cgcButton">พิมพ์รายงาน</a>
                    <a href="#" onClick="javascript:window.close();" class="cgcButton">ปิด</a>
                </td>
            </tr>                
            <%

                String varMonth, varYear, varBurn, varline_no = "";
                int varCarbon_burn_in = 0;
                int varCarbon_burn_out = 0;
                String sql, sql2, sqlIn, sqlOut;
                int line_no = 0;
                String varWeight = "";
                String vIodian = "";
                String varDataSize = "";
                // กำหนดค่าสำหรับทดสอบ


                varYear = request.getParameter("price_year");
                System.out.println("varYear = " + varYear);
                varMonth = request.getParameter("month_id");
                System.out.println("varMonth = " + varMonth);

                Statement stm = null;
                Statement stmData = null;
                DecimalFormat dc = new DecimalFormat();
                dc.applyPattern("###,###.##");

                DecimalFormat cd2Digit = new DecimalFormat();
                cd2Digit.applyPattern("00");

                // clear temp

                stmData = Conn.createStatement();
                stmData.execute("TRUNCATE Table t_carbon_burn_out_detail");
                stmData.execute("ALTER SEQUENCE seq_t_carbon_burn_out_detail RESTART WITH 1");

                //for (int iMonth = 1; iMonth <= 12; iMonth++) {


                // loop หาเตา
                sql2 = "SELECT DISTINCT(burn_no) FROM vd_carbon_burn_out_detail_wh_complete_month "
                        + " WHERE month = '" + varMonth + "' order by burn_no";
                //+ " WHERE month = '" + cd2Digit.format(iMonth) + "' order by burn_no";
                stm = Conn.createStatement();
                ResultSet rec2 = stm.executeQuery(sql2);
                while ((rec2 != null) && (rec2.next())) {
                    varBurn = rec2.getString("burn_no");
                    sql = "SELECT runno,price_year,pgroup_id,iodine FROM  mproduct_price"
                            + " where pgroup_id = 'WIP' and price_year = '" + varYear + "' "
                            + " order by runno DESC ";
                    stm = Conn.createStatement();
                    ResultSet recIo = stm.executeQuery(sql);
                    line_no = 1;
                    while ((recIo != null) && (recIo.next())) {
                        vIodian = (recIo.getString("iodine"));
                        // insert into t_carbon_burn_out_detail
                        String sqlInsert = "";
                        sqlInsert = "insert into t_carbon_burn_out_detail (doc_year, doc_month,burn_no, i2 ,line_no) values ("
                                + "'" + varYear + "','" + varMonth + "','" + varBurn + "','"
                                //+ "'" + varYear + "','" + cd2Digit.format(iMonth) + "','" + varBurn + "','"                                    
                                + vIodian + "'," + line_no + ")";
                        // System.out.println("SQL : " + sqlInsert);
                        stmData = Conn.createStatement();
                        stmData.execute(sqlInsert);
                        line_no += 1;
                    } // end while loop iodian
                } // while loop burn
                //}   // end for iMonth  
                // -----------------------------------------------------------------------

            %>                           
            <%
                // นำข้อมูลในตาราง t_carbon_burn_out_detail มาวนหาข้อมูลใน vd_carbon_burn_out_detail_wh_complete_month
                // โดย join เอา size จาก m_carbon_size_out
                String sqlCarbon = "";
                String sqlData = "";
                sqlCarbon = "SELECT * FROM t_carbon_burn_out_detail ";

                stm = Conn.createStatement();
                ResultSet recCarbon = stm.executeQuery(sqlCarbon);
                while ((recCarbon != null) && (recCarbon.next())) {
                    varMonth = recCarbon.getString("doc_month");
                    varYear = recCarbon.getString("doc_year");
                    varBurn = recCarbon.getString("burn_no");
                    vIodian = recCarbon.getString("i2");


                    sqlData = "SELECT month,year,rawmatt_id,burn_no, size,to_number(size_id::TEXT,'99'::TEXT) as size_id"
                            + " ,coalesce(ctc_i2,'-')as ctc_i2, name_t,to_number(weight::TEXT, '99999.99'::TEXT) as weight   "
                            + " FROM vd_carbon_burn_out_detail_wh_complete_month "
                            + "     INNER JOIN m_carbon_size_out "
                            + "     ON vd_carbon_burn_out_detail_wh_complete_month.size = m_carbon_size_out.name_t "
                            + "  WHERE month = '" + varMonth + "' "
                            + "  AND year = '" + varYear + "' AND ctc_i2 = '" + vIodian + "' "
                            + "  AND burn_no='" + varBurn + "' ";
                    //System.out.println("Sql : "+sqlData);
                    stm = Conn.createStatement();
                    ResultSet recData = stm.executeQuery(sqlData);
                    while ((recData != null) && (recData.next())) {
                        varWeight = recData.getString("weight");
                        varDataSize = recData.getString("size_id");

                        //update table t_carbon_burn_out_detail
                        String sqlUpdateText = "UPDATE t_carbon_burn_out_detail SET ";
                        if (varDataSize.equals("1")) {
                            sqlUpdateText += "w4 = '" + varWeight + "' ";
                        } else if (varDataSize.equals("2")) {
                            sqlUpdateText += "w4x8 = '" + varWeight + "' ";
                        } else if (varDataSize.equals("3")) {
                            sqlUpdateText += "w8x3 = '" + varWeight + "' ";
                        } else if (varDataSize.equals("4")) {
                            sqlUpdateText += "w30 = '" + varWeight + "' ";
                        } else if (varDataSize.equals("5")) {
                            sqlUpdateText += "dust = '" + varWeight + "' ";
                        } else if (varDataSize.equals("6")) {
                            sqlUpdateText += "rock = '" + varWeight + "' ";                        
                        } else if (varDataSize.equals("7")) {
                            sqlUpdateText += "w_30 = '" + varWeight + "' ";
                        }

                        sqlUpdateText += " WHERE doc_month = '" + varMonth + "' "
                                + "  AND doc_year = '" + varYear + "' AND i2 = '" + vIodian + "' "
                                + "  AND burn_no='" + varBurn + "' ";
                        //  System.out.println("SQL Update : " + varline_no + " - > " + sqlUpdateText);

                        stmData = Conn.createStatement();
                        stmData.execute(sqlUpdateText);

                    } // end loop while dataz

                } // end loop while carbon


                // ------------------------------------------------------
                // loop หาค่าน้ำหนักเติม และถ่านออก                    

                sqlCarbon = "SELECT * FROM t_carbon_burn_out_detail where line_no = 1";

                stm = Conn.createStatement();
                ResultSet recCarbon2 = stm.executeQuery(sqlCarbon);

                while ((recCarbon2 != null) && (recCarbon2.next())) {

                    varline_no = recCarbon2.getString("line_no");
                    varMonth = recCarbon2.getString("doc_month");
                    varYear = recCarbon2.getString("doc_year");
                    varBurn = recCarbon2.getString("burn_no");

                    //  if (varline_no.equals("1")) {
                    String sqlUpdateText = "UPDATE t_carbon_burn_out_detail SET ";
                    // ---- หาน้ำหนักถ่านเติม
                    sqlIn = " SELECT  "
                            + "  substring(doc_date,7,4) as year ,substring(doc_date,4,2) as month,burn_no ,product_id,  "
                            + "     sum(coalesce(tot_weight,0)) as sum_weight  "
                            + "  FROM vd_carbon_burn_in_detail_rp_group  "
                            + "  WHERE substring(doc_date,7,4) = '" + varYear + "' "
                            + "     AND  substring(doc_date,4,2) = '" + varMonth + "'  "
                            + "     AND burn_no='" + varBurn + "'  "
                            + "  GROUP BY substring(doc_date,4,2) ,substring(doc_date,7,4) ,burn_no ,product_id  "
                            + "  ORDER BY substring(doc_date,4,2) ,substring(doc_date,7,4) ,burn_no ,product_id "
                            + " ";
                    stm = Conn.createStatement();
                    ResultSet recC_Brun_in = stm.executeQuery(sqlIn);
                    varCarbon_burn_in = 0;
                    while ((recC_Brun_in != null) && (recC_Brun_in.next())) {
                        varCarbon_burn_in = (recC_Brun_in.getInt("sum_weight"));
                    } // end loop while burn in
                    sqlUpdateText += "  carbon_in = '" + varCarbon_burn_in + "' ";


                    // ----- หาน้ำหนักถ่านออก
                    sqlOut = " SELECT substring(d.doc_date,7,4) as year"
                            + "    ,substring(d.doc_date,4,2) as month"
                            + "    , d.burn_no,SUM(to_number(d.wh_weight::TEXT,'99999'::TEXT)) as sum_weight_out"
                            + " FROM vd_carbon_burn_out_detail_wh d"                            
                            + " WHERE "
                            + "  d.delete_flag <> 'Y' "
                            + "     AND  substring(d.doc_date,7,4) = '" + varYear + "' "
                            + "     AND  substring(d.doc_date,4,2) = '" + varMonth + "'  "
                            + "     AND  d.burn_no='" + varBurn + "' "
                            + " Group BY  substring(d.doc_date,4,2)  ,substring(d.doc_date,7,4)   , d.burn_no "
                            + " ORDER BY substring(d.doc_date,4,2)  ,substring(d.doc_date,7,4)   , d.burn_no ";
/*
                    sqlOut = " SELECT substring(h.doc_date,7,4) as year"
                            + "    ,substring(h.doc_date,4,2) as month"
                            + "    , h.burn_no,SUM(to_number(d.wh_weight::TEXT,'99999'::TEXT)) as sum_weight_out"
                            + " FROM d_carbon_burn_out_header_wh h"
                            + "  	INNER JOIN d_carbon_burn_out_detail_wh d"
                            + "  	ON h.doc_id = d.doc_id"
                            + " WHERE "
                            + "  h.delete_flag != 'N' "
                            + "     AND  substring(h.doc_date,7,4) = '" + varYear + "' "
                            + "     AND  substring(h.doc_date,4,2) = '" + varMonth + "'  "
                            + "     AND  burn_no='" + varBurn + "' "
                            + " Group BY  substring(h.doc_date,4,2)  ,substring(h.doc_date,7,4)   , h.burn_no "
                            + " ORDER BY substring(h.doc_date,4,2)  ,substring(h.doc_date,7,4)   , h.burn_no ";                                       
*/                    
                    
                    System.out.println(">> " + sqlOut);
                    stm = Conn.createStatement();
                    ResultSet recC_Brun_out = stm.executeQuery(sqlOut);
                    varCarbon_burn_out = 0;
                    while ((recC_Brun_out != null) && (recC_Brun_out.next())) {
                        varCarbon_burn_out = (recC_Brun_out.getInt("sum_weight_out"));
                    }

                    sqlUpdateText += ", carbon_out = '" + varCarbon_burn_out + "' ";
                    sqlUpdateText += " WHERE doc_month = '" + varMonth + "' "
                            + "  AND doc_year = '" + varYear + "'   "
                            + "  AND burn_no='" + varBurn + "' AND line_no = '1'";
                    //System.out.println("SQL Update : " + varline_no + " - > " + sqlUpdateText);
                    stmData = Conn.createStatement();
                    stmData.execute(sqlUpdateText);

                    //     } // end loop line_no = 1

                }      // end while carbon2     


            %>

            100%
        </form>

    </body>
</html>

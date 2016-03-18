<%@page import="java.util.ArrayList"%>
<%@page import="java.lang.String"%>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.*" %>
<%@page import="java.io.*" %>
<%@page contentType="text/html; charset=TIS-620" language="java" %>
<%@page import="com.cgc.Util.Serchselect" %>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.DB.DBConnect"%>
<%@page import="java.text.DecimalFormat" %>
<%@page import="com.cgc.cDate.LastDate" %>
<%@page import="java.lang.String" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <title>Process ...</title>        
        <title>CGC ERP</title>
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
                String varRawmat_id = "";

                // กำหนดค่าสำหรับทดสอบ


                varYear = request.getParameter("price_year");
                System.out.println("varYear = " + varYear);
                varMonth = request.getParameter("month_id");
                System.out.println("varMonth = " + varMonth);

                varBurn = request.getParameter("burn_no");

                Statement STateMent = null;
                Statement STateMentData = null;
                DecimalFormat dc = new DecimalFormat();
                dc.applyPattern("###,###.##");

                DecimalFormat cd2Digit = new DecimalFormat();
                cd2Digit.applyPattern("00");

                // clear temp

                STateMentData = Conn.createStatement();
                STateMentData.execute("TRUNCATE Table t_carbon_burn_out_detail");
                STateMentData.execute("ALTER SEQUENCE seq_t_carbon_burn_out_detail RESTART WITH 1");

                //for (int iMonth = 1; iMonth <= 12; iMonth++) {


                // loop หาเตา

                if (varBurn.equals("-")||varBurn.equals("")||varBurn.equals(null)) {
                    sql2 = "SELECT DISTINCT(burn_no) FROM vd_carbon_burn_out_detail_wh_complete_month "
                            + " WHERE month = '" + varMonth + "' order by burn_no";
                } else {
                    sql2 = "SELECT DISTINCT(burn_no) FROM vd_carbon_burn_out_detail_wh_complete_month "
                            + " WHERE month = '" + varMonth + "' and burn_no = '" + varBurn + "' order by burn_no";
                }

                //+ " WHERE month = '" + cd2Digit.format(iMonth) + "' order by burn_no";
                STateMent = Conn.createStatement();
                ResultSet rec2 = STateMent.executeQuery(sql2);
                while ((rec2 != null) && (rec2.next())) {
                    varBurn = rec2.getString("burn_no");
                    sql = "SELECT runno,price_year,pgroup_id,iodine FROM  mproduct_price"
                            + " where pgroup_id = 'WIP' and price_year = '" + varYear + "' "
                            + " order by runno DESC ";
                    STateMent = Conn.createStatement();
                    ResultSet recIo = STateMent.executeQuery(sql);
                    line_no = 1;
                    while ((recIo != null) && (recIo.next())) {
                        vIodian = (recIo.getString("iodine"));
                        // insert into t_carbon_burn_out_detail
                        String sqlInsert = "";
                        sqlInsert = "insert into t_carbon_burn_out_detail (doc_year, doc_month,burn_no, i2 ,line_no,rawmat_id) values ("
                                + "'" + varYear + "','" + varMonth + "','" + varBurn + "','"
                                //+ "'" + varYear + "','" + cd2Digit.format(iMonth) + "','" + varBurn + "','"                                    
                                + vIodian + "'," + line_no + ",'CF'" + ")";
                        // System.out.println("SQL : " + sqlInsert);
                        STateMentData = Conn.createStatement();
                        STateMentData.execute(sqlInsert);
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

                STateMent = Conn.createStatement();
                ResultSet recCarbon = STateMent.executeQuery(sqlCarbon);
                while ((recCarbon != null) && (recCarbon.next())) {
                    varMonth = recCarbon.getString("doc_month");
                    varYear = recCarbon.getString("doc_year");
                    varBurn = recCarbon.getString("burn_no");
                    vIodian = recCarbon.getString("i2");

/*
                    sqlData = "SELECT month,year,rawmatt_id,burn_no, size,to_number(size_id::TEXT,'99'::TEXT) as size_id"
                            + " ,coalesce(ctc_i2,'0')as ctc_i2, name_t,to_number(weight::TEXT, '99999.99'::TEXT) as weight   "
                            + " FROM vd_carbon_burn_out_detail_wh_complete_month "
                            + "     INNER JOIN m_carbon_size_out "
                            + "     ON vd_carbon_burn_out_detail_wh_complete_month.size = m_carbon_size_out.name_t "
                            + "  WHERE month = '" + varMonth + "' "
                            + "  AND year = '" + varYear + "' AND ctc_i2 = '" + vIodian + "' "
                            + "  AND burn_no='" + varBurn + "' ";
 */
                                      
                    sqlData = "SELECT month,year,burn_no, size,size_id"
                            + " ,coalesce(ctc_i2,'0')as ctc_i2, to_number(weight::TEXT, '99999.99'::TEXT) as weight   "
                            + " FROM vd_carbon_burn_out_detail_wh_complete_month_1 "
                            + "  WHERE month = '" + varMonth + "' "
                            + "  AND year = '" + varYear + "' AND ctc_i2 = '" + vIodian + "' "
                            + "  AND burn_no='" + varBurn + "' " 
                            + "  Order By burn_no ";
                                                          
                    System.out.println("Sql : " + sqlData);
                    STateMent = Conn.createStatement();
                    ResultSet recData = STateMent.executeQuery(sqlData);
                    while ((recData != null) && (recData.next())) {
                        varWeight = recData.getString("weight");
                        varDataSize = recData.getString("size_id");
                        //varRawmat_id = recData.getString("rawmatt_id");

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
                        } else if (varDataSize.equals("8")) {
                            sqlUpdateText += "w8 = '" + varWeight + "' ";
                        }                        
                        //sqlUpdateText += " , rawmat_id = '" + varRawmat_id + "' ";    
                        sqlUpdateText += " WHERE doc_month = '" + varMonth + "' "
                                + "  AND doc_year = '" + varYear + "' AND i2 = '" + vIodian + "' "
                                + "  AND burn_no='" + varBurn + "' ";

                        //System.out.println("SQL Update : " + varline_no + " - > " + sqlUpdateText);

                        STateMentData = Conn.createStatement();
                        STateMentData.execute(sqlUpdateText);

                    } // end loop while dataz

                } // end loop while carbon


                // ------------------------------------------------------
                // loop หาค่าน้ำหนักเติม และถ่านออก                    

                sqlCarbon = "SELECT * FROM t_carbon_burn_out_detail where line_no = 1";

                STateMent = Conn.createStatement();
                ResultSet recCarbon2 = STateMent.executeQuery(sqlCarbon);

                while ((recCarbon2 != null) && (recCarbon2.next())) {

                    varline_no = recCarbon2.getString("line_no");
                    varMonth = recCarbon2.getString("doc_month");
                    varYear = recCarbon2.getString("doc_year");
                    varBurn = recCarbon2.getString("burn_no");

                    //  if (varline_no.equals("1")) {
                    String sqlUpdateText = "UPDATE t_carbon_burn_out_detail SET ";


                    /*                                       
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
                    
                     */

                    sqlIn = " SELECT substring(d.doc_date,7,4) as year"
                            + "    ,substring(d.doc_date,4,2) as month"
                            + "    , d.burn_no,SUM(to_number(d.total_weight_in::TEXT,'99999'::TEXT)) as sum_weight"
                            + " FROM vd_carbon_burn_io_report d"
                            + " WHERE "
                            + "  d.delete_flag <> 'Y' "
                            + "     AND  substring(d.doc_date,7,4) = '" + varYear + "' "
                            + "     AND  substring(d.doc_date,4,2) = '" + varMonth + "'  "
                            + "     AND  d.burn_no='" + varBurn + "' "
                            + " Group BY  substring(d.doc_date,4,2)  ,substring(d.doc_date,7,4)   , d.burn_no "
                            + " ORDER BY substring(d.doc_date,4,2)  ,substring(d.doc_date,7,4)   , d.burn_no ";

                    STateMent = Conn.createStatement();
                    ResultSet recC_Brun_in = STateMent.executeQuery(sqlIn);
                    varCarbon_burn_in = 0;
                    while ((recC_Brun_in != null) && (recC_Brun_in.next())) {
                        varCarbon_burn_in = (recC_Brun_in.getInt("sum_weight"));
                    } // end loop while burn in
                    sqlUpdateText += "  carbon_in = '" + varCarbon_burn_in + "' ";


                    // ----- หาน้ำหนักถ่านออก


                    /*                                       
                     sqlOut = " SELECT substring(d.doc_date,7,4) as year"
                     + "    ,substring(d.doc_date,4,2) as month"
                     + "    , d.burn_no,SUM(to_number(d.wh_weight::TEXT,'99999'::TEXT)) as sum_weight_out"
                     + " FROM vd_carbon_burn_out_detail_wh d"                            
                     + " WHERE "
                     + "  d.delete_flag <> 'Y' "
                     + "     AND  substring(d.doc_date,7,4) = '" + varYear + "' "
                     + "     AND  substring(d.doc_date,4,2) = '" + varMonth + "'  "
                     + "     AND  d.burn_no='" + varBurn + "' "
                     + "     AND  (d.size = '+4'"                            
                     + "     OR d.size = '4x8'"
                     + "     OR d.size = '8x30'"
                     + "     OR d.size = '-30'"
                     + "     OR d.size = '+30'"                            
                     + "     OR d.size = 'ฝุ่น'"
                     + "     OR d.size = 'หิน'"                            
                     + ") "
                     + " Group BY  substring(d.doc_date,4,2)  ,substring(d.doc_date,7,4)   , d.burn_no "
                     + " ORDER BY substring(d.doc_date,4,2)  ,substring(d.doc_date,7,4)   , d.burn_no ";
                     */

                    sqlOut = " SELECT substring(d.doc_date,7,4) as year"
                            + "    ,substring(d.doc_date,4,2) as month"
                            + "    , d.burn_no,SUM(to_number(d.total_weight_out::TEXT,'99999'::TEXT)) as sum_weight_out"
                            + " FROM vd_carbon_burn_io_report d"
                            + " WHERE "
                            + "  d.delete_flag <> 'Y' "
                            + "     AND  substring(d.doc_date,7,4) = '" + varYear + "' "
                            + "     AND  substring(d.doc_date,4,2) = '" + varMonth + "'  "
                            + "     AND  d.burn_no='" + varBurn + "' "
                            + " Group BY  substring(d.doc_date,4,2)  ,substring(d.doc_date,7,4)   , d.burn_no "
                            + " ORDER BY substring(d.doc_date,4,2)  ,substring(d.doc_date,7,4)   , d.burn_no ";




                    //System.out.println(">> " + sqlOut);
                    STateMent = Conn.createStatement();
                    ResultSet recC_Brun_out = STateMent.executeQuery(sqlOut);
                    varCarbon_burn_out = 0;
                    while ((recC_Brun_out != null) && (recC_Brun_out.next())) {
                        varCarbon_burn_out = (recC_Brun_out.getInt("sum_weight_out"));
                    }

                    sqlUpdateText += ", carbon_out = '" + varCarbon_burn_out + "' ";
                    sqlUpdateText += " WHERE doc_month = '" + varMonth + "' "
                            + "  AND doc_year = '" + varYear + "'   "
                            + "  AND burn_no='" + varBurn + "' AND line_no = '1'";
                    //System.out.println("SQL Update : " + varline_no + " - > " + sqlUpdateText);
                    STateMentData = Conn.createStatement();
                    STateMentData.execute(sqlUpdateText);

                    //     } // end loop line_no = 1

                }      // end while carbon2     


            %>
            <font color="red"><b>สร้างข้อมูล 100%</b></font>
        </form>

    </body>
</html>

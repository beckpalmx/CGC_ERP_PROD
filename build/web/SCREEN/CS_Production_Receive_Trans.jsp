<!DOCTYPE html>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.*" %>
<%@page import="com.cgc.Util.Serchselect" %>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.DB.DBConnect"%>
<%@page import="java.text.DecimalFormat" %>
<%@ page import="com.cgc.cDate.LastDate" %>

<%!    String path, lookup, doc_eff_date, doc_no, screen_name;
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
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
            <%
                UserBean userbean = (UserBean) session.getAttribute("user");
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_Production_Receive_Trans_frm");
                UtiDatabase objuti = new UtiDatabase();
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objr_p = r_p.Fn_Report(objr_p, "S807");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
                screen_name = objr_p.getName_t();
                //_______________________________________________________________report
            %>            
            <input type="hidden" name="type_report" value="2">
            <input type="hidden" name="report_code" value="RP_400_NEW">
            <input type="hidden" id="lookup" name="lookup" value="<%=lookup%>">
            <input type="hidden" id="doc_eff_date" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" id="doc_no" name="doc_no" value="<%=doc_no%>">            
            <%
                String job_id = request.getParameter("job_id");
            %>

            <tr>
                <td class="ftopleft"></td>
                <td  class="ftopcenter" colspan="2"><b>รายงานสรุปการผลิต</b></td>
                <td class="ftopright"></td>
            </tr>
            <br>
            <br>
            <tr>               
            <input type="hidden" name="SQL" value="Where doc_id = '<%=job_id%>' ">
            <b>ใบแจ้งการผลิต</B>
            <input type='text' class="inputs" name="doc_id" value="<%=job_id%>" size ="12" readonly="true">
            <br>
            <br>
            </tr>
            <%

                String sql_where_1 = "";

                if (!job_id.equals("") && !job_id.equals(null) && !job_id.equals("-")) {
                    sql_where_1 = " WHERE job_id = '" + job_id + "' ";
                }

                Statement STateMent = null;
                Statement STateMentData = null;

                String sql, sql_ins = "";
                String size, job_type_id, job_type_desc, sum_weight, size_name = "";

                // เชื่อมต่อฐานข้อมูล            
                UtiDatabase objut = new UtiDatabase();
                DBConnect db = new DBConnect();
                Connection Conn = db.openNewConnection();

                size_name = objut.GetField("select size_name as field from vd_job_order_header where doc_id = '" + job_id + "'");
                System.out.println("Size Name : " + size_name);

                String sqlDelete = "Delete From t_transaction_production_receive " + sql_where_1;
                STateMentData = Conn.createStatement();
                STateMentData.execute(sqlDelete);

                //Receive Product By Size 
                sql = " SELECT job_id,size,job_type_id, job_type_desc, "
                        + " sum(to_number(weight::TEXT,'999999.99'::TEXT)) as sum_weight "
                        + " FROM d_product_receive_detail_prod "
                        + sql_where_1
                        + " AND delete_flag <> 'Y' "
                        + " AND size = '" + size_name + "'"
                        + " AND job_type_id = '006' "
                        + " GROUP BY  job_id,size,job_type_id,job_type_desc"
                        + " ORDER BY  job_id,size,job_type_id,job_type_desc";
                System.out.println(sql);
                STateMent = Conn.createStatement();
                ResultSet rec1 = STateMent.executeQuery(sql);
                while ((rec1 != null) && (rec1.next())) {
                    size = (rec1.getString("size"));
                    job_type_id = (rec1.getString("job_type_id"));
                    job_type_desc = rec1.getString("job_type_desc");
                    sum_weight = rec1.getString("sum_weight");

                    sql_ins = "INSERT INTO t_transaction_production_receive(doc_type,job_id,size,job_type_id,job_type_desc,weight)"
                            + "  VALUES ('+','"
                            + job_id + "','" + size + "','"
                            + job_type_id + "','" + job_type_desc + "','" + sum_weight + "')";
                    System.out.println(sql_ins);
                    STateMentData = Conn.createStatement();
                    STateMentData.execute(sql_ins);

                }

                //Withdraw
                sql = " SELECT job_id,size,job_type_id, job_type_desc, "
                        + " sum(to_number(qty::TEXT,'999999.99'::TEXT)) as sum_weight "
                        + " FROM d_product_receive_detail "
                        + sql_where_1
                        + " AND delete_flag <> 'Y' "
                        + " AND size = '" + size_name + "'"
                        + " AND job_type_id <> '006' "
                        + " GROUP BY  job_id,size,job_type_id,job_type_desc"
                        + " ORDER BY  job_id,size,job_type_id,job_type_desc";
                System.out.println(sql);
                STateMent = Conn.createStatement();
                ResultSet rec2 = STateMent.executeQuery(sql);
                while ((rec2 != null) && (rec2.next())) {
                    size = (rec2.getString("size"));
                    job_type_id = (rec2.getString("job_type_id"));
                    job_type_desc = rec2.getString("job_type_desc");
                    sum_weight = rec2.getString("sum_weight");

                    sql_ins = "INSERT INTO t_transaction_production_receive(doc_type,job_id,size,job_type_id,job_type_desc,weight)"
                            + "  VALUES ('-','"
                            + job_id + "','" + size + "','"
                            + job_type_id + "','" + job_type_desc + "','" + sum_weight + "')";
                    System.out.println(sql_ins);
                    STateMentData = Conn.createStatement();
                    STateMentData.execute(sql_ins);

                }

                //Receive Product Remain 1
                sql = " SELECT job_id,size,job_type_id, job_type_desc, "
                        + " sum(to_number(weight::TEXT,'999999.99'::TEXT)) as sum_weight "
                        + " FROM d_product_receive_detail_prod "
                        + sql_where_1
                        + " AND delete_flag <> 'Y' "
                        + " AND size <> '" + size_name + "'"
                        //+ " AND job_type_id = '006' "
                        + " GROUP BY  job_id,size,job_type_id,job_type_desc"
                        + " ORDER BY  job_id,size,job_type_id,job_type_desc";
                System.out.println(sql);
                STateMent = Conn.createStatement();
                ResultSet rec3 = STateMent.executeQuery(sql);
                while ((rec3 != null) && (rec3.next())) {
                    size = (rec3.getString("size"));
                    job_type_id = (rec3.getString("job_type_id"));
                    job_type_desc = rec3.getString("job_type_desc");
                    sum_weight = rec3.getString("sum_weight");

                    sql_ins = "INSERT INTO t_transaction_production_receive(doc_type,job_id,size,job_type_id,job_type_desc,weight)"
                            + "  VALUES ('+','"
                            + job_id + "','" + size + "','"
                            + job_type_id + "','" + job_type_desc + "','" + sum_weight + "')";
                    System.out.println(sql_ins);
                    STateMentData = Conn.createStatement();
                    STateMentData.execute(sql_ins);

                }

                //Receive Product Remain 2
                sql = " SELECT job_id,size,job_type_id, job_type_desc, "
                        + " sum(to_number(weight::TEXT,'999999.99'::TEXT)) as sum_weight "
                        + " FROM d_product_receive_detail_prod "
                        + sql_where_1
                        + " AND delete_flag <> 'Y' "
                        + " AND size = '" + size_name + "'"
                        + " AND job_type_id = '008' "
                        + " GROUP BY  job_id,size,job_type_id,job_type_desc"
                        + " ORDER BY  job_id,size,job_type_id,job_type_desc";
                System.out.println(sql);
                STateMent = Conn.createStatement();
                ResultSet rec4 = STateMent.executeQuery(sql);
                while ((rec4 != null) && (rec4.next())) {
                    size = (rec4.getString("size"));
                    job_type_id = (rec4.getString("job_type_id"));
                    job_type_desc = rec4.getString("job_type_desc");
                    sum_weight = rec4.getString("sum_weight");

                    sql_ins = "INSERT INTO t_transaction_production_receive(doc_type,job_id,size,job_type_id,job_type_desc,weight)"
                            + "  VALUES ('+','"
                            + job_id + "','" + size + "','"
                            + job_type_id + "','" + job_type_desc + "','" + sum_weight + "')";
                    System.out.println(sql_ins);
                    STateMentData = Conn.createStatement();
                    STateMentData.execute(sql_ins);

                }


            %>       



            </table>
            </td>
            </td>
            </tr>

            <%    // insert section          
            %>          



            <font color="red"><b>สร้างข้อมูล 100%</b></font>
            <br>
            <br>
            <tr>
                <td colspan='2' class='blankspace' align="left">                                              
                    <a href="#" onClick="javascript:document.report.submit();" class="cgcButton">พิมพ์รายงาน</a>
                    <a href="#" onClick="javascript:window.close();" class="cgcButton">ปิด</a>
                </td>
            </tr>  
        </table>
    </form>
</body>
</html>

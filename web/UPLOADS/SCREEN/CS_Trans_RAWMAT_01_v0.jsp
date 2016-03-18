
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
<!DOCTYPE html>

<%!    String date_f, date_t;
%>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=TIS-620">        
        <!--link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css"-->
        <link rel="stylesheet" href="../table.css" type="text/css"/>	        
        <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
        <script src="//code.jquery.com/jquery-1.9.1.js"></script>
        <script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
        <link rel="stylesheet" href="/resources/demos/style.css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">
        <script>
            $(function() {
                $("input[type=submit], a, button")
                        .button()
                        .click(function(event) {
                            event.preventDefault();
                        });
            });
        </script>     

        <script>
            $(function() {
                $("#progressbar").progressbar({
                    value: 100
                });
            });
        </script>        

        <title>CGC  รายงานการเคลื่อนไหว</title>        
        <style type="text/css">
            <!--
            .myTable{
                border: thin inset; 
                font: xx-small/ Tahoma, Geneva, sans-serif;
                margin: auto;
                width: 80%;
                padding: 0px;

                alignment-adjust: central;
            }

            -->
        </style>


    </head>
    <body>
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <input type="hidden" name="type_report" value="1">
            <input type="hidden" name="report_code" value="RP_021_RAW_FRICTION">
            <input type="hidden" name="price_year" value="2558">
            <%
                String product_id = request.getParameter("product_id");
                String pgroup_id = request.getParameter("pgroup_id");
                System.out.println("product_id = " + product_id);
                System.out.println("pgroup_id = " + pgroup_id);
                System.out.println("1 date_from = " + request.getParameter("date_from"));
                System.out.println("1 date_to = " + request.getParameter("date_to"));
                date_f = request.getParameter("date_f");
                date_t = request.getParameter("date_t");

                int Total = 0;
                int Temp_Total = 0;
                String data_type = "";
                int data_weight = 0;
                int data_r = 0;
                int data_w = 0;
                int sum_r = 0;
                int sum_w = 0;
                //Connection connect = null;
                Statement stm = null;
                Statement stmData = null;
                String sql, sql_where = "";
                //String product_id = null;
                DecimalFormat dc = new DecimalFormat();
                dc.applyPattern("###,###.##");
                try {

                    UtiDatabase objut = new UtiDatabase();
                    DBConnect db = new DBConnect();
                    Connection Conn = db.openNewConnection();
                    System.out.println("Conn First : " + Conn);

                    if (!product_id.equals("") && !product_id.equals(null)) {
                        sql_where = " WHERE product_id = '" + product_id + "' ";
                    }

                    if (pgroup_id.equals("") || pgroup_id.equals(null)) {
                        if (!sql_where.equals("") && !sql_where.equals(null)) {
                            sql_where = sql_where + " AND pgroup_id = 'RAW' ";
                        } else {
                            sql_where = " WHERE pgroup_id = 'RAW' ";
                        }
                    }

                    System.out.println("1 sql_where = " + sql_where);

                    if (!pgroup_id.equals("") && !pgroup_id.equals(null)) {
                        if (!sql_where.equals("") && !sql_where.equals(null)) {
                            sql_where = sql_where + " AND pgroup_id = '" + pgroup_id + "' ";
                        } else {
                            sql_where = " WHERE pgroup_id = '" + pgroup_id + "' ";
                        }
                    }

                    sql_where = sql_where + " and (process_id = 'PR_025' or process_id = 'PR_057') ";

                    System.out.println("2 sql_where = " + sql_where);

                    if (!request.getParameter("date_from").equals("") && !request.getParameter("date_to").equals("") && !request.getParameter("date_from").equals(null) && !request.getParameter("date_to").equals(null)) {
                        if (!sql_where.equals("") && !sql_where.equals(null)) {
                            sql_where = sql_where + " AND to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + request.getParameter("date_from") + "'),'YYYY-MM-DD') AND to_date(format_date2('" + request.getParameter("date_to") + "'),'YYYY-MM-DD') ";
                        } else {
                            sql_where = " WHERE to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + request.getParameter("date_from") + "'),'YYYY-MM-DD') AND to_date(format_date2('" + request.getParameter("date_to") + "'),'YYYY-MM-DD') ";
                        }
                    }

                    System.out.println("Connect String : " + Conn);

                    sql = "SELECT doc_date,product_id, doc_type,sum(weight_total) as weight_total,pname_t,pgroup_id,location_id  "
                            + " FROM vt_transaction_stock_process_report "
                            + sql_where
                            + " Group by product_id, doc_date,location_id ,doc_type,pname_t,pgroup_id "
                            + " Order by location_id,to_date(format_date(doc_date),'YYYY-MM-DD') , doc_type desc ";

                    System.out.println("SQL : " + sql);

                    stm = Conn.createStatement();
                    ResultSet rec = stm.executeQuery(sql);
                    String sqlDelete = "DELETE FROM tmp_stock_rawmat_friction";
                    stmData = Conn.createStatement();
                    System.out.println("Conn 2 : " + Conn);
                    System.out.println("sqlDelete 2 : " + sqlDelete);
                    stmData.execute(sqlDelete);


            %>   

            <div class="CSS_Table_Example" style="width:1200px;height:150px;">    
                <tr>
                    <td colspan='2' class='blankspace' align="right">                                              
                        <!--input type="button" name="myBut" value=" พิมพ์รายงาน  " onClick="javascript:document.report.submit();"/>
                        <input type=button value="ปิด" onClick="javascript:window.close();"-->
                        <a href="#" onClick="javascript:document.report.submit();" class="cgcButton">พิมพ์รายงาน</a>
                        <a href="#" onClick="javascript:window.close();" class="cgcButton">ปิด</a>
                    </td>
                </tr>              
                <table border ="1"  cellpadding="0"  cellspacing="0" class="myTable">
                    <center><h2>รายงานความเคลื่อนไหววัตถุดิบ (ถ่านสี)</h2></center>                   
                    <center><h3>วันที่ : <%=date_f%> ถึง <%=date_t%></h3></center>                 
                    <tr align="center">
                        <td>วันที่</td>
                        <td>Product</td>
                        <td>Doc Type</td>
                        <!-- <td>Weight Total</td> -->
                        <td>รับเข้า</td>
                        <td>จ่ายออก</td>
                        <td>คงเหลือ </td>
                    </tr>
                    <% String tmp_location_id = ""; // สตริงไว้ดักจับตัวซ้ำ  %>

                    <%while ((rec != null) && (rec.next())) {%>
                    <!-- ------------------------------------------------------------------------------------ -->
                    <!-- Summary Group by Product ID  -->
                    <%
                        if (rec.getString("location_id").equals(tmp_location_id) || tmp_location_id.equals("")) {
                        } else {
                    %>  

                    <tr>
                        <td colspan="2" align="right"> ยอดรวม</td>
                        <td>  &nbsp;</td>
                        <td align="right"> <%=dc.format(sum_r)%>&nbsp;</td>
                        <td align="right"> <%=dc.format(sum_w)%>&nbsp;</td>
                        <td align="right"> <%=dc.format(Total)%>&nbsp;</td>
                    </tr>    
                    <%      sum_r = 0;
                            sum_w = 0;
                            Total = 0;
                            Temp_Total = 0;
                        }
                        tmp_location_id = rec.getString("location_id");
                    %>
                    <!-- -------------------------------------------------------------------------------------- -->

                    <tr>
                        <td> &nbsp;<%=rec.getString("doc_date")%></td> 
                        <td> &nbsp;<%=rec.getString("product_id")%> | <%=rec.getString("pname_t")%></td>
                        <td> &nbsp;<%=rec.getString("location_id")%></td> 
                        <td align='center'><%=rec.getString("doc_type")%></td>               
                        <% data_type = rec.getString("doc_type");%>
                        <% data_weight = rec.getInt("weight_total");%>
                        <%

                            if (data_type.equals("+")) {
                                data_r = data_weight;
                                data_w = 0;
                            } else if (data_type.equals("-")) {
                                data_w = data_weight;
                                data_r = 0;
                            }
                            Total = data_r + data_w + Temp_Total;
                            Temp_Total = Total;
                            sum_r += data_r;
                            sum_w += data_w;

                            String SqlInsert = "INSERT INTO tmp_stock_rawmat_friction(product_id,doc_date,doc_type,data_r,data_w,data_total,pgroup_id,location_id) VALUES "
                                    + "('" + rec.getString("product_id") + "','" + rec.getString("doc_date") + "','"
                                    + rec.getString("doc_type") + "'," + data_r + "," + data_w + "," + Total + ",'"
                                    + rec.getString("pgroup_id") + "','" + rec.getString("location_id") + "')";
                            System.out.println("SqlInsert = " + SqlInsert);
                            stmData = Conn.createStatement();
                            stmData.execute(SqlInsert);
                            // ResultSet recInsert = stmInsert.executeQuery(SqlInsert);


                        %>
                        <td align="right"> <%=dc.format(data_r)%>&nbsp;</td>
                        <td align="right"> <%=dc.format(data_w)%>&nbsp;</td>
                        <td align="right"> <%=dc.format(Total)%>&nbsp;</td>    
                    </tr>
                    <%}%>
                    <tr> 
                        <td colspan="3"></td>
                        <td align="right"><%=dc.format(sum_r)%>&nbsp;</td>
                        <td align="right"><%=dc.format(sum_w)%>&nbsp;</td>
                        <td> </t>
                    </tr>


                </table>      
            </div>
            <%
                }
                catch (Exception e

                
                    ) {
                    // TODO Auto-generated catch block
                    out.println(e.getMessage());
                    e.printStackTrace();
                }

                
                    try {
                    if (stm != null) {
                        stm.close();
                        //Conn.close();
                    }
                }
                catch (SQLException e

                
                    ) {
                    // TODO Auto-generated catch block
                    out.println(e.getMessage());
                    e.printStackTrace();
                }
            %>
        </form>
    </body>
</html>

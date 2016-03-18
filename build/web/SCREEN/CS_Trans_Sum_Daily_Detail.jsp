<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<%@page import="java.sql.Timestamp"%>

<%!    String date_f, date_t;

%>

<html>
    <head>
        <meta charset="utf-8">       
        <meta name="viewport" content="width=device-width, initial-scale=1">        

        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> 
        <link href="../CSS/component.css" rel="stylesheet" type="text/css">

        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>

        <script>
            $(function() {
                $("input[type=submit], a, button")
                        .button()
                        .click(function(event) {
                            event.preventDefault();
                        });
            });
        </script>     

        <script type="text/javascript">

            $(document).ready(function() {
                $('[data-toggle="tooltip"]').tooltip();
            });

        </script>     

        <title>CGC  รายงานมูลค่าสินค้า (คลังสินค้า)</title>        
        <style type="text/css">
        </style>

        <style>
            .table tbody tr:hover td, .table tbody tr:hover th {
                background-color: #FF66FF;
            }
        </style>


    </head>
    <body>
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <input type="hidden" name="type_report" value="1">
            <input type="hidden" name="report_code" value="">
            <input type="hidden" name="price_year" value="">
            <%
                //String product_id = request.getParameter("product_id");
                //String pgroup_id = request.getParameter("pgroup_id");
                //System.out.println("product_id = " + product_id);
                //System.out.println("pgroup_id = " + pgroup_id);
                System.out.println("1 date_from = " + request.getParameter("date_from"));
                System.out.println("1 date_to = " + request.getParameter("date_to"));
                date_f = request.getParameter("date_f");
                date_t = request.getParameter("date_t");

                double weight_value = 0;
                double price_value = 0;
                //Connection connect = null;
                Statement STateMent = null;
                Statement STateMentData = null;
                Statement STateMent_periods = null;
                String sql, sql_where = "";
                String start_period = "";
                //String product_id = null;
                DecimalFormat dc = new DecimalFormat();
                dc.applyPattern("###,###.##");

                DecimalFormat df = new DecimalFormat("#.##");

                UtiDatabase objut = new UtiDatabase();

                DBConnect db = new DBConnect();
                Connection Conn = db.openNewConnection();
                Connection Conn2 = db.openNewConnection();
                Connection Conn3 = db.openNewConnection();

                //System.out.println("Conn First : " + Conn);
                sql = "SELECT * "
                        + " FROM mperiod "
                        + " where doc_type = 'S'";

                STateMent_periods = Conn2.createStatement();
                ResultSet rec_periods = STateMent_periods.executeQuery(sql);
                if (rec_periods.next()) {
                    //start_period = rec_periods.getString("start_period");
                    //System.out.println("Select DB start_period : " + rec_periods.getString("start_period"));
                    start_period = rec_periods.getString("start_period").substring(6, 10) + "-" + rec_periods.getString("start_period").substring(3, 5) + "-" + rec_periods.getString("start_period").substring(0, 2);
                }

                //System.out.println("Conn start_period : " + start_period);
                //System.out.println("Conn date_to : " + request.getParameter("date_to"));
                int day = Integer.parseInt(request.getParameter("date_to").substring(8, 10));

                String sdate_to, sdate_to_db = "";
                sdate_to = (request.getParameter("date_to").substring(0, 8));
            %>       

            <%
                int iday = 0;
                for (iday = 1; iday <= day; iday++) {

                    String sdate_to_cond = sdate_to + String.format("%02d", iday);
                    //System.out.println(String.format("%02d", iday));
                    //System.out.println("sdate_to_cond = " + sdate_to_cond);

                    String sqlDelete = "DELETE FROM tmp_stock_daily "
                            + " WHERE to_date(format_date(doc_date),'YYYY-MM-DD') = to_date(format_date2('" + sdate_to_cond + "'),'YYYY-MM-DD')";

                    STateMentData = Conn.createStatement();
                    //System.out.println("Conn 2 : " + Conn);
                    //System.out.println("sqlDelete 2 : " + sqlDelete);
                    STateMentData.execute(sqlDelete);

                    sql_where = " WHERE to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + start_period + "'),'YYYY-MM-DD') AND to_date(format_date2('" + sdate_to_cond + "'),'YYYY-MM-DD') ";
                    //System.out.println("sql_where Loop 0 : " + sql_where);                        

                    //System.out.println("Connect String : " + Conn);
                    sql = "SELECT Sum(weight_total) as weight_total,Sum(weight_total * price_per_unit_num) as price_total"
                            + " FROM vt_transaction_stock_process_report "
                            + sql_where
                            + " And pgroup_id <> 'RAW'";
                    //+ " Order by product_id, to_date(format_date(doc_date),'YYYY-MM-DD') , doc_type desc ";

                    //System.out.println("SQL : " + sql);
                    STateMent = Conn.createStatement();
                    ResultSet rec = STateMent.executeQuery(sql);

                    while ((rec != null) && (rec.next())) {

                        //System.out.println("Select DB Value : " + rec.getString("weight_total") + " | " + rec.getString("price_total"));
                        weight_value = Double.parseDouble(rec.getString("weight_total"));
                        price_value = Double.parseDouble(rec.getString("price_total"));
                        //System.out.print(iday + "|" + weight_value + " | " + price_value);
                        System.out.println("DATE : " + iday + " | " + String.format("%.2f", weight_value) + " / " + String.format("%.2f", price_value));
                        //System.out.println("sdate_to_cond = " + sdate_to_cond);
                        sdate_to_db = sdate_to_cond.substring(8, 10) + "-" + sdate_to_cond.substring(5, 7) + "-" + sdate_to_cond.substring(0, 4);

                        java.sql.Timestamp sqlDate = new java.sql.Timestamp(new java.util.Date().getTime());
                        String SqlInsert = "INSERT INTO tmp_stock_daily(doc_date,weight_value,price_value,stock_type,create_date) VALUES (?,?,?,?,?)";
                        //+ "('" + sdate_to_db + "'," + weight_value + "," + price_value + ",'WH'," + ts + ")";

                        PreparedStatement pSTateMentt = Conn3.prepareStatement(SqlInsert);
                        pSTateMentt.setString(1, sdate_to_db);
                        
                        pSTateMentt.setDouble(2, weight_value);
                        pSTateMentt.setDouble(3, price_value);
                        pSTateMentt.setString(4, "WH");
                        pSTateMentt.setTimestamp(5, sqlDate);
                        pSTateMentt.executeUpdate();

                        System.out.println("SqlInsert = " + SqlInsert);
                    }
                }

            %>

            <nav class="navbar navbar-default">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <a class="navbar-brand" href="#">
                            <img alt="C. Gigantic Carbon Co.,Ltd" src="../IMAGES/CGC_LOGO_139.png">
                        </a>
                    </div>
                </div>
            </nav>    

            <div class="container">        
                <div class="panel panel-primary">
                    <div class="panel-heading"> <span class="glyphicon glyphicon-stats" style="color:white"></span>
                        <b><font color="white">ประมวลผลสรุปข้อมูลสินค้ารายวัน (CS_Trans_Sum_Daily_Detail)</font></b>
                    </div>                

                    <div class="panel-footer">   

                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>วันที่</th>
                                    <th>น้ำหนักสินค้า (กิโลกรัม)</th>
                                    <th>มูลค่า (บาท)</th>
                                    <th>มูลค่า (พันบาท)</th>
                                </tr>
                            </thead>

                            <tbody>

                                <%                                    
                                    DecimalFormat formatter = new DecimalFormat("#0.00");
                                    String weight_value_diplay = "";
                                    String price_value_diplay = "";
                                    String price_value_thousand_diplay = "";
                                    String Statement_Display = " Select * From vtmp_stock_daily " + sql_where;
                                    System.out.println("Statement_Display = " + Statement_Display);

                                    STateMentData = Conn.createStatement();
                                    ResultSet rec_wh_stock_daily = STateMentData.executeQuery(Statement_Display);

                                    int rec_count = 1;

                                    while (rec_wh_stock_daily != null && (rec_wh_stock_daily.next())) {
                                        rec_count++;
                                        System.out.println(rec_wh_stock_daily.getString("doc_date"));
                                        weight_value_diplay = formatter.format(rec_wh_stock_daily.getDouble("weight_value"));
                                        price_value_diplay = formatter.format(rec_wh_stock_daily.getDouble("price_value"));
                                        price_value_thousand_diplay = formatter.format(rec_wh_stock_daily.getDouble("price_value_thousand"));

                                %>

                                <%if (rec_count % 2 == 0) {%>
                                <tr class="info">
                                    <%} else {%>
                                <tr> 
                                    <%}%>

                                    <td><%=rec_wh_stock_daily.getString("doc_date")%></td>
                                    <td><%=weight_value_diplay%></td>
                                    <td><%=price_value_diplay%></td>
                                    <td><%=price_value_thousand_diplay%></td>
                                </tr>

                                <%}

                                %>


                            </tbody>
                        </table>
                        <button id = "newThread" class="btn btn-warning btn-block" type="submit" data-toggle="tooltip" title="ปิดหน้าจอนี้"  onClick="javascript:window.close();"><b>ปิด</b></button>                                
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>

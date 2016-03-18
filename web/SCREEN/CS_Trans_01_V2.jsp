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
<%@page import="java.sql.Date"%>

<%!    String date_f, date_t;
%>


<html>
    <head>
        <title>CGC  รายงานการเคลื่อนไหว</title>        
        <meta http-equiv="Content-Type" content="text/html; charset=TIS-620">        
        <!--link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css"-->
        <link rel="stylesheet" href="../table.css" type="text/css"/>	        
        <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
        <script src="//code.jquery.com/jquery-1.9.1.js"></script>
        <script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
        <link rel="stylesheet" href="/resources/demos/style.css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">

        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>          

        <script src="../JS/bootstrap_select/js/bootstrap-select.js"></script>        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.min.css">        
        <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-theme.min.css">               

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
        
        <script>

            var value = 0;

            function barAnim() {
                value += 5;
                $(".progress-bar").css("width", value + "%").attr("aria-valuenow", value);
                //if (value == 25 || value == 55 || value == 85) {
                if (value === 75 || value === 95) {
                    return setTimeout(barAnim, 500);
                }
                //if (value >= 100) {
                //    alert(value + " % Complete");
                //}
                return value >= 100 || setTimeout(barAnim, 20);
            }

            setTimeout(barAnim, 20);
        </script>                    


    </head>
    <body>
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <%
                date_f = request.getParameter("date_f");
                date_t = request.getParameter("date_t");
            %>
            <input type="hidden" name="type_report" value="4">
            <input type="hidden" name="report_code" value="RP_021_WH_2">
            <input type="hidden" name="price_year" value="">
            <input type="hidden" name="pgroup_id" value="-">
            <input type="hidden" name="product_id" value="-">
            <input type="hidden" name="warehouse_id" value="-">
            <input type="hidden" name="branch" value="-">
            <input type="hidden" name="location_id" value="-">
            <input type="hidden" name="friction_house" value="-">                          
            <input type="hidden" id="date_form" name="date_form" value="<%=date_f%>">
            <input type="hidden" id="date_to" name="date_to" value="<%=date_t%>">            

            <%
                UtiDatabase objut = new UtiDatabase();
                DBConnect db = new DBConnect();
                Connection Conn = db.openNewConnection();
                Connection Conn2 = db.openNewConnection();
                ResultSet rec_periods = null;

                Timestamp ts = (new Timestamp(new java.util.Date().getTime()));
                System.out.println("ts = " + ts);

                Statement STateMent = null;
                Statement STateMentData = null;
                Statement STateMent_loop1 = null;
                Statement STateMent_loop2 = null;

                DecimalFormat formatter = new DecimalFormat("#0.00");
                Double data_r = 0.00;
                Double data_w = 0.00;
                Double transfer = 0.00;
                Double balance = 0.00;

                String product_id = request.getParameter("product_id");
                //String pgroup_id = request.getParameter("pgroup_id");
                // **** ลบข้อมูลตาราง ความเคลื่อนไหว
                String sqlDelete = " DELETE FROM tmp_stock_2 ;"
                        + " ALTER SEQUENCE seq_tmp_stock_2 RESTART WITH 1; "
                        + " DELETE FROM tmp_mproduct_current_movement ;"
                        + " ALTER SEQUENCE seq_tmp_mproduct_current_movement RESTART WITH 1; ";
                STateMentData = Conn.createStatement();
                STateMentData.execute(sqlDelete);

                String SQL_PERIOD = "SELECT * FROM mperiod where doc_type = 'S'";

                String start_period = "";

                String SqlInsert1, SqlInsert2, SqlIns_Tmp_Prod = "";

                rec_periods = Conn2.createStatement().executeQuery(SQL_PERIOD);

                if (rec_periods.next()) {
                    start_period = rec_periods.getString("start_period").substring(6, 10) + rec_periods.getString("start_period").substring(2, 6) + rec_periods.getString("start_period").substring(0, 2);
                    System.out.println("Select DB start_period : " + start_period);
                }

                String s_prev_month_period = "00";

                int currmonth = Integer.parseInt(request.getParameter("date_from").substring(5, 7));
                String curryear = request.getParameter("date_from").substring(0, 4);
                System.out.println("currmonth = " + currmonth + " curryear = " + curryear);

                if (Integer.parseInt(request.getParameter("date_from").substring(5, 7)) > 1) {
                    s_prev_month_period = String.format("%02d", Integer.parseInt(request.getParameter("date_from").substring(5, 7)) - 1);
                }

                int s_prev_year_period = (Integer.parseInt(request.getParameter("date_from").substring(0, 4)) - 1);

                System.out.println("s_prev_month_period = " + s_prev_month_period);
                System.out.println("s_prev_year_period = " + s_prev_year_period);

                SQL_PERIOD = "SELECT * FROM mmonth where month_id = '" + s_prev_month_period + "' ";

                String end_period = "";
                String s_end_period = "";

                rec_periods = Conn2.createStatement().executeQuery(SQL_PERIOD);
                if (rec_periods.next()) {
                    end_period = rec_periods.getString("end_date").substring(6, 10) + rec_periods.getString("end_date").substring(2, 6) + rec_periods.getString("end_date").substring(0, 2);
                    s_end_period = rec_periods.getString("end_date");
                } else {
                    s_end_period = "31-12-" + s_prev_year_period;
                }

                System.out.println("end_period = " + end_period + " | s_end_period = " + s_end_period);

                String sql_where = "";

                if (!request.getParameter("date_from").equals("") && !request.getParameter("date_to").equals("") && !request.getParameter("date_from").equals(null) && !request.getParameter("date_to").equals(null)) {
                    sql_where = " WHERE to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('"
                            + request.getParameter("date_from") + "'),'YYYY-MM-DD') AND to_date(format_date2('"
                            + request.getParameter("date_to") + "'),'YYYY-MM-DD') and pgroup_id <> 'RAW' ";
                }

                System.out.println("cond product_id  = " + product_id);

                if (product_id.equals("") || product_id == null) {
                    System.out.println("Loop Null product_id  = " + product_id);
                } else {
                    if (sql_where.equals("") || sql_where == null) {
                        System.out.println("loop cond - sql_where  = " + sql_where);
                    } else {
                        sql_where = sql_where + " and product_id = '" + product_id + "'";
                    }
                }

                System.out.println("cond - sql_where  = " + sql_where);

                /**
                 * ** หารหัสสินค้าที่เคลื่อนไหวเดือนปัจจุบัน ***
                 */
                String sql_product_id = " Select distinct(product_id) from vt_transaction_stock_process_report " + sql_where + " Order By product_id";

                //int count_product_id = 0;
                //String product_id_check = "";
                STateMent = Conn.createStatement();
                STateMentData = Conn2.createStatement();
                ResultSet rec_product = STateMent.executeQuery(sql_product_id);

                while (rec_product != null && (rec_product.next())) {

                    /*                    
                     count_product_id++;
                     if (count_product_id == 1) {
                     product_id_check = "'" + rec_product.getString("product_id") + "'";
                     } else {
                     product_id_check += ",'" + rec_product.getString("product_id") + "'";
                     }             
                     */
                    SqlIns_Tmp_Prod = "INSERT INTO tmp_mproduct_current_movement(product_id,period_month,create_date,create_by,period_year,remark) VALUES "
                            + "('" + rec_product.getString("product_id") + "','" + currmonth + "'"
                            + ",'" + ts + "','System','" + curryear + "','" + request.getParameter("date_to") + "')";
                    //System.out.println("SqlIns_Tmp_Prod = " + SqlIns_Tmp_Prod);

                    STateMentData = Conn.createStatement();
                    STateMentData.execute(SqlIns_Tmp_Prod);
                }

                String sql_tmp_product = " Select * from tmp_mproduct_current_movement Order By product_id ";
                STateMent = Conn.createStatement();                
                STateMentData = Conn2.createStatement();
                ResultSet rec_tmp_product = STateMent.executeQuery(sql_tmp_product);

                String sql_loop1 = "";

                while ((rec_tmp_product != null) && (rec_tmp_product.next())) { // Loop Main 

                    sql_loop1 = " select product_id,sum(weight_total) as weight_total,pname_t,pgroup_id,"
                            //+ "price_per_unit,"
                            + "avg(to_number(price_per_unit,'999999.99')) as price_per_unit "
                            + " from vt_transaction_stock_process_report "
                            + " WHERE product_id = '" + rec_tmp_product.getString("product_id") + "' "
                            + " and to_number(month,'99') < " + currmonth
                            + " and year = '" + curryear + "'"
                            + " GROUP BY pgroup_id,product_id,pname_t  ";

                    //System.out.println("sql_loop1 = " + sql_loop1);
                    STateMent_loop1 = Conn.createStatement();
                    ResultSet rec_loop1 = STateMent_loop1.executeQuery(sql_loop1);
                    //String doc_type = "***";

                    while ((rec_loop1 != null) && (rec_loop1.next())) { // Loop 1 
/*
                         System.out.println("rec_loop1 = product_id = " + rec_loop1.getString("product_id")
                         + " pgroup_id = " + rec_loop1.getString("pgroup_id")
                         + " pname_t = " + rec_loop1.getString("pname_t")
                         + " weight_total = " + rec_loop1.getDouble("weight_total")
                         + " price_per_unit = " + rec_loop1.getDouble("price_per_unit"));
                         */

                        transfer = rec_loop1.getDouble("weight_total");
                        transfer = Double.parseDouble(formatter.format(transfer));
                        data_r = 0.00;
                        data_w = 0.00;

                        SqlInsert1 = "INSERT INTO tmp_stock_2(product_id,doc_date,doc_type,data_r,data_w,data_total,data_transfer,price_per_unit,pgroup_id) VALUES "
                                + "('" + rec_loop1.getString("product_id") + "','" + s_end_period + "','"
                                //+ doc_type + "'," + data_r + "," + data_w + "," + transfer + "," + transfer + ",'"
                                + "***'," + formatter.format(data_r) + "," + formatter.format(data_w) + "," + formatter.format(transfer) + "," + formatter.format(transfer) + ",'"
                                + rec_loop1.getString("price_per_unit") + "','" + rec_loop1.getString("pgroup_id") + "')";

                        STateMentData = Conn.createStatement();
                        STateMentData.execute(SqlInsert1);

                    }  // Loop 1

                    //Start Loop 2                     
                    String sql_loop2 = "SELECT runno,doc_date,product_id,"
                            + "doc_type,weight_total,pname_t,pgroup_id,"
                            + "price_per_unit"
                            //+ " avg(to_number(price_per_unit,'999999.99')) as price_per_unit "
                            + " FROM vt_transaction_stock_process_report "
                            + " where to_number(month,'99') = " + currmonth
                            + " and year = '" + curryear + "'"
                            + " and product_id = '" + rec_tmp_product.getString("product_id") + "'"
                            + " Order by pgroup_id,product_id, to_date(format_date(doc_date),'YYYY-MM-DD') , doc_type desc ";

                    //System.out.println("sql_loop2 = " + sql_loop2);
                    STateMent_loop2 = Conn.createStatement();
                    ResultSet rec_loop2 = STateMent_loop1.executeQuery(sql_loop2);

                    int rec_loop = 1;

                    while ((rec_loop2 != null) && (rec_loop2.next())) { // Loop 2

                        //System.out.println("First rec_loop = " + rec_loop);
                        if (rec_loop == 1) {
                            balance = 0.00;
                            //balance = transfer + rec_loop2.getDouble("weight_total");
                            balance = Double.parseDouble(formatter.format(transfer)) + Double.parseDouble(formatter.format(rec_loop2.getDouble("weight_total")));
                        } else {
                            balance = Double.parseDouble(formatter.format(balance)) + Double.parseDouble(formatter.format(rec_loop2.getDouble("weight_total")));
                        }

                        //if (balance < 0) {
                        //balance = 0.00;
                        //}
                        if (rec_loop2.getString("doc_type").equals("-")) {
                            data_w = rec_loop2.getDouble("weight_total");
                            data_r = 0.00;
                        } else {
                            data_r = rec_loop2.getDouble("weight_total");
                            data_w = 0.00;
                        }

                        if (rec_loop2.getString("product_id").equals("C-I0801A-0+30-K")) {
                            System.out.println(" rec_loop = " + rec_loop
                                    + " | data_r = " + formatter.format(data_r)
                                    + " | data_w = " + formatter.format(data_w)
                                    + " | balance = " + formatter.format(balance));
                        }

                        rec_loop++;

                        /*                        
                         System.out.println("rec_loop2 = product_id = " + rec_loop2.getString("product_id")
                         + " pgroup_id = " + rec_loop2.getString("pgroup_id")
                         + " pname_t = " + rec_loop2.getString("pname_t")
                         + " weight_total = " + rec_loop2.getDouble("weight_total")
                         + " price_per_unit = " + rec_loop2.getDouble("price_per_unit")
                         + " data_r = " + data_r
                         + " data_w = " + data_w
                         + " balance = " + balance);
                         */
                        SqlInsert2 = "INSERT INTO tmp_stock_2(product_id,doc_date,doc_type,data_r,data_w,data_total,price_per_unit,pgroup_id) VALUES "
                                + "('" + rec_loop2.getString("product_id") + "','" + rec_loop2.getString("doc_date") + "','"
                                + rec_loop2.getString("doc_type") + "'," + formatter.format(data_r) + "," + formatter.format(data_w) + "," + formatter.format(balance) + ",'"
                                + rec_loop2.getString("price_per_unit") + "','" + rec_loop2.getString("pgroup_id") + "')";
                        STateMentData = Conn.createStatement();
                        STateMentData.execute(SqlInsert2);

                    } // Loop 2

                    transfer = 0.00;

                } // Loop Main 

                Timestamp ts1 = (new Timestamp(new java.util.Date().getTime()));
                System.out.println("ts1 = " + ts1);

                
                


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

            <!--div class="CSS_Table_Example" style="width:1200px;height:150px;"-->
            <div class="jumbotron">
                <div class="container">
                    <table border ="1"  cellpadding="0"  cellspacing="0" class="">
                        <center><h1>รายงานความเคลื่อนไหวสินค้า V2</h1></center>                 
                        <center><h2><span class="label label-success">วันที่ : <%=date_f%> ถึง <%=date_t%></span></h2></center> 
                        <!--center><h2>วันที่ : <%=date_f%> ถึง <%=date_t%></h2></center--> 
                        <center>   
                            <!--div class="progress progress-striped active"-->
                            <div class="progress">                                
                                <div class="progress-bar" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width:0%"></div>                                
                            </div>
                        </center>                          
                        <center><h2>จัดเตรียมข้อมูลเสร็จสิ้น กรุณากดปุ่ม พิมพ์รายงาน</h2></center>          
                        <!--center><h2>กรุณากดปุ่ม พิมพ์รายงาน</h2></center-->          
                        <!--center>Start : <%=ts%></center> 
                        <center>Stop&nbsp; : <%=ts1%></center-->
                    </table>      

                    <div class="CSS_Table_Example" style="width:1200px;height:150px;">    
                        <center>
                            <a href="#" onClick="javascript:document.report.submit();" class="cgcButton_19">พิมพ์รายงาน</a>
                            &nbsp;&nbsp;<a href="#" onClick="javascript:window.close();" class="cgcButton_19">ปิด</a>
                        </center>    
                    </div>

                    <div class="CSS_Table_Example" style="width:1200px;height:150px;">    
                        <left>                            
                            <div class="alert alert-info">
                                <a href="#" class="close" data-dismiss="alert">×</a>

                                <table class="table table-bordered">
                                    <tr>
                                        <td class="row5" width="20%">
                                    <left>เริ่มประมวลผล เวลา :</left> 
                                    </td>
                                    <td class="row5" width="20%">
                                    <left><%=ts%></left> 
                                    </td>
                                    </tr>
                                    <tr>
                                        <td class="row5" width="20%">
                                    <left>สิ้นสุดการประมวลผล เวลา :</left> 
                                    </td>
                                    <td class="row5" width="20%">
                                    <left><%=ts1%></left> 
                                    </td>
                                    </tr>                        
                                </table>                                    
                            </div>
                        </left>    
                    </div>                    

                </div>
            </div>

        </form>
    </body>
</html>


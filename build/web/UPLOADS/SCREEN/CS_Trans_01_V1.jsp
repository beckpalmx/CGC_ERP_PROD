
<!--%@ page contentType="text/html; charset=TIS-620" language="java" %-->
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
<!DOCTYPE html>

<%!    String date_f, date_t, product_id;
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

        <title>CGC  รายงานการเคลื่อนไหว</title>        

    </head>
    <body>
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <%
                date_f = request.getParameter("date_f");
                date_t = request.getParameter("date_t");
                product_id = request.getParameter("product_id");
            %>
            <input type="hidden" name="type_report" value="4">
            <input type="hidden" name="report_code" value="RP_021_WH">
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

                String pgroup_id = request.getParameter("pgroup_id");

                Timestamp ts = (new Timestamp(new java.util.Date().getTime()));
                System.out.println("ts = " + ts);

                //System.out.println("product_id = " + product_id);
                //System.out.println("pgroup_id = " + pgroup_id);
                //System.out.println("1 date_from = " + request.getParameter("date_from"));
                //System.out.println("1 date_to = " + request.getParameter("date_to"));
                String SQL_PERIOD = "SELECT * FROM mperiod where doc_type = 'S'";

                String start_period = "";

                String SqlInsert1, SqlInsert2, SqlInsert3, SqlInsert4 = "";

                rec_periods = Conn2.createStatement().executeQuery(SQL_PERIOD);
                if (rec_periods.next()) {
                    start_period = rec_periods.getString("start_period").substring(6, 10) + rec_periods.getString("start_period").substring(2, 6) + rec_periods.getString("start_period").substring(0, 2);
                    System.out.println("Select DB start_period : " + start_period);
                }

                String s_prev_month_period = "00";
                if (Integer.parseInt(request.getParameter("date_from").substring(5, 7)) > 1) {
                    s_prev_month_period = String.format("%02d", Integer.parseInt(request.getParameter("date_from").substring(5, 7)) - 1);
                }

                SQL_PERIOD = "SELECT * FROM mmonth where month_id = '" + s_prev_month_period + "' ";

                String end_period = "";
                String s_end_period = "";

                rec_periods = Conn2.createStatement().executeQuery(SQL_PERIOD);
                if (rec_periods.next()) {
                    end_period = rec_periods.getString("end_date").substring(6, 10) + rec_periods.getString("end_date").substring(2, 6) + rec_periods.getString("end_date").substring(0, 2);
                    s_end_period = rec_periods.getString("end_date");
                }

                String month_check = "";

                DecimalFormat formatter = new DecimalFormat("#0.00");
                double Total = 0;
                double Temp_Total = 0;
                String data_type = "";
                double data_weight = 0;
                double data_r = 0;
                double data_w = 0;
                double sum_r = 0;
                double sum_w = 0;
                double price_per_unit = 0.00;
                double total_price_trans = 0.00;
                double total_price_sum = 0.00;
                double total_weight_trans = 0.00;
                //Connection connect = null;
                Statement STateMent = null;
                Statement STateMent_loop1 = null;
                Statement STateMent_loop2 = null;
                Statement STateMent_loop3 = null;
                Statement STateMent_loop4 = null;
                Statement STateMentData = null;
                String sql, sql_where = "";
                //String product_id = null;
                DecimalFormat dc = new DecimalFormat();
                dc.applyPattern("###,###.##");

                //System.out.println("Conn First : " + Conn);
                // **** ลบข้อมูลตาราง ความเคลื่อนไหว
                String sqlDelete = " DELETE FROM tmp_stock ;"
                        + " ALTER SEQUENCE seq_tmp_stock RESTART WITH 1; ";
                STateMentData = Conn.createStatement();
                //System.out.println("Conn 2 : " + Conn);
                //System.out.println("sqlDelete 2 : " + sqlDelete);
                STateMentData.execute(sqlDelete);

                //System.out.println("2 sql_where = " + sql_where);
                if (!request.getParameter("date_from").equals("") && !request.getParameter("date_to").equals("") && !request.getParameter("date_from").equals(null) && !request.getParameter("date_to").equals(null)) {
                    if (!sql_where.equals("") && !sql_where.equals(null)) {
                        sql_where = sql_where + " AND to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + request.getParameter("date_from") + "'),'YYYY-MM-DD') AND to_date(format_date2('" + request.getParameter("date_to") + "'),'YYYY-MM-DD') ";
                    } else {
                        sql_where = " WHERE to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + request.getParameter("date_from") + "'),'YYYY-MM-DD') AND to_date(format_date2('" + request.getParameter("date_to") + "'),'YYYY-MM-DD') ";
                    }
                }

                sql_where = sql_where + " and pgroup_id <> 'RAW' ";

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

                //System.out.println("Connect String : " + Conn);
                String sql_product_id = " Select distinct(product_id) from vt_transaction_stock_process_report " + sql_where + " Order By product_id";
                String sql_loop1 = "";
                String sql_loop2 = "";
                String product_cond = "";
                String where_product = "";
                String product_id_check = "";

                double receive = 0.00;
                double withdraw = 0.00;
                double transfer = 0.00;
                double balance = 0.00;
                double balance1 = 0.00;
                double balance2 = 0.00;
                String product_id_loop1 = "";

                System.out.println("sql_product_id : " + sql_product_id);
                STateMent = Conn.createStatement();
                ResultSet rec_product = STateMent.executeQuery(sql_product_id);

                int i = 1;
                int count_product_id = 1;

                //System.out.println("Integer.parseInt(s_prev_month_period) = " + Integer.parseInt(s_prev_month_period));
                while ((rec_product != null) && (rec_product.next() && Integer.parseInt(s_prev_month_period) > 0)) {

                    sql_loop1 = " select product_id,sum(weight_total) as weight_total,pname_t,pgroup_id "
                            + " ,avg(to_number(price_per_unit,'999999.99')) as price_per_unit "
                            + " from vt_transaction_stock_process_report "
                            + " WHERE product_id = '" + rec_product.getString("product_id") + "' "
                            + " and to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + start_period + "'),'YYYY-MM-DD') AND to_date(format_date2('" + end_period + "'),'YYYY-MM-DD') "
                            + " GROUP BY pgroup_id,product_id,pname_t  ";
                    STateMent_loop1 = Conn.createStatement();
                    ResultSet rec_loop1 = STateMent_loop1.executeQuery(sql_loop1);

                    while ((rec_loop1 != null) && (rec_loop1.next())) {

                        //System.out.println(" rec_loop1 --> Integer.parseInt(s_prev_month_period) = " + Integer.parseInt(s_prev_month_period));
                        if (count_product_id == 1) {
                            product_id_check = "'" + rec_loop1.getString("product_id") + "'";
                        } else {
                            product_id_check += ",'" + rec_loop1.getString("product_id") + "'";
                        }

                        if (rec_loop1.getString("product_id").equals("C-I1000A-2050-4")) {
                            System.out.println("sql_loop1 = " + sql_loop1);
                        }

                        count_product_id++;

                        //if (rec_loop1.getString("product_id").equals("C-AW1100-5150-6") || rec_loop1.getString("product_id").equals("C-201502-3060-6")) {
                        //System.out.println("Loop1 sql_loop1 = " + sql_loop1);
                        /*                        
                         System.out.println("Loop1 = doc_date = " + s_end_period
                         + " : product_id = " + rec_loop1.getString("product_id") + " == weight_total = "
                         + rec_loop1.getString("weight_total")
                         + " : " + rec_loop1.getString("price_per_unit")
                         + " : " + rec_loop1.getString("pname_t")
                         + " : " + rec_loop1.getString("pgroup_id"));
                         */
                        //}
                        transfer = rec_loop1.getDouble("weight_total");
                        product_id_loop1 = rec_loop1.getString("product_id");

                        data_r = 0.00;
                        data_w = 0.00;

                        SqlInsert2 = "INSERT INTO tmp_stock(product_id,doc_date,doc_type,data_r,data_w,data_total,data_transfer,price_per_unit,pgroup_id) VALUES "
                                + "('" + rec_loop1.getString("product_id") + "','" + s_end_period + "','"
                                + "***'," + data_r + "," + data_w + "," + transfer + "," + transfer + ",'"
                                + rec_loop1.getString("price_per_unit") + "','" + rec_loop1.getString("pgroup_id") + "')";
                        STateMentData = Conn.createStatement();
                        STateMentData.execute(SqlInsert2);

                        sql_loop2 = "SELECT runno,doc_date,product_id,"
                                + " doc_type,weight_total,pname_t,price_per_unit,pgroup_id "
                                + " FROM vt_transaction_stock_process_report "
                                + sql_where
                                + " and product_id = '" + rec_loop1.getString("product_id") + "'"
                                + " Order by pgroup_id,product_id, to_date(format_date(doc_date),'YYYY-MM-DD') , doc_type desc ";
                        STateMent_loop2 = Conn.createStatement();
                        ResultSet rec_loop2 = STateMent_loop2.executeQuery(sql_loop2);

                        int rec_loop = 1;

                        while (rec_loop2.next()) {

                            //System.out.println(" rec_loop2 --> Integer.parseInt(s_prev_month_period) = " + Integer.parseInt(s_prev_month_period));
                            //System.out.println("In Loop 2 product_id  = " +  rec_loop2.getString("product_id") );
                            if (rec_loop == 1) {
                                //balance = transfer + rec_loop2.getDouble("weight_total");
                                balance = Double.parseDouble(formatter.format(transfer)) + Double.parseDouble(formatter.format(rec_loop2.getDouble("weight_total")));
                            } else {
                                //balance = balance + rec_loop2.getDouble("weight_total");
                                balance = Double.parseDouble(formatter.format(balance)) + Double.parseDouble(formatter.format(rec_loop2.getDouble("weight_total")));
                            }

                            if (balance < 0) {
                                //balance = 0.00;
                            }

                            rec_loop++;
                            //System.out.println("Loop2 = doc_date = " + rec_loop2.getString("doc_date") + " product_id = " + rec_loop2.getString("product_id") + " == weight_total = "
                            //        + rec_loop2.getString("weight_total")
                            //        + " : balance " + balance);

                            if (rec_loop2.getString("doc_type").equals("-")) {
                                data_w = rec_loop2.getDouble("weight_total");
                                data_r = 0.00;
                            } else {
                                data_r = rec_loop2.getDouble("weight_total");
                                data_w = 0.00;
                            }

                            SqlInsert2 = "INSERT INTO tmp_stock(product_id,doc_date,doc_type,data_r,data_w,data_total,price_per_unit,pgroup_id) VALUES "
                                    + "('" + rec_loop2.getString("product_id") + "','" + rec_loop2.getString("doc_date") + "','"
                                    + rec_loop2.getString("doc_type") + "'," + data_r + "," + data_w + "," + balance + ",'"
                                    + rec_loop2.getString("price_per_unit") + "','" + rec_loop2.getString("pgroup_id") + "')";
                            STateMentData = Conn.createStatement();
                            STateMentData.execute(SqlInsert2);

            %>                            
            <%                                        }
                        //next sum value 
                        //System.out.println(" Before End Loop :: Product_id = " + product_id_loop1 + " transfer = " + transfer);
                        balance = 0.00;
                    }

                    if (i == 1) {
                        product_cond = "'" + rec_product.getString("product_id") + "'";
                    } else {
                        product_cond += ",'" + rec_product.getString("product_id") + "'";
                    }
                    i++;
                }

                String sql_loop3 = "";
                String sql_loop4 = "";

                if (Integer.parseInt(s_prev_month_period) > 0) {

                    //System.out.println("Final product_cond : " + product_cond);
                    String[] temp;
                    /* delimiter */
                    String delimiter = ",";
                    temp = product_cond.split(delimiter);

                    for (int k = 0; k < temp.length; k++) {
                        //System.out.println("product_cond No. " + k + " : " + temp[k]);

                        sql_loop3 = "SELECT runno,doc_date,product_id,"
                                + " doc_type,weight_total,pname_t,price_per_unit,pgroup_id "
                                + " FROM vt_transaction_stock_process_report "
                                + sql_where
                                + " and product_id = " + temp[k]
                                + " and product_id not in  (" + product_id_check + ")"
                                + " Order by pgroup_id,product_id, to_date(format_date(doc_date),'YYYY-MM-DD') , doc_type desc ";

                        //System.out.println("sql_loop3 = " + sql_loop3);
                        STateMent_loop3 = Conn.createStatement();
                        ResultSet rec_loop3 = STateMent_loop3.executeQuery(sql_loop3);

                        while (rec_loop3.next()) {

                            balance1 = balance1 + rec_loop3.getDouble("weight_total");

                            if (rec_loop3.getString("doc_type").equals("-")) {
                                data_w = rec_loop3.getDouble("weight_total");
                                data_r = 0.00;
                            } else {
                                data_r = rec_loop3.getDouble("weight_total");
                                data_w = 0.00;
                            }

                            SqlInsert3 = "INSERT INTO tmp_stock(product_id,doc_date,doc_type,data_r,data_w,data_total,price_per_unit,pgroup_id) VALUES "
                                    + "('" + rec_loop3.getString("product_id") + "','" + rec_loop3.getString("doc_date") + "','"
                                    + rec_loop3.getString("doc_type") + "'," + data_r + "," + data_w + "," + balance1 + ",'"
                                    + rec_loop3.getString("price_per_unit") + "','" + rec_loop3.getString("pgroup_id") + "')";
                            STateMentData = Conn.createStatement();
                            STateMentData.execute(SqlInsert3);

                        }

                        balance1 = 0.00;

                    }
                } else {

                    STateMent = Conn.createStatement();
                    ResultSet rec_product_4 = STateMent.executeQuery(sql_product_id);
                    int i_count = 1;

                    String product_cond4 = "";

                    while (rec_product_4.next()) {
                        if (i_count == 1) {
                            product_cond4 = "'" + rec_product_4.getString("product_id") + "'";
                        } else {
                            product_cond4 += ",'" + rec_product_4.getString("product_id") + "'";
                        }
                        i_count++;
                    }

                    //System.out.println("Final product_cond4 : " + product_cond4);
                    String[] temp1;
                    /* delimiter */
                    String delimiter1 = ",";
                    temp1 = product_cond4.split(delimiter1);

                    for (int k1 = 0; k1 < temp1.length; k1++) {

                        sql_loop4 = "SELECT runno,doc_date,product_id,"
                                + " doc_type,weight_total,pname_t,price_per_unit,pgroup_id "
                                + " FROM vt_transaction_stock_process_report "
                                + sql_where
                                + " and product_id = " + temp1[k1]
                                + " Order by pgroup_id,product_id, to_date(format_date(doc_date),'YYYY-MM-DD') , doc_type desc ";

                        //System.out.println("sql_loop4 = " + sql_loop4);
                        STateMent_loop4 = Conn.createStatement();
                        ResultSet rec_loop4 = STateMent_loop4.executeQuery(sql_loop4);

                        while (rec_loop4.next()) {

                            balance2 = balance2 + rec_loop4.getDouble("weight_total");

                            if (rec_loop4.getString("doc_type").equals("-")) {
                                data_w = rec_loop4.getDouble("weight_total");
                                data_r = 0.00;
                            } else {
                                data_r = rec_loop4.getDouble("weight_total");
                                data_w = 0.00;
                            }

                            //System.out.println("Loop4 = doc_date = " + rec_loop4.getString("doc_date") + " product_id = " + rec_loop4.getString("product_id") + " == weight_total = "
                            //        + rec_loop4.getString("weight_total")
                            //        + " : balance2 " + balance2);
                            SqlInsert4 = "INSERT INTO tmp_stock(product_id,doc_date,doc_type,data_r,data_w,data_total,price_per_unit,pgroup_id) VALUES "
                                    + "('" + rec_loop4.getString("product_id") + "','" + rec_loop4.getString("doc_date") + "','"
                                    + rec_loop4.getString("doc_type") + "'," + data_r + "," + data_w + "," + balance2 + ",'"
                                    + rec_loop4.getString("price_per_unit") + "','" + rec_loop4.getString("pgroup_id") + "')";
                            STateMentData = Conn.createStatement();
                            STateMentData.execute(SqlInsert4);

                        }
                        balance2 = 0.00;
                    }
                }

                /*                
                 if (!product_cond.equals("") && !product_cond.equals(null)) {
                 where_product = " OR product_id in (" + product_cond + ") ";
                 }
                 */
                System.out.println("End Process ");

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
                        <center><h1>รายงานความเคลื่อนไหวสินค้า</h1></center>                   
                        <center><h2><span class="label label-success">วันที่ : <%=date_f%> ถึง <%=date_t%></span></h2></center> 
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

    <script>

        var value = 0;

        function barAnim() {
            value += 5;
            $(".progress-bar").css("width", value + "%").attr("aria-valuenow", value);
            //if (value == 25 || value == 55 || value == 85) {
            if (value == 75 || value == 95) {
                return setTimeout(barAnim, 500);
            }
            //if (value >= 100) {
            //    alert(value + " % Complete");
            //}
            return value >= 100 || setTimeout(barAnim, 20);
        }

        setTimeout(barAnim, 20);
    </script>        

</html>

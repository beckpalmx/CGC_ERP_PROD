
<%@page contentType="text/html; charset=TIS-620" language="java" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.SQLException" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.*" %>
<%@page import="com.cgc.Util.Serchselect" %>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.DB.DBConnect"%>
<%@page import="java.text.DecimalFormat" %>
<%@page import="com.cgc.report.PrintReport"%>
<%@page import="java.io.InputStream"%>
<%@page trimDirectiveWhitespaces="true" %>

<!DOCTYPE html>

<%!    String date_f, date_t, movement_year, movement_month, month_movement_name, username, doc_date, date_form, date_to;
%>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=TIS-620">        
        <!--link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css"-->
        <link rel="stylesheet" href="../table.css" type="text/css"/>	        
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
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

        <script>
            $(function() {
                $("#progressbar").progressbar({
                    value: 100
                });
            });
        </script>        

        <title>CGC  รายงานคลังสินค้า</title>        

    </head>
    <body>
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <%
                UtiDatabase objut = new UtiDatabase();
                DBConnect db = new DBConnect();
                Connection Conn = db.openNewConnection();
                Connection Conn2 = db.openNewConnection();
                ResultSet rec_prod = null;
                Statement STateMentData = null;

                Connection Conn_Period = db.openNewConnection();
                ResultSet rec_periods = null;

                //date_f = request.getParameter("date_f");
                //date_t = request.getParameter("date_t");
                movement_year = request.getParameter("price_year");
                movement_month = request.getParameter("month_id");
                username = request.getParameter("username");
                System.out.println("Year = " + movement_year);
                System.out.println("Month = " + movement_month);

                String start_period = "";

                String SQL_PERIOD = "SELECT * FROM mperiod where doc_type = 'S'";

                rec_periods = Conn_Period.createStatement().executeQuery(SQL_PERIOD);
                if (rec_periods.next()) {

                    start_period = rec_periods.getString("start_period");
                    //start_period = rec_periods.getString("start_period").substring(6, 10) + rec_periods.getString("start_period").substring(2, 6) + rec_periods.getString("start_period").substring(0, 2);

                }

                String SQL_Month = "SELECT * FROM mmonth where month_id = '" + movement_month + "'";
                rec_periods = Conn_Period.createStatement().executeQuery(SQL_Month);
                if (rec_periods.next()) {
                    month_movement_name = rec_periods.getString("name_t");
                }

                SQL_PERIOD = "SELECT end_date FROM mmonth where month_id = '" + movement_month + "'";

                rec_periods = Conn_Period.createStatement().executeQuery(SQL_PERIOD);
                if (rec_periods.next()) {
                    doc_date = rec_periods.getString("end_date");
                }

                date_f = start_period;
                date_t = doc_date;

                System.out.println("date_f = " + start_period);
                System.out.println("date_t = " + doc_date);


            %>
            <input type="hidden" name="type_report" value="4">
            <input type="hidden" name="report_code" value="RP_VTMP_STOCK_NOT_MOVEMENT">
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
                String product_id_check = "";
                int count_product_id = 1;

                String sqlSelProduct, SqlInsert = "";
                String table_stock = "tmp_stock_not_movement";

                //String product_id = request.getParameter("product_id");
                //String pgroup_id = request.getParameter("pgroup_id");               
                // ลบข้อมูลใน Table Transaction
                String sqlDelete = " DELETE FROM " + table_stock + ";"
                        + " ALTER SEQUENCE seq_" + table_stock + " RESTART WITH 1; ";
                STateMentData = Conn.createStatement();
                STateMentData.execute(sqlDelete);

                //String s_prev_month_period = (Integer.parseInt(movement_month) > 1) ? String.format("%02d", Integer.parseInt(movement_month) - 1) : "00";                
                //System.out.println("s_prev_month_period = " + s_prev_month_period);  
                String sqlSelProductCount_Movement = " select count(runno) as num from vmproduct "
                        + " where last_movement <> '-' and month = '" + movement_month + "'"
                        + " and year = '" + movement_year + "'";
                System.out.println(sqlSelProductCount_Movement);
                int statusnum = 0;
                statusnum = objut.numRowdatabase(sqlSelProductCount_Movement);
                if (statusnum > 0 && !movement_month.equals("01")) {

                    sqlSelProduct = " select runno,product_id,name_t,iodine,pgroup_id,last_movement,day,month,year from vmproduct "
                            + " where last_movement <> '-' and month = '" + movement_month + "'"
                            + " and year = '" + movement_year + "'";

                    System.out.println("sqlSelProduct = " + sqlSelProduct);

                    rec_prod = Conn.createStatement().executeQuery(sqlSelProduct);

                    while ((rec_prod != null) && (rec_prod.next())) {

                        if (count_product_id == 1) {
                            product_id_check = "'" + rec_prod.getString("product_id") + "'";
                        } else {
                            product_id_check += ",'" + rec_prod.getString("product_id") + "'";
                        }
                        //System.out.println("Product_id = " + rec_prod.getString("product_id"));                   
                        count_product_id++;
                    }

                    System.out.println("product_id_check = " + product_id_check);

                    String sql_where = " where product_id not in (" + product_id_check + ") and to_number(month,'99') < " + movement_month
                            + " and year = '" + movement_year + "' "
                            + " and to_number((select vmproduct.month from vmproduct where  vmproduct.product_id = vt_transaction_stock_process_report.product_id),'99') < " + movement_month;

                    String sql = "SELECT pgroup_id,product_id,Sum(weight_total) as weight_total,Sum(weight_total * price_per_unit_num) as price_total,avg(price_per_unit_num) as price_per_unit_num "
                            + ",(select mp.last_movement from mproduct mp where vt_transaction_stock_process_report.product_id = mp.product_id and mp.delete_flag <> 'Y') as last_movement "
                            + ",(select mp.name_t from mproduct mp where vt_transaction_stock_process_report.product_id = mp.product_id and mp.delete_flag <> 'Y') as prod_name "
                            + " FROM vt_transaction_stock_process_report "
                            + sql_where
                            + " and pgroup_id <> 'RAW'"
                            + " GROUP BY pgroup_id,product_id "
                            + " HAVING SUM(weight_total) > 0  "
                            + " ORDER BY pgroup_id,product_id ";

                    System.out.println("sql = " + sql);
                    rec_prod = null;
                    rec_prod = Conn.createStatement().executeQuery(sql);

                    while ((rec_prod != null) && (rec_prod.next())) {

                        /*                    
                         System.out.println("Product_id = " + rec_prod.getString("product_id")
                         + " | Product Name = " + rec_prod.getString("prod_name")
                         + " | Product Group = " + rec_prod.getString("pgroup_id")
                         + " | Weight Total = " + rec_prod.getString("weight_total")
                         + " | price/unit = " + rec_prod.getString("price_per_unit_num")
                         + " | price Total = " + rec_prod.getString("price_total"));
                         */
                        java.sql.Timestamp sqlDate = new java.sql.Timestamp(new java.util.Date().getTime());

                        SqlInsert = "INSERT INTO " + table_stock + " (product_id,pgroup_id,prod_name,weight_total,price_per_unit,total_price,last_movement,create_date,create_by,doc_date) VALUES (?,?,?,?,?,?,?,?,?,?)";

                        PreparedStatement pSTateMentt = Conn2.prepareStatement(SqlInsert);
                        pSTateMentt.setString(1, rec_prod.getString("product_id"));
                        pSTateMentt.setString(2, rec_prod.getString("pgroup_id"));
                        pSTateMentt.setString(3, rec_prod.getString("prod_name"));
                        pSTateMentt.setDouble(4, rec_prod.getDouble("weight_total"));
                        pSTateMentt.setDouble(5, rec_prod.getDouble("price_per_unit_num"));
                        pSTateMentt.setDouble(6, rec_prod.getDouble("price_total"));
                        pSTateMentt.setString(7, rec_prod.getString("last_movement"));
                        pSTateMentt.setTimestamp(8, sqlDate);
                        pSTateMentt.setString(9, username);
                        pSTateMentt.setString(10, doc_date);
                        pSTateMentt.executeUpdate();
                        //System.out.println("SqlInsert = " + SqlInsert);
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

            <!--div class="CSS_Table_Example" style="width:1200px;height:150px;"-->
            <div class="jumbotron">
                <div class="container">
                    <table border ="1"  cellpadding="0"  cellspacing="0" class="">
                        <tr>
                        <center><h1>รายงานสินค้าที่ไม่มีการเคลื่อนไหว</h1></center>                   
                        <center>
                            <h2><span class="label label-success">เดือน : <%=month_movement_name%> ปี <%=movement_year%></span></h2>
                        </center> 
                        <!--center><h2><b>เดือน : <%=movement_month%> ปี <%=movement_year%></b></h2></center-->
                        <center>   
                            <!--div class="progress progress-striped active"-->
                            <div class="progress">                                
                                <div class="progress-bar" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width:0%"></div>                                
                            </div>
                        </center>                                  
                        <center><h2>จัดเตรียมข้อมูลเสร็จสิ้น</h2></center>          
                        <center><h2>กรุณากดปุ่ม พิมพ์รายงาน</h2></center>   
                        </tr>
                        <tr>    
                        <center>                    
                            <a href="#" onClick="javascript:document.report.submit();" class="cgcButton_19">พิมพ์รายงาน</a>
                            &nbsp;&nbsp;<a href="#" onClick="javascript:window.close();" class="cgcButton_19">ปิด</a>   
                        </center>
                        </tr>       
                    </table>             
                </div>
            </div>

            <%
            } else {
            %>  
            <div class="jumbotron">
                <div class="container">                    
                    <center><h1>ไม่พบข้อมูล</h1>                                           
                        <a href="#" onClick="javascript:window.close();" class="cgcButton_19">ปิด</a>
                    </center>
                </div>
            </div>            
            <%}%>
        </form>

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


    </body>
</html>

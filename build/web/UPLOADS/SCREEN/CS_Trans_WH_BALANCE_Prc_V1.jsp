<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
        <!--link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
        <link href="../CSS/BT.css" rel="stylesheet" type="text/css"-->
        <link rel="stylesheet" href="../table.css" type="text/css"/>	        
        <link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
        <script src="//code.jquery.com/jquery-1.9.1.js"></script>
        <script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
        <link rel="stylesheet" href="/resources/demos/style.css">
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">                            

        <%@ include file="PageHeader.jsp" %>

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
            <%                date_f = request.getParameter("date_f");
                date_t = request.getParameter("date_t");
                System.out.println("date_f " + date_f);
                System.out.println("date_t " + date_t);
            %>
            <input type="hidden" name="type_report" value="4">
            <input type="hidden" name="report_code" value="RP_015_WH_BALANCE">
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
                DecimalFormat formatter = new DecimalFormat("#0.00");

                String product_id = request.getParameter("product_id");
                String pgroup_id = request.getParameter("pgroup_id");
                // **** ลบข้อมูลตาราง ความเคลื่อนไหว
                String sqlDelete = " DELETE FROM tmp_stock_3 ;"
                        + " ALTER SEQUENCE seq_tmp_stock_3 RESTART WITH 1; ";
                STateMentData = Conn.createStatement();
                STateMentData.execute(sqlDelete);

                String SQL_PERIOD = "SELECT * FROM mperiod where doc_type = 'S'";

                String start_period = "";

                String SqlSelectSTK, SqlInsertSTK = "";

                rec_periods = Conn2.createStatement().executeQuery(SQL_PERIOD);

                if (rec_periods.next()) {
                    //start_period = rec_periods.getString("start_period");
                    start_period = rec_periods.getString("start_period").substring(6, 10) + rec_periods.getString("start_period").substring(2, 6) + rec_periods.getString("start_period").substring(0, 2);
                    System.out.println("Select DB start_period : " + start_period);
                }

                String sql_where = "";

                if (!request.getParameter("date_from").equals("") && !request.getParameter("date_to").equals("") && !request.getParameter("date_from").equals(null) && !request.getParameter("date_to").equals(null)) {
                    sql_where = " WHERE to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('"
                            //+ request.getParameter("date_from") + "'),'YYYY-MM-DD') AND to_date(format_date2('"
                            + start_period + "'),'YYYY-MM-DD') AND to_date(format_date2('"
                            + request.getParameter("date_to") + "'),'YYYY-MM-DD') and pgroup_id <> 'RAW' ";
                }

                if (!sql_where.equals("") && !sql_where.equals(null)) {
                    if (!product_id.equals("") && !product_id.equals(null)) {
                        sql_where = sql_where + " and product_id = '" + product_id + "' ";
                    }
                }

                if (!sql_where.equals("") && !sql_where.equals(null)) {
                    if (!pgroup_id.equals("") && !pgroup_id.equals(null)) {
                        sql_where = sql_where + " and pgroup_id = '" + pgroup_id + "' ";
                    }
                }

                String SqlFeature = "group by product_id,pname_t,pgroup_id,pgroup_name,pcat_id,pcat_name,ptype_id,ptype_name,unit_name,weight_per_unit"
                        + " having sum(weight_total) <> 0"
                        + " order by pgroup_id desc ,product_id ";

                //System.out.println("sql_where = " + sql_where);
                SqlSelectSTK = " select product_id,pname_t,pgroup_id,pgroup_name,"
                        + " pcat_id,pcat_name,ptype_id,ptype_name,sum(weight_total) as weight_toal_group,unit_name,weight_per_unit"
                        //+ " ,avg(price_per_unit_num) as price_per_unit_num,sum(total_price_cal) as total_price_cal"
                        + " ,avg(price_per_unit_num) as price_per_unit_num "
                        + " from vt_transaction_stock_process_report "
                        + sql_where
                        + SqlFeature;

                System.out.println("SqlSelectSTK = " + SqlSelectSTK);
                STateMent = Conn.createStatement();
                ResultSet rec_wh_stock = STateMent.executeQuery(SqlSelectSTK);

                while (rec_wh_stock != null && (rec_wh_stock.next())) {

                    double price_total = rec_wh_stock.getDouble("weight_toal_group") * rec_wh_stock.getDouble("price_per_unit_num");

                    /*                    
                     System.out.println(" weight total = " + formatter.format(rec_wh_stock.getDouble("weight_toal_group"))
                     + " | price_per_unit = " + formatter.format(rec_wh_stock.getDouble("price_per_unit_num"))
                     + " |  price_total = " + formatter.format(price_total));
                     */
                    SqlInsertSTK = "INSERT INTO tmp_stock_3(pgroup_id,product_id,doc_date,data_total,price_per_unit,data_transfer,doc_type,data_r,data_w) VALUES "
                            + "('" + rec_wh_stock.getString("pgroup_id") + "','" + rec_wh_stock.getString("product_id")
                            + "','" + request.getParameter("date_to") + "','" + formatter.format(rec_wh_stock.getDouble("weight_toal_group"))
                            + "','" + formatter.format(rec_wh_stock.getDouble("price_per_unit_num")) + "','" + formatter.format(price_total)
                            + "','SUM','" + rec_wh_stock.getString("weight_per_unit") + "','0')";

                    //System.out.println("---------------------------------");
                    //System.out.println("SqlInsertSTK = " + SqlInsertSTK);
                    STateMentData = Conn.createStatement();
                    STateMentData.execute(SqlInsertSTK);
                }

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
                        <center><h1>รายงานสรุปยอดคงเหลือสินค้า</h1></center>                
                        <center><h2><span class="label label-success">วันที่ : <%=date_f%> ถึง <%=date_t%></span></h2></center> 
                        <!--center><h2>วันที่ : <%=date_f%> ถึง <%=date_t%></h2></center--> 

                        <center>   
                            <!--div class="progress progress-striped active"-->
                            <div class="progress">                                
                                <div class="progress-bar" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width:0%"></div>                                
                            </div>
                        </center>                                       

                        <center><h2>จัดเตรียมข้อมูลเสร็จสิ้น กรุณากดปุ่ม พิมพ์รายงาน</h2></center>          
                        <!--center><h2>กรุณากดปุ่ม พิมพ์รายงาน</h2></center>          
                        <center>Start : <%=ts%></center> 
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


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
<%@page import="com.cgc.Util.DateUtil"%>

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
            %>
            <input type="hidden" name="type_report" value="4">
            <input type="hidden" name="report_code" value="RP_025_C_1">
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
                DateUtil ObjDate = new DateUtil();
                DBConnect db = new DBConnect();
                Connection Conn = db.openNewConnection();
                Connection Conn2 = db.openNewConnection();
                ResultSet rec_periods = null;

                String SqlIns_Tmp_Rawmat = "";
                String SqlUpdate_Tmp_Rawmat = "";
                String sql_raw_lost_summary = "";
                String table_rawmatt_friction = "vd_carbon_friction_withdraw_detail";
                String table_rawmatt_receive = "vd_rawmatt_receive";

                Timestamp ts = (new Timestamp(new java.util.Date().getTime()));
                System.out.println("ts = " + ts);

                Statement STateMent = null;
                Statement STateMentData = null;
                //Statement STateMent_loop1 = null;
                Statement STateMent_loop2 = null;
                Statement STateMent_loop3 = null;
                Statement STateMent_loop4 = null;

                DecimalFormat formatter = new DecimalFormat("#0.00");
                Double rawmat_weight = 0.00;
                Double friction_total_weight = 0.00;
                Double total_magnet = 0.00;
                Double total_dust_weight = 0.00;
                Double total_friction_weight = 0.00;
                Double real_lost_weight = 0.00;
                Double real_lost_percent = 0.00;
                Double ratio_lost_weight = 0.00;
                Double ratio_lost_percent = 0.00;
                double total_lost_Dust_Magnet = 0.00;
                double bigbag_weight = 0.00;
                double friction_withdraw_weight = 0.00;

                //String product_id = request.getParameter("product_id");
                String pgroup_id = request.getParameter("pgroup_id");
                String ptype_id = "RAW";

                String currmonth = date_f.substring(3, 5);
                String curryear = date_f.substring(6, 10);

                String doc_date = date_f + " - " + date_t;

                String date_from = ObjDate.ThaiDate_To_ThaiDate(date_f);
                String date_to = ObjDate.ThaiDate_To_ThaiDate(date_t);

                // **** ลบข้อมูลตาราง ความเคลื่อนไหว
                String sqlDelete = " DELETE FROM tmp_mrawmat_lost_location ;"
                        + " ALTER SEQUENCE seq_tmp_mrawmat_lost_location RESTART WITH 1; "
                        + " DELETE FROM tmp_rawmat_lost_summary ;"
                        + " ALTER SEQUENCE seq_tmp_rawmat_lost_summary RESTART WITH 1; ";
                STateMentData = Conn.createStatement();
                STateMentData.execute(sqlDelete);

                String sql_where = "";

                if (!date_f.equals("") && !date_t.equals("") && !date_f.equals(null) && !date_t.equals(null)) {
                    sql_where = " WHERE to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('"
                            + date_from + "'),'YYYY-MM-DD') AND to_date(format_date2('"
                            + date_to + "'),'YYYY-MM-DD') and ptype_id = '" + ptype_id + "' ";
                    //+ " and location_id not like '%B%'" ;
                }

                String sql_product_id = " Select distinct(location_id) from " + table_rawmatt_friction + sql_where + " Order By location_id";

                System.out.println("sql_product_id  = " + sql_product_id);

                STateMent = Conn.createStatement();
                ResultSet rec_raw_location = STateMent.executeQuery(sql_product_id);

                while (rec_raw_location != null && (rec_raw_location.next())) {

                    SqlIns_Tmp_Rawmat = "INSERT INTO tmp_mrawmat_lost_location(location_id,period_month,create_date,create_by,period_year,remark) VALUES "
                            + "('" + rec_raw_location.getString("location_id") + "','" + currmonth + "'"
                            + ",'" + ts + "','System','" + curryear + "','" + request.getParameter("date_to") + "')";

                    //System.out.println("location_id  = " + rec_raw_location.getString("location_id") + " | " + request.getParameter("date_to") );
                    STateMentData = Conn.createStatement();
                    STateMentData.execute(SqlIns_Tmp_Rawmat);

                }

                String sql_friction = " Select friction_house,location_id,ptype_id,product_id"
                        + ",COALESCE(sum(to_number(friction_dust_weight,'9999999999.99')),0) as sum_friction_dust_weight"
                        + ",COALESCE(sum(to_number(pan_dust_weight,'9999999999.99')),0) as sum_pan_dust_weight"
                        + ",COALESCE(sum(to_number(sucker_dust_weight,'9999999999.99')),0) as sum_sucker_dust_weight"
                        + ",COALESCE(sum(to_number(magnet1,'9999999999.99')),0) as sum_magnet1"
                        + ",COALESCE(sum(to_number(magnet2,'9999999999.99')),0) as sum_magnet2"
                        + ",COALESCE(sum(to_number(magnet1,'9999999999.99')),0) + COALESCE(sum(to_number(magnet2,'9999999999.99')),0) as total_magnet"
                        + ",COALESCE(sum(to_number(laps_total,'9999999999.99')),0) as laps_total_weight "
                        + ",(COALESCE(sum(to_number(friction_dust_weight,'9999999999.99')),0) + COALESCE(sum(to_number(pan_dust_weight,'9999999999.99')),0) + COALESCE(sum(to_number(sucker_dust_weight,'9999999999.99')),0)) as total_dust_weight"
                        + " from " + table_rawmatt_friction
                        + sql_where
                        + " Group By friction_house,location_id,ptype_id,product_id"
                        + " Order By friction_house,location_id,ptype_id,product_id";

                System.out.println("sql_friction  = " + sql_friction);
                STateMent = Conn.createStatement();
                ResultSet rec_raw_friction = STateMent.executeQuery(sql_friction);

                while (rec_raw_friction != null && (rec_raw_friction.next())) {

                    // น้ำหนักถ่านที่สีได้
                    friction_total_weight = rec_raw_friction.getDouble("laps_total_weight") - (rec_raw_friction.getDouble("total_dust_weight") + rec_raw_friction.getDouble("total_magnet"));

                    SqlIns_Tmp_Rawmat = "INSERT INTO tmp_rawmat_lost_summary(pgroup_id,doc_date,product_id,doc_type,location_id,friction_dust_weight,pan_dust_weight,sucker_dust_weight"
                            + ",magnet1,magnet2,total_magnet,total_friction_weight,total_dust_weight,friction_total_weight"
                            + ")"
                            + " VALUES "
                            + "('" + pgroup_id + "'"
                            + ",'" + doc_date + "'"
                            + ",'" + rec_raw_friction.getString("product_id") + "'"
                            + ",'" + rec_raw_friction.getString("friction_house") + "'"
                            + ",'" + rec_raw_friction.getString("location_id") + "'"
                            + "," + rec_raw_friction.getString("sum_friction_dust_weight")
                            + "," + rec_raw_friction.getString("sum_pan_dust_weight")
                            + "," + rec_raw_friction.getString("sum_sucker_dust_weight")
                            + "," + rec_raw_friction.getString("sum_magnet1")
                            + "," + rec_raw_friction.getString("sum_magnet2")
                            + "," + rec_raw_friction.getString("total_magnet")
                            + "," + rec_raw_friction.getString("laps_total_weight")
                            + "," + rec_raw_friction.getString("total_dust_weight")
                            + "," + friction_total_weight
                            + ")";

                    //System.out.println("SqlIns_Tmp_Rawmat  = " + SqlIns_Tmp_Rawmat);
                    STateMentData = Conn.createStatement();
                    STateMentData.execute(SqlIns_Tmp_Rawmat);

                }

                String sql_raw_receive = "";

                String sql_rawmat_lost_location = " Select location_id from tmp_mrawmat_lost_location ";

                STateMent = Conn.createStatement();
                ResultSet rec_raw_lost_location = STateMent.executeQuery(sql_rawmat_lost_location);

                while (rec_raw_lost_location != null && (rec_raw_lost_location.next())) {

                    sql_raw_receive = " Select position_no,pgroup_id,ptype_id,product_id "
                            + ",COALESCE(sum(to_number(carbon_net,'9999999999.99')),0) as rawmat_weight "
                            + " from " + table_rawmatt_receive
                            + " where position_no = '" + rec_raw_lost_location.getString("location_id") + "'"
                            + " Group By position_no,pgroup_id,ptype_id,product_id";

                    //System.out.println("sql_raw_receive = " + sql_raw_receive);
                    STateMent_loop2 = Conn2.createStatement();
                    ResultSet rec_raw_receive = STateMent_loop2.executeQuery(sql_raw_receive);

                    while (rec_raw_receive != null && (rec_raw_receive.next())) {

                        //System.out.println("position_no = " + rec_raw_receive.getString("position_no") + " | " + rec_raw_receive.getString("rawmat_weight"));
                        //System.out.println("SqlIns_Tmp_Rawmat  = " + SqlIns_Tmp_Rawmat);
                        sql_raw_lost_summary = " select * from tmp_rawmat_lost_summary "
                                + " where location_id = '" + rec_raw_receive.getString("position_no") + "'"
                                + " and product_id = '" + rec_raw_receive.getString("product_id") + "'";
                        STateMent_loop3 = Conn.createStatement();
                        ResultSet rec_raw_tmp_rawmat_lost_summary = STateMent_loop3.executeQuery(sql_raw_lost_summary);

                        friction_total_weight = 0.00;
                        total_dust_weight = 0.00;
                        total_magnet = 0.00;
                        total_lost_Dust_Magnet = 0.00;
                        total_friction_weight = 0.00;

                        while (rec_raw_tmp_rawmat_lost_summary != null && (rec_raw_tmp_rawmat_lost_summary.next())) {

                            System.out.println("-------------------------------------------------------------------------");
                            System.out.println("friction_total_weight = " + rec_raw_tmp_rawmat_lost_summary.getDouble("friction_total_weight"));
                            System.out.println("total_dust_weight = " + rec_raw_tmp_rawmat_lost_summary.getDouble("total_dust_weight"));
                            System.out.println("total_magnet = " + rec_raw_tmp_rawmat_lost_summary.getDouble("total_magnet"));
                            System.out.println("total_friction_weight = " + rec_raw_tmp_rawmat_lost_summary.getDouble("total_friction_weight"));

                            friction_total_weight = rec_raw_tmp_rawmat_lost_summary.getDouble("friction_total_weight");
                            total_dust_weight = rec_raw_tmp_rawmat_lost_summary.getDouble("total_dust_weight");
                            total_magnet = rec_raw_tmp_rawmat_lost_summary.getDouble("total_magnet");
                            total_lost_Dust_Magnet = total_dust_weight + total_magnet;
                            total_friction_weight = rec_raw_tmp_rawmat_lost_summary.getDouble("total_friction_weight");

                        }

                        String sql_friction_withdraw = " Select location_id,pgroup_id,product_id "
                                + ",COALESCE(sum(to_number(weight,'9999999999.99')),0) as friction_withdraw_weight "
                                + " from vd_rawmatt_withdraw_detail "
                                + " where location_id = '" + rec_raw_lost_location.getString("location_id") + "'"
                                + " Group By location_id,pgroup_id,product_id";

                        System.out.println("sql_friction_withdraw = " + sql_friction_withdraw);

                        STateMent_loop4 = Conn2.createStatement();
                        ResultSet rec_friction_withdraw = STateMent_loop4.executeQuery(sql_friction_withdraw);

                        while (rec_friction_withdraw != null && (rec_friction_withdraw.next())) {

                            friction_withdraw_weight = rec_friction_withdraw.getDouble("friction_withdraw_weight");
                            System.out.print("friction_withdraw_weight = " + friction_withdraw_weight);
                        }

                        String sql_bigbag_receive = " Select location_id2,pgroup_id,product_id "
                                + ",COALESCE(sum(to_number(total_weight,'9999999999.99')),0) as bigbag_weight "
                                + " from vd_carbon_friction_receive_detail_2 "
                                + " where location_id2 = '" + rec_raw_lost_location.getString("location_id") + "'"
                                + " Group By location_id2,pgroup_id,product_id";

                        System.out.println("sql_bigbag_receive = " + sql_bigbag_receive);

                        STateMent_loop4 = Conn2.createStatement();
                        ResultSet rec_bigbag_receive = STateMent_loop4.executeQuery(sql_bigbag_receive);

                        bigbag_weight = 0.00;

                        while (rec_bigbag_receive != null && (rec_bigbag_receive.next())) {

                            System.out.print("Location ID = " + rec_raw_lost_location.getString("location_id") + " |  bigbag_weight = " + rec_bigbag_receive.getDouble("bigbag_weight"));
                            bigbag_weight = rec_bigbag_receive.getDouble("bigbag_weight");
                        }

                        rawmat_weight = rec_raw_receive.getDouble("rawmat_weight");

                        real_lost_weight = rawmat_weight - (bigbag_weight + total_lost_Dust_Magnet);
                        real_lost_percent = ((rawmat_weight - (bigbag_weight + total_lost_Dust_Magnet)) * 100) / rawmat_weight;

                        //ratio_lost_weight = total_friction_weight - total_dust_weight - total_magnet - rawmat_weight;
                        //ratio_lost_percent = ((total_friction_weight - total_dust_weight - total_magnet - rawmat_weight) * 100) / rawmat_weight;
                        ratio_lost_weight = 0.00;
                        ratio_lost_percent = 0.00;

                        System.out.println("rawmat_weight = " + rawmat_weight + " | " + real_lost_percent);

                        System.out.println("-------------------------------------------------------------------------");

                        SqlUpdate_Tmp_Rawmat = " Update tmp_rawmat_lost_summary set rawmat_weight = " + rawmat_weight
                                + ",total_friction_weight = " + formatter.format(bigbag_weight)
                                + ",friction_total_weight = " + formatter.format(friction_withdraw_weight)
                                + ",real_lost_weight = " + formatter.format(real_lost_weight)
                                + ",real_lost_percent = " + formatter.format(real_lost_percent)
                                + ",ratio_lost_weight = " + formatter.format(ratio_lost_weight)
                                + ",ratio_lost_percent = " + formatter.format(ratio_lost_percent)
                                + " where location_id = '" + rec_raw_receive.getString("position_no") + "'"
                                + " and product_id = '" + rec_raw_receive.getString("product_id") + "'";

                        STateMentData = Conn.createStatement();
                        STateMentData.execute(SqlUpdate_Tmp_Rawmat);

                    }

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
                        <center><h2>รายงานสรุปเปอร์เซ็นต์สูญเสียวัตถุดิบ</h2></center>
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


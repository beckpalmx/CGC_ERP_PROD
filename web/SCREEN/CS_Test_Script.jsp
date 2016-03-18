<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.Util.HeaderScreen_Process"%>
<%@page import="com.cgc.Util.HeaderScreen_Report"%>
<%@page import="com.cgc.bean.DataBean_Screen_Report"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.bean.DataBean_Screen_Process"%>
<%@page import="com.cgc.Util.Serchselect" %>
<%@page import="com.cgc.DB.DBConnect"%>
<%@page import="java.text.DecimalFormat" %>
<%@page import="java.sql.Date"%>

<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.*" %>


<%!    String date_f, date_t, job_id, path, lookup, doc_eff_date, doc_no;
%>


<html>
    <head>

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

        <title>CGC  รายงานการเคลื่อนไหว</title>        
    </head>
    <body>
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <%
                date_f = request.getParameter("date_f");
                date_t = request.getParameter("date_t");
                job_id = request.getParameter("job_id");
            %>     

            <%
                UtiDatabase objuti = new UtiDatabase();
                DBConnect db = new DBConnect();
                Connection Conn = db.openNewConnection();
                Connection Conn2 = db.openNewConnection();
                //ResultSet rec_periods = null;

                UserBean userbean = (UserBean) session.getAttribute("user");
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_036");
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objr_p = r_p.Fn_Report(objr_p, "S807");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
            %>

            <input type="hidden" name="type_report" value="2">
            <input type="hidden" name="report_code" value="RP_407">
            <input type="hidden" name="price_year" value="">
            <input type="hidden" name="pgroup_id" value="-">
            <input type="hidden" name="product_id" value="-">
            <input type="hidden" name="warehouse_id" value="-">
            <input type="hidden" name="branch" value="-">
            <input type="hidden" name="location_id" value="-">
            <input type="hidden" name="friction_house" value="-">                          
            <input type="hidden" id="date_form" name="date_form" value="<%=date_f%>">
            <input type="hidden" id="date_to" name="date_to" value="<%=date_t%>">            
            <input type="hidden" id="job_id" name="job_id" value="<%=job_id%>">     
            <input type="hidden" id="doc_id" name="doc_id" value="<%=job_id%>">  
            <input type="hidden" id="lookup" name="lookup" value="<%=lookup%>">
            <input type="hidden" id="doc_eff_date" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" id="doc_no" name="doc_no" value="<%=doc_no%>">       

            <%
                UtiDatabase uti = new UtiDatabase();
                Timestamp ts = (new Timestamp(new java.util.Date().getTime()));
                System.out.println("ts = " + ts);

                Statement STateMent = null;
                Statement STateMentData = null;
                Statement STateMentData_Update = null;
                Statement STateMent_loop1 = null;
                Statement STateMent_loop2 = null;

                DecimalFormat formatter = new DecimalFormat("#0.00");

                String product_id = request.getParameter("product_id");
                String pgroup_id = request.getParameter("pgroup_id");
                String ptype_id = request.getParameter("ptype_id");
                String SQL_Product_withdraw = "";
                String SQL_Product_result = "";
                String SQL_Product_cond = "";
                String SQL_Product_cond_more = "";
                String SQL_Search_Result = "";

                String SqlInsert_Process = "";
                String SqlUpdate_Process = "";
                String SQL_Res1 = "";
                ResultSet rs_header = null;
                ResultSet rs_detail = null;
                ResultSet rs_withdraw = null;
                ResultSet rs_result = null;

                String Size_By_Job = "";
                SQL_Product_cond = " where job_id = '" + job_id + "'";
                int product_job_count = 0;

                String SQL_Main_Menu = " Select * from " + "mmenu_main" + " where delete_flag <> 'Y' Order By main_menu_id";
                String SQL_Sub_Menu = "";
                rs_header = Conn.createStatement().executeQuery(SQL_Main_Menu);
                while (rs_header.next()) {

                    System.out.println("Main Menu = " + rs_header.getString("main_menu_id") + " | " + rs_header.getString("name_t"));

                    SQL_Sub_Menu = " Select * from " + "mmenu_sub "
                            + " where delete_flag <> 'Y' "
                            + " and mmenu_sub.main_menu_id = '" + rs_header.getString("main_menu_id") + "'"
                            + " Order By main_menu_id,sub_menu_id";

                    rs_detail = Conn.createStatement().executeQuery(SQL_Sub_Menu);

                    while (rs_detail.next()) {

                        System.out.println("Sub Menu = " + rs_detail.getString("Sub_menu_id") + " | " + rs_detail.getString("name_t"));

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
            <div class="container">
                <div class="panel panel-primary">
                    <!-- Default panel contents -->
                    <div class="panel-heading"> <span class="glyphicon glyphicon-list" style="color:white"></span>&nbsp;<center><h2>รายงาน</h2></center></div>
                    <div class="panel-footer">
                        <p>
                        <center>                               
                            <div class="progress">                                
                                <div class="progress-bar" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width:0%"></div>                                
                            </div>
                        </center>                        
                        </p>
                    </div>

                    <!-- Table -->
                    <table class="table">
                        
                    </table>
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


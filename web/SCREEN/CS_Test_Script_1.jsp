<!DOCTYPE html>

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


<%!    String date_f, date_t, job_id, path, lookup, doc_eff_date, doc_no, main_menu_id, main_menu_name;
%>

<head>
    <%@ include file="PageHeader.jsp" %>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Bare - Start Bootstrap Template</title>

    <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
    <script src="../JS/jquery/jquery-2.1.4.js"></script>
    <script src="../JS/bootstrap/js/bootstrap.min.js"></script>          

    <script src="../JS/bootstrap_select/js/bootstrap-select.js"></script>        
    <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.css">        
    <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-select.min.css">        
    <link rel="stylesheet" href="../JS/bootstrap_select/css/bootstrap-theme.min.css">    

    <!-- Custom CSS -->
    <style>
        body {
            padding-top: 70px;
            /* Required padding for .navbar-fixed-top. Remove if using .navbar-static-top. Change if height of navigation changes. */
        }
    </style>
    
</head>

<body id="page-top" data-spy="scroll" data-target=".navbar-fixed-top">
    <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
        <%            date_f = request.getParameter("date_f");
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

                //System.out.println("Main Menu = " + rs_header.getString("main_menu_id") + " | " + rs_header.getString("name_t"));
                SQL_Sub_Menu = " Select * from " + "mmenu_sub "
                        + " where delete_flag <> 'Y' "
                        + " and mmenu_sub.main_menu_id = '" + rs_header.getString("main_menu_id") + "'"
                        + " Order By main_menu_id,sub_menu_id";

                rs_detail = Conn.createStatement().executeQuery(SQL_Sub_Menu);

                while (rs_detail.next()) {

                    //System.out.println("Sub Menu = " + rs_detail.getString("Sub_menu_id") + " | " + rs_detail.getString("name_t"));
                }

            }

        %>



        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
            <div class="container">
                <div class="navbar-header page-scroll">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">C.Gigantic Carbon Co.,Ltd. [CGC ERP]</a>
                </div>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">

                        <%                            rs_header = Conn.createStatement().executeQuery(SQL_Main_Menu);
                            while (rs_header.next()) {

                                main_menu_name = rs_header.getString("name_t");
                                System.out.println("1 Main Menu = " + rs_header.getString("main_menu_id") + " | " + rs_header.getString("name_t"));
                                System.out.println("2 Main Menu = " + rs_header.getString("main_menu_id") + " | " + main_menu_name);
                        %>                        
                        <li>
                            <a href="#"><%=main_menu_name%></a>
                        </li>                        
                        <%
                            }
                        %>



                        <!--li>
                            <a href="#">Services</a>
                        </li>
                        <li>
                            <a href="#">Contact</a>
                        </li-->
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container -->
        </nav>

        <!-- Page Content -->
        <div class="container">

            <div class="row">
                <div class="col-lg-12 text-center">
                    <h1>CGC ERP</h1>
                    <p class="lead">With Bootstrap Style Framework</p>
                    <ul class="list-unstyled">
                        <li>
                        <center>                               
                            <div class="progress">                                
                                <div class="progress-bar" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width:0%"></div>                                
                            </div>
                        </center>
                        </li>
                        <li>jQuery</li>
                    </ul>
                </div>
            </div>
            <!-- /.row -->

        </div>
        <!-- /.container -->
    </form>
</body>

</html>

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
        <!--meta http-equiv="Content-Type" content="text/html; charset=TIS-620"-->
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
                Double total_withdraw = 0.00;
                Double percent_receive = 0.00;
                Double grand_total_receive = 0.00;
                Double grand_percent_receive = 0.00;

                String product_id = request.getParameter("product_id");
                String pgroup_id = request.getParameter("pgroup_id");
                String ptype_id = request.getParameter("ptype_id");
                String SQL_Product_withdraw = "";
                String SQL_Product_result = "";
                String SQL_Product_cond = "";
                String SQL_Product_cond_more = "";
                String SQL_Search_Result = "";
                String table_product_header = "vd_product_receive_header";
                String table_product_withdraw = "vd_product_receive_detail";
                String table_product_result = "vd_product_receive_detail_prod";
                String Table_Job_order_Header = "vd_job_order_header";
                String Table_d_receive_product_detail = "d_receive_product_detail";

                String SqlInsert_Process = "";
                String SqlUpdate_Process = "";
                String SQL_Res1 = "";
                ResultSet rs_header = null;
                ResultSet rs_withdraw = null;
                ResultSet rs_result = null;

                String job_type_id_product = "('001','002','004','005','006','008','010')";
                String Size_By_Job = "";
                SQL_Product_cond = " where job_id = '" + job_id + "'";
                int product_job_count = 0;

                product_job_count = uti.numRowdatabase("Select Count(job_id) As num from  d_product_receive_header" + SQL_Product_cond);
                System.out.println("product_job_count = " + product_job_count);
                if (product_job_count == 0) {
                    System.out.println("No Data");
                } else {

//************  Start ใบสรุปการผลิต   ************                              
                    // **** ลบข้อมูลตาราง ความเคลื่อนไหว
                    String sqlDelete = " DELETE FROM d_receive_product_detail where job_id = '" + job_id + "';"
                            + " DELETE FROM d_receive_product_withdraw_header where job_id = '" + job_id + "';"
                            + " DELETE FROM d_receive_product_detail_sum where job_id = '" + job_id + "';";

                    STateMentData = Conn.createStatement();
                    STateMentData.execute(sqlDelete);

                    SQL_Res1 = " Select * from " + Table_Job_order_Header + " where doc_id = '" + job_id + "'";
                    rs_header = Conn.createStatement().executeQuery(SQL_Res1);
                    while (rs_header.next()) {
                        Size_By_Job = rs_header.getString("size_name");
                        System.out.println("Size_By_Job = " + Size_By_Job);
                    }

                    System.out.println("------------------------------------------------------------------------------------------");
                    //หาจำนวนถ่านเบิกรอบแรก
                    SQL_Product_withdraw = " select job_type_id,process_order,ctc_i2,size,sum(to_number(qty,'999999.99')) as withdraw_weight "
                            + " from " + table_product_withdraw + SQL_Product_cond
                            + " and to_number(process_order,'99') <=1 "
                            + " group by job_type_id,process_order,size,ctc_i2"
                            + " order by size,ctc_i2,job_type_id,process_order";

                    rs_withdraw = Conn.createStatement().executeQuery(SQL_Product_withdraw);
                    while (rs_withdraw.next()) {
                        System.out.println("Withdraw Loop 1 size = " + rs_withdraw.getString("size") + " ctc_i2 = " + rs_withdraw.getString("ctc_i2") + " | process_order = "
                                + rs_withdraw.getString("process_order") + " | " + rs_withdraw.getString("ctc_i2")
                                + " | " + rs_withdraw.getDouble("withdraw_weight"));

                        total_withdraw = total_withdraw + rs_withdraw.getDouble("withdraw_weight");

                        SqlInsert_Process = "INSERT INTO " + "d_receive_product_withdraw_header"
                                + " (job_id,size,iodine,weight,doc_id,doc_type) VALUES "
                                + "('" + job_id
                                + "','" + rs_withdraw.getString("size")
                                + "','" + rs_withdraw.getString("ctc_i2")
                                + "'," + rs_withdraw.getDouble("withdraw_weight")
                                + ",'" + job_id + "#" + rs_withdraw.getString("size") + "@" + rs_withdraw.getString("ctc_i2")
                                + "','" + "1"
                                + "')";

                        // System.out.println("SqlInsert_Process = " + SqlInsert_Process);
                        STateMentData = Conn.createStatement();
                        STateMentData.execute(SqlInsert_Process);

                    }

                    System.out.println("------------------------------------------------------------------------------------------");
                    //หาจำนวนถ่านได้รอบแรก
                    SQL_Product_result = " select job_type_id,process_order,size,sum(to_number(weight,'999999.99')) as result_weight "
                            + " from " + table_product_result + SQL_Product_cond
                            + " and to_number(process_order,'99') <=1 "
                            + " group by job_type_id,process_order,size"
                            + " order by size,job_type_id,process_order";

                    rs_result = Conn.createStatement().executeQuery(SQL_Product_result);
                    while (rs_result.next()) {
                        System.out.println("Result Loop 1 size = " + rs_result.getString("size") + " | process_order = "
                                + rs_result.getString("process_order") + " | "
                                + rs_result.getDouble("result_weight"));

                        SqlInsert_Process = "INSERT INTO " + Table_d_receive_product_detail + " (job_id,job_type_id,size,total_receive,percent_receive) VALUES "
                                + "('" + job_id + "','" + rs_result.getString("job_type_id")
                                + "','" + rs_result.getString("size")
                                + "'," + formatter.format(rs_result.getDouble("result_weight"))
                                + "," + formatter.format(percent_receive) + ")";

                        STateMentData = Conn.createStatement();
                        STateMentData.execute(SqlInsert_Process);

                    }

                    System.out.println("------------------------------------------------------------------------------------------");

                    //หาจำนวนถ่านได้ที่ผ่านการแก้ และ นำไปบวกกับถ่านได้ก่อนหน้า
                    SQL_Product_result = " select job_type_id,process_order,size,sum(to_number(weight,'999999.99')) as result_weight "
                            + " from " + table_product_result + SQL_Product_cond
                            + " and to_number(process_order,'99') >=2 "
                            + " group by job_type_id,process_order,size"
                            + " order by size,job_type_id,process_order";

                    rs_result = Conn.createStatement().executeQuery(SQL_Product_result);
                    while (rs_result.next()) {
                        System.out.println("Result Loop 2 size = " + rs_result.getString("size") + " | process_order = "
                                + rs_result.getString("process_order") + " | "
                                + rs_result.getDouble("result_weight"));

                        SQL_Search_Result = " select count(*) As num from " + Table_d_receive_product_detail + SQL_Product_cond;
                        //+ " and size = '" + rs_result.getString("size") + "'"
                        //+ " and job_type_id = '" + rs_result.getString("job_type_id") + "'";

                        System.out.println("SQL_Search_Result = " + SQL_Search_Result);

                        int statusnum = objuti.numRowdatabase(SQL_Search_Result);

                        if (statusnum >= 1 && !rs_result.getString("size").equals(Size_By_Job)) {

                            SqlInsert_Process = "INSERT INTO " + Table_d_receive_product_detail + " (job_id,job_type_id,size,total_receive,percent_receive) VALUES "
                                    + "('" + job_id + "','" + rs_result.getString("job_type_id")
                                    + "','" + rs_result.getString("size")
                                    + "'," + formatter.format(rs_result.getDouble("result_weight"))
                                    + "," + formatter.format(percent_receive) + ")";

                            System.out.println("SqlInsert_Process = " + SqlInsert_Process);

                            STateMentData = Conn.createStatement();
                            STateMentData.execute(SqlInsert_Process);

                        } else if (statusnum >= 1 && rs_result.getString("size").equals(Size_By_Job)) {
                            System.out.println("Result Loop 2_1 size = " + rs_result.getString("size") + " | process_order = "
                                    + rs_result.getString("process_order") + " | "
                                    + rs_result.getDouble("result_weight"));

                            SqlUpdate_Process = " update " + Table_d_receive_product_detail
                                    + " set total_receive = (total_receive + " + rs_result.getDouble("result_weight") + ")"
                                    + SQL_Product_cond
                                    //+ " and job_type_id = '" + rs_result.getString("job_type_id") + "'"
                                    + " and size = '" + rs_result.getString("size") + "'"
                                    + "";
                            System.out.println("SqlUpdate_Process = " + SqlUpdate_Process);

                            STateMentData_Update = Conn.createStatement();
                            STateMentData_Update.execute(SqlUpdate_Process);

                        }

                    }

                    System.out.println("------------------------------------------------------------------------------------------");

                    //หาการเบิกถ่านที่ไม่ผ่านมาแก้ และ นำไปหักออกจากถ่านได้
                    SQL_Product_withdraw = " select job_type_id,process_order,ctc_i2,size,sum(to_number(qty,'999999.99')) as withdraw_weight "
                            + " from " + table_product_withdraw + SQL_Product_cond
                            + " and to_number(process_order,'99') >=2 "
                            + " group by job_type_id,process_order,size,ctc_i2"
                            + " order by size,ctc_i2,job_type_id,process_order";

                    rs_withdraw = Conn.createStatement().executeQuery(SQL_Product_withdraw);
                    while (rs_withdraw.next()) {
                        System.out.println("Withdraw Loop 2 size = " + rs_withdraw.getString("size") + " ctc_i2 = " + rs_withdraw.getString("ctc_i2") + " | process_order = "
                                + rs_withdraw.getString("process_order") + " | " + rs_withdraw.getString("ctc_i2")
                                + " | " + rs_withdraw.getDouble("withdraw_weight"));

                        SQL_Search_Result = " select count(*) As num from " + Table_d_receive_product_detail + SQL_Product_cond;
                        //+ " and size = '" + rs_result.getString("size") + "'"
                        //+ " and job_type_id = '" + rs_result.getString("job_type_id") + "'";

                        System.out.println("SQL_Search_Result = " + SQL_Search_Result);

                        int statusnum = objuti.numRowdatabase(SQL_Search_Result);

                        if (statusnum >= 1 && rs_withdraw.getString("size").equals(Size_By_Job)) {

                            SqlUpdate_Process = " update " + Table_d_receive_product_detail
                                    + " set total_receive = (total_receive - " + rs_withdraw.getDouble("withdraw_weight") + ")"
                                    + SQL_Product_cond
                                    + " and size = '" + rs_withdraw.getString("size") + "'"
                                    + "";
                            System.out.println("SqlUpdate_Process = " + SqlUpdate_Process);

                            STateMentData_Update = Conn.createStatement();
                            STateMentData_Update.execute(SqlUpdate_Process);

                        }
                    }

                    System.out.println("total_withdraw = " + total_withdraw);

                    Double percent_total_lost = 0.00;

                    SQL_Res1 = " Select size,sum(total_receive) as total_receive from " + Table_d_receive_product_detail + SQL_Product_cond
                            + " Group By size ";
                    rs_result = Conn.createStatement().executeQuery(SQL_Res1);
                    while (rs_result.next()) {

                        grand_total_receive = grand_total_receive + rs_result.getDouble("total_receive");
                        percent_receive = (rs_result.getDouble("total_receive") * 100) / total_withdraw;
                        grand_percent_receive = grand_percent_receive + percent_receive;

                        System.out.println("XXX size = " + rs_result.getString("size") + " | "
                                + rs_result.getDouble("total_receive") + " | " + percent_receive + " | " + grand_total_receive);

                        SqlUpdate_Process = " update " + Table_d_receive_product_detail
                                + " set percent_receive = 0.00"
                                + " , total_withdraw = " + formatter.format(total_withdraw)
                                + SQL_Product_cond
                                + " and size = '" + rs_result.getString("size") + "'"
                                + "";
                        System.out.println("SqlUpdate_Process = " + SqlUpdate_Process);

                        STateMentData_Update = Conn.createStatement();
                        STateMentData_Update.execute(SqlUpdate_Process);

                    }

                    Double total_lost = grand_total_receive - total_withdraw;

                    if (total_withdraw == 0) {
                        percent_total_lost = 0.00;
                    } else {
                        percent_total_lost = (total_lost * 100) / total_withdraw;
                    }

                    System.out.println("total_lost = " + formatter.format(total_lost) + " | percent_total_lost = " + formatter.format(percent_total_lost));
                    System.out.println("Loop XPO grand_percent_receive = " + formatter.format(grand_percent_receive));
                    String Value_Insert = "";
                    for (int loop = 1; loop <= 2; loop++) {

                        if (loop == 1) {
                            Value_Insert = "," + formatter.format(total_withdraw) + "," + formatter.format(total_lost) + "," + formatter.format(percent_total_lost);
                        } else {
                            Value_Insert = "," + formatter.format(total_withdraw) + "," + formatter.format(grand_total_receive) + "," + formatter.format(grand_percent_receive);
                        }

                        SqlInsert_Process = " insert into d_receive_product_detail_sum (job_id,line_no,total_withdraw,total_receive,percent_receive) values "
                                + "('" + job_id + "','" + loop + "'"
                                + Value_Insert
                                + ")";

                        STateMentData_Update = Conn.createStatement();
                        STateMentData_Update.execute(SqlInsert_Process);

                    }

//************  End ใบสรุปการผลิต   ************              
                    System.out.println("------------------------------------------------------------------------------------------");

//************                  
                    String SQL_Header = " select concat(mashed_machine,pan,ball_mill,pill_flat,mag,job_edit,wash,roast,roast_edit) as machine_desc , month , year from "
                            + table_product_header + SQL_Product_cond
                            + " group by concat(mashed_machine,pan,ball_mill,pill_flat,mag,job_edit,wash,roast,roast_edit),month,year ";

                    System.out.println("SQL_Header = " + SQL_Header);

                    rs_header = Conn.createStatement().executeQuery(SQL_Header);
                    while (rs_header.next()) {
                        System.out.println("machine_desc = " + rs_header.getString("machine_desc") + " | " + rs_header.getString("month") + " | " + rs_header.getString("year"));
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
                        <center>
                            <h2>รายงานสรุปการผลิต(ตามใบแจ้งการผลิต)</h2>
                            <h2><span class="label label-success">เลขที่ : <%=job_id%></span></h2>
                        </center>                        
                        <!--center><h2>วันที่ : <%=date_f%> ถึง <%=date_t%></h2></center--> 
                        <%
                            if (product_job_count == 0) {
                        %>     
                        <center><h2><font color="red">ไม่พบข้อมูลการผลิต ตามใบแจ้งการผลิต</font></h2></center>          
                                <%
                                } else {
                                %>
                        <center><h2>จัดเตรียมข้อมูลเสร็จสิ้น</h2></center>          
                        <center><h2>กรุณากดปุ่ม พิมพ์รายงาน</h2></center>          
                            <%
                                }
                            %>
                        <center>   
                            <div class="progress">                                
                                <div class="progress-bar" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width:0%"></div>                                
                            </div>
                        </center>                           

                    </table>      

                    <div class="CSS_Table_Example" style="width:1200px;height:150px;">    
                        <center>
                            <%
                                if (product_job_count >= 1) {
                            %>  
                            <a href="#" onClick="javascript:document.report.submit();" class="cgcButton_19">พิมพ์รายงาน</a>
                            <%}%>
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


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
<%@page import="java.util.ArrayList"%>

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
        <meta http-equiv="Content-Type" content="text/html; charset=TIS-620">     
        <script language="javascript" src="../JS/myAjaxFramework.js"></script>
        <link rel="stylesheet" href="../table.css" type="text/css"/>	                
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css"> <link href="../CSS/component.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="../JS/bootstrap/css/bootstrap-theme.min.css">
        <script src="../JS/jquery/jquery-2.1.4.js"></script>
        <script src="../JS/bootstrap/js/bootstrap.min.js"></script>    



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
                ResultSet rec_periods = null;

                UserBean userbean = (UserBean) session.getAttribute("user");
                DataBean_Screen_Process objs_p = new DataBean_Screen_Process();
                HeaderScreen_Process h_p = new HeaderScreen_Process();
                objs_p = h_p.selectheaderscreen_process(objs_p, "CS_Trans_Production_Track_Scr_V1");
                // _______________________________________________________________report
                DataBean_Screen_Report objr_p = new DataBean_Screen_Report();
                HeaderScreen_Report r_p = new HeaderScreen_Report();
                objr_p = r_p.Fn_Report(objr_p, "SB15");
                path = objr_p.getPath();
                lookup = objr_p.getLookup();
                doc_eff_date = objr_p.getDoc_eff_date();
                doc_no = objr_p.getDoc_no();
            %>

            <input type="hidden" id="doc_id" name="doc_id" value=""/>
            <input type="hidden" id="type_report" name="type_report" value="2">
            <input type="hidden" id="report_code" name="report_code" value="">
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
            <input type="hidden" id="lookup" name="lookup" value="<%=lookup%>">
            <input type="hidden" id="doc_eff_date" name="doc_eff_date" value="<%=doc_eff_date%>">
            <input type="hidden" id="doc_no" name="doc_no" value="<%=doc_no%>">       

            <%

                Timestamp ts = (new Timestamp(new java.util.Date().getTime()));
                System.out.println("ts = " + ts);

                Statement STateMent = null;
                Statement STateMentData = null;
                Statement STateMentData_Update = null;

                DecimalFormat formatter = new DecimalFormat("#0.00");

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
                ResultSet rs_withdraw_find = null;

                String job_type_id_product = "('001','002','004','005','006','008','010')";

                String Size_By_Job = "";
                String Iodine_By_Job = "";
                String Weight_By_Job = "";

                SQL_Product_cond = " where job_id = '" + job_id + "'";

                ArrayList<String> myDoc_ID_List = new ArrayList<String>();

            %>

            <%//**** Start สร้างส่วนหัวรายงาน  ****//
                String sqlDelete = " DELETE FROM tmp_receive_product_machine_header " + SQL_Product_cond + ";"
                        + " DELETE FROM tmp_receive_product_track_result_detail " + SQL_Product_cond + ";"
                        + " DELETE FROM tmp_receive_product_track_result_header " + SQL_Product_cond + ";"
                        + " DELETE FROM tmp_receive_product_track_other_header " + SQL_Product_cond + ";";

                STateMentData = Conn.createStatement();
                STateMentData.execute(sqlDelete);

                SQL_Res1 = " Select * from " + Table_Job_order_Header + " where doc_id = '" + job_id + "'";
                rs_header = Conn.createStatement().executeQuery(SQL_Res1);
                while (rs_header.next()) {
                    Size_By_Job = rs_header.getString("size_name");
                    Iodine_By_Job = rs_header.getString("i2");
                    Weight_By_Job = rs_header.getString("weight");
                    // System.out.println("Size_By_Job = " + Size_By_Job + " | " + Iodine_By_Job + " | " + Weight_By_Job);
                }

                String SQL_Header = " select concat(mashed_machine,pan,ball_mill,pill_flat,mag,job_edit,wash,roast,roast_edit) as machine_desc , month , year from "
                        + table_product_header + SQL_Product_cond
                        + " group by concat(mashed_machine,pan,ball_mill,pill_flat,mag,job_edit,wash,roast,roast_edit),month,year "
                        + " order by concat(mashed_machine,pan,ball_mill,pill_flat,mag,job_edit,wash,roast,roast_edit),to_number(month,'99'),to_number(year,'9999')";

                //System.out.println("SQL_Header = " + SQL_Header);
                rs_header = Conn.createStatement().executeQuery(SQL_Header);
                while (rs_header.next()) {
                    //System.out.println("machine_desc = " + rs_header.getString("machine_desc") + " | " + rs_header.getString("month")
                    //+ " | " + rs_header.getString("year"));

                    myDoc_ID_List.add(job_id + '#' + rs_header.getString("machine_desc") + '@' + rs_header.getString("month") + '_' + rs_header.getString("year"));

                    SqlInsert_Process = "INSERT INTO " + "tmp_receive_product_machine_header"
                            + " (job_id,job_type_id,machine_id,job_size,job_iodine,job_weight,period_month,period_year,doc_id) VALUES "
                            + "('" + job_id + "','" + rs_header.getString("machine_desc")
                            + "','" + rs_header.getString("machine_desc")
                            + "','" + Size_By_Job
                            + "','" + Iodine_By_Job
                            + "','" + Weight_By_Job
                            + "','" + rs_header.getString("month")
                            + "','" + rs_header.getString("year")
                            + "','" + job_id + '#' + rs_header.getString("machine_desc") + '@' + rs_header.getString("month") + '_' + rs_header.getString("year")
                            + "')";

                    // System.out.println("SqlInsert_Process = " + SqlInsert_Process);
                    STateMentData = Conn.createStatement();
                    STateMentData.execute(SqlInsert_Process);
                }

            //**** End สร้างส่วนหัวรายงาน      ****// 
            %>

            <%//**** Detail 1 Start สร้างส่วนรายละเอียดรายงานส่วนที่ 1 งานได้      ****//
                ResultSet rs_detail = null;
                ResultSet rs_detail1 = null;
                String report_doc_id = "";
                String doc_type_1 = "1";
                String doc_type_2 = "2";
                String doc_type_3 = "3";
                String doc_type_4 = "4";
                String doc_type_5 = "5";

                Double d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, d16, d17, d18, d19, d20, d21, d22, d23, d24, d25, d26, d27, d28, d29, d30, d31;
                Double d_sum_1, d_sum_2, d_sum_3, d_sum_4, d_sum_5, d_sum_6, d_sum_7, d_sum_8, d_sum_9, d_sum_10, d_sum_11, d_sum_12, d_sum_13, d_sum_14, d_sum_15, d_sum_16, d_sum_17, d_sum_18, d_sum_19, d_sum_20, d_sum_21, d_sum_22, d_sum_23, d_sum_24, d_sum_25, d_sum_26, d_sum_27, d_sum_28, d_sum_29, d_sum_30, d_sum_31;
                SQL_Res1 = " Select * from " + "tmp_receive_product_machine_header" + " where job_id = '" + job_id + "'";
                String SQL_Detail1 = "";
                rs_header = Conn.createStatement().executeQuery(SQL_Res1);

                while (rs_header.next()) { //Start Main Loop

                    report_doc_id = rs_header.getString("doc_id");

                    System.out.println("report_doc_id = " + report_doc_id);

                    // System.out.println("doc_id = " + report_doc_id
                    //+ " | " + rs_header.getString("job_id")
                    //+ " | " + rs_header.getString("machine_id")
                    //+ " | " + rs_header.getString("job_size"));
                    SQL_Res1 = " SELECT day,month,year,job_type_desc,job_type_id,shift,shift_name,sum(to_number(weight,'999999.99'))  as weight "
                            + " FROM vd_product_receive_detail_prod "
                            + " WHERE job_id = '" + rs_header.getString("job_id") + "'"
                            + " AND job_type_desc = '" + rs_header.getString("machine_id") + "'"
                            + " AND size = '" + rs_header.getString("job_size") + "'"
                            + " AND to_number(process_order,'99') = 1"
                            + " GROUP BY day,month,year,job_type_desc,job_type_id,shift,shift_name "
                            + " ORDER BY day,month,year,shift,shift_name ";

                    //System.out.println("Detail 1 SQL_Res1 = " + SQL_Res1);
                    rs_detail = Conn.createStatement().executeQuery(SQL_Res1);
                    while (rs_detail.next()) {

                        /*                        
                         System.out.println("day = " + rs_detail.getString("day")
                         + " | " + rs_detail.getString("month")
                         + " | " + rs_detail.getString("year")
                         + " | " + rs_detail.getString("job_type_desc")
                         + " | " + rs_detail.getString("job_type_id")
                         + " | " + rs_detail.getString("shift")
                         + " | " + rs_detail.getDouble("weight")
                         );
                         */
                        d1 = rs_detail.getString("day").equals("01") ? rs_detail.getDouble("weight") : 0;
                        d2 = rs_detail.getString("day").equals("02") ? rs_detail.getDouble("weight") : 0;
                        d3 = rs_detail.getString("day").equals("03") ? rs_detail.getDouble("weight") : 0;
                        d4 = rs_detail.getString("day").equals("04") ? rs_detail.getDouble("weight") : 0;
                        d5 = rs_detail.getString("day").equals("05") ? rs_detail.getDouble("weight") : 0;
                        d6 = rs_detail.getString("day").equals("06") ? rs_detail.getDouble("weight") : 0;
                        d7 = rs_detail.getString("day").equals("07") ? rs_detail.getDouble("weight") : 0;
                        d8 = rs_detail.getString("day").equals("08") ? rs_detail.getDouble("weight") : 0;
                        d9 = rs_detail.getString("day").equals("09") ? rs_detail.getDouble("weight") : 0;
                        d10 = rs_detail.getString("day").equals("10") ? rs_detail.getDouble("weight") : 0;
                        d11 = rs_detail.getString("day").equals("11") ? rs_detail.getDouble("weight") : 0;
                        d12 = rs_detail.getString("day").equals("12") ? rs_detail.getDouble("weight") : 0;
                        d13 = rs_detail.getString("day").equals("13") ? rs_detail.getDouble("weight") : 0;
                        d14 = rs_detail.getString("day").equals("14") ? rs_detail.getDouble("weight") : 0;
                        d15 = rs_detail.getString("day").equals("15") ? rs_detail.getDouble("weight") : 0;
                        d16 = rs_detail.getString("day").equals("16") ? rs_detail.getDouble("weight") : 0;
                        d17 = rs_detail.getString("day").equals("17") ? rs_detail.getDouble("weight") : 0;
                        d18 = rs_detail.getString("day").equals("18") ? rs_detail.getDouble("weight") : 0;
                        d19 = rs_detail.getString("day").equals("19") ? rs_detail.getDouble("weight") : 0;
                        d20 = rs_detail.getString("day").equals("20") ? rs_detail.getDouble("weight") : 0;
                        d21 = rs_detail.getString("day").equals("21") ? rs_detail.getDouble("weight") : 0;
                        d22 = rs_detail.getString("day").equals("22") ? rs_detail.getDouble("weight") : 0;
                        d23 = rs_detail.getString("day").equals("23") ? rs_detail.getDouble("weight") : 0;
                        d24 = rs_detail.getString("day").equals("24") ? rs_detail.getDouble("weight") : 0;
                        d25 = rs_detail.getString("day").equals("25") ? rs_detail.getDouble("weight") : 0;
                        d26 = rs_detail.getString("day").equals("26") ? rs_detail.getDouble("weight") : 0;
                        d27 = rs_detail.getString("day").equals("27") ? rs_detail.getDouble("weight") : 0;
                        d28 = rs_detail.getString("day").equals("28") ? rs_detail.getDouble("weight") : 0;
                        d29 = rs_detail.getString("day").equals("29") ? rs_detail.getDouble("weight") : 0;
                        d30 = rs_detail.getString("day").equals("30") ? rs_detail.getDouble("weight") : 0;
                        d31 = rs_detail.getString("day").equals("31") ? rs_detail.getDouble("weight") : 0;

                        SQL_Detail1 = " SELECT count(*) as num "
                                + " FROM tmp_receive_product_track_result_detail "
                                + " WHERE job_id = '" + job_id + "'"
                                + " AND machine_id = '" + rs_detail.getString("job_type_desc") + "'"
                                + " AND shift = '" + rs_detail.getString("shift") + "'"
                                + " AND period_month = '" + rs_detail.getString("month") + "'"
                                + " AND period_year = '" + rs_detail.getString("year") + "'"
                                + " AND doc_type = '" + doc_type_1 + "'";

                        //System.out.println("Detail 1 SQL_Detail1 = " + SQL_Detail1);
                        int rec_count = objuti.numRowdatabase(SQL_Detail1);
                        if (rec_count <= 0) {
                            SqlInsert_Process = "INSERT INTO " + "tmp_receive_product_track_result_detail"
                                    + " (job_id,machine_id,shift,period_month,period_year,doc_type,doc_id"
                                    + ",d_1,d_2,d_3,d_4,d_5,d_6,d_7,d_8,d_9,d_10"
                                    + ",d_11,d_12,d_13,d_14,d_15,d_16,d_17,d_18,d_19,d_20"
                                    + ",d_21,d_22,d_23,d_24,d_25,d_26,d_27,d_28,d_29,d_30,d_31)"
                                    + " VALUES "
                                    + "('" + job_id + "','" + rs_detail.getString("job_type_desc")
                                    + "','" + rs_detail.getString("shift")
                                    + "','" + rs_detail.getString("month")
                                    + "','" + rs_detail.getString("year")
                                    + "','" + doc_type_1
                                    + "','" + report_doc_id
                                    + "'," + d1 + "," + d2 + "," + d3 + "," + d4 + "," + d5 + "," + d6 + "," + d7 + "," + d8 + "," + d9 + "," + d10
                                    + "," + d11 + "," + d12 + "," + d13 + "," + d14 + "," + d15 + "," + d16 + "," + d17 + "," + d18 + "," + d19 + "," + d20
                                    + "," + d21 + "," + d22 + "," + d23 + "," + d24 + "," + d25 + "," + d26 + "," + d27 + "," + d28 + "," + d29 + "," + d30 + "," + d31
                                    + ")";

                            //System.out.println("SqlInsert_Process = " + SqlInsert_Process);
                            STateMentData = Conn.createStatement();
                            STateMentData.execute(SqlInsert_Process);

                        } else {
                            SqlUpdate_Process = "update tmp_receive_product_track_result_detail set "
                                    + "d_1= (d_1+" + d1 + ")" + " ,d_2= (d_2+" + d2 + ")" + " ,d_3= (d_3+" + d3 + ")"
                                    + " ,d_4= (d_4+" + d4 + ")" + " ,d_5= (d_5+" + d5 + ")" + " ,d_6= (d_6+" + d6 + ")"
                                    + " ,d_7= (d_7+" + d7 + ")" + " ,d_8= (d_8+" + d8 + ")" + " ,d_9= (d_9+" + d9 + ")"
                                    + " ,d_10= (d_10+" + d10 + ")" + " ,d_11= (d_11+" + d11 + ")" + " ,d_12= (d_12+" + d12 + ")"
                                    + " ,d_13= (d_13+" + d13 + ")" + " ,d_14= (d_14+" + d14 + ")" + " ,d_15= (d_15+" + d15 + ")"
                                    + " ,d_16= (d_16+" + d16 + ")" + " ,d_17= (d_17+" + d17 + ")" + " ,d_18= (d_18+" + d18 + ")"
                                    + " ,d_19= (d_19+" + d19 + ")" + " ,d_20= (d_20+" + d20 + ")" + " ,d_21= (d_21+" + d21 + ")"
                                    + " ,d_22= (d_22+" + d22 + ")" + " ,d_23= (d_23+" + d23 + ")" + " ,d_24= (d_24+" + d24 + ")"
                                    + " ,d_25= (d_25+" + d25 + ")" + " ,d_26= (d_26+" + d26 + ")" + " ,d_27= (d_27+" + d27 + ")"
                                    + " ,d_28= (d_28+" + d28 + ")" + " ,d_29= (d_29+" + d29 + ")" + " ,d_30= (d_30+" + d30 + ")"
                                    + " ,d_31= (d_31+" + d31 + ")"
                                    + " WHERE job_id = '" + job_id + "'"
                                    + " AND machine_id = '" + rs_detail.getString("job_type_desc") + "'"
                                    + " AND shift = '" + rs_detail.getString("shift") + "'"
                                    + " AND period_month = '" + rs_detail.getString("month") + "'"
                                    + " AND period_year = '" + rs_detail.getString("year") + "'"
                                    + " AND doc_type = '" + doc_type_1 + "'";

                            //System.out.println("SqlUpdate_Process = " + SqlUpdate_Process);
                            STateMentData_Update = Conn.createStatement();
                            STateMentData_Update.execute(SqlUpdate_Process);
                        }

                    } //End Loop1 หางานได้ รอบที่ 1                     
            %>

            <%
                // หาวัตถุดิบที่เบิกรอบที่ 1
                String SQL_Withdraw_Find = " select size,ctc_i2 as iodine,sum(to_number(qty,'999999.99')) as weight from vd_product_receive_detail  "
                        + table_product_header
                        + " WHERE job_id = '" + rs_header.getString("job_id") + "'"
                        + " AND job_type_desc = '" + rs_header.getString("machine_id") + "'"
                        //+ " AND size = '" + rs_header.getString("job_size") + "'"
                        + " AND to_number(process_order,'99') = 1"
                        + " group by size,ctc_i2 "
                        + " order by size desc,ctc_i2 ";

                //System.out.println("SQL_Header = " + SQL_Header);
                rs_withdraw_find = Conn.createStatement().executeQuery(SQL_Withdraw_Find);
                while (rs_withdraw_find.next()) {

                    SqlInsert_Process = "INSERT INTO " + "tmp_receive_product_track_other_header"
                            + " (job_id,size,iodine,weight,doc_id,doc_type) VALUES "
                            + "('" + job_id
                            + "','" + rs_withdraw_find.getString("size")
                            + "','" + rs_withdraw_find.getString("iodine")
                            + "'," + rs_withdraw_find.getDouble("weight")
                            + ",'" + report_doc_id
                            + "','" + doc_type_4
                            + "')";

                    // System.out.println("SqlInsert_Process = " + SqlInsert_Process);
                    STateMentData = Conn.createStatement();
                    STateMentData.execute(SqlInsert_Process);

                }


            %>            

            <%                // หาถ่านได้รอบที่ 1 นอกเหนือจาก Size Job By Order 
                //SQL_Withdraw_Find = " select size,ctc_i2 as iodine,sum(to_number(weight,'999999.99')) as weight from vd_product_receive_detail_prod  "
                SQL_Withdraw_Find = " select size,sum(to_number(weight,'999999.99')) as weight from vd_product_receive_detail_prod  "
                        + table_product_header
                        + " WHERE job_id = '" + rs_header.getString("job_id") + "'"
                        + " AND job_type_desc = '" + rs_header.getString("machine_id") + "'"
                        + " AND size <> '" + Size_By_Job + "'"
                        + " AND to_number(process_order,'99') = 1"
                        //+ " group by size,ctc_i2 "
                        //+ " order by size desc,ctc_i2 ";                        
                        + " group by size "
                        + " order by size desc ";

                //System.out.println("SQL_Header = " + SQL_Header);
                rs_withdraw_find = Conn.createStatement().executeQuery(SQL_Withdraw_Find);
                while (rs_withdraw_find.next()) {

                    SqlInsert_Process = "INSERT INTO " + "tmp_receive_product_track_other_header"
                            + " (job_id,size,iodine,weight,doc_id,doc_type) VALUES "
                            + "('" + job_id
                            + "','" + rs_withdraw_find.getString("size")
                            + "','" + "-"
                            //+ "','" + rs_withdraw_find.getString("iodine")
                            + "'," + rs_withdraw_find.getDouble("weight")
                            + ",'" + report_doc_id
                            + "','" + doc_type_5
                            + "')";

                    // System.out.println("SqlInsert_Process = " + SqlInsert_Process);
                    STateMentData = Conn.createStatement();
                    STateMentData.execute(SqlInsert_Process);

                }


            %>                   


            <%                // หาถ่านได้รอบที่ 2 นอกเหนือจาก Size Job By Order 
                SQL_Withdraw_Find = " select size,sum(to_number(weight,'999999.99')) as weight from vd_product_receive_detail_prod  "
                        + table_product_header
                        + " WHERE job_id = '" + rs_header.getString("job_id") + "'"
                        + " AND job_type_desc = '" + rs_header.getString("machine_id") + "'"
                        + " AND size <> '" + Size_By_Job + "'"
                        + " AND to_number(process_order,'99') >= 2"
                        + " group by size "
                        + " order by size desc ";

                //System.out.println("SQL_Header = " + SQL_Header);
                rs_withdraw_find = Conn.createStatement().executeQuery(SQL_Withdraw_Find);
                while (rs_withdraw_find.next()) {

                    SqlInsert_Process = "INSERT INTO " + "tmp_receive_product_track_other_header"
                            + " (job_id,size,iodine,weight,doc_id,doc_type) VALUES "
                            + "('" + job_id
                            + "','" + rs_withdraw_find.getString("size")
                            + "','" + "-"
                            + "'," + rs_withdraw_find.getDouble("weight")
                            + ",'" + report_doc_id
                            + "','" + doc_type_5
                            + "')";

                    // System.out.println("SqlInsert_Process = " + SqlInsert_Process);
                    STateMentData = Conn.createStatement();
                    STateMentData.execute(SqlInsert_Process);

                }


            %>                   



            <%                //Start Loop2 หาการเบิกแก้ไข
                SQL_Res1 = " SELECT day,month,year,job_type_desc,job_type_id,shift,shift_name,sum(to_number(qty,'999999.99'))  as weight "
                        + " FROM vd_product_receive_detail "
                        + " WHERE job_id = '" + rs_header.getString("job_id") + "'"
                        + " AND job_type_desc = '" + rs_header.getString("machine_id") + "'"
                        + " AND size = '" + rs_header.getString("job_size") + "'"
                        + " AND to_number(process_order,'99') >= 2"
                        + " GROUP BY day,month,year,job_type_desc,job_type_id,shift,shift_name "
                        + " ORDER BY day,month,year,shift,shift_name ";

                //System.out.println("Detail 1 SQL_Res1 = " + SQL_Res1);
                rs_detail = Conn.createStatement().executeQuery(SQL_Res1);
                while (rs_detail.next()) {

                    /*                        
                     System.out.println("day = " + rs_detail.getString("day")
                     + " | " + rs_detail.getString("month")
                     + " | " + rs_detail.getString("year")
                     + " | " + rs_detail.getString("job_type_desc")
                     + " | " + rs_detail.getString("job_type_id")
                     + " | " + rs_detail.getString("shift")
                     + " | " + rs_detail.getDouble("weight")
                     );
                     */
                    d1 = rs_detail.getString("day").equals("01") ? rs_detail.getDouble("weight") : 0;
                    d2 = rs_detail.getString("day").equals("02") ? rs_detail.getDouble("weight") : 0;
                    d3 = rs_detail.getString("day").equals("03") ? rs_detail.getDouble("weight") : 0;
                    d4 = rs_detail.getString("day").equals("04") ? rs_detail.getDouble("weight") : 0;
                    d5 = rs_detail.getString("day").equals("05") ? rs_detail.getDouble("weight") : 0;
                    d6 = rs_detail.getString("day").equals("06") ? rs_detail.getDouble("weight") : 0;
                    d7 = rs_detail.getString("day").equals("07") ? rs_detail.getDouble("weight") : 0;
                    d8 = rs_detail.getString("day").equals("08") ? rs_detail.getDouble("weight") : 0;
                    d9 = rs_detail.getString("day").equals("09") ? rs_detail.getDouble("weight") : 0;
                    d10 = rs_detail.getString("day").equals("10") ? rs_detail.getDouble("weight") : 0;
                    d11 = rs_detail.getString("day").equals("11") ? rs_detail.getDouble("weight") : 0;
                    d12 = rs_detail.getString("day").equals("12") ? rs_detail.getDouble("weight") : 0;
                    d13 = rs_detail.getString("day").equals("13") ? rs_detail.getDouble("weight") : 0;
                    d14 = rs_detail.getString("day").equals("14") ? rs_detail.getDouble("weight") : 0;
                    d15 = rs_detail.getString("day").equals("15") ? rs_detail.getDouble("weight") : 0;
                    d16 = rs_detail.getString("day").equals("16") ? rs_detail.getDouble("weight") : 0;
                    d17 = rs_detail.getString("day").equals("17") ? rs_detail.getDouble("weight") : 0;
                    d18 = rs_detail.getString("day").equals("18") ? rs_detail.getDouble("weight") : 0;
                    d19 = rs_detail.getString("day").equals("19") ? rs_detail.getDouble("weight") : 0;
                    d20 = rs_detail.getString("day").equals("20") ? rs_detail.getDouble("weight") : 0;
                    d21 = rs_detail.getString("day").equals("21") ? rs_detail.getDouble("weight") : 0;
                    d22 = rs_detail.getString("day").equals("22") ? rs_detail.getDouble("weight") : 0;
                    d23 = rs_detail.getString("day").equals("23") ? rs_detail.getDouble("weight") : 0;
                    d24 = rs_detail.getString("day").equals("24") ? rs_detail.getDouble("weight") : 0;
                    d25 = rs_detail.getString("day").equals("25") ? rs_detail.getDouble("weight") : 0;
                    d26 = rs_detail.getString("day").equals("26") ? rs_detail.getDouble("weight") : 0;
                    d27 = rs_detail.getString("day").equals("27") ? rs_detail.getDouble("weight") : 0;
                    d28 = rs_detail.getString("day").equals("28") ? rs_detail.getDouble("weight") : 0;
                    d29 = rs_detail.getString("day").equals("29") ? rs_detail.getDouble("weight") : 0;
                    d30 = rs_detail.getString("day").equals("30") ? rs_detail.getDouble("weight") : 0;
                    d31 = rs_detail.getString("day").equals("31") ? rs_detail.getDouble("weight") : 0;

                    SQL_Detail1 = " SELECT count(*) as num "
                            + " FROM tmp_receive_product_track_result_detail "
                            + " WHERE job_id = '" + job_id + "'"
                            + " AND machine_id = '" + rs_detail.getString("job_type_desc") + "'"
                            + " AND shift = '" + rs_detail.getString("shift") + "'"
                            + " AND period_month = '" + rs_detail.getString("month") + "'"
                            + " AND period_year = '" + rs_detail.getString("year") + "'"
                            + " AND doc_type = '" + doc_type_2 + "'";

                    //System.out.println("Detail 1 SQL_Detail1 = " + SQL_Detail1);
                    int rec_count = objuti.numRowdatabase(SQL_Detail1);
                    if (rec_count <= 0) {
                        SqlInsert_Process = "INSERT INTO " + "tmp_receive_product_track_result_detail"
                                + " (job_id,machine_id,shift,period_month,period_year,doc_type,doc_id"
                                + ",d_1,d_2,d_3,d_4,d_5,d_6,d_7,d_8,d_9,d_10"
                                + ",d_11,d_12,d_13,d_14,d_15,d_16,d_17,d_18,d_19,d_20"
                                + ",d_21,d_22,d_23,d_24,d_25,d_26,d_27,d_28,d_29,d_30,d_31)"
                                + " VALUES "
                                + "('" + job_id + "','" + rs_detail.getString("job_type_desc")
                                + "','" + rs_detail.getString("shift")
                                + "','" + rs_detail.getString("month")
                                + "','" + rs_detail.getString("year")
                                + "','" + doc_type_2
                                + "','" + report_doc_id
                                + "'," + d1 + "," + d2 + "," + d3 + "," + d4 + "," + d5 + "," + d6 + "," + d7 + "," + d8 + "," + d9 + "," + d10
                                + "," + d11 + "," + d12 + "," + d13 + "," + d14 + "," + d15 + "," + d16 + "," + d17 + "," + d18 + "," + d19 + "," + d20
                                + "," + d21 + "," + d22 + "," + d23 + "," + d24 + "," + d25 + "," + d26 + "," + d27 + "," + d28 + "," + d29 + "," + d30 + "," + d31
                                + ")";

                        //System.out.println("SqlInsert_Process = " + SqlInsert_Process);
                        STateMentData = Conn.createStatement();
                        STateMentData.execute(SqlInsert_Process);

                    } else {
                        SqlUpdate_Process = "update tmp_receive_product_track_result_detail set "
                                + "d_1= (d_1+" + d1 + ")" + " ,d_2= (d_2+" + d2 + ")" + " ,d_3= (d_3+" + d3 + ")"
                                + " ,d_4= (d_4+" + d4 + ")" + " ,d_5= (d_5+" + d5 + ")" + " ,d_6= (d_6+" + d6 + ")"
                                + " ,d_7= (d_7+" + d7 + ")" + " ,d_8= (d_8+" + d8 + ")" + " ,d_9= (d_9+" + d9 + ")"
                                + " ,d_10= (d_10+" + d10 + ")" + " ,d_11= (d_11+" + d11 + ")" + " ,d_12= (d_12+" + d12 + ")"
                                + " ,d_13= (d_13+" + d13 + ")" + " ,d_14= (d_14+" + d14 + ")" + " ,d_15= (d_15+" + d15 + ")"
                                + " ,d_16= (d_16+" + d16 + ")" + " ,d_17= (d_17+" + d17 + ")" + " ,d_18= (d_18+" + d18 + ")"
                                + " ,d_19= (d_19+" + d19 + ")" + " ,d_20= (d_20+" + d20 + ")" + " ,d_21= (d_21+" + d21 + ")"
                                + " ,d_22= (d_22+" + d22 + ")" + " ,d_23= (d_23+" + d23 + ")" + " ,d_24= (d_24+" + d24 + ")"
                                + " ,d_25= (d_25+" + d25 + ")" + " ,d_26= (d_26+" + d26 + ")" + " ,d_27= (d_27+" + d27 + ")"
                                + " ,d_28= (d_28+" + d28 + ")" + " ,d_29= (d_29+" + d29 + ")" + " ,d_30= (d_30+" + d30 + ")"
                                + " ,d_31= (d_31+" + d31 + ")"
                                + " WHERE job_id = '" + job_id + "'"
                                + " AND machine_id = '" + rs_detail.getString("job_type_desc") + "'"
                                + " AND shift = '" + rs_detail.getString("shift") + "'"
                                + " AND period_month = '" + rs_detail.getString("month") + "'"
                                + " AND period_year = '" + rs_detail.getString("year") + "'"
                                + " AND doc_type = '" + doc_type_2 + "'";

                        System.out.println("SqlUpdate_Process = " + SqlUpdate_Process);
                        STateMentData_Update = Conn.createStatement();
                        STateMentData_Update.execute(SqlUpdate_Process);
                    }

                }


            %>

            <%  //Start Loop3 หางานได้จากการแก้ไข  Doc_Type = 3
                SQL_Res1 = " SELECT day,month,year,job_type_desc,job_type_id,shift,shift_name,sum(to_number(weight,'999999.99'))  as weight "
                        + " FROM vd_product_receive_detail_prod "
                        + " WHERE job_id = '" + rs_header.getString("job_id") + "'"
                        + " AND job_type_desc = '" + rs_header.getString("machine_id") + "'"
                        + " AND size = '" + rs_header.getString("job_size") + "'"
                        + " AND to_number(process_order,'99') >= 2"
                        + " GROUP BY day,month,year,job_type_desc,job_type_id,shift,shift_name "
                        + " ORDER BY day,month,year,shift,shift_name ";

                //System.out.println("Detail 1 SQL_Res1 = " + SQL_Res1);
                rs_detail = Conn.createStatement().executeQuery(SQL_Res1);
                while (rs_detail.next()) {

                    d1 = rs_detail.getString("day").equals("01") ? rs_detail.getDouble("weight") : 0;
                    d2 = rs_detail.getString("day").equals("02") ? rs_detail.getDouble("weight") : 0;
                    d3 = rs_detail.getString("day").equals("03") ? rs_detail.getDouble("weight") : 0;
                    d4 = rs_detail.getString("day").equals("04") ? rs_detail.getDouble("weight") : 0;
                    d5 = rs_detail.getString("day").equals("05") ? rs_detail.getDouble("weight") : 0;
                    d6 = rs_detail.getString("day").equals("06") ? rs_detail.getDouble("weight") : 0;
                    d7 = rs_detail.getString("day").equals("07") ? rs_detail.getDouble("weight") : 0;
                    d8 = rs_detail.getString("day").equals("08") ? rs_detail.getDouble("weight") : 0;
                    d9 = rs_detail.getString("day").equals("09") ? rs_detail.getDouble("weight") : 0;
                    d10 = rs_detail.getString("day").equals("10") ? rs_detail.getDouble("weight") : 0;
                    d11 = rs_detail.getString("day").equals("11") ? rs_detail.getDouble("weight") : 0;
                    d12 = rs_detail.getString("day").equals("12") ? rs_detail.getDouble("weight") : 0;
                    d13 = rs_detail.getString("day").equals("13") ? rs_detail.getDouble("weight") : 0;
                    d14 = rs_detail.getString("day").equals("14") ? rs_detail.getDouble("weight") : 0;
                    d15 = rs_detail.getString("day").equals("15") ? rs_detail.getDouble("weight") : 0;
                    d16 = rs_detail.getString("day").equals("16") ? rs_detail.getDouble("weight") : 0;
                    d17 = rs_detail.getString("day").equals("17") ? rs_detail.getDouble("weight") : 0;
                    d18 = rs_detail.getString("day").equals("18") ? rs_detail.getDouble("weight") : 0;
                    d19 = rs_detail.getString("day").equals("19") ? rs_detail.getDouble("weight") : 0;
                    d20 = rs_detail.getString("day").equals("20") ? rs_detail.getDouble("weight") : 0;
                    d21 = rs_detail.getString("day").equals("21") ? rs_detail.getDouble("weight") : 0;
                    d22 = rs_detail.getString("day").equals("22") ? rs_detail.getDouble("weight") : 0;
                    d23 = rs_detail.getString("day").equals("23") ? rs_detail.getDouble("weight") : 0;
                    d24 = rs_detail.getString("day").equals("24") ? rs_detail.getDouble("weight") : 0;
                    d25 = rs_detail.getString("day").equals("25") ? rs_detail.getDouble("weight") : 0;
                    d26 = rs_detail.getString("day").equals("26") ? rs_detail.getDouble("weight") : 0;
                    d27 = rs_detail.getString("day").equals("27") ? rs_detail.getDouble("weight") : 0;
                    d28 = rs_detail.getString("day").equals("28") ? rs_detail.getDouble("weight") : 0;
                    d29 = rs_detail.getString("day").equals("29") ? rs_detail.getDouble("weight") : 0;
                    d30 = rs_detail.getString("day").equals("30") ? rs_detail.getDouble("weight") : 0;
                    d31 = rs_detail.getString("day").equals("31") ? rs_detail.getDouble("weight") : 0;

                    SQL_Detail1 = " SELECT count(*) as num "
                            + " FROM tmp_receive_product_track_result_detail "
                            + " WHERE job_id = '" + job_id + "'"
                            + " AND machine_id = '" + rs_detail.getString("job_type_desc") + "'"
                            + " AND shift = '" + rs_detail.getString("shift") + "'"
                            + " AND period_month = '" + rs_detail.getString("month") + "'"
                            + " AND period_year = '" + rs_detail.getString("year") + "'"
                            + " AND doc_type = '" + doc_type_3 + "'";

                    //System.out.println("Detail 1 SQL_Detail1 = " + SQL_Detail1);
                    int rec_count = objuti.numRowdatabase(SQL_Detail1);
                    if (rec_count <= 0) {
                        SqlInsert_Process = "INSERT INTO " + "tmp_receive_product_track_result_detail"
                                + " (job_id,machine_id,shift,period_month,period_year,doc_type,doc_id"
                                + ",d_1,d_2,d_3,d_4,d_5,d_6,d_7,d_8,d_9,d_10"
                                + ",d_11,d_12,d_13,d_14,d_15,d_16,d_17,d_18,d_19,d_20"
                                + ",d_21,d_22,d_23,d_24,d_25,d_26,d_27,d_28,d_29,d_30,d_31)"
                                + " VALUES "
                                + "('" + job_id + "','" + rs_detail.getString("job_type_desc")
                                + "','" + rs_detail.getString("shift")
                                + "','" + rs_detail.getString("month")
                                + "','" + rs_detail.getString("year")
                                + "','" + doc_type_3
                                + "','" + report_doc_id
                                + "'," + d1 + "," + d2 + "," + d3 + "," + d4 + "," + d5 + "," + d6 + "," + d7 + "," + d8 + "," + d9 + "," + d10
                                + "," + d11 + "," + d12 + "," + d13 + "," + d14 + "," + d15 + "," + d16 + "," + d17 + "," + d18 + "," + d19 + "," + d20
                                + "," + d21 + "," + d22 + "," + d23 + "," + d24 + "," + d25 + "," + d26 + "," + d27 + "," + d28 + "," + d29 + "," + d30 + "," + d31
                                + ")";

                        //System.out.println("SqlInsert_Process = " + SqlInsert_Process);
                        STateMentData = Conn.createStatement();
                        STateMentData.execute(SqlInsert_Process);

                    } else {
                        SqlUpdate_Process = "update tmp_receive_product_track_result_detail set "
                                + "d_1= (d_1+" + d1 + ")" + " ,d_2= (d_2+" + d2 + ")" + " ,d_3= (d_3+" + d3 + ")"
                                + " ,d_4= (d_4+" + d4 + ")" + " ,d_5= (d_5+" + d5 + ")" + " ,d_6= (d_6+" + d6 + ")"
                                + " ,d_7= (d_7+" + d7 + ")" + " ,d_8= (d_8+" + d8 + ")" + " ,d_9= (d_9+" + d9 + ")"
                                + " ,d_10= (d_10+" + d10 + ")" + " ,d_11= (d_11+" + d11 + ")" + " ,d_12= (d_12+" + d12 + ")"
                                + " ,d_13= (d_13+" + d13 + ")" + " ,d_14= (d_14+" + d14 + ")" + " ,d_15= (d_15+" + d15 + ")"
                                + " ,d_16= (d_16+" + d16 + ")" + " ,d_17= (d_17+" + d17 + ")" + " ,d_18= (d_18+" + d18 + ")"
                                + " ,d_19= (d_19+" + d19 + ")" + " ,d_20= (d_20+" + d20 + ")" + " ,d_21= (d_21+" + d21 + ")"
                                + " ,d_22= (d_22+" + d22 + ")" + " ,d_23= (d_23+" + d23 + ")" + " ,d_24= (d_24+" + d24 + ")"
                                + " ,d_25= (d_25+" + d25 + ")" + " ,d_26= (d_26+" + d26 + ")" + " ,d_27= (d_27+" + d27 + ")"
                                + " ,d_28= (d_28+" + d28 + ")" + " ,d_29= (d_29+" + d29 + ")" + " ,d_30= (d_30+" + d30 + ")"
                                + " ,d_31= (d_31+" + d31 + ")"
                                + " WHERE job_id = '" + job_id + "'"
                                + " AND machine_id = '" + rs_detail.getString("job_type_desc") + "'"
                                + " AND shift = '" + rs_detail.getString("shift") + "'"
                                + " AND period_month = '" + rs_detail.getString("month") + "'"
                                + " AND period_year = '" + rs_detail.getString("year") + "'"
                                + " AND doc_type = '" + doc_type_3 + "'";

                        //System.out.println("SqlUpdate_Process = " + SqlUpdate_Process);
                        STateMentData_Update = Conn.createStatement();
                        STateMentData_Update.execute(SqlUpdate_Process);
                    }

                } //End Loop3 หางานได้จากการแก้ไข  
            %>

            <%                } //End Main Loop

            %>



            <%// หาผลรวมงานได้ตามใบแจ้งและเครื่องจักร และสร้างส่วนหัวรายงาน
                ResultSet rs_product_sum = null;

                SQL_Res1 = " select job_id,machine_id,period_month,period_year "
                        + " ,sum(d_1) as sum_d1,sum(d_2) as sum_d2,sum(d_3) as sum_d3,sum(d_4) as sum_d4,sum(d_5) as sum_d5,sum(d_6) as sum_d6 "
                        + " ,sum(d_7) as sum_d7,sum(d_8) as sum_d8,sum(d_9) as sum_d9,sum(d_10) as sum_d10"
                        + " ,sum(d_11) as sum_d11,sum(d_12) as sum_d12,sum(d_13) as sum_d13,sum(d_14) as sum_d14,sum(d_15) as sum_d15,sum(d_16) as sum_d16"
                        + ",sum(d_17) as sum_d17,sum(d_18) as sum_d18 ,sum(d_19) as sum_d19,sum(d_20) as sum_d20"
                        + ",sum(d_21) as sum_d21,sum(d_22) as sum_d22,sum(d_23) as sum_d23,sum(d_24) as sum_d24,sum(d_25) as sum_d25"
                        + ",sum(d_26) as sum_d26,sum(d_27) as sum_d27,sum(d_28) as sum_d28,sum(d_29) as sum_d29,sum(d_30) as sum_d30"
                        + ",sum(d_31) as sum_d31"
                        + " from tmp_receive_product_track_result_detail "
                        + " where job_id = '" + job_id + "'"
                        + " and doc_type = '" + doc_type_1 + "'"
                        + " group by job_id,machine_id,period_month,period_year";
                System.out.println("FTC SQL_Res1 = " + SQL_Res1);
                int count_loop = 1;
                rs_product_sum = Conn.createStatement().executeQuery(SQL_Res1);
                while (rs_product_sum.next()) {

                    System.out.println("count_loop = " + count_loop);
                    System.out.println("rs_product_sum machine_id = " + rs_product_sum.getString("machine_id"));
                    System.out.println("period_month = " + rs_product_sum.getString("period_month"));
                    System.out.println("period_year = " + rs_product_sum.getString("period_year"));

                    SqlInsert_Process = "INSERT INTO " + "tmp_receive_product_track_result_header (doc_id,job_id,machine_id,period_month,period_year,doc_type) values ("
                            //+ "'" + report_doc_id
                            + "'" + job_id + '#' + rs_product_sum.getString("machine_id") + '@' + rs_product_sum.getString("period_month") + '_' + rs_product_sum.getString("period_year")
                            + "','" + job_id
                            + "','" + rs_product_sum.getString("machine_id")
                            + "','" + rs_product_sum.getString("period_month")
                            + "','" + rs_product_sum.getString("period_year")
                            + "','" + doc_type_1
                            + "')";

                    STateMentData = Conn.createStatement();
                    STateMentData.execute(SqlInsert_Process);

                    /*                    
                     System.out.println("job_id= " + rs_product_sum.getString("job_id"));
                     System.out.println("machine_id= " + rs_product_sum.getString("machine_id"));
                     System.out.println("period_month= " + rs_product_sum.getString("period_month"));
                     System.out.println("period_year= " + rs_product_sum.getString("period_year"));
                     System.out.println("sum_d1= " + rs_product_sum.getDouble("sum_d1"));
                     System.out.println("sum_d2= " + rs_product_sum.getDouble("sum_d2"));
                     System.out.println("sum_d3= " + rs_product_sum.getDouble("sum_d3"));
                     System.out.println("sum_d4= " + rs_product_sum.getDouble("sum_d4"));
                     System.out.println("sum_d5= " + rs_product_sum.getDouble("sum_d5"));
                     System.out.println("sum_d6= " + rs_product_sum.getDouble("sum_d6"));
                     System.out.println("sum_d7= " + rs_product_sum.getDouble("sum_d7"));
                     System.out.println("sum_d8= " + rs_product_sum.getDouble("sum_d8"));
                     System.out.println("sum_d9= " + rs_product_sum.getDouble("sum_d9"));
                     System.out.println("sum_d10= " + rs_product_sum.getDouble("sum_d10"));
                     System.out.println("sum_d11= " + rs_product_sum.getDouble("sum_d11"));
                     System.out.println("sum_d12= " + rs_product_sum.getDouble("sum_d12"));
                     System.out.println("sum_d13= " + rs_product_sum.getDouble("sum_d13"));
                     System.out.println("sum_d14= " + rs_product_sum.getDouble("sum_d14"));
                     System.out.println("sum_d15= " + rs_product_sum.getDouble("sum_d15"));
                     System.out.println("sum_d16= " + rs_product_sum.getDouble("sum_d16"));
                     System.out.println("sum_d17= " + rs_product_sum.getDouble("sum_d17"));
                     System.out.println("sum_d18= " + rs_product_sum.getDouble("sum_d18"));
                     System.out.println("sum_d19= " + rs_product_sum.getDouble("sum_d19"));
                     System.out.println("sum_d20= " + rs_product_sum.getDouble("sum_d20"));
                     System.out.println("sum_d21= " + rs_product_sum.getDouble("sum_d21"));
                     System.out.println("sum_d22= " + rs_product_sum.getDouble("sum_d22"));
                     System.out.println("sum_d23= " + rs_product_sum.getDouble("sum_d23"));
                     System.out.println("sum_d24= " + rs_product_sum.getDouble("sum_d24"));
                     System.out.println("sum_d25= " + rs_product_sum.getDouble("sum_d25"));
                     System.out.println("sum_d26= " + rs_product_sum.getDouble("sum_d26"));
                     System.out.println("sum_d27= " + rs_product_sum.getDouble("sum_d27"));
                     System.out.println("sum_d28= " + rs_product_sum.getDouble("sum_d28"));
                     System.out.println("sum_d29= " + rs_product_sum.getDouble("sum_d29"));
                     System.out.println("sum_d30= " + rs_product_sum.getDouble("sum_d30"));
                     System.out.println("sum_d31= " + rs_product_sum.getDouble("sum_d31"));
                     */
                    Double day_weight[] = new Double[32];
                    Double day_sum[] = new Double[32];
                    Double d_sum = 0.00;
                    for (int loop = 1; loop <= 31; loop++) {
                        day_weight[loop] = rs_product_sum.getDouble("sum_d" + loop);
                        System.out.println("day_weight[loop] = " + day_weight[loop]);
                    }
                    for (int i = 1; i <= 31; i++) {
                        d_sum += (day_weight[i]);
                        day_sum[i] = d_sum;

                        if (day_weight[i] > 0) {
                            System.out.println("day_sum[" + i + "] = " + day_sum[i]);

                        } else {
                            System.out.println("day_sum[" + i + "] = 0.00");
                        }

                    }

                    d_sum_1 = day_weight[1] > 0 ? day_sum[1] : 0.00;
                    d_sum_2 = day_weight[2] > 0 ? day_sum[2] : 0.00;
                    d_sum_3 = day_weight[3] > 0 ? day_sum[3] : 0.00;
                    d_sum_4 = day_weight[4] > 0 ? day_sum[4] : 0.00;
                    d_sum_5 = day_weight[5] > 0 ? day_sum[5] : 0.00;
                    d_sum_6 = day_weight[6] > 0 ? day_sum[6] : 0.00;
                    d_sum_7 = day_weight[7] > 0 ? day_sum[7] : 0.00;
                    d_sum_8 = day_weight[8] > 0 ? day_sum[8] : 0.00;
                    d_sum_9 = day_weight[9] > 0 ? day_sum[9] : 0.00;
                    d_sum_10 = day_weight[10] > 0 ? day_sum[10] : 0.00;
                    d_sum_11 = day_weight[11] > 0 ? day_sum[11] : 0.00;
                    d_sum_12 = day_weight[12] > 0 ? day_sum[12] : 0.00;
                    d_sum_13 = day_weight[13] > 0 ? day_sum[13] : 0.00;
                    d_sum_14 = day_weight[14] > 0 ? day_sum[14] : 0.00;
                    d_sum_15 = day_weight[15] > 0 ? day_sum[15] : 0.00;
                    d_sum_16 = day_weight[16] > 0 ? day_sum[16] : 0.00;
                    d_sum_17 = day_weight[17] > 0 ? day_sum[17] : 0.00;
                    d_sum_18 = day_weight[18] > 0 ? day_sum[18] : 0.00;
                    d_sum_19 = day_weight[19] > 0 ? day_sum[19] : 0.00;
                    d_sum_20 = day_weight[20] > 0 ? day_sum[20] : 0.00;
                    d_sum_21 = day_weight[21] > 0 ? day_sum[21] : 0.00;
                    d_sum_22 = day_weight[22] > 0 ? day_sum[22] : 0.00;
                    d_sum_23 = day_weight[23] > 0 ? day_sum[23] : 0.00;
                    d_sum_24 = day_weight[24] > 0 ? day_sum[24] : 0.00;
                    d_sum_25 = day_weight[25] > 0 ? day_sum[25] : 0.00;
                    d_sum_26 = day_weight[26] > 0 ? day_sum[26] : 0.00;
                    d_sum_27 = day_weight[27] > 0 ? day_sum[27] : 0.00;
                    d_sum_28 = day_weight[28] > 0 ? day_sum[28] : 0.00;
                    d_sum_29 = day_weight[29] > 0 ? day_sum[29] : 0.00;
                    d_sum_30 = day_weight[30] > 0 ? day_sum[30] : 0.00;
                    d_sum_31 = day_weight[31] > 0 ? day_sum[31] : 0.00;

                    SqlUpdate_Process = " update tmp_receive_product_track_result_header set "
                            + "d_1= (" + d_sum_1 + ")" + " ,d_2= (" + d_sum_2 + ")" + " ,d_3= (" + d_sum_3 + ")"
                            + " ,d_4= (" + d_sum_4 + ")" + " ,d_5= (" + d_sum_5 + ")" + " ,d_6= (" + d_sum_6 + ")"
                            + " ,d_7= (" + d_sum_7 + ")"
                            + " ,d_8= (" + d_sum_8 + ")" + " ,d_9= (" + d_sum_9 + ")" + " ,d_10= (" + d_sum_10 + ")"
                            + " ,d_11= (" + d_sum_11 + ")" + " ,d_12= (" + d_sum_12 + ")" + " ,d_13= (" + d_sum_13 + ")"
                            + " ,d_14= (" + d_sum_14 + ")" + " ,d_15= (" + d_sum_15 + ")"
                            + " ,d_16= (" + d_sum_16 + ")" + " ,d_17= (" + d_sum_17 + ")" + " ,d_18= (" + d_sum_18 + ")"
                            + " ,d_19= (" + d_sum_19 + ")" + " ,d_20= (" + d_sum_20 + ")" + " ,d_21= (" + d_sum_21 + ")" + " ,d_22= (" + d_sum_22 + ")"
                            + " ,d_23= (" + d_sum_23 + ")" + " ,d_24= (" + d_sum_24 + ")" + " ,d_25= (" + d_sum_25 + ")"
                            + " ,d_26= (" + d_sum_26 + ")" + " ,d_27= (" + d_sum_27 + ")" + " ,d_28= (" + d_sum_28 + ")"
                            + " ,d_29= (" + d_sum_29 + ")" + " ,d_30= (" + d_sum_30 + ")"
                            + " ,d_31= (" + d_sum_31 + ")"
                            + " WHERE job_id = '" + job_id + "'"
                            + " AND machine_id = '" + rs_product_sum.getString("machine_id") + "'"
                            + " AND period_month = '" + rs_product_sum.getString("period_month") + "'"
                            + " AND period_year = '" + rs_product_sum.getString("period_year") + "'"
                            + " AND doc_type = '" + doc_type_1 + "'";

                    System.out.println("SqlUpdate_Process = " + SqlUpdate_Process);
                    STateMentData_Update = Conn.createStatement();
                    STateMentData_Update.execute(SqlUpdate_Process);

                    count_loop++;

                }

            %>


            <%// หาผลรวมการเบิกถ่านเพื่อแก้ไขตามใบแจ้งและเครื่องจักร และสร้างส่วนหัวรายงาน Doc_Type = 2
                //ResultSet rs_product_sum = null;
                //Double d_sum_1, d_sum_2, d_sum_3, d_sum_4, d_sum_5, d_sum_6, d_sum_7, d_sum_8, d_sum_9, d_sum_10, d_sum_11, d_sum_12, d_sum_13, d_sum_14, d_sum_15, d_sum_16, d_sum_17, d_sum_18, d_sum_19, d_sum_20, d_sum_21, d_sum_22, d_sum_23, d_sum_24, d_sum_25, d_sum_26, d_sum_27, d_sum_28, d_sum_29, d_sum_30, d_sum_31;
                SQL_Res1 = " select job_id,machine_id,period_month,period_year "
                        + " ,sum(d_1) as sum_d1,sum(d_2) as sum_d2,sum(d_3) as sum_d3,sum(d_4) as sum_d4,sum(d_5) as sum_d5,sum(d_6) as sum_d6 "
                        + " ,sum(d_7) as sum_d7,sum(d_8) as sum_d8,sum(d_9) as sum_d9,sum(d_10) as sum_d10"
                        + " ,sum(d_11) as sum_d11,sum(d_12) as sum_d12,sum(d_13) as sum_d13,sum(d_14) as sum_d14,sum(d_15) as sum_d15,sum(d_16) as sum_d16"
                        + ",sum(d_17) as sum_d17,sum(d_18) as sum_d18 ,sum(d_19) as sum_d19,sum(d_20) as sum_d20"
                        + ",sum(d_21) as sum_d21,sum(d_22) as sum_d22,sum(d_23) as sum_d23,sum(d_24) as sum_d24,sum(d_25) as sum_d25"
                        + ",sum(d_26) as sum_d26,sum(d_27) as sum_d27,sum(d_28) as sum_d28,sum(d_29) as sum_d29,sum(d_30) as sum_d30"
                        + ",sum(d_31) as sum_d31"
                        + " from tmp_receive_product_track_result_detail "
                        + " where job_id = '" + job_id + "'"
                        + " and doc_type = '" + doc_type_2 + "'"
                        + " group by job_id,machine_id,period_month,period_year";
                count_loop = 1;
                rs_product_sum = Conn.createStatement().executeQuery(SQL_Res1);
                while (rs_product_sum.next()) {
                    System.out.println("count_loop = " + count_loop);

                    SqlInsert_Process = "INSERT INTO " + "tmp_receive_product_track_result_header (doc_id,job_id,machine_id,period_month,period_year,doc_type,create_by) values ("
                            //+ "'" + report_doc_id
                            + "'" + job_id + '#' + rs_product_sum.getString("machine_id") + '@' + rs_product_sum.getString("period_month") + '_' + rs_product_sum.getString("period_year")
                            + "','" + job_id
                            + "','" + rs_product_sum.getString("machine_id")
                            + "','" + rs_product_sum.getString("period_month")
                            + "','" + rs_product_sum.getString("period_year")
                            + "','" + doc_type_2
                            + "','" + "Insert" + count_loop
                            + "')";

                    STateMentData = Conn.createStatement();
                    STateMentData.execute(SqlInsert_Process);

                    Double day_weight[] = new Double[32];
                    Double day_sum[] = new Double[32];
                    Double d_sum = 0.00;
                    for (int loop = 1; loop <= 31; loop++) {
                        day_weight[loop] = rs_product_sum.getDouble("sum_d" + loop);
                        System.out.println("day_weight[loop] = " + day_weight[loop]);
                    }
                    for (int i = 1; i <= 31; i++) {
                        d_sum += (day_weight[i]);
                        day_sum[i] = d_sum;

                        if (day_weight[i] > 0) {
                            System.out.println("day_sum[" + i + "] = " + day_sum[i]);

                        } else {
                            System.out.println("day_sum[" + i + "] = 0.00");
                        }

                    }

                    d_sum_1 = day_weight[1] > 0 ? day_sum[1] : 0.00;
                    d_sum_2 = day_weight[2] > 0 ? day_sum[2] : 0.00;
                    d_sum_3 = day_weight[3] > 0 ? day_sum[3] : 0.00;
                    d_sum_4 = day_weight[4] > 0 ? day_sum[4] : 0.00;
                    d_sum_5 = day_weight[5] > 0 ? day_sum[5] : 0.00;
                    d_sum_6 = day_weight[6] > 0 ? day_sum[6] : 0.00;
                    d_sum_7 = day_weight[7] > 0 ? day_sum[7] : 0.00;
                    d_sum_8 = day_weight[8] > 0 ? day_sum[8] : 0.00;
                    d_sum_9 = day_weight[9] > 0 ? day_sum[9] : 0.00;
                    d_sum_10 = day_weight[10] > 0 ? day_sum[10] : 0.00;
                    d_sum_11 = day_weight[11] > 0 ? day_sum[11] : 0.00;
                    d_sum_12 = day_weight[12] > 0 ? day_sum[12] : 0.00;
                    d_sum_13 = day_weight[13] > 0 ? day_sum[13] : 0.00;
                    d_sum_14 = day_weight[14] > 0 ? day_sum[14] : 0.00;
                    d_sum_15 = day_weight[15] > 0 ? day_sum[15] : 0.00;
                    d_sum_16 = day_weight[16] > 0 ? day_sum[16] : 0.00;
                    d_sum_17 = day_weight[17] > 0 ? day_sum[17] : 0.00;
                    d_sum_18 = day_weight[18] > 0 ? day_sum[18] : 0.00;
                    d_sum_19 = day_weight[19] > 0 ? day_sum[19] : 0.00;
                    d_sum_20 = day_weight[20] > 0 ? day_sum[20] : 0.00;
                    d_sum_21 = day_weight[21] > 0 ? day_sum[21] : 0.00;
                    d_sum_22 = day_weight[22] > 0 ? day_sum[22] : 0.00;
                    d_sum_23 = day_weight[23] > 0 ? day_sum[23] : 0.00;
                    d_sum_24 = day_weight[24] > 0 ? day_sum[24] : 0.00;
                    d_sum_25 = day_weight[25] > 0 ? day_sum[25] : 0.00;
                    d_sum_26 = day_weight[26] > 0 ? day_sum[26] : 0.00;
                    d_sum_27 = day_weight[27] > 0 ? day_sum[27] : 0.00;
                    d_sum_28 = day_weight[28] > 0 ? day_sum[28] : 0.00;
                    d_sum_29 = day_weight[29] > 0 ? day_sum[29] : 0.00;
                    d_sum_30 = day_weight[30] > 0 ? day_sum[30] : 0.00;
                    d_sum_31 = day_weight[31] > 0 ? day_sum[31] : 0.00;

                    SqlUpdate_Process = " update tmp_receive_product_track_result_header set "
                            + "d_1= (" + d_sum_1 + ")" + " ,d_2= (" + d_sum_2 + ")" + " ,d_3= (" + d_sum_3 + ")"
                            + " ,d_4= (" + d_sum_4 + ")" + " ,d_5= (" + d_sum_5 + ")" + " ,d_6= (" + d_sum_6 + ")"
                            + " ,d_7= (" + d_sum_7 + ")"
                            + " ,d_8= (" + d_sum_8 + ")" + " ,d_9= (" + d_sum_9 + ")" + " ,d_10= (" + d_sum_10 + ")"
                            + " ,d_11= (" + d_sum_11 + ")" + " ,d_12= (" + d_sum_12 + ")" + " ,d_13= (" + d_sum_13 + ")"
                            + " ,d_14= (" + d_sum_14 + ")" + " ,d_15= (" + d_sum_15 + ")"
                            + " ,d_16= (" + d_sum_16 + ")" + " ,d_17= (" + d_sum_17 + ")" + " ,d_18= (" + d_sum_18 + ")"
                            + " ,d_19= (" + d_sum_19 + ")" + " ,d_20= (" + d_sum_20 + ")" + " ,d_21= (" + d_sum_21 + ")" + " ,d_22= (" + d_sum_22 + ")"
                            + " ,d_23= (" + d_sum_23 + ")" + " ,d_24= (" + d_sum_24 + ")" + " ,d_25= (" + d_sum_25 + ")"
                            + " ,d_26= (" + d_sum_26 + ")" + " ,d_27= (" + d_sum_27 + ")" + " ,d_28= (" + d_sum_28 + ")"
                            + " ,d_29= (" + d_sum_29 + ")" + " ,d_30= (" + d_sum_30 + ")"
                            + " ,d_31= (" + d_sum_31 + ")"
                            + " ,update_by='Update " + count_loop + "'"
                            + " WHERE job_id = '" + job_id + "'"
                            + " AND machine_id = '" + rs_product_sum.getString("machine_id") + "'"
                            + " AND period_month = '" + rs_product_sum.getString("period_month") + "'"
                            + " AND period_year = '" + rs_product_sum.getString("period_year") + "'"
                            + " AND doc_type = '" + doc_type_2 + "'";

                    System.out.println("SqlUpdate_Process = " + SqlUpdate_Process);
                    STateMentData_Update = Conn.createStatement();
                    STateMentData_Update.execute(SqlUpdate_Process);

                    count_loop++;

                }

            %>

            <%// หาผลรวมงานได้จากการแก้ไข ตามใบแจ้งและเครื่องจักร และสร้างส่วนหัวรายงาน Doc_Type = 3
                //ResultSet rs_product_sum = null;
                //Double d_sum_1, d_sum_2, d_sum_3, d_sum_4, d_sum_5, d_sum_6, d_sum_7, d_sum_8, d_sum_9, d_sum_10, d_sum_11, d_sum_12, d_sum_13, d_sum_14, d_sum_15, d_sum_16, d_sum_17, d_sum_18, d_sum_19, d_sum_20, d_sum_21, d_sum_22, d_sum_23, d_sum_24, d_sum_25, d_sum_26, d_sum_27, d_sum_28, d_sum_29, d_sum_30, d_sum_31;
                SQL_Res1 = " select job_id,machine_id,period_month,period_year "
                        + " ,sum(d_1) as sum_d1,sum(d_2) as sum_d2,sum(d_3) as sum_d3,sum(d_4) as sum_d4,sum(d_5) as sum_d5,sum(d_6) as sum_d6 "
                        + " ,sum(d_7) as sum_d7,sum(d_8) as sum_d8,sum(d_9) as sum_d9,sum(d_10) as sum_d10"
                        + " ,sum(d_11) as sum_d11,sum(d_12) as sum_d12,sum(d_13) as sum_d13,sum(d_14) as sum_d14,sum(d_15) as sum_d15,sum(d_16) as sum_d16"
                        + ",sum(d_17) as sum_d17,sum(d_18) as sum_d18 ,sum(d_19) as sum_d19,sum(d_20) as sum_d20"
                        + ",sum(d_21) as sum_d21,sum(d_22) as sum_d22,sum(d_23) as sum_d23,sum(d_24) as sum_d24,sum(d_25) as sum_d25"
                        + ",sum(d_26) as sum_d26,sum(d_27) as sum_d27,sum(d_28) as sum_d28,sum(d_29) as sum_d29,sum(d_30) as sum_d30"
                        + ",sum(d_31) as sum_d31"
                        + " from tmp_receive_product_track_result_detail "
                        + " where job_id = '" + job_id + "'"
                        + " and doc_type = '" + doc_type_3 + "'"
                        + " group by job_id,machine_id,period_month,period_year";
                count_loop = 1;
                rs_product_sum = Conn.createStatement().executeQuery(SQL_Res1);
                while (rs_product_sum.next()) {
                    System.out.println("count_loop = " + count_loop);

                    SqlInsert_Process = "INSERT INTO " + "tmp_receive_product_track_result_header (doc_id,job_id,machine_id,period_month,period_year,doc_type) values ("
                            //+ "'" + report_doc_id
                            + "'" + job_id + '#' + rs_product_sum.getString("machine_id") + '@' + rs_product_sum.getString("period_month") + '_' + rs_product_sum.getString("period_year")
                            + "','" + job_id
                            + "','" + rs_product_sum.getString("machine_id")
                            + "','" + rs_product_sum.getString("period_month")
                            + "','" + rs_product_sum.getString("period_year")
                            + "','" + doc_type_3
                            + "')";

                    STateMentData = Conn.createStatement();
                    STateMentData.execute(SqlInsert_Process);

                    Double day_weight[] = new Double[32];
                    Double day_sum[] = new Double[32];
                    Double d_sum = 0.00;
                    for (int loop = 1; loop <= 31; loop++) {
                        day_weight[loop] = rs_product_sum.getDouble("sum_d" + loop);
                        System.out.println("day_weight[loop] = " + day_weight[loop]);
                    }
                    for (int i = 1; i <= 31; i++) {
                        d_sum += (day_weight[i]);
                        day_sum[i] = d_sum;
                        /*
                         if (day_weight[i] > 0) {
                         System.out.println("day_sum[" + i + "] = " + day_sum[i]);

                         } else {
                         System.out.println("day_sum[" + i + "] = 0.00");
                         }
                         */

                    }

                    d_sum_1 = day_weight[1] > 0 ? day_sum[1] : 0.00;
                    d_sum_2 = day_weight[2] > 0 ? day_sum[2] : 0.00;
                    d_sum_3 = day_weight[3] > 0 ? day_sum[3] : 0.00;
                    d_sum_4 = day_weight[4] > 0 ? day_sum[4] : 0.00;
                    d_sum_5 = day_weight[5] > 0 ? day_sum[5] : 0.00;
                    d_sum_6 = day_weight[6] > 0 ? day_sum[6] : 0.00;
                    d_sum_7 = day_weight[7] > 0 ? day_sum[7] : 0.00;
                    d_sum_8 = day_weight[8] > 0 ? day_sum[8] : 0.00;
                    d_sum_9 = day_weight[9] > 0 ? day_sum[9] : 0.00;
                    d_sum_10 = day_weight[10] > 0 ? day_sum[10] : 0.00;
                    d_sum_11 = day_weight[11] > 0 ? day_sum[11] : 0.00;
                    d_sum_12 = day_weight[12] > 0 ? day_sum[12] : 0.00;
                    d_sum_13 = day_weight[13] > 0 ? day_sum[13] : 0.00;
                    d_sum_14 = day_weight[14] > 0 ? day_sum[14] : 0.00;
                    d_sum_15 = day_weight[15] > 0 ? day_sum[15] : 0.00;
                    d_sum_16 = day_weight[16] > 0 ? day_sum[16] : 0.00;
                    d_sum_17 = day_weight[17] > 0 ? day_sum[17] : 0.00;
                    d_sum_18 = day_weight[18] > 0 ? day_sum[18] : 0.00;
                    d_sum_19 = day_weight[19] > 0 ? day_sum[19] : 0.00;
                    d_sum_20 = day_weight[20] > 0 ? day_sum[20] : 0.00;
                    d_sum_21 = day_weight[21] > 0 ? day_sum[21] : 0.00;
                    d_sum_22 = day_weight[22] > 0 ? day_sum[22] : 0.00;
                    d_sum_23 = day_weight[23] > 0 ? day_sum[23] : 0.00;
                    d_sum_24 = day_weight[24] > 0 ? day_sum[24] : 0.00;
                    d_sum_25 = day_weight[25] > 0 ? day_sum[25] : 0.00;
                    d_sum_26 = day_weight[26] > 0 ? day_sum[26] : 0.00;
                    d_sum_27 = day_weight[27] > 0 ? day_sum[27] : 0.00;
                    d_sum_28 = day_weight[28] > 0 ? day_sum[28] : 0.00;
                    d_sum_29 = day_weight[29] > 0 ? day_sum[29] : 0.00;
                    d_sum_30 = day_weight[30] > 0 ? day_sum[30] : 0.00;
                    d_sum_31 = day_weight[31] > 0 ? day_sum[31] : 0.00;

                    SqlUpdate_Process = " update tmp_receive_product_track_result_header set "
                            + "d_1= (" + d_sum_1 + ")" + " ,d_2= (" + d_sum_2 + ")" + " ,d_3= (" + d_sum_3 + ")"
                            + " ,d_4= (" + d_sum_4 + ")" + " ,d_5= (" + d_sum_5 + ")" + " ,d_6= (" + d_sum_6 + ")"
                            + " ,d_7= (" + d_sum_7 + ")"
                            + " ,d_8= (" + d_sum_8 + ")" + " ,d_9= (" + d_sum_9 + ")" + " ,d_10= (" + d_sum_10 + ")"
                            + " ,d_11= (" + d_sum_11 + ")" + " ,d_12= (" + d_sum_12 + ")" + " ,d_13= (" + d_sum_13 + ")"
                            + " ,d_14= (" + d_sum_14 + ")" + " ,d_15= (" + d_sum_15 + ")"
                            + " ,d_16= (" + d_sum_16 + ")" + " ,d_17= (" + d_sum_17 + ")" + " ,d_18= (" + d_sum_18 + ")"
                            + " ,d_19= (" + d_sum_19 + ")" + " ,d_20= (" + d_sum_20 + ")" + " ,d_21= (" + d_sum_21 + ")" + " ,d_22= (" + d_sum_22 + ")"
                            + " ,d_23= (" + d_sum_23 + ")" + " ,d_24= (" + d_sum_24 + ")" + " ,d_25= (" + d_sum_25 + ")"
                            + " ,d_26= (" + d_sum_26 + ")" + " ,d_27= (" + d_sum_27 + ")" + " ,d_28= (" + d_sum_28 + ")"
                            + " ,d_29= (" + d_sum_29 + ")" + " ,d_30= (" + d_sum_30 + ")"
                            + " ,d_31= (" + d_sum_31 + ")"
                            + " WHERE job_id = '" + job_id + "'"
                            + " AND machine_id = '" + rs_product_sum.getString("machine_id") + "'"
                            + " AND period_month = '" + rs_product_sum.getString("period_month") + "'"
                            + " AND period_year = '" + rs_product_sum.getString("period_year") + "'"
                            + " AND doc_type = '" + doc_type_3 + "'";

                    System.out.println("SqlUpdate_Process = " + SqlUpdate_Process);
                    STateMentData_Update = Conn.createStatement();
                    STateMentData_Update.execute(SqlUpdate_Process);

                    count_loop++;

                }

            %>            


            <%    Timestamp ts1 = (new Timestamp(new java.util.Date().getTime()));
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
            <div class="jumbotron">
                <div class="container">

                    <table class="table table-bordered">
                        <center><h2>รายงานติดตามการผลิต(ตามใบแจ้งการผลิต)</h2></center>                        
                        <center>                               
                            <div class="progress">                                
                                <div class="progress-bar" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width:0%"></div>                                
                            </div>
                        </center>
                        <% if (myDoc_ID_List.size() > 0) {

                        %>
                        <center><h2>จัดเตรียมข้อมูลเสร็จสิ้น กรุณากดปุ่ม พิมพ์รายงาน ตามช่วงวันที่</h2></center>                                  
                    </table>                        

                    <%                        for (int i = 0; i < myDoc_ID_List.size(); i++) {
                            System.out.println("myDoc_ID_List index[" + i + "] = " + myDoc_ID_List.get(i));
                    %>                        

                    <!--table width="100%" align="center" border="0" cellpadding="0" cellspacing="1" class="inner3"-->
                    <table class="table table-bordered">
                        <tr>
                            <td class="row5" width="40%">
                                <h5><font color="blue">เลขที่เอกสาร : </font><span class="label label-success"><%=myDoc_ID_List.get(i)%></span></h5>
                                <!--b>เลขที่เอกสาร : <font color="blue"><%=myDoc_ID_List.get(i)%></font></b-->
                                <!--p class="">เลขที่เอกสาร : <%=myDoc_ID_List.get(i)%></p-->
                            </td>
                            <td class="row5" width="60%">                                
                                <input type ="button" class="cgcButton_20" id="report_i" name=report_i" value ="วันที่ 1- 16" onclick="send_print('<%=myDoc_ID_List.get(i)%>', 'RP_407A')">
                                <input type ="button" class="cgcButton_20" id="report_i" name=report_i" value ="วันที่ 17- 31" onclick="send_print('<%=myDoc_ID_List.get(i)%>', 'RP_407B')">
                            </td>
                        </tr>
                    </table>                            

                    <%
                        }
                    } else {
                    %>

                    <h3><font color="red">ไม่พบข้อมูลการผลิต</font></h3>                    
                    </table>    
                    <%
                        }

                    %>            

                    <table class="table table-bordered">
                        <tr>
                            <td class="row5" width="40%">
                                <!--a href="#" onClick="javascript:window.close();" class="cgcButton_19">ปิด</a-->
                                <button type="button" class="btn btn-info btn-block" onClick="javascript:window.close();"><b>ปิด</b></button>
                            </td>
                        </tr>
                    </table>                      

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

        function send_print(doc_id, report_code) {
            //alert(doc_id+ " | " +report_code);
            getId("doc_id").value = doc_id;
            getId("report_code").value = report_code;
            document.report.submit();

        }

    </script> 

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


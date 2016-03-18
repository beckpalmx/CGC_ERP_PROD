
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
            <input type="hidden" name="report_code" value="RP_021_RAW_FRICTION">
            <input type="hidden" name="price_year" value="2558">
            <input type="hidden" name="pgroup_id" value="-">
            <input type="hidden" name="product_id" value="-">
            <input type="hidden" name="warehouse_id" value="-">
            <input type="hidden" name="branch" value="-">
            <input type="hidden" name="location_id" value="-">
            <input type="hidden" name="friction_house" value="-">                          
            <input type="hidden" id="date_form" name="date_form" value="<%=date_f%>">
            <input type="hidden" id="date_to" name="date_to" value="<%=date_t%>">                  
            <%
                String product_id = request.getParameter("product_id");
                String pgroup_id = request.getParameter("pgroup_id");
                System.out.println("product_id = " + product_id);
                System.out.println("pgroup_id = " + pgroup_id);
                System.out.println("1 date_from = " + request.getParameter("date_from"));
                System.out.println("1 date_to = " + request.getParameter("date_to"));

                double Total = 0;
                double Temp_Total = 0;
                String data_type = "";
                double data_weight = 0;
                double data_r = 0;
                double data_w = 0;
                double sum_r = 0;
                double sum_w = 0;
                //Connection connect = null;
                Statement STateMent = null;
                Statement STateMentData = null;
                String sql, sql_where = "";
                //String product_id = null;
                DecimalFormat dc = new DecimalFormat();
                dc.applyPattern("###,###.##");

                Timestamp ts = (new Timestamp(new java.util.Date().getTime()));
                System.out.println("Start Process ts = " + ts);

                try {

                    UtiDatabase objut = new UtiDatabase();
                    DBConnect db = new DBConnect();
                    Connection Conn = db.openNewConnection();
                    System.out.println("Conn First : " + Conn);

                    String sqlDelete = "DELETE FROM tmp_stock_rawmat_friction";
                    STateMentData = Conn.createStatement();
                    System.out.println("Conn 2 : " + Conn);
                    System.out.println("sqlDelete 2 : " + sqlDelete);
                    STateMentData.execute(sqlDelete);

                    if (!product_id.equals("") && !product_id.equals(null)) {
                        sql_where = " WHERE product_id = '" + product_id + "' ";
                    }

                    if (pgroup_id.equals("") || pgroup_id.equals(null)) {
                        if (!sql_where.equals("") && !sql_where.equals(null)) {
                            sql_where = sql_where + " AND pgroup_id = 'RAW' ";
                        } else {
                            sql_where = " WHERE pgroup_id = 'RAW' ";
                        }
                    }

                    System.out.println("1 sql_where = " + sql_where);

                    if (!pgroup_id.equals("") && !pgroup_id.equals(null)) {
                        if (!sql_where.equals("") && !sql_where.equals(null)) {
                            sql_where = sql_where + " AND pgroup_id = '" + pgroup_id + "' ";
                        } else {
                            sql_where = " WHERE pgroup_id = '" + pgroup_id + "' ";
                        }
                    }

                    sql_where = sql_where + " and (process_id = 'PR_025' or process_id = 'PR_057' or process_id = 'PR_117') and location_id like '%B%' ";

                    System.out.println("2 sql_where = " + sql_where);

                    if (!request.getParameter("date_from").equals("") && !request.getParameter("date_to").equals("") && !request.getParameter("date_from").equals(null) && !request.getParameter("date_to").equals(null)) {
                        if (!sql_where.equals("") && !sql_where.equals(null)) {
                            sql_where = sql_where + " AND to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + request.getParameter("date_from") + "'),'YYYY-MM-DD') AND to_date(format_date2('" + request.getParameter("date_to") + "'),'YYYY-MM-DD') ";
                        } else {
                            sql_where = " WHERE to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + request.getParameter("date_from") + "'),'YYYY-MM-DD') AND to_date(format_date2('" + request.getParameter("date_to") + "'),'YYYY-MM-DD') ";
                        }
                    }

                    System.out.println("Connect String : " + Conn);

                    String sql_location = " Select distinct(location_id) from vt_transaction_stock_process_report " + sql_where;

                    String location_cond = "";
                    String where_location = "";

                    System.out.println("sql_location : " + sql_location);

                    STateMent = Conn.createStatement();
                    ResultSet rec_location = STateMent.executeQuery(sql_location);

                    int i = 1;

                    while ((rec_location != null) && (rec_location.next())) {
                        if (i == 1) {
                            location_cond = "'" + rec_location.getString("location_id") + "'";
                        } else {
                            location_cond += ",'" + rec_location.getString("location_id") + "'";
                        }
                        i++;
                    }

                    System.out.println("location_cond : " + location_cond);

                    if (!location_cond.equals("") && !location_cond.equals(null)) {
                        where_location = " OR location_id in (" + location_cond + ") ";
                    }

                    System.out.println("where_location : " + where_location);

                    sql = "SELECT doc_date,product_id, doc_type,sum(weight_total) as weight_total,pname_t,pgroup_id,location_id  "
                            + " FROM vt_transaction_stock_process_report "
                            + sql_where
                            + where_location
                            + " Group by product_id, doc_date,location_id ,doc_type,pname_t,pgroup_id "
                            + " Order by location_id,to_date(format_date(doc_date),'YYYY-MM-DD') , doc_type desc ";

                    System.out.println("SQL : " + sql);

                    STateMent = Conn.createStatement();
                    ResultSet rec = STateMent.executeQuery(sql);
            %>   



            <% String tmp_location_id = ""; // สตริงไว้ดักจับตัวซ้ำ  %>

            <%while ((rec != null) && (rec.next())) {%>
            <!-- ------------------------------------------------------------------------------------ -->
            <!-- Summary Group by Product ID  -->
            <%
                if (rec.getString("location_id").equals(tmp_location_id) || tmp_location_id.equals("")) {
                } else {
            %>  

            <!--tr>
                <td colspan="2" align="right"> ยอดรวม</td>
                <td>  &nbsp;</td>
                <td align="right"> <%=dc.format(sum_r)%>&nbsp;</td>
                <td align="right"> <%=dc.format(sum_w)%>&nbsp;</td>
                <td align="right"> <%=dc.format(Total)%>&nbsp;</td>
            </tr-->  

            <%      sum_r = 0.00;
                    sum_w = 0.00;
                    Total = 0.00;
                    Temp_Total = 0.00;
                }
                tmp_location_id = rec.getString("location_id");
            %>


            <!--tr-->
                <!--td> &nbsp;<%=rec.getString("doc_date")%></td> 
                <td> &nbsp;<%=rec.getString("product_id")%> | <%=rec.getString("pname_t")%></td>
                <td> &nbsp;<%=rec.getString("location_id")%></td> 
                <td align='center'><%=rec.getString("doc_type")%></td-->

            <% data_type = rec.getString("doc_type");%>
            <% data_weight = rec.getDouble("weight_total");%>
            <%

                if (data_type.equals("+")) {
                    data_r = data_weight;
                    data_w = 0;
                } else if (data_type.equals("-")) {
                    data_w = data_weight;
                    data_r = 0;
                }
                Total = (data_r + data_w + Temp_Total) > 0 ? data_r + data_w + Temp_Total : 0;
                Temp_Total = Total > 0 ? Total : 0;
                sum_r += data_r;
                sum_w += data_w;

                System.out.println("Total = " + Total);
                System.out.println("Temp_Total = " + Temp_Total);

                String SqlInsert = "INSERT INTO tmp_stock_rawmat_friction(product_id,doc_date,doc_type,data_r,data_w,data_total,pgroup_id,location_id) VALUES "
                        + "('" + rec.getString("product_id") + "','" + rec.getString("doc_date") + "','"
                        + rec.getString("doc_type") + "'," + data_r + "," + data_w + "," + Total + ",'"
                        + rec.getString("pgroup_id") + "','" + rec.getString("location_id") + "')";
                System.out.println("SqlInsert = " + SqlInsert);
                STateMentData = Conn.createStatement();
                STateMentData.execute(SqlInsert);
                // ResultSet recInsert = STateMentInsert.executeQuery(SqlInsert);


            %>
            <!--td align="right"> <%=dc.format(data_r)%>&nbsp;</td>
            <td align="right"> <%=dc.format(data_w)%>&nbsp;</td>
            <td align="right"> <%=dc.format(Total)%>&nbsp;</td-->
            <!--/tr-->
            <%}%>
            <!--tr> 
                <td colspan="3"></td>
                <td align="right"><%=dc.format(sum_r)%>&nbsp;</td>
                <td align="right"><%=dc.format(sum_w)%>&nbsp;</td>
                <td> </t>
            </tr-->


            <%
                }
                catch (Exception e

                
                    ) {
                    // TODO Auto-generated catch block
                    out.println(e.getMessage());
                    e.printStackTrace(System.out);
                }

                
                    try {
                    if (STateMent != null) {
                        STateMent.close();
                        //
                    }
                }
                catch (SQLException e

                
                    ) {
                    // TODO Auto-generated catch block
                    out.println(e.getMessage());
                    e.printStackTrace(System.out);
                }

                Timestamp ts1 = (new Timestamp(new java.util.Date().getTime()));
            %>           

            <div class="jumbotron">
                <div class="container">
                    <table border ="1"  cellpadding="0"  cellspacing="0" class="">
                        <center><h2>รายงานความเคลื่อนไหวถ่านวัตถุดิบ (ถ่านสี)</h2></center>
                        <center><h3>วันที่ : <%=date_f%> ถึง <%=date_t%></h3></center> 
                        <center>   
                            <!--div class="progress progress-striped active"-->
                            <div class="progress">                                
                                <div class="progress-bar" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width:0%"></div>                                
                            </div>
                        </center>                             
                        <center><h3>จัดเตรียมข้อมูลเสร็จสิ้น กรุณากดปุ่ม พิมพ์รายงาน</h3></center>          
                        <!--center><h3>กรุณากดปุ่ม พิมพ์รายงาน</h3></center>          
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

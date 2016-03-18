
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.Util.Serchselect" %>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.DB.DBConnect"%>
<%@page import="java.text.DecimalFormat" %>
<!DOCTYPE html>

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

        <title>รายการเคลื่อนไหววัตถุดิบ</title>        

    </head>
    <body>
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            
            <%
                String product_id = request.getParameter("product_id");
                String pgroup_id = request.getParameter("pgroup_id");
                System.out.println("product_id = " + product_id);
                System.out.println("pgroup_id = " + pgroup_id);
                System.out.println("1 date_from = " + request.getParameter("date_from"));
                System.out.println("1 date_to = " + request.getParameter("date_to"));
                date_f = request.getParameter("date_f");
                date_t = request.getParameter("date_t");                
            %>
            
            <input type="hidden" name="type_report" value="4">
            <input type="hidden" name="report_code" value="RP_021_RAW_REC_WITDRAW_FRICTION">
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
                double Total = 0;
                double Temp_Total = 0;
                String data_type = "";
                String process_id = "";
                double data_weight = 0;
                double data_weight_rw = 0;
                double data_r = 0;
                double data_w = 0;
                double data_raw_rec = 0;
                double sum_r = 0;
                double sum_w = 0;
                double sum_data_raw_rec = 0;
                //Connection connect = null;
                Statement stm = null;
                Statement stmData = null;
                String sql, sql_where = "";
                //String product_id = null;
                DecimalFormat dc = new DecimalFormat();
                dc.applyPattern("###,###.##");
                try {

                    UtiDatabase objut = new UtiDatabase();
                    DBConnect db = new DBConnect();
                    Connection Conn = db.openNewConnection();
                    System.out.println("Conn First : " + Conn);

                    String sqlDelete = "DELETE FROM tmp_stock_rawmat_receive_withdraw_friction";
                    stmData = Conn.createStatement();
                    System.out.println("Conn 2 : " + Conn);
                    System.out.println("sqlDelete 2 : " + sqlDelete);
                    stmData.execute(sqlDelete);

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

                    //sql_where = sql_where + " and (process_id = 'PR_022' or process_id = 'PR_023' or process_id = 'PR_024' or process_id = 'PR_117') and location_id not like '%B%' ";
                    sql_where = sql_where + " and (process_id = 'PR_023' or process_id = 'PR_024') and location_id not like '%B%' ";

                    System.out.println("2 sql_where = " + sql_where);

                    if (!request.getParameter("date_from").equals("") && !request.getParameter("date_to").equals("") && !request.getParameter("date_from").equals(null) && !request.getParameter("date_to").equals(null)) {
                        if (!sql_where.equals("") && !sql_where.equals(null)) {
                            sql_where = sql_where + " AND to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + request.getParameter("date_from") + "'),'YYYY-MM-DD') AND to_date(format_date2('" + request.getParameter("date_to") + "'),'YYYY-MM-DD') ";
                        } else {
                            sql_where = " WHERE to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + request.getParameter("date_from") + "'),'YYYY-MM-DD') AND to_date(format_date2('" + request.getParameter("date_to") + "'),'YYYY-MM-DD') ";
                        }
                    }

                    System.out.println("Connect String : " + Conn);

                    String sql_location = " Select distinct(location_id) from vt_transaction_stock_rawmat_process_report " + sql_where;

                    String location_cond = "";
                    String where_location = "";

                    System.out.println("sql_location : " + sql_location);

                    stm = Conn.createStatement();
                    ResultSet rec_location = stm.executeQuery(sql_location);

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
                        where_location = " AND location_id in (" + location_cond + ") ";
                    }

                    System.out.println("where_location : " + where_location);

                    String sql_where1 = "";

                    //String start_period = "2558-01-01";
                    String start_period = "";
                    ResultSet rec_periods = null;
                    Connection Conn2 = db.openNewConnection();
                    String SQL_PERIOD = "SELECT * FROM mperiod where doc_type = 'S'";
                    rec_periods = Conn2.createStatement().executeQuery(SQL_PERIOD);
                    if (rec_periods.next()) {
                        start_period = rec_periods.getString("start_period").substring(6, 10) + rec_periods.getString("start_period").substring(2, 6) + rec_periods.getString("start_period").substring(0, 2);
                        System.out.println("Select DB start_period : " + start_period);
                    }

                    if (!request.getParameter("date_from").equals("") && !request.getParameter("date_to").equals("") && !request.getParameter("date_from").equals(null) && !request.getParameter("date_to").equals(null)) {
                        if (!sql_where1.equals("") && !sql_where1.equals(null)) {
                            sql_where1 = sql_where1 + " AND to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + start_period + "'),'YYYY-MM-DD') AND to_date(format_date2('" + request.getParameter("date_to") + "'),'YYYY-MM-DD') ";
                        } else {
                            sql_where1 = " WHERE to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + start_period + "'),'YYYY-MM-DD') AND to_date(format_date2('" + request.getParameter("date_to") + "'),'YYYY-MM-DD') ";
                        }
                    }

                    sql = "SELECT doc_date,product_id, doc_type,sum(to_number(weight,'999999.99')) as weight,sum(weight_total) as weight_total,pname_t,pgroup_id,location_id,process_id,avg(to_number(price_per_unit, '999999.99')) as price_per_unit   "
                            + " FROM vt_transaction_stock_rawmat_process_report "
                            + sql_where1
                            + where_location
                            + " and (process_id = 'PR_023' or process_id = 'PR_024') "
                            + " Group by product_id, doc_date,location_id ,doc_type,pname_t,pgroup_id,process_id "
                            + " Order by location_id,to_date(format_date(doc_date),'YYYY-MM-DD'),process_id , doc_type desc ";

                    System.out.println("SQL : " + sql);

                    stm = Conn.createStatement();
                    ResultSet rec = stm.executeQuery(sql);
            %>   

            <div class="CSS_Table_Example" style="width:1200px;height:150px;">    
                <tr>
                    <td colspan='2' class='blankspace' align="right">                                              
                        <a href="#" onClick="javascript:document.report.submit();" class="cgcButton">พิมพ์</a>
                        <a href="#" onClick="javascript:window.close();" class="cgcButton">ปิด</a>
                    </td>
                </tr>              
                <table border ="1"  cellpadding="0"  cellspacing="0" class="">
                    <center><h2>รายการเคลื่อนไหววัตถุดิบ</h2></center>                   
                    <center><h3>วันที่ : <%=date_f%> ถึง <%=date_t%></h3></center>                 
                    <tr align="center">
                        <td>วันที่</td>
                        <td>Product</td>                        
                        <td>กองที่</td>
                        <td>ยกยอดมา</td>
                        <td>รับเข้า</td>
                        <td>จ่ายออก</td>
                        <td>คงเหลือ</td>
                    </tr>
                    <% String tmp_location_id = ""; // ʵ�ԧ���ѡ�Ѻ��ǫ��  %>

                    <%while ((rec != null) && (rec.next())) {%>
                    <!-- ------------------------------------------------------------------------------------ -->
                    <!-- Summary Group by Product ID  -->
                    <%
                        if (rec.getString("location_id").equals(tmp_location_id) || tmp_location_id.equals("")) {
                        } else {
                    %>  

                    <tr>
                        <td colspan="2" align="right">รวม</td>
                        <td>  &nbsp;</td>
                        <td align="right"> <%=dc.format(sum_data_raw_rec)%>&nbsp;</td>
                        <td align="right"> <%=dc.format(sum_r)%>&nbsp;</td>
                        <td align="right"> <%=dc.format(sum_w)%>&nbsp;</td>
                        <td align="right"> <%=dc.format(Total)%>&nbsp;</td>
                    </tr>    
                    <%      sum_r = 0.00;
                            sum_w = 0.00;
                            Total = 0.00;
                            sum_data_raw_rec = 0.00;
                            Temp_Total = 0.00;
                        }
                        tmp_location_id = rec.getString("location_id");
                    %>
                    <!-- -------------------------------------------------------------------------------------- -->

                    <tr>
                        <td> &nbsp;<%=rec.getString("doc_date")%></td> 
                        <td> &nbsp;<%=rec.getString("product_id")%> | <%=rec.getString("pname_t")%></td>
                        <td> &nbsp;<%=rec.getString("location_id")%></td> 
                        <!--td align='center'><%=rec.getString("doc_type")%></td-->
                        <% data_type = rec.getString("doc_type");%>
                        <% process_id = rec.getString("process_id");%>
                        <% data_weight = rec.getDouble("weight_total");%>
                        <% data_weight_rw = rec.getDouble("weight");%>
                        <%
                            /*
                             if (data_type.equals("+")) {
                             data_r = data_weight;
                             data_w = 0;
                             } else if (data_type.equals("-")) {
                             data_w = data_weight;
                             data_r = 0;
                             }
                             */
                            if (process_id.equalsIgnoreCase("PR_023")||process_id.equalsIgnoreCase("PR_117")) {
                                data_r = data_weight_rw;
                                data_w = 0;
                                data_raw_rec = 0;
                            } else if (process_id.equalsIgnoreCase("PR_024")) {
                                data_w = data_weight;
                                data_r = 0;
                                data_raw_rec = 0;
                            } else {
                                data_raw_rec = data_weight;
                                data_r = 0;
                                data_w = 0;
                            }

                            Total = (data_r + data_w + Temp_Total) > 0 ? data_r + data_w + Temp_Total : 0;
                            Temp_Total = Total > 0 ? Total : 0;
                            sum_r += data_r;
                            sum_w += data_w;
                            sum_data_raw_rec += data_raw_rec;

                            System.out.println("Total = " + Total);
                            System.out.println("Temp_Total = " + Temp_Total);

                            String SqlInsert = "INSERT INTO tmp_stock_rawmat_receive_withdraw_friction(product_id,doc_date,doc_type,data_r,data_w,data_total,pgroup_id,location_id,data_raw_rec,price_per_unit) VALUES "
                                    + "('" + rec.getString("product_id") + "','" + rec.getString("doc_date") + "','"
                                    + rec.getString("doc_type") + "'," + data_r + "," + data_w + "," + Total + ",'"
                                    + rec.getString("pgroup_id") + "','" + rec.getString("location_id") + "'," + data_raw_rec + ",'" + rec.getString("price_per_unit") + "')";
                            System.out.println("SqlInsert = " + SqlInsert);
                            stmData = Conn.createStatement();
                            stmData.execute(SqlInsert);
                            // ResultSet recInsert = stmInsert.executeQuery(SqlInsert);


                        %>
                        <td align="right"> <%=dc.format(data_raw_rec)%>&nbsp;</td>
                        <td align="right"> <%=dc.format(data_r)%>&nbsp;</td>
                        <td align="right"> <%=dc.format(data_w)%>&nbsp;</td>
                        <td align="right"> <%=dc.format(Total)%>&nbsp;</td>    
                    </tr>
                    <%}%>
                    <tr> 
                        <td colspan="3"></td>                        
                        <td align="right"><%=dc.format(sum_data_raw_rec)%>&nbsp;</td>
                        <td align="right"><%=dc.format(sum_r)%>&nbsp;</td>
                        <td align="right"><%=dc.format(sum_w)%>&nbsp;</td>
                        <td align="right"> <%=dc.format(Total)%>&nbsp;</td>    
                        <td> </td>
                    </tr>


                </table>      
            </div>
            <%
                }
                catch (Exception e

                
                    ) {
                    // TODO Auto-generated catch block
                    out.println(e.getMessage());
                    e.printStackTrace(System.out);
                }

                
                    try {
                    if (stm != null) {
                        stm.close();
                        //
                    }
                }
                catch (SQLException e

                
                    ) {
                    // TODO Auto-generated catch block
                    out.println(e.getMessage());
                    e.printStackTrace(System.out);
                }
            %>
        </form>
    </body>
</html>

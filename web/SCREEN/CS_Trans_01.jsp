
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
        <link href="../CSS/cgc_button.css" rel="stylesheet" type="text/css">
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

        <title>CGC  ��§ҹ�������͹���</title>        

    </head>
    <body>
        <form name="report" method="post" action="../JSP/CS_REPORT.jsp" target="_blank">
            <input type="hidden" name="type_report" value="1">
            <input type="hidden" name="report_code" value="RP_021">
            <input type="hidden" name="price_year" value="2557">
            <%
                String product_id = request.getParameter("product_id");
                String pgroup_id = request.getParameter("pgroup_id");
                System.out.println("product_id = " + product_id);
                System.out.println("pgroup_id = " + pgroup_id);
                System.out.println("1 date_from = " + request.getParameter("date_from"));
                System.out.println("1 date_to = " + request.getParameter("date_to"));
                date_f = request.getParameter("date_f");
                date_t = request.getParameter("date_t");

                String month_priod = request.getParameter("date_from").substring(5, 7);
                String month_check = "";

                double Total = 0.00;
                double Temp_Total = 0.00;
                String data_type = "";
                double data_weight = 0.00;
                double data_r = 0.00;
                double data_w = 0.00;
                double sum_r = 0.00;
                double sum_w = 0.00;
                double price_per_unit = 0.00;
                double total_price_trans = 0.00;
                double total_price_sum = 0.00;
                double total_weight_trans = 0.00;
                //Connection connect = null;
                Statement stm = null;
                Statement stmData = null;
                String sql, sql_where = "";
                //String product_id = null;
                DecimalFormat dc = new DecimalFormat();
                dc.applyPattern("###,###.##");

                UtiDatabase objut = new UtiDatabase();
                DBConnect db = new DBConnect();
                Connection Conn = db.openNewConnection();
                System.out.println("Conn First : " + Conn);
                
                //Delete data tmp_stock
                String sqlDelete = "DELETE FROM tmp_stock";
                stmData = Conn.createStatement();
                System.out.println("Conn 2 : " + Conn);
                System.out.println("sqlDelete 2 : " + sqlDelete);
                stmData.execute(sqlDelete);
                

                if (!product_id.equals("") && !product_id.equals(null)) {
                    sql_where = " WHERE product_id = '" + product_id + "' ";
                }

                if (pgroup_id.equals("") || pgroup_id.equals(null)) {
                    if (!sql_where.equals("") && !sql_where.equals(null)) {
                        sql_where = sql_where + " AND pgroup_id <> 'RAW' ";
                    } else {
                        sql_where = " WHERE pgroup_id <> 'RAW' ";
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

                System.out.println("2 sql_where = " + sql_where);

                if (!request.getParameter("date_from").equals("") && !request.getParameter("date_to").equals("") && !request.getParameter("date_from").equals(null) && !request.getParameter("date_to").equals(null)) {
                    if (!sql_where.equals("") && !sql_where.equals(null)) {
                        sql_where = sql_where + " AND to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + request.getParameter("date_from") + "'),'YYYY-MM-DD') AND to_date(format_date2('" + request.getParameter("date_to") + "'),'YYYY-MM-DD') ";
                    } else {
                        sql_where = " WHERE to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date2('" + request.getParameter("date_from") + "'),'YYYY-MM-DD') AND to_date(format_date2('" + request.getParameter("date_to") + "'),'YYYY-MM-DD') ";
                    }
                }

                System.out.println("Connect String : " + Conn);

                String sql_product_id = " Select distinct(product_id) from vt_transaction_stock_process_report " + sql_where;

                String product_cond = "";
                String where_product = "";

                System.out.println("sql_product_id : " + sql_product_id);

                stm = Conn.createStatement();
                ResultSet rec_product = stm.executeQuery(sql_product_id);

                int i = 1;

                while ((rec_product != null) && (rec_product.next())) {
                    if (i == 1) {
                        product_cond = "'" + rec_product.getString("product_id") + "'";
                    } else {
                        product_cond += ",'" + rec_product.getString("product_id") + "'";
                    }
                    i++;
                }

                System.out.println("product_cond : " + product_cond);

                if (!product_cond.equals("") && !product_cond.equals(null)) {
                    where_product = " OR product_id in (" + product_cond + ") ";
                }

                System.out.println("where_product : " + where_product);

                sql = "SELECT runno,doc_date,product_id,"
                        + " doc_type,weight_total,pname_t,price_per_unit,pgroup_id "
                        + " FROM vt_transaction_stock_process_report "
                        + sql_where
                        //+ where_product
                        + " Order by product_id, to_date(format_date(doc_date),'YYYY-MM-DD') , doc_type desc ";

                System.out.println("SQL : " + sql);

                stm = Conn.createStatement();
                ResultSet rec = stm.executeQuery(sql);

            %>   

            <div class="CSS_Table_Example" style="width:1200px;height:150px;">    
                <tr>
                    <td colspan='2' class='blankspace' align="right">                                              
                        <!--input type="button" name="myBut" value=" �������§ҹ  " onClick="javascript:document.report.submit();"/>
                        <input type=button value="�Դ" onClick="javascript:window.close();"-->
                        <a href="#" onClick="javascript:document.report.submit();" class="cgcButton">�������§ҹ</a>
                        <a href="#" onClick="javascript:window.close();" class="cgcButton">�Դ</a>
                    </td>
                </tr>              
                <table border ="1"  cellpadding="0"  cellspacing="0" class="">
                    <center><h2>��§ҹ��������͹����Թ���</h2></center>                   
                    <center><h3>�ѹ��� : <%=date_f%> �֧ <%=date_t%></h3></center>                 
                    <tr align="center">
                        <td>�ѹ���</td>
                        <td>Product</td>
                        <td>Doc Type</td>
                        <!-- <td>Weight Total</td> -->
                        <td>�Ѻ���</td>
                        <td>�����͡</td>                        
                        <td>������� </td>
                        <td>�Ҥҵ��˹���</td>                        
                    </tr>
                    <% String tmp_product_id = ""; // ʵ�ԧ���ѡ�Ѻ��ǫ��  %>

                    <%while ((rec != null) && (rec.next())) {%>
                    <!-- ------------------------------------------------------------------------------------ -->
                    <!-- Summary Group by Product ID  -->                    
                    <%
                        month_check = rec.getString("doc_date").substring(3, 5);

                        if (rec.getString("product_id").equals("C-AW1100-1230-6")) {
                                //System.out.println("month_check = " + month_check + " product_id = " + rec.getString("product_id") + " weight = " + rec.getDouble("weight_total") + "tmp_product_id = " + tmp_product_id);
                            //System.out.println("runno = " + rec.getString("runno") + " tmp_product_id =  " + tmp_product_id);
                        }

                        if (rec.getString("product_id").equals(tmp_product_id) && !month_check.equals(month_priod)) {
                            total_weight_trans = total_weight_trans + rec.getDouble("weight_total");
                            if (rec.getString("product_id").equals("C-AW1100-1230-6")) {
                                //System.out.println("month_check = " + month_check + " product_id = " + rec.getString("product_id") + " weight = " + rec.getDouble("weight_total") + "tmp_product_id = " + tmp_product_id);
                                //System.out.println("runno = " + rec.getString("runno") + " ### total_weight_trans = " + total_weight_trans);
                            }
                        }
                        if (rec.getString("product_id").equals("C-AW1100-1230-6")) {
                            //System.out.println("product_id = " + rec.getString("product_id") + " ### total_weight_trans = " + total_weight_trans);
                        }

                        if (rec.getString("product_id").equals(tmp_product_id) || tmp_product_id.equals("")) {
                            System.out.println("runno = " + rec.getString("runno") + " tmp_product_id =  " + tmp_product_id);
                        } else {
                    %>  

                    <tr>
                        <td colspan="2" align="right"><font color="blue"<b>�ʹ���</b></font></td>
                        <td>&nbsp;</td>
                        <td align="right"><font color="blue"<b> <%=dc.format(sum_r)%></b></font>&nbsp;</td>
                        <td align="right"><font color="blue"<b> <%=dc.format(sum_w)%></b></font>&nbsp;</td>                        
                        <td align="right"><font color="blue"<b> <%=dc.format(Total)%></b></font>&nbsp;</td>
                        <td align="right"><font color="blue"<b> <%=dc.format(price_per_unit)%></b></font>&nbsp;</td>                        
                        <!--td align="right"> &nbsp;</td-->
                    </tr>    
                    <%      sum_r = 0.00;
                            sum_w = 0.00;
                            Total = 0.00;
                            Temp_Total = 0.00;
                            total_weight_trans = 0.00;
                        }
                        tmp_product_id = rec.getString("product_id");
                    %>
                    <!-- -------------------------------------------------------------------------------------- -->

                    <tr>
                        <td> &nbsp;<%=rec.getString("doc_date")%></td> 
                        <td> &nbsp;<%=rec.getString("product_id")%> | <%=rec.getString("pname_t")%></td>
                        <td align='center'><%=rec.getString("doc_type")%></td>               
                        <% data_type = rec.getString("doc_type");%>
                        <% data_weight = rec.getDouble("weight_total");%>
                        <% price_per_unit = rec.getDouble("price_per_unit");%>
                        <%

                            if (data_type.equals("+")) {
                                data_r = data_weight;
                                data_w = 0;
                            } else if (data_type.equals("-")) {
                                data_w = data_weight;
                                data_r = 0;
                            }
                            Total = data_r + data_w + Temp_Total;
                            Temp_Total = Total;
                            sum_r += data_r;
                            sum_w += data_w;

                            //System.out.println("price_per_unit = " + price_per_unit);
                            total_price_trans = Total * price_per_unit;

                            //System.out.println("total_price_trans = " + total_price_trans);
                            String SqlInsert = "INSERT INTO tmp_stock(product_id,doc_date,doc_type,data_r,data_w,data_total,price_per_unit,pgroup_id) VALUES "
                                    + "('" + rec.getString("product_id") + "','" + rec.getString("doc_date") + "','"
                                    + rec.getString("doc_type") + "'," + data_r + "," + data_w + "," + Total + ",'"
                                    + rec.getString("price_per_unit") + "','" + rec.getString("pgroup_id") + "')";
                              stmData = Conn.createStatement();
                              stmData.execute(SqlInsert);
                              //ResultSet recInsert = stmInsert.executeQuery(SqlInsert);


                        %>
                        <td align="right"> <%=dc.format(data_r)%>&nbsp;</td>
                        <td align="right"> <%=dc.format(data_w)%>&nbsp;</td>                        
                        <td align="right"> <%=dc.format(Total)%>&nbsp;</td> 
                        <td align="right"> <%=dc.format(price_per_unit)%>&nbsp;</td>                        
                    </tr>
                    <%}%>
                    <tr> 
                        <td colspan="3"></td>
                        <td align="right"><%=dc.format(sum_r)%>&nbsp;</td>
                        <td align="right"><%=dc.format(sum_w)%>&nbsp;</td>
                        <td> </t>
                    </tr>


                </table>      
            </div>

        </form>
    </body>
</html>

<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.cgc.DB.DBConnect"%>
<%@page import="java.sql.Connection"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!    DBConnect dbConnect = new DBConnect();
    Connection con;
    String sql;
    PreparedStatement p = null;
    ResultSet rs;
    String htmltext;
    String table, f,w,l, process,l_out;
    String[] data;
    int cnt = 0;

%>
<%    try {
                cnt = 0;
                f = "";
                w = "wh_out";
                l = "location_id2";
                l_out = "location_id";
                htmltext = "";
                table = (String) request.getParameter("table");
                data = table.split(",");
                sql = "select * from v" + data[0] + " where delete_flag <> 'Y' and complete_flag = 'N' order by runno";
                //JOptionPane.showConfirmDialog(null, sql);
                process = data[1];
                if (process.equals("PR_022")) {
                    //f = "net_weight_ch";
                    f = "carbon_net";
                    w = "wh_in";
                    l = "position_no";
                } else if (process.equals("PR_025")) {
                    f = "weight_balance";
                } else if (process.equals("PR_032")) {
                    f = "";
                }else if (process.equals("PR_029")) {
                    l_out = "loc_id";
                    //f = "weight";
                    f="wh_weight";
                    w = "wh_id";
                } else if (process.equals("PR_034")) {
                    f = "weight";
                } else if (process.equals("PR_036")) {
                    f = "qty";
                } else if (process.equals("PR_042")) {
                    l_out = "lot_no";
                    f = "weight";
                } else if (process.equals("PR_038")) {
                    l_out = "location_id2";
                    f = "weight";
                } else if (process.equals("PR_040")) {
                    l_out = "location_id2";
                    w = "wh_id";
                    f = "weight";
                } else {
                    f = "weight";
                }

                htmltext = "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>";
                con = dbConnect.openNewConnection();
                p = con.prepareStatement(sql);
                //p.setString(1, id);
                rs = p.executeQuery();
                if (!process.equals("PR_032")) {

                    while (rs.next()) {
                        htmltext += "<tr>"
                                + "<td class='forborder' width='3px'><input type='checkbox' name='DEL_" + cnt + "' id='DEL_" + cnt + "' value='" + rs.getString("doc_id") + "' /></td>"
                                + "<td class='forborder' width='3%'>" + (cnt + 1) + "</td>"
                                + "<td class='forborder' width='14%'>" + rs.getString("doc_id") + "</td>"
                                + "<td class='forborder' width='11%'>" + rs.getString("doc_date") + "</td>"
                                + "<td class='forborder' width='10%' align='center'>-</td>"
                                + "<td class='forborder' width='10%'>" + rs.getString("product_id") + "</td>"
                                + "<td class='forborder' width='10%' align='right'>" + rs.getString(f) + "&nbsp;</td>"
                                + "<td class='forborder' width='13%'><input type='text' class="inputs" name='prod_code_" + cnt + "' id='prod_code_" + cnt + "' value='" + rs.getString("product_id") + "' size='12'/></td>"
                                + "<td class='forborder' width='7%'><input type='text' class="inputs" name='location_" + cnt + "' id='location_" + cnt + "' value='" + rs.getString(l) + "' size='5'/></td>"
                                + "<td class='forborder' width='9%'><input type='text' class="inputs" name='wh_" + cnt + "' id='wh_" + cnt + "' value='" + rs.getString(w) + "' size='8'/></td>"
                                + "<td class='forborder' width='10%'><input type='text' class="inputs" name='weight_" + cnt + "' id='weight_" + cnt + "' value='" + rs.getString(f) + "' size='9'/></td>";
                        if(process.equals("PR_022")){
                                htmltext +=  "<input type='hidden' name='total_price_" + cnt + "' id='total_price_" + cnt + "' value='" + rs.getString("total_price") + "'/>";
                        }else{
                            htmltext += "<input type='hidden' name='location_out_"+cnt+"' id='location_out_"+cnt+"' value='"+rs.getString(l_out)+"'";
                        }
                        htmltext += "</tr>";
                        cnt++;
                    }
                } else {
                    htmltext = "<td class='forborder' colspan='11' align='center'>ไม่มี Process</td>";
                }
                htmltext += "</table>";
                out.print(htmltext);
            } catch (Exception e) {
                e.printStackTrace(System.out);
            } finally {
                try {
                    p.close();
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace(System.out);
                }
            }
%>
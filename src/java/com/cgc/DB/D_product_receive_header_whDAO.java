/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_product_receive_header;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

/**
 *
 * @author Administrator
 */
public class D_product_receive_header_whDAO {

    private int Returnvalue;

    public int update(DataBeanD_product_receive_header dataBean) throws Exception {
        Returnvalue = 0;
        UtiDatabase objuti = new UtiDatabase();
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql =
                "update d_product_receive_header_wh set  "
                + "doc_type=?,update_date=?,update_by=? "
                + " where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p = null;
        try {
            if (dataBean.getReturn_document_flag().equalsIgnoreCase("N")) {
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getConfirm_document_flag());
                p.setTimestamp(2, dataBean.getDate());
                p.setString(3, dataBean.getBy());
                p.setString(4, dataBean.getDoc_id());
                p.executeUpdate();
                sql = "select count(doc_id) as num from d_product_receive_detail_wh where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
                if (objuti.numRowdatabase(sql) != 0) {
                    sql = "update d_product_receive_detail_wh set wh_in=?,wh_out=?,doc_date=?,update_by=?,job_id=?,update_date=? where doc_id = ? and delete_flag = 'N' and complete_flag = 'N'";
                    p = null;
                    p = con.prepareStatement(sql);
                    p.setString(1, dataBean.getWh_in());
                    p.setString(2, dataBean.getWh_out());
                    p.setString(3, dataBean.getDoc_date());
                    p.setString(4, dataBean.getBy());
                    p.setString(5, dataBean.getJob_id());
                    p.setTimestamp(6, dataBean.getDate());
                    p.setString(7, dataBean.getDoc_id());
                    p.executeUpdate();
                }
                sql = "select count(doc_id) as num from d_product_receive_detail_prod_wh where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
                if (objuti.numRowdatabase(sql) != 0) {
                    sql = "update d_product_receive_detail_prod_wh set wh_in=?,wh_out=?,doc_date=?,update_by=?,job_id=?,update_date=?  where doc_id = ? and delete_flag = 'N' and complete_flag = 'N'";
                    p = null;
                    p = con.prepareStatement(sql);
                    p.setString(1, dataBean.getWh_in());
                    p.setString(2, dataBean.getWh_out());
                    p.setString(3, dataBean.getDoc_date());
                    p.setString(4, dataBean.getBy());
                    p.setString(5, dataBean.getJob_id());
                    p.setTimestamp(6, dataBean.getDate());
                    p.setString(7, dataBean.getDoc_id());
                    p.executeUpdate();
                }
            } else {
                Returnvalue = Return_Document("d_product_receive", dataBean.getDoc_id(), con, p, objuti);
            }

        } finally {
            try {
                if (p != null) {
                    p.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }
        return Returnvalue;

    }

    public void update_D_job_order(Connection con, PreparedStatement p, String job_id, String job_id_end) throws Exception {
        String SQL = "update d_job_order_header set doc_type = ?  where doc_id = ? and delete_flag = 'N' and complete_flag = 'N'";
        try {
            p = con.prepareStatement(SQL);
            p.setString(1, job_id_end);
            p.setString(2, job_id);
            p.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
        }

    }

    public void UpDel(DataBeanD_product_receive_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqlheader = "update d_product_receive_header set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        String sqldetail = "update d_product_receive_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        String sqldetail_prod = "update d_product_receive_detail_prod set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p = null;
        try {
            for (int i = 0; i < 3; i++) {
                if (i == 0) {
                    p = con.prepareStatement(sqlheader);
                } else if (i == 2) {
                    p = con.prepareStatement(sqldetail);
                } else {
                    p = con.prepareStatement(sqldetail_prod);
                }
                p.setString(1, "Y");
                p.setTimestamp(2, dataBean.getDate());
                p.setString(3, dataBean.getBy());
                p.setString(4, dataBean.getDoc_id());
                p.executeUpdate();
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }

    }

    private int Return_Document(String Table_name, String doc_id, Connection con, PreparedStatement p, UtiDatabase Objuti) throws Exception {
        String SQLDetail = "";
        int status_return = 0;
        try {
            //SQLHeader = "Select count(doc_id) as num from "+Table_name+"_header_wh where doc_id = '"+doc_id+"' and delete_flag = 'N' and complete_flag = 'Y'";
            SQLDetail = "Select count(doc_id) as num from " + Table_name + "_detail_wh where doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'Y'";
            if (Objuti.numRowdatabase(SQLDetail) == 0) {
                //***************Delete Warehouse********************************
                p = con.prepareStatement("DELETE FROM " + Table_name + "_header_wh where doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'N'");
                p.executeUpdate();
                p.clearParameters();
                p = con.prepareStatement("DELETE FROM " + Table_name + "_detail_wh where doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'N'");
                p.executeUpdate();
                p.clearParameters();
                p = con.prepareStatement("DELETE FROM " + Table_name + "_detail_prod_wh where doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'N'");
                p.executeUpdate();
                p.clearParameters();
                //***************************************************************
                //**************return Complet_flag *****************************
                p = con.prepareStatement("UPDATE " + Table_name + "_header set complete_flag = 'N' WHERE doc_id ='" + doc_id + "' and delete_flag = 'N' and complete_flag = 'Y'");
                p.executeUpdate();
                p.clearParameters();
                p = con.prepareStatement("UPDATE " + Table_name + "_detail set complete_flag = 'N' WHERE doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'Y'");
                p.executeUpdate();
                p.clearParameters();
                p = con.prepareStatement("UPDATE " + Table_name + "_detail_prod set complete_flag = 'N' WHERE doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'Y'");
                p.executeUpdate();
                p.clearParameters();
                //***************************************************************
                status_return = 1;
            } else {
                status_return = 0;
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            return status_return;
        }
    }

    public String Cal_Approve(String[] string_input, String[] string_doc_id, String username) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        String SQL = "";
        int count = 0;
        try {
            while (count < 3) {
                SQL = "update " + ((count == 0) ? "d_product_receive_header_wh" : (count == 1) ? "d_product_receive_detail_wh" : "d_product_receive_detail_prod_wh") + " set doc_type = 'Y',complete_flag = 'Y',update_by=?,update_date=? "
                        + "where "
                        + ((count == 0) ? "runno" : "doc_id") + " = ? and delete_flag = 'N' and complete_flag = 'N'";
                p = con.prepareStatement(SQL);
                for (int i = 0; i < string_input.length; i++) {
                    switch (count) {
                        case 0:
                            p.setString(1, username);
                            p.setTimestamp(2, new Timestamp(new java.util.Date().getTime()));
                            p.setInt(3, Integer.parseInt(string_input[i]));
                            break;
                        default:
                            p.setString(1, username);
                            p.setTimestamp(2, new Timestamp(new java.util.Date().getTime()));
                            p.setString(3, string_doc_id[i]);
                            break;
                    }
                    p.addBatch();
                }
                p.executeBatch();
                p.clearBatch();
                count += 1;
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            if (con != null) {
                con.close();
            }
            return "ทำการอนุมัติสำเร็จ";
        }
    }

    public String Show_Approve(String Screen) throws Exception {
        int start, row_page = 15, total = 0, screen, count_line = 1;
        UtiDatabase objuti = new UtiDatabase();
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        StringBuffer Return_String = new StringBuffer();
        ResultSet rs = null;
        String SQL = "";
        total = objuti.numRowdatabase("Select Count(doc_id) As num from  d_product_receive_header_wh where delete_flag = 'N' and complete_flag = 'N'");
        try {
            if (total != 0) {
                int total_page = (int) Math.ceil((double) total / (double) row_page);
                screen = Screen == null ? 1 : Integer.parseInt(Screen);
                if (screen >= 1 && screen <= total) {
                    start = (screen - 1) * row_page;
                    SQL = "select "
                            + "runno,doc_id,doc_date,product_id,job_id,size,"
                            + "(select mproduct.name_t from mproduct where mproduct.product_id = d_product_receive_header_wh.product_id and mproduct.delete_flag = 'N') as product_name,"
                            + "(select cust_name from  vd_job_order_header where vd_job_order_header.doc_id = d_product_receive_header_wh.job_id and vd_job_order_header.delete_flag  = 'N') as job_cust_name "
                            + "FROM d_product_receive_header_wh where delete_flag = 'N' and complete_flag = 'N' order by runno desc limit " + row_page + " offset " + start;
                    Return_String.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>\n");
                    rs = con.createStatement().executeQuery(SQL);
                    while (rs.next()) {
                        Return_String.append("<tr>\n");
                        Return_String.append("<td class='forborder' width='3px'><input type='checkbox' id='ckbox' value='" + rs.getString("runno") + "' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>");
                        Return_String.append("<td class='forborder' width='7%'>" + count_line + "</td>\n");
                        Return_String.append("<td class='forborder' width='15%'>" + objuti.NotNull(rs.getString("doc_id")) + "<input type = 'hidden' id = 'line_doc_id_" + rs.getString("runno") + "' value = '" + rs.getString("doc_id") + "' name = 'line_doc_id'>&nbsp;</td>\n");
                        Return_String.append("<td class='forborder' width='10%'>" + objuti.NotNull(rs.getString("doc_date")) + "</td>\n");
                        Return_String.append("<td class='forborder' width='15%'>" + objuti.NotNull(rs.getString("product_id")) + "&nbsp;" + objuti.NotNull(rs.getString("product_name")) + "</td>\n");
                        Return_String.append("<td class='forborder' width='10%'>" + objuti.NotNull(rs.getString("size")) + "</td>\n");
                        Return_String.append("<td class='forborder' width='10%'>" + objuti.NotNull(rs.getString("job_id")) + "&nbsp;</td>\n");
                        Return_String.append("<td class='forborder' width='30%'>" + objuti.NotNull(rs.getString("job_cust_name")) + "&nbsp;</td>\n");
                        Return_String.append("</tr>\n");
                        count_line += 1;
                    }
                    Return_String.append("</table>");
                }
                Return_String.append("<div align='center'>\n");
                if ((screen % 10) != 0 && screen <= 10) {
                    for (int count = 1; count <= 10 && count <= total_page; count++) {
                        if (count == screen) {
                            Return_String.append(" [" + count + "] |");
                        } else {
                            Return_String.append(" <a href='#'  onclick = \"showTableNonPopup_Detail('show','doc_id','s_screen_" + count + "','../JSP/CS_Show056.jsp?doc_id=')\"><input type = 'hidden' id='s_screen_" + count + "' name='s_screen_" + count + "' value =\"" + count + "\">" + count + "</a> |");
                        }

                    }
                    //**************************************************Select**************************************
                    /*Return_String.append("<select id='select_screen' name = 'select_screen'>");
                    for(int count = 1; count <= 10 && count <= total_page; count++){
                    if (count == screen) {
                    Return_String.append("<option selected  value=\'"+count+"\' onclick = \"showTableNonPopup_Detail('show','A_doc_id','select_screen','../SHOWDETAILSCREEN/BW_CS_Show026.jsp?doc_id=')\">"+count+"</option>");
                    }else{
                    Return_String.append("<option   value=\'"+count+"\' onclick = \"showTableNonPopup_Detail('show','A_doc_id','select_screen','../SHOWDETAILSCREEN/BW_CS_Show026.jsp?doc_id=')\">"+count+"</option>");
                    }
                    }
                    Return_String.append("</select>");*/
                    //**************************************************Select**************************************
                } else {
                    for (int count = (screen - 5); count <= (screen + 5) && count <= total_page; count++) {
                        if (count == screen) {
                            Return_String.append("| [" + count + "] |");
                        } else {
                            Return_String.append(" <a href='#' onclick = \"showTableNonPopup_Detail('show','doc_id','s_screen_" + count + "','../JSP/CS_Show056.jsp?doc_id=')\"><input type = 'hidden' id='s_screen_" + count + "' name='s_screen_" + count + "' value ='" + count + "'>" + count + "</a> |");
                        }
                    }
                    //**************************************************Select**************************************
                    /*Return_String.append("<select id='select_screen' name = 'select_screen'>");
                    for(int count = (screen - 5); count <= (screen + 5) && count <= total_page; count++){
                    if (count == screen) {
                    Return_String.append("<option selected  value=\'"+count+"\' onclick = \"showTableNonPopup_Detail('show','A_doc_id','select_screen','../SHOWDETAILSCREEN/BW_CS_Show026.jsp?doc_id=')\">"+count+"</option>");
                    }else{
                    Return_String.append("<option   value=\'"+count+"\' onclick = \"showTableNonPopup_Detail('show','A_doc_id','select_screen','../SHOWDETAILSCREEN/BW_CS_Show026.jsp?doc_id=')\">"+count+"</option>");
                    }
                    }
                    Return_String.append("</select>");*/
                    //**************************************************Select**************************************
                }
                Return_String.append("</div>\n");

            } else {
                Return_String.append("ไม่พบข้อมูลที่ต้องการ");
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {

            if (rs != null) {
                rs.close();
            }
            if (con != null) {
                con.close();
            }
            return Return_String.toString();

        }

    }

    public String Show_Approve_Date(String Doc_date) throws Exception {
        int total = 0, count_line;
        UtiDatabase objuti = new UtiDatabase();
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        StringBuffer Return_String = new StringBuffer();
        ResultSet rs = null;
        String SQL = "";
        total = objuti.numRowdatabase("Select Count(doc_id) As num from  d_product_receive_header_wh where doc_date = '" + Doc_date + "' and delete_flag = 'N' and complete_flag = 'N'");
        try {

            if (total != 0) {
                count_line = 1;
                SQL = "select "
                        + "runno,doc_id,doc_date,product_id,job_id,size,"
                        + "(select mproduct.name_t from mproduct where mproduct.product_id = d_product_receive_header_wh.product_id and mproduct.delete_flag = 'N') as product_name,"
                        + "(select cust_name from  vd_job_order_header where vd_job_order_header.doc_id = vd_product_receive_header_wh.job_id and d_job_order_header = 'N') as job_cust_name "
                        + "FROM d_product_receive_header_wh "
                        + "WHERE doc_date = '" + Doc_date + "' and delete_flag = 'N' and complete_flag = 'N' order by runno desc";
                Return_String.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>\n");
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    Return_String.append("<tr>\n");
                    Return_String.append("<td class='forborder' width='3%'><input type='checkbox' id='ckbox' value='" + rs.getString("runno") + "' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>");
                    Return_String.append("<td class='forborder' width='7%'>" + count_line + "</td>\n");
                    Return_String.append("<td class='forborder' width='15%'>" + objuti.NotNull(rs.getString("doc_id")) + "<input type = 'hidden' id = 'line_doc_id_" + rs.getString("runno") + "' value = '" + rs.getString("doc_id") + "' name = 'line_doc_id'>&nbsp;</td>\n");
                    Return_String.append("<td class='forborder' width='10%'>" + objuti.NotNull(rs.getString("doc_date")) + "</td>\n");
                    Return_String.append("<td class='forborder' width='15%'>" + objuti.NotNull(rs.getString("product_id")) + "&nbsp;" + objuti.NotNull(rs.getString("product_name")) + "</td>\n");
                    Return_String.append("<td class='forborder' width='10%'>" + objuti.NotNull(rs.getString("size")) + "</td>\n");
                    Return_String.append("<td class='forborder' width='10%'>" + objuti.NotNull(rs.getString("job_id")) + "&nbsp;</td>\n");
                    Return_String.append("<td class='forborder' width='30%'>" + objuti.NotNull(rs.getString("job_cust_name")) + "&nbsp;</td>\n");
                    Return_String.append("</tr>\n");
                    count_line += 1;
                }
                Return_String.append("</table>");

            } else {
                Return_String.append("ไม่พบข้อมูลที่ต้องการ");
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {

            if (rs != null) {
                rs.close();
            }
            if (con != null) {
                con.close();
            }
            return Return_String.toString();

        }

    }
}

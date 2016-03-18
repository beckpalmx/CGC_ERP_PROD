/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_carbon_burn_out_header;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Beck
 */
public class D_carbon_burn_out_header_whDAO {

    private int Returnvalue;
    private double lost_total;
    private UtiDatabase objuti;

    public int insert(DataBeanD_carbon_burn_out_header dataBean) throws Exception {
        objuti = new UtiDatabase();
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        PreparedStatement p = null;
        try {
            String sql = "select count(doc_id) as num from d_carbon_burn_out_detail_wh where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
            if (objuti.numRowdatabase(sql) != 0) {//ตรวจสอบว่ารหัสนี้มี Row ใน Detail หรือไม่

                sql = "update d_carbon_burn_out_detail_wh set doc_date=?,wh_in=?,wh_out=?,create_by=?,shift=?,complete_flag=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                p = null;
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getDoc_date());
                p.setString(2, dataBean.getWh_in());
                p.setString(3, dataBean.getWh_out());
                p.setString(4, dataBean.getBy());
                p.setString(5, dataBean.getShift());
                p.setString(6, "N");
                p.setString(7, dataBean.getDoc_id());
                Returnvalue = p.executeUpdate();
            }

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }

        return Returnvalue;
    }
    public int update(DataBeanD_carbon_burn_out_header dataBean) throws Exception {
        objuti = new UtiDatabase();
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        String sql = null;
        Connection con = objcon.openNewConnection();
        PreparedStatement p = null;
        try {
            sql = "update d_carbon_burn_out_header_wh set doc_type = ?,update_by=?,update_date=? where doc_id = ? and delete_flag = 'N' and complete_flag = 'N'";
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_type());
            p.setString(2, dataBean.getBy());
            p.setTimestamp(3, dataBean.getDate());
            p.setString(4, dataBean.getDoc_id());
            p.executeUpdate();
            p.clearParameters();
            if (dataBean.getComplete_flag().equalsIgnoreCase("N")) {
                sql = "select count(doc_id) as num from d_carbon_burn_out_detail_wh where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
                if (objuti.numRowdatabase(sql) != 0) {//ตรวจสอบว่ารหัสนี้มี Row ใน Detail หรือไม่
                    sql = "update d_carbon_burn_out_detail_wh set doc_date=?,wh_in=?,wh_out=?,update_by=?,shift=?,update_date=? where doc_id = ? and delete_flag <> 'Y' and complete_flag <> 'Y'";
                    p = null;
                    p = con.prepareStatement(sql);
                    p.setString(1, dataBean.getDoc_date());
                    p.setString(2, dataBean.getWh_in());
                    p.setString(3, dataBean.getWh_out());
                    p.setString(4, dataBean.getBy());
                    p.setString(5, dataBean.getShift());
                    p.setTimestamp(6, dataBean.getDate());
                    p.setString(7, dataBean.getDoc_id());
                    Returnvalue = p.executeUpdate();
                }
            } else {
                Returnvalue = Return_Document("d_carbon_burn_out", dataBean.getDoc_id(), con, p, objuti);
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
    public void UpDel(DataBeanD_carbon_burn_out_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqlheader = "update d_carbon_burn_out_detail_wh set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        String sqldetail = "update d_carbon_burn_out_detail_wh set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p = null;
        try {
            for (int i = 0; i < 2; i++) {
                if (i == 0) {
                    p = con.prepareStatement(sqlheader);
                } else {
                    p = con.prepareStatement(sqldetail);
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
    /*
    private void CopyToD_carbon_burn_out_wh(DataBeanD_carbon_burn_out_header dataBean) throws Exception {
    UtiDatabase objuti = new UtiDatabase();
    DBConnect objcon = new DBConnect();
    Connection con = objcon.openNewConnection();
    String SQLcount = "select count(doc_id) as num from d_carbon_burn_out_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag = 'Y'";
    String SQLcopy = "Select * from  d_carbon_burn_out_detail where doc_id='" + dataBean.getDoc_id() + "' and complete_flag ='Y' and delete_flag ='N' order by  to_number(line_no,'9999')";
    String SQLinsert_header = "insert into d_carbon_burn_out_header_wh "
    + "(doc_id,doc_date,work_date,time_from,time_to,runner_id,shift,wh_in,wh_out,burn_no,product_id,ch_from,ch_to,weight_split,burn_out_date,lost_weight,total_weight,create_date,update_date,create_by,report_id)"
    + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    String SQLinsert_detail = "insert into d_carbon_burn_out_detail_wh "
    + "(doc_id,line_no,wh_in,wh_out,doc_date,production_no,size,g_code,g_sum,ctc_i2,bag,weight,lost,remark,create_date,create_by,shift) "
    + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    ResultSet rs = null;
    PreparedStatement p = null;
    try {
    p = con.prepareStatement(SQLinsert_header);
    p.setString(1, dataBean.getDoc_id());
    p.setString(2, dataBean.getDoc_date());
    p.setString(3, dataBean.getWork_date());
    p.setString(4, dataBean.getTime_from());
    p.setString(5, dataBean.getTime_to());
    p.setString(6, dataBean.getRunner_id());
    p.setString(7, dataBean.getShift());
    p.setString(8, dataBean.getWh_in());
    p.setString(9, dataBean.getWh_out());
    p.setString(10, dataBean.getBurn_no());
    p.setString(11, dataBean.getProduct_id());
    p.setString(12, dataBean.getCh_from());
    p.setString(13, dataBean.getCh_to());
    p.setString(14, dataBean.getWeight_split());
    p.setString(15, dataBean.getBurn_out_date());
    p.setString(16, dataBean.getLost_weight());
    p.setString(17, dataBean.getTotal_weight());
    p.setTimestamp(18, dataBean.getDate());
    p.setTimestamp(19, dataBean.getDate());
    p.setString(20, dataBean.getBy());
    p.setString(21, dataBean.getReport_id());
    p.executeUpdate();

    if (objuti.numRowdatabase(SQLcount) != 0) {
    rs = con.createStatement().executeQuery(SQLcopy);
    while (rs.next()) {
    p = null;
    p = con.prepareStatement(SQLinsert_detail);
    p.setString(1, rs.getString("doc_id"));
    p.setString(2, rs.getString("line_no"));
    p.setString(3, rs.getString("wh_in"));
    p.setString(4, rs.getString("wh_out"));
    p.setString(5, rs.getString("doc_date"));
    p.setString(6, rs.getString("production_no"));
    p.setString(7, rs.getString("size"));
    p.setString(8, rs.getString("g_code"));
    p.setString(9, rs.getString("g_sum"));
    p.setString(10, rs.getString("ctc_i2"));
    p.setString(11, rs.getString("bag"));
    p.setString(12, rs.getString("weight"));
    p.setString(13, rs.getString("lost"));
    p.setString(14, rs.getString("remark"));
    p.setTimestamp(15, dataBean.getDate());
    p.setString(16, dataBean.getBy());
    p.setString(17,rs.getString("shift"));
    Returnvalue = p.executeUpdate();
    }
    }

    } catch (Exception e) {
    e.printStackTrace(System.out);
    } finally {
    if (rs != null) {
    rs.close();
    }
    if (p != null) {
    p.close();
    }
    if (con != null) {
    con.close();
    }
    }
    }*/

    public int Return_Document(String Table_name, String doc_id, Connection con, PreparedStatement p, UtiDatabase Objuti) throws Exception {
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
                //***************************************************************
                p.clearParameters();
                //**************return Complet_flag *****************************
                p = con.prepareStatement("UPDATE " + Table_name + "_header set complete_flag = 'N' WHERE doc_id ='" + doc_id + "' and delete_flag = 'N' and complete_flag = 'Y'");
                p.executeUpdate();
                p.clearParameters();
                p = con.prepareStatement("UPDATE " + Table_name + "_detail set complete_flag = 'N' WHERE doc_id = '" + doc_id + "' and delete_flag = 'N' and complete_flag = 'Y'");
                p.executeUpdate();
                p.clearParameters();
                //***************************************************************
                status_return = 1;
            } else {
                status_return = -1;
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

    public String Show_Approve(String Screen) throws Exception {
        int start, row_page = 15, total = 0, screen, count_line = 1;
        objuti = new UtiDatabase();
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        StringBuffer Return_String = new StringBuffer();
        ResultSet rs = null;
        String SQL = "";
        total = objuti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_burn_out_header_wh where delete_flag = 'N' and complete_flag = 'N'");
        try {

            if (total != 0) {
                int total_page = (int) Math.ceil((double) total / (double) row_page);
                screen = Screen == null ? 1 : Integer.parseInt(Screen);
                if (screen >= 1 && screen <= total) {
                    start = (screen - 1) * row_page;
                    SQL = "select "
                            + "runno,doc_id,doc_date,product_id,work_date,time_from,time_to,total_weight,"
                            + "(select mproduct.name_t from mproduct where mproduct.product_id = show_detail_d_carbon_burn_out_wh.product_id and mproduct.delete_flag = 'N') as product_name "
                            + "FROM show_detail_d_carbon_burn_out_wh(" + row_page + "," + start + ")";
                    
                    System.out.println("F SQL : " + SQL);
                    Return_String.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>\n");
                    rs = con.createStatement().executeQuery(SQL);
                    while (rs.next()) {
                        Return_String.append("<tr>\n");
                        Return_String.append("<td class='forborder' width='3px'><input type='checkbox' id='ckbox' value='" + rs.getString("runno") + "' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>");
                        Return_String.append("<td class='forborder' width='7%'>" + count_line + "</td>\n");
                        Return_String.append("<td class='forborder' width='15%'>" + objuti.NotNull(rs.getString("doc_id")) + "<input type = 'hidden' id = 'line_doc_id_"+rs.getString("runno")+"' value = '"+rs.getString("doc_id")+"' name = 'line_doc_id'>&nbsp;</td>\n");
                        Return_String.append("<td class='forborder' width='15%'>" + objuti.NotNull(rs.getString("doc_date")) + "</td>\n");
                        Return_String.append("<td class='forborder' width='15%'>" + objuti.NotNull(rs.getString("product_id")) + "&nbsp;" + objuti.NotNull(rs.getString("product_name")) + "</td>\n");
                        Return_String.append("<td class='forborder' width='15%'>" + objuti.NotNull(rs.getString("work_date")) + "</td>\n");
                        Return_String.append("<td class='forborder' width='15%'>" + objuti.NotNull(rs.getString("time_from")) + "&nbsp;</td>\n");
                        Return_String.append("<td class='forborder' width='15%'>" + objuti.NotNull(rs.getString("time_from")) + "&nbsp;</td>\n");
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
                            Return_String.append(" <a href='#'  onclick = \"showTableNonPopup_Detail('show','doc_id','s_screen_" + count + "','../JSP/CS_Show055.jsp?doc_id=')\"><input type = 'hidden' id='s_screen_" + count + "' name='s_screen_" + count + "' value =\"" + count + "\">" + count + "</a> |");
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
                            Return_String.append(" <a href='#' onclick = \"showTableNonPopup_Detail('show','doc_id','s_screen_" + count + "','../JSP/CS_Show055.jsp?doc_id=')\"><input type = 'hidden' id='s_screen_" + count + "' name='s_screen_" + count + "' value ='" + count + "'>" + count + "</a> |");
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

    public String Cal_Approve(String[] string_input,String[] string_doc_id) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        String SQL = "";
        int count = 0;
        try {
            while (count < 2) {
                SQL = "update "+((count == 0) ?"d_carbon_burn_out_header_wh":"d_carbon_burn_out_detail_wh")+" set doc_type = 'Y',complete_flag = 'Y' "
                        + "where "
                        + ((count == 0) ?"runno":"doc_id")+" = ? and delete_flag = 'N' and complete_flag = 'N'";
                p = con.prepareStatement(SQL);
                for (int i = 0; i < string_input.length; i++) {
                    switch (count){
                        case 0:
                            p.setInt(1, Integer.parseInt(string_input[i]));
                            break;
                        case 1:
                             p.setString(1,string_doc_id[i]);
                            break;
                    }
                    p.addBatch();
                }
                p.executeBatch();
                p.clearBatch();
                count +=1;
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
    public String Show_Approve_Date(String Doc_date) throws Exception {
        int total = 0,count_line;
        objuti = new UtiDatabase();
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        StringBuffer Return_String = new StringBuffer();
        ResultSet rs = null;
        String SQL = "";
        total = objuti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_burn_out_header_wh where doc_date = '"+Doc_date+"' and delete_flag = 'N' and complete_flag = 'N'");
        try {

            if (total != 0) {
                count_line = 1;
                    SQL = "select "
                            + "runno,doc_id,doc_date,product_id,work_date,time_from,time_to,total_weight,"
                            + "(select mproduct.name_t from mproduct where mproduct.product_id = d_carbon_burn_out_header_wh.product_id and mproduct.delete_flag = 'N') as product_name "
                            + "FROM d_carbon_burn_out_header_wh "
                            + "WHERE doc_date = '"+Doc_date+"' and delete_flag = 'N' and complete_flag = 'N'";
                    Return_String.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>\n");
                    rs = con.createStatement().executeQuery(SQL);
                    while (rs.next()) {
                        Return_String.append("<tr>\n");
                        Return_String.append("<td class='forborder' width='3px'><input type='checkbox' id='ckbox' value='" + rs.getString("runno") + "' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>");
                        Return_String.append("<td class='forborder' width='7%'>" + count_line + "</td>\n");
                        Return_String.append("<td class='forborder' width='15%'>" + objuti.NotNull(rs.getString("doc_id")) + "<input type = 'hidden' id = 'line_doc_id_"+rs.getString("runno")+"' value = '"+rs.getString("doc_id")+"' name = 'line_doc_id'>&nbsp;</td>\n");
                        Return_String.append("<td class='forborder' width='15%'>" + objuti.NotNull(rs.getString("doc_date")) + "</td>\n");
                        Return_String.append("<td class='forborder' width='15%'>" + objuti.NotNull(rs.getString("product_id")) + "&nbsp;" + objuti.NotNull(rs.getString("product_name")) + "</td>\n");
                        Return_String.append("<td class='forborder' width='15%'>" + objuti.NotNull(rs.getString("work_date")) + "</td>\n");
                        Return_String.append("<td class='forborder' width='15%'>" + objuti.NotNull(rs.getString("time_from")) + "&nbsp;</td>\n");
                        Return_String.append("<td class='forborder' width='15%'>" + objuti.NotNull(rs.getString("time_from")) + "&nbsp;</td>\n");
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

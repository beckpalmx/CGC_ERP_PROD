/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Administrator
 */
public class CS_311DAO {

    public String ShowAll() throws Exception {
        Connection con = new DBConnect().openNewConnection();
        StringBuffer String_return = new StringBuffer();
        ResultSet rs = null;
        String SQL = null;
        int count = 1;
        try {
            SQL = "SELECT "
                    + "runno,doc_id,doc_date,job_id,po_no,net_weight_wh"
                    + " FROM "
                    + " d_requisition_product_header_wh "
                    + " WHERE "
                    + "complete_flag = 'Y' and delete_flag = 'N' and approve_flag = 'N' order by runno desc";

            rs = con.createStatement().executeQuery(SQL);
            String_return.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>\n");
            while (rs.next()) {
                String_return.append("<tr>\n");
                String_return.append("<td class='forborder' width='3%'><input type='checkbox' id='ckbox_" + rs.getString("runno") + "' name='ckbox' value ='" + rs.getString("runno") + "' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>\n");
                String_return.append("<td class='forborder' width='7%'>" + count + "&nbsp;</td>\n");
                String_return.append("<td class='forborder' width='15%'>" + rs.getString("doc_id") + "&nbsp;</td>\n");
                String_return.append("<td class='forborder' width='15%'>" + rs.getString("doc_date") + "&nbsp;</td>\n");
                String_return.append("<td class='forborder' width='15%'>" + rs.getString("job_id") + "&nbsp;</td>\n");
                String_return.append("<td class='forborder' width='15%'>" + rs.getString("po_no") + "&nbsp;</td>\n");
                String_return.append("<td class='forborder' width='30%'>" + rs.getString("net_weight_wh") + "&nbsp;</td>\n");
                String_return.append("</tr>\n");
                count += 1;
            }
            String_return.append("</table>");

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (con != null) {
                con.close();
            }
            return String_return.toString();
        }
    }
    public String Cal_Approve(String[] runno)throws Exception{
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        String SQL = null;
        try{
            SQL = "UPDATE "
                    + "d_requisition_product_header_wh"
                    + " SET "
                    + " approve_flag = ? "
                    + " WHERE runno = ? and complete_flag = 'Y' and delete_flag = 'N'";
            p = con.prepareStatement(SQL);
            for(int i = 0;i<runno.length;i++){
                p.setString(1, "Y");
                p.setInt(2, Integer.parseInt(runno[i]));
                p.addBatch();
            }
            p.executeBatch();
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            if(p != null){
                p.close();
            }
            if(con != null){
                con.close();
            }
            return "ทำการส่งข้อมูลสำเร็จ";
        }
    }
}

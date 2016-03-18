/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_carbon_out_analysis_detail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Man
 */
public class D_carbon_out_analysis_detailDAO {
    public void insert(DataBeanD_carbon_out_analysis_detail DataBean)throws Exception{
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        int i = 1;
        try{
            p = con.prepareStatement("insert into d_carbon_out_analysis_detail(doc_id,line_no,c_type1,bu1,avg1,c_type2,bu2,avg2,c_type3,bu3,avg3,create_by,create_date,update_date) "
                    + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            p.setString(i, DataBean.getDoc_id());i += 1;
            p.setString(i, DataBean.getLine_no());i += 1;
            p.setString(i, DataBean.getC_type1());i += 1;
            p.setString(i, DataBean.getBu1());i += 1;
            p.setString(i, DataBean.getAvg1());i += 1;
            p.setString(i, DataBean.getC_type2());i += 1;
            p.setString(i, DataBean.getBu2());i += 1;
            p.setString(i, DataBean.getAvg2());i += 1;
            p.setString(i, DataBean.getC_type3());i += 1;
            p.setString(i, DataBean.getBu3());i += 1;
            p.setString(i, DataBean.getAvg3());i += 1;            
            p.setString(i, DataBean.getBy());i += 1;
            p.setTimestamp(i, DataBean.getDate());i += 1;
            p.setTimestamp(i, DataBean.getDate());i += 1;
            p.executeUpdate();
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            if(p != null){
                p.close();
            }
            con.close();
        }
    }
    public void update(DataBeanD_carbon_out_analysis_detail DataBean)throws Exception{
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        int i = 1;
        try{
            p = con.prepareStatement("update d_carbon_out_analysis_detail set c_type1=?,bu1=?,avg1=?,c_type2=?,bu2=?,avg2=?,c_type3=?,bu3=?,avg3=?,update_by=?,update_date=? where doc_id = ? and line_no = ? and delete_flag = 'N' and complete_flag ='N' ");
            p.setString(i, DataBean.getC_type1());i += 1;
            p.setString(i, DataBean.getBu1());i += 1;
            p.setString(i, DataBean.getAvg1());i += 1;
            p.setString(i, DataBean.getC_type2());i += 1;
            p.setString(i, DataBean.getBu2());i += 1;
            p.setString(i, DataBean.getAvg2());i += 1;
            p.setString(i, DataBean.getC_type3());i += 1;
            p.setString(i, DataBean.getBu3());i += 1;
            p.setString(i, DataBean.getAvg3());i += 1;            
            p.setString(i, DataBean.getBy());i += 1;
            p.setTimestamp(i, DataBean.getDate());i += 1;
            p.setString(i, DataBean.getDoc_id());i += 1;
            p.setString(i, DataBean.getLine_no());i += 1;
            p.executeUpdate();
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            if(p != null){
                p.close();
            }
            con.close();
        }
    }
    public void Delete_line_no(String Select_line_no, DataBeanD_carbon_out_analysis_detail DataBean, String Table_Detail) throws Exception {
        StringBuffer old_line_no = new StringBuffer();
        String Str_old_line_no = "";
        Connection con = new DBConnect().openNewConnection();
        ResultSet rs = null;
        PreparedStatement p = null;
        UtiDatabase objuti = new UtiDatabase();
        int numrow = 0;
        try {
            if (Select_line_no.length() != 0) {
                String[] Number_Line_no = Select_line_no.split(",");
                p = con.prepareStatement("update "+Table_Detail+" set delete_flag='Y',delete_by=?,delete_date=? where doc_id =? and line_no = ? and complete_flag = 'N' and delete_flag = 'N'");
                for (int loop = 0; loop < Number_Line_no.length; loop++) {
                    p.setString(1, DataBean.getBy());
                    p.setTimestamp(2, DataBean.getDate());
                    p.setString(3, DataBean.getDoc_id());
                    p.setString(4, Number_Line_no[loop]);
                    p.addBatch();
                }
                p.executeBatch();
                numrow = objuti.numRowdatabase("Select count(doc_id) as num from " + Table_Detail + " where doc_id = '" + DataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'");
                if (numrow != 0) {
                    rs = con.createStatement().executeQuery("SELECT line_no from " + Table_Detail + " where doc_id = '" + DataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N' order by runno");
                    while (rs.next()) {
                        old_line_no.append(rs.getString("line_no"));
                        old_line_no.append(",");
                    }
                    Str_old_line_no = old_line_no.toString().substring(0, old_line_no.toString().length()-1);
                    Number_Line_no = null;
                    p  = null;
                    Number_Line_no = Str_old_line_no.split(",");
                    p = con.prepareStatement("update "+Table_Detail+" set line_no=? where doc_id =? and line_no = ? and complete_flag = 'N' and delete_flag = 'N'");
                    for (int loop = 0; loop < Number_Line_no.length; loop++) {
                        p.setString(1, Integer.toString(loop+1));
                        p.setString(2, DataBean.getDoc_id());
                        p.setString(3, Number_Line_no[loop]);
                        p.addBatch();
                    }
                    p.executeBatch();
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
            con.close();
        }
    }

    public void Delete_all_line_no(DataBeanD_carbon_out_analysis_detail DataBean, String Table_Detail) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        try {
            p = con.prepareStatement("update "+Table_Detail+" set delete_flag='Y',delete_by=?,delete_date=? Where doc_id = ?  and delete_flag = 'N' and  complete_flag = 'N'");
            p.setString(1, DataBean.getBy());
            p.setTimestamp(2, DataBean.getDate());
            p.setString(3, DataBean.getDoc_id());
            p.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            con.close();
        }
    }
    public DataBeanD_carbon_out_analysis_detail Return_Edit(String doc_id,String line_no)throws Exception{
        DataBeanD_carbon_out_analysis_detail DataBean = new DataBeanD_carbon_out_analysis_detail();
        Connection con = new DBConnect().openNewConnection();
        ResultSet rs = null;
        UtiDatabase objuti = new UtiDatabase();
        try{
            rs = con.createStatement().executeQuery("select c_type1,bu1,avg1,c_type2,bu2,avg2,c_type3,bu3,avg3 from d_carbon_out_analysis_detail where doc_id = '"+doc_id+"' and line_no = '"+line_no+"' and delete_flag = 'N' and complete_flag = 'N'");
            while(rs.next()){
                DataBean.setC_type1(objuti.NotNull(rs.getString("c_type1")));
                DataBean.setBu1(objuti.NotNull(rs.getString("bu1")));
                DataBean.setAvg1(objuti.NotNull(rs.getString("avg1")));
                DataBean.setC_type2(objuti.NotNull(rs.getString("c_type2")));
                DataBean.setBu2(objuti.NotNull(rs.getString("bu2")));
                DataBean.setAvg2(objuti.NotNull(rs.getString("avg2")));
                DataBean.setC_type3(objuti.NotNull(rs.getString("c_type3")));
                DataBean.setBu3(objuti.NotNull(rs.getString("bu3")));
                DataBean.setAvg3(objuti.NotNull(rs.getString("avg3")));                
            }
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            if(rs != null){
                rs.close();
            }
            con.close();
            return DataBean;
        }
    }
    public String ShowDetail(String doc_id)throws Exception{
        StringBuffer str_return = new StringBuffer();
        UtiDatabase objuti = new UtiDatabase();
        Connection con = new DBConnect().openNewConnection();
        ResultSet rs = null;
        String SQL = "select count(doc_id) as num from d_carbon_out_analysis_detail where doc_id = '"+doc_id+"' and delete_flag = 'N' and complete_flag = 'N'";
        try{
            str_return.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>");
            if(objuti.numRowdatabase(SQL) == 0){
                str_return.append("<tr ><td align='center'>ไม่พบข้อมูลที่ต้องการ</td></tr>");
            }else{
                SQL = "select runno,doc_id,line_no,c_type1,bu1,avg1,c_type2,bu2,avg2,c_type3,bu3,avg3 from d_carbon_out_analysis_detail where doc_id = '"+doc_id+"' and delete_flag = 'N' and complete_flag = 'N' order by to_number(line_no,'990')";
                rs = con.createStatement().executeQuery(SQL);
                while(rs.next()){
                    str_return.append("<tr>");
                    str_return.append("<td class='forborder' width='6%'><input type='checkbox' id='ckbox' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>");
                    str_return.append("<td class='forborder' width='11%'><a href=\"#\"  class='link_data_transparent' onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("line_no") + ",username,doc_id,tdate1,tname1,ttime1,tdate2,tname2,ttime2,tdate3,tname3,ttime3','../SCREEN/CS_Detail_D_carbon_out_analysis.jsp'))\"><input type='hidden' id='line_no_" + rs.getString("line_no") + "' value=\"" + rs.getString("line_no") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\"><input type='hidden' id='runno_" + rs.getString("runno") + "'' value=\"" + rs.getString("runno") + "\">" + rs.getString("line_no") + "</a></td>");
                    str_return.append("<td class='forborder' width='9%'>" + rs.getString("c_type1") + "</td>");
                    str_return.append("<td class='forborder' width='9%'>" + rs.getString("bu1") + "</td>");
                    str_return.append("<td class='forborder' width='9%'>" + rs.getString("avg1") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("c_type2") + "</td>");
                    str_return.append("<td class='forborder' width='9%'>" + rs.getString("bu2") + "</td>");
                    str_return.append("<td class='forborder' width='9%'>" + rs.getString("avg2") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("c_type3") + "</td>");
                    str_return.append("<td class='forborder' width='9%'>" + rs.getString("bu3") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("avg3") + "</td>");                    
                    str_return.append("</tr>");
                }
            }
            str_return.append("</table>");
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            if(rs != null){
                rs.close();
            }
            con.close();
           return str_return.toString();
        }
    }
}

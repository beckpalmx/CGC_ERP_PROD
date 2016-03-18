/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_carbon_friction_receive_detail_1;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Administrator
 */
public class D_carbon_friction_receive_detail_1DAO {

    public String product_id, location_id, friction_house, silo_no;
    UtiDatabase uti = new UtiDatabase();

    public void insert(DataBeanD_carbon_friction_receive_detail_1 DataBean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        int i = 1;
        try {
            p = con.prepareStatement("insert into d_carbon_friction_receive_detail_1(doc_id,line_no,product_id,friction_house,silo_no,location_id,balance_weight,remain_weight,create_by,create_date,update_date,doc_date) "
                    + "values(?,?,?,?,?,?,?,?,?,?,?,?)");
            p.setString(i, DataBean.getDoc_id());
            i += 1;
            p.setString(i, DataBean.getLine_no());
            i += 1;
            p.setString(i, DataBean.getProduct_id());
            i += 1;
            p.setString(i, DataBean.getFriction_house());
            i += 1;
            p.setString(i, DataBean.getSilo_no());
            i += 1;
            p.setString(i, DataBean.getLocation_id());
            i += 1;
            p.setString(i, DataBean.getBalance_weight());
            i += 1;
            p.setString(i, DataBean.getRemain_weight());
            i += 1;
            p.setString(i, DataBean.getBy());
            i += 1;
            p.setTimestamp(i, DataBean.getDate());
            i += 1;
            p.setTimestamp(i, DataBean.getDate());
            i += 1;
            p.setString(i, DataBean.getDoc_date());
            i += 1;

            String SqlCount = "Select Count(doc_id) As num from  d_carbon_friction_receive_detail_1 where doc_id = '" + DataBean.getDoc_id() + "' and delete_flag = 'N' and line_no = '" + DataBean.getLine_no() + "' ;";
            System.out.println("SqlCount = " + SqlCount);
            if (uti.numRowdatabase(SqlCount) == 0) {
                p.executeUpdate();
                System.out.println("Returnvalue = " + true);
            }

        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            con.close();
        }
    }

    public void update(DataBeanD_carbon_friction_receive_detail_1 DataBean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        int i = 1;
        try {
            p = con.prepareStatement("update d_carbon_friction_receive_detail_1 set "
                    + "product_id=?,friction_house=?,silo_no=?,location_id=?,balance_weight=?,remain_weight=?,update_by=?,update_date=?,doc_date=?"
                    + " where doc_id = '" + DataBean.getDoc_id() + "' and line_no = '" + DataBean.getLine_no() + "' and delete_flag = 'N' and complete_flag = 'N'");//insert into d_carbon_friction_receive_detail_2(doc_id,line_no,product_id,location_id,amount_bag,weight,total_weight,wh_in,create_by,create_date,update_date) ""values(?,?,?,?,?,?,?,?,?,?)
            p.setString(i, DataBean.getProduct_id());
            i += 1;
            p.setString(i, DataBean.getFriction_house());
            i += 1;
            p.setString(i, DataBean.getSilo_no());
            i += 1;
            p.setString(i, DataBean.getLocation_id());
            i += 1;
            p.setString(i, DataBean.getBalance_weight());
            i += 1;
            p.setString(i, DataBean.getRemain_weight());
            i += 1;
            p.setString(i, DataBean.getBy());
            i += 1;
            p.setTimestamp(i, DataBean.getDate());
            i += 1;
            p.setString(i, DataBean.getDoc_date());
            i += 1;
            p.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
            con.close();
        }
    }

    public DataBeanD_carbon_friction_receive_detail_1 ReturnEdit(String doc_id, String line_no) throws Exception {
        DataBeanD_carbon_friction_receive_detail_1 obj_return = new DataBeanD_carbon_friction_receive_detail_1();
        Connection con = new DBConnect().openNewConnection();
        ResultSet rs = null;
        //String SQL = "Select product_id,friction_house,silo_no,location_id,balance_weight,remain_weight,doc_date from d_carbon_friction_receive_detail_1 where doc_id ='"+doc_id+"' and line_no = '"+line_no+"' and delete_flag = 'N' and complete_flag = 'N'";
        String SQL = "Select product_id,friction_house,silo_no,location_id,balance_weight,remain_weight,doc_date from d_carbon_friction_receive_detail_1 where doc_id ='" + doc_id + "' and line_no = '" + line_no + "' and delete_flag = 'N' ";
        try {
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                obj_return.setProduct_id(rs.getString("product_id"));
                obj_return.setFriction_house(rs.getString("friction_house"));
                obj_return.setSilo_no(rs.getString("silo_no"));
                obj_return.setLocation_id(rs.getString("location_id"));
                obj_return.setBalance_weight(rs.getString("balance_weight"));
                obj_return.setRemain_weight(rs.getString("remain_weight"));
                obj_return.setDoc_date(rs.getString("doc_date"));
            }
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            con.close();
        }
        return obj_return;
    }

    public void DeleteLine_no(String inputarry, DataBeanD_carbon_friction_receive_detail_1 bean) throws Exception {        
        boolean ckclose = false;
        Connection con = new DBConnect().openNewConnection();
        int count = 1;
        ResultSet rs ;
        PreparedStatement p ;
        String sql, sql2;
        try {
            if (inputarry.length() != 0) {
                String[] strarry = inputarry.split(",");
                for (String strarry1 : strarry) {
                    sql = "update d_carbon_friction_receive_detail_1 set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and line_no=? and delete_flag = 'N' and complete_flag = 'N'";
                    p = con.prepareStatement(sql);
                    p.setString(1, "Y");
                    p.setTimestamp(2, bean.getDate());
                    p.setString(3, bean.getBy());
                    p.setString(4, bean.getDoc_id());
                    p.setString(5, strarry1);
                    p.executeUpdate();
                }
                if (strarry.length != -1) {
                    sql = "select count(doc_id) as num from d_carbon_friction_receive_detail_1 where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
                    if (uti.numRowdatabase(sql) != 0) {                        
                        sql2 = "Select line_no from  d_carbon_friction_receive_detail_1 where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag ='N' order by runno ";
                        rs = con.createStatement().executeQuery(sql2);
                        while (rs.next()) {
                            sql = "update d_carbon_friction_receive_detail_1 set line_no=? where doc_id=? and line_no=?";
                            p = con.prepareStatement(sql);
                            p.setString(1, Integer.toString(count));
                            p.setString(2, bean.getDoc_id());
                            p.setString(3, rs.getString("line_no"));
                            p.executeUpdate();
                            count = count + 1;
                        }

                        ckclose = true;
                    }
                }
            }
        } finally {
            try {
                if (ckclose) {
                    //rs.close();
                    //p.close();
                    con.close();
                }

            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }

    }

    public void Delete_line_no_All(DataBeanD_carbon_friction_receive_detail_1 dataBean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        String sqldetail = "update d_carbon_friction_receive_detail_1 set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p;
        try {

            p = con.prepareStatement(sqldetail);
            p.setString(1, "Y");
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getBy());
            p.setString(4, dataBean.getDoc_id());
            p.executeUpdate();

        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }

    }

    public String ShowDetail(String doc_id) throws Exception {
        StringBuilder str_return = new StringBuilder();
        //UtiDatabase uti = new UtiDatabase();
        Connection con = new DBConnect().openNewConnection();
        ResultSet rs = null;
        //String SQL = "select count(doc_id) as num from d_carbon_friction_receive_detail_1 where doc_id = '"+doc_id+"' and delete_flag = 'N' and complete_flag = 'N'";
        String SQL = "select count(doc_id) as num from d_carbon_friction_receive_detail_1 where doc_id = '" + doc_id + "' and delete_flag = 'N' ";
        try {
            str_return.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>");
            if (uti.numRowdatabase(SQL) == 0) {
                str_return.append("<tr><td align='center'>ไม่พบข้อมูลที่ต้องการ</td></tr>");
            } else {
                SQL = "select runno,doc_id,doc_date,line_no,product_id,friction_house,silo_no,location_id,balance_weight,remain_weight from d_carbon_friction_receive_detail_1 "
                        //+ "where doc_id = '"+doc_id+"' and delete_flag = 'N' and complete_flag = 'N' order by to_number(line_no,'990')";
                        + "where doc_id = '" + doc_id + "' and delete_flag = 'N' order by to_number(line_no,'990')";
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    str_return.append("<tr>");
                    str_return.append("<td class='forborder' width='3px'><input type='checkbox' id='ckbox2' name='ckbox2' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>");
                    str_return.append("<td class='forborder' width='7%'><a class=\"ex1\" href=\"#\" onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("line_no") + ",username,doc_id','../SCREEN/CS_Detail_025_2.jsp'))\"><font color='blue'><input type='hidden' id='line_no_" + rs.getString("line_no") + "' value=\"" + rs.getString("line_no") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\"><input type='hidden' id='doc_date' value=\"" + rs.getString("doc_date") + "\"><input type='hidden' id='runno_" + rs.getString("runno") + "'' value=\"" + rs.getString("runno") + "\">" + rs.getString("line_no") + "</font></a></td>");
                    str_return.append("<td class='forborder' width='20%'>" + rs.getString("product_id") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("friction_house") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("silo_no") + "</td>");
                    str_return.append("<td class='forborder' width='20%'>" + rs.getString("location_id") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("balance_weight") + "</td>");
                    str_return.append("<td class='forborder' width='20%'>" + rs.getString("remain_weight") + "</td>");
                    str_return.append("</tr>");
                }
            }
            str_return.append("</table>");
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            con.close();
        }
        return str_return.toString();
    }

    public String Get_Balance_value() throws Exception {
        String return_string = null, SQL = null;
        try {

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {            
            System.out.println("Ok");
        }
        return return_string;
    }
}

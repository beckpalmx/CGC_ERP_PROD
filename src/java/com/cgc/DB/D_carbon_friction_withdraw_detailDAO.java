/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_carbon_friction_withdraw_detail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Administrator
 */
public class D_carbon_friction_withdraw_detailDAO {

    UtiDatabase uti = new UtiDatabase();

    public void insert(DataBeanD_carbon_friction_withdraw_detail DataBean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p;
        int i = 1;
        String SQL = "insert into d_carbon_friction_withdraw_detail(doc_id,line_no,product_id,friction_house,location_id,wh_in,friction_dust_bag,friction_dust_amount,friction_dust_weight,pan_dust_bag,pan_dust_amount,pan_dust_weight,sucker_dust_bag,sucker_dust_amount,sucker_dust_weight,magnet1,magnet2,laps_amount,laps_weight,laps_total,friction_carbon_in_weight,lost_weight,carbon_burn_in_weight,jumbo_weight,create_by,create_date,update_date,doc_date,moisture_percent,moisture_weight) "
                + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        try {
            p = con.prepareStatement(SQL);
            p.setString(i, DataBean.getDoc_id());
            i += 1;
            p.setString(i, DataBean.getLine_no());
            i += 1;
            p.setString(i, DataBean.getProduct_id());
            i += 1;
            p.setString(i, DataBean.getFriction_house());
            i += 1;
            p.setString(i, DataBean.getLocation_id());
            i += 1;
            p.setString(i, DataBean.getWh_in());
            i += 1;
            p.setString(i, DataBean.getFriction_dust_bag());
            i += 1;
            p.setString(i, DataBean.getFriction_dust_amount());
            i += 1;
            p.setString(i, DataBean.getFriction_dust_weight());
            i += 1;
            p.setString(i, DataBean.getPan_dust_bag());
            i += 1;
            p.setString(i, DataBean.getPan_dust_amount());
            i += 1;
            p.setString(i, DataBean.getPan_dust_weight());
            i += 1;
            p.setString(i, DataBean.getSucker_dust_bag());
            i += 1;
            p.setString(i, DataBean.getSucker_dust_amount());
            i += 1;
            p.setString(i, DataBean.getSucker_dust_weight());
            i += 1;
            p.setString(i, DataBean.getMagnet1());
            i += 1;
            p.setString(i, DataBean.getMagnet2());
            i += 1;
            p.setString(i, DataBean.getLaps_amount());
            i += 1;
            p.setString(i, DataBean.getLaps_weight());
            i += 1;
            p.setString(i, DataBean.getLaps_total());
            i += 1;
            p.setString(i, DataBean.getFriction_carbon_in_weight());
            i += 1;
            p.setString(i, DataBean.getLost_weight());
            i += 1;
            p.setString(i, DataBean.getCarbon_burn_in_weight());
            i += 1;
            p.setString(i, DataBean.getJumbo_weight());
            i += 1;
            p.setString(i, DataBean.getBy());
            i += 1;
            p.setTimestamp(i, DataBean.getDate());
            i += 1;
            p.setTimestamp(i, DataBean.getDate());
            i += 1;
            p.setString(i, DataBean.getDoc_date());
            i += 1;
            p.setString(i, DataBean.getMoisture_percent());
            i += 1;
            p.setString(i, DataBean.getMoisture_weight());
            i += 1;
            String SqlCount = "Select Count(doc_id) As num from  d_carbon_friction_withdraw_detail where doc_id = '" + DataBean.getDoc_id() + "' and delete_flag = 'N' and line_no = '" + DataBean.getLine_no() + "' ;";
            System.out.println("SqlCount = " + SqlCount);
            if (uti.numRowdatabase(SqlCount) == 0) {
                p.executeUpdate();
                System.out.println("Returnvalue = " + true);
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            con.close();
        }
    }

    public void update(DataBeanD_carbon_friction_withdraw_detail DataBean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        PreparedStatement p = null;
        int i = 1;
        String SQL = "update d_carbon_friction_withdraw_detail set product_id=?,friction_house=?,location_id=?,wh_in=?,friction_dust_bag=?,friction_dust_amount=?,friction_dust_weight=?,pan_dust_bag=?,pan_dust_amount=?,pan_dust_weight=?,sucker_dust_bag=?,sucker_dust_amount=?,sucker_dust_weight=?,magnet1=?,magnet2=?,laps_amount=?,laps_weight=?,laps_total=?,friction_carbon_in_weight=?,lost_weight=?,carbon_burn_in_weight=?,jumbo_weight=?,update_by=?,update_date=?,doc_date=?,moisture_percent=?,moisture_weight=? "
                + "Where doc_id = '" + DataBean.getDoc_id() + "' and line_no ='" + DataBean.getLine_no() + "' and delete_flag = 'N' and complete_flag = 'N'";
        try {
            p = con.prepareStatement(SQL);
            p.setString(i, DataBean.getProduct_id());
            i += 1;
            p.setString(i, DataBean.getFriction_house());
            i += 1;
            p.setString(i, DataBean.getLocation_id());
            i += 1;
            p.setString(i, DataBean.getWh_in());
            i += 1;
            p.setString(i, DataBean.getFriction_dust_bag());
            i += 1;
            p.setString(i, DataBean.getFriction_dust_amount());
            i += 1;
            p.setString(i, DataBean.getFriction_dust_weight());
            i += 1;
            p.setString(i, DataBean.getPan_dust_bag());
            i += 1;
            p.setString(i, DataBean.getPan_dust_amount());
            i += 1;
            p.setString(i, DataBean.getPan_dust_weight());
            i += 1;
            p.setString(i, DataBean.getSucker_dust_bag());
            i += 1;
            p.setString(i, DataBean.getSucker_dust_amount());
            i += 1;
            p.setString(i, DataBean.getSucker_dust_weight());
            i += 1;
            p.setString(i, DataBean.getMagnet1());
            i += 1;
            p.setString(i, DataBean.getMagnet2());
            i += 1;
            p.setString(i, DataBean.getLaps_amount());
            i += 1;
            p.setString(i, DataBean.getLaps_weight());
            i += 1;
            p.setString(i, DataBean.getLaps_total());
            i += 1;
            p.setString(i, DataBean.getFriction_carbon_in_weight());
            i += 1;
            p.setString(i, DataBean.getLost_weight());
            i += 1;
            p.setString(i, DataBean.getCarbon_burn_in_weight());
            i += 1;
            p.setString(i, DataBean.getJumbo_weight());
            i += 1;
            p.setString(i, DataBean.getBy());
            i += 1;
            p.setTimestamp(i, DataBean.getDate());
            i += 1;
            p.setString(i, DataBean.getDoc_date());
            i += 1;
            p.setString(i, DataBean.getMoisture_percent());
            i += 1;
            p.setString(i, DataBean.getMoisture_weight());
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

    public void DeleteLine_no(String inputarry, DataBeanD_carbon_friction_withdraw_detail bean) throws Exception {
        boolean ckclose = false;
        Connection con = new DBConnect().openNewConnection();
        int count = 1;
        ResultSet rs;
        PreparedStatement p;
        String sql, sql2;
        try {
            if (inputarry.length() != 0) {
                String[] strarry = inputarry.split(",");
                for (String strarry1 : strarry) {
                    sql = "update d_carbon_friction_withdraw_detail set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and line_no=? and delete_flag = 'N' and complete_flag = 'N'";
                    p = con.prepareStatement(sql);
                    p.setString(1, "Y");
                    p.setTimestamp(2, bean.getDate());
                    p.setString(3, bean.getBy());
                    p.setString(4, bean.getDoc_id());
                    p.setString(5, strarry1);
                    p.executeUpdate();
                }
                if (strarry.length != -1) {
                    sql = "select count(doc_id) as num from d_carbon_friction_withdraw_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
                    if (uti.numRowdatabase(sql) != 0) {
                        sql2 = "Select line_no from  d_carbon_friction_withdraw_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag ='N' order by runno ";
                        rs = con.createStatement().executeQuery(sql2);
                        while (rs.next()) {
                            sql = "update d_carbon_friction_withdraw_detail set line_no=? where doc_id=? and line_no=?";
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

    public void Delete_line_no_All(DataBeanD_carbon_friction_withdraw_detail dataBean) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        String sqldetail = "update d_carbon_friction_withdraw_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p ;
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

    public DataBeanD_carbon_friction_withdraw_detail ReturnEdit(String doc_id, String line_no) throws Exception {
        Connection con = new DBConnect().openNewConnection();
        DataBeanD_carbon_friction_withdraw_detail objbean = new DataBeanD_carbon_friction_withdraw_detail();
        ResultSet rs;
        try {
            //rs = con.createStatement().executeQuery("select doc_date,product_id,friction_house,location_id,wh_in,friction_dust_bag,friction_dust_amount,friction_dust_weight,pan_dust_bag,pan_dust_amount,pan_dust_weight,sucker_dust_bag,sucker_dust_amount,sucker_dust_weight,magnet1,magnet2,laps_amount,friction_carbon_in_weight,lost_weight,carbon_burn_in_weight,jumbo_weight,doc_date,laps_weight,laps_total,weight_friction_recieve_total from vd_carbon_friction_withdraw_detail where doc_id = '"+doc_id+"' and line_no = '"+line_no+"' and delete_flag = 'N' and complete_flag = 'N'");
            rs = con.createStatement().executeQuery("select doc_date,product_id,friction_house,location_id,wh_in,friction_dust_bag,friction_dust_amount,friction_dust_weight,pan_dust_bag,pan_dust_amount,pan_dust_weight,sucker_dust_bag,sucker_dust_amount,sucker_dust_weight,magnet1,magnet2,laps_amount,friction_carbon_in_weight,lost_weight,carbon_burn_in_weight,jumbo_weight,doc_date,laps_weight,laps_total,weight_friction_recieve_total,moisture_percent,moisture_weight from vd_carbon_friction_withdraw_detail where doc_id = '" + doc_id + "' and line_no = '" + line_no + "' and delete_flag = 'N' ");
            while (rs.next()) {
                objbean.setProduct_id(rs.getString("product_id"));
                objbean.setFriction_house(rs.getString("friction_house"));
                objbean.setLocation_id(rs.getString("location_id"));
                objbean.setWh_in(rs.getString("wh_in"));
                objbean.setFriction_dust_bag(rs.getString("friction_dust_bag"));
                objbean.setFriction_dust_amount(rs.getString("friction_dust_amount"));
                objbean.setFriction_dust_weight(rs.getString("friction_dust_weight"));
                objbean.setPan_dust_bag(rs.getString("pan_dust_bag"));
                objbean.setPan_dust_amount(rs.getString("pan_dust_amount"));
                objbean.setPan_dust_weight(rs.getString("pan_dust_weight"));
                objbean.setSucker_dust_bag(rs.getString("sucker_dust_bag"));
                objbean.setSucker_dust_amount(rs.getString("sucker_dust_amount"));
                objbean.setSucker_dust_weight(rs.getString("sucker_dust_weight"));
                objbean.setMagnet1(rs.getString("magnet1"));
                objbean.setMagnet2(rs.getString("magnet2"));
                objbean.setLaps_amount(rs.getString("laps_amount"));
                objbean.setLaps_weight(rs.getString("laps_weight"));
                objbean.setLaps_total(rs.getString("laps_total"));
                objbean.setFriction_carbon_in_weight(rs.getString("friction_carbon_in_weight"));
                objbean.setLost_weight(rs.getString("lost_weight"));
                objbean.setCarbon_burn_in_weight(rs.getString("carbon_burn_in_weight"));
                objbean.setWeight_friction_recieve_total(rs.getString("weight_friction_recieve_total"));
                objbean.setJumbo_weight(rs.getString("jumbo_weight"));
                objbean.setDoc_date(rs.getString("doc_date"));
                objbean.setMoisture_percent(rs.getString("moisture_percent"));
                objbean.setMoisture_weight(rs.getString("moisture_weight"));
                System.out.println("Recieve weight_friction_recieve_total = " + rs.getString("weight_friction_recieve_total"));
            }
        } catch (SQLException e) {
            e.printStackTrace(System.out);
        } finally {
            con.close();
        }
        return objbean;
    }

    public String ShowDetail(String doc_id) throws Exception {
        StringBuilder str_return = new StringBuilder();
        Connection con = new DBConnect().openNewConnection();
        ResultSet rs = null;
        String SQL;

        try {
            str_return.append("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>");
            //if(uti.numRowdatabase("select count(doc_id) as num from vd_carbon_friction_withdraw_detail where doc_id = '"+doc_id+"' and delete_flag = 'N' and complete_flag = 'N'") == 0){
            if (uti.numRowdatabase("select count(doc_id) as num from vd_carbon_friction_withdraw_detail where doc_id = '" + doc_id + "' and delete_flag = 'N' ") == 0) {
                System.out.println("Detail = 0 ");
                str_return.append("<tr><td align='center'>ไม่พบข้อมูล</td></tr>");

            } else {
                //SQL = "select doc_date,runno,doc_id,line_no,product_id,friction_house,location_id,wh_in,laps_amount,friction_carbon_in_weight,lost_weight,carbon_burn_in_weight,jumbo_weight,laps_total,weight_friction_recieve_total from vd_carbon_friction_withdraw_detail where doc_id = '"+doc_id+"' and delete_flag = 'N' and complete_flag = 'N' order by to_number(line_no,'990')";
                SQL = "select doc_date,runno,doc_id,line_no,product_id,friction_house,location_id,wh_in,laps_amount,friction_carbon_in_weight,lost_weight,carbon_burn_in_weight,jumbo_weight,laps_total,weight_friction_recieve_total from vd_carbon_friction_withdraw_detail where doc_id = '" + doc_id + "' and delete_flag = 'N' order by to_number(line_no,'990')";
                System.out.println("SQL Detail = " + SQL);
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    str_return.append("<tr>");
                    str_return.append("<td class='forborder' width='3px'><input type='checkbox' id='ckbox' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>");
                    str_return.append("<td class='forborder' width='7%'><a class=\"ex1\" href=\"#\" onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("line_no") + ",username,doc_id,doc_date','../SCREEN/CS_Detail_025_1.jsp'))\"><font color='blue'><input type='hidden' id='line_no_" + rs.getString("line_no") + "' value=\"" + rs.getString("line_no") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\"><input type='hidden' id='doc_date' value=\"" + rs.getString("doc_date") + "\"><input type='hidden' id='runno_" + rs.getString("runno") + "'' value=\"" + rs.getString("runno") + "\">" + rs.getString("line_no") + "</font></a></td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("product_id") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("friction_house") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("location_id") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("wh_in") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("laps_amount") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("laps_total") + "</td>");
                    //str_return.append("<td class='forborder' width='10%'>" + rs.getString("friction_carbon_in_weight") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("lost_weight") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("carbon_burn_in_weight") + "</td>");
                    str_return.append("<td class='forborder' width='10%'>" + rs.getString("jumbo_weight") + "</td>");
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
            System.out.println(str_return.toString());
        }
        return str_return.toString();
    }

}

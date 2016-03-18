/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.bean.DataBeanD_carbon_friction_receive_detail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.cgc.Util.ThaiUtil;
import com.cgc.Util.UtiDatabase;

/**
 *
 * @author Beckpalmx No7
 */
public class D_carbon_friction_receive_detailDAO {
    private int Returnvalue;

    public int insert(DataBeanD_carbon_friction_receive_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_carbon_friction_receive_detail (doc_id,line_no,product_id,location_id,silo_no,weight_balance,create_date,create_by) values(?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getLine_no());
            p.setString(3, dataBean.getProduct_id());
            p.setString(4, dataBean.getLocation_id());
            p.setString(5, dataBean.getSilo_no());
            p.setString(6, dataBean.getWeight_balance());
            p.setTimestamp(7, dataBean.getDate());
            p.setString(8, dataBean.getBy());
            Returnvalue = p.executeUpdate();
        } finally {
            //JOptionPane.showConfirmDialog(null, "test");
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }

        }
        return Returnvalue;
    }

    public int update(DataBeanD_carbon_friction_receive_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();

        String sql =
                "update d_carbon_friction_receive_detail set  product_id=?,location_id=?,silo_no=?,weight_balance=?,update_date=?,update_by=? where doc_id=? and line_no=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getProduct_id());
            p.setString(2, dataBean.getLocation_id());
            p.setString(3, dataBean.getSilo_no());
            p.setString(4, dataBean.getWeight_balance());
            p.setTimestamp(5, dataBean.getDate());
            p.setString(6, dataBean.getBy());
            p.setString(7, dataBean.getDoc_id());
            p.setString(8, dataBean.getLine_no());
            Returnvalue = p.executeUpdate();

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

    public DataBeanD_carbon_friction_receive_detail ReturnEdit(String Doc_id, String Line_no, DataBeanD_carbon_friction_receive_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        //JOptionPane.showConfirmDialog(null, "test");
        String SQL = "Select doc_id,doc_date,line_no,location_id,silo_no,weight_balance,product_id from vd_carbon_friction_receive_detail where doc_id = '" + Doc_id + "' and line_no ='" + Line_no + "' and delete_flag = 'N' and complete_flag = 'N'";
        ResultSet rs = con.createStatement().executeQuery(SQL);
        try {
            while (rs.next()) {
                bean.setDoc_id(rs.getString("doc_id"));
                bean.setDoc_date(rs.getString("doc_date"));
                bean.setLine_no(rs.getString("line_no"));
                bean.setProduct_id(rs.getString("product_id"));
                //bean.setProd_name(rs.getString("prod_name"));
                bean.setLocation_id(rs.getString("location_id"));
                bean.setSilo_no(rs.getString("silo_no"));
                bean.setWeight_balance(rs.getString("weight_balance"));
                
            }
        } finally {
            try {
                rs.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        return bean;
    }
    //ทำการลบ Line_no ตามบรรทัดที่เลื่อกแล้วทำการ update ข

    public int DeleteLine_no(String inputarry, DataBeanD_carbon_friction_receive_detail bean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        DBConnect dbConnect = new DBConnect();
        boolean ckclose = false;
        boolean pclose =false;
        Connection con = dbConnect.openNewConnection();
        int count = 1;
        int total = 0;
        ResultSet rs = null;
        PreparedStatement p = null;
        String sql, sql2 = "";
        try {

            if (inputarry.length() != 0) {
                String[] strarry = inputarry.split(",");
                for (int i = 0; i < strarry.length; i++) {
                    sql = "update d_carbon_friction_receive_detail set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and line_no=?";
                    p = con.prepareStatement(sql);
                    p.setString(1, "Y");
                    p.setTimestamp(2, bean.getDate());
                    p.setString(3, bean.getBy());
                    p.setString(4, bean.getDoc_id());
                    p.setString(5, strarry[i]);
                    p.executeUpdate();
                }
                pclose = true;

                if (strarry.length != -1) {
                    sql = "select count(doc_id) as num from d_carbon_friction_receive_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
                    if(objuti.numRowdatabase(sql) != 0){
                    p = null;
                    sql2 = "Select line_no,runno from  d_carbon_friction_receive_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y' order by runno ";
                    rs = con.createStatement().executeQuery(sql2);
                    while (rs.next()) {
                        sql = "update d_carbon_friction_receive_detail set line_no=? where doc_id=? and line_no=? and runno=?";
                        p = con.prepareStatement(sql);
                        p.setString(1, Integer.toString(count));
                        p.setString(2, bean.getDoc_id());
                        p.setString(3, rs.getString("line_no"));
                        p.setInt(4,rs.getInt("runno"));
                        p.executeUpdate();
                        count = count + 1;
                    }
                    ckclose =true;
                    
                    }
                }

            }

        } finally {
            try {
                if (inputarry.length() != 0) {
                    if(ckclose){
                        rs.close();
                    }if(pclose){
                    p.close();
                    con.close();
                    }
                }
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        //JOptionPane.showConfirmDialog(null, total);
        return total;

    }

    public void Delete_line_no_All(DataBeanD_carbon_friction_receive_detail dataBean) throws Exception {

        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqldetail = "update d_carbon_friction_receive_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=?";
        PreparedStatement p = null;
        try {

            p = con.prepareStatement(sqldetail);
            p.setString(1, "Y");
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getBy());
            p.setString(4, dataBean.getDoc_id());
            p.executeUpdate();

        } finally {
            try {
                p.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }

    }
    public String showDetail(String doc_id)throws Exception
    {
        ThaiUtil objth = new ThaiUtil();
        UtiDatabase objuti = new UtiDatabase();
        String SQL,SQL1,strOutput = "";
         SQL1 = "Select Count(doc_id) As num from  vd_carbon_friction_receive_detail where doc_id ='"+objth.EncodeTexttoTIS(doc_id)+"' and delete_flag = 'N' and complete_flag ='N' ";
        int a = objuti.numRowdatabase(SQL1);
        //JOptionPane.showConfirmDialog(null, objuti.numRowdatabase(SQL1));
        strOutput += "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>";
	SQL = "Select doc_id,line_no,product_id,weight_balance,silo_no,location_id from vd_carbon_friction_receive_detail where doc_id ='"+objth.EncodeTexttoTIS(doc_id)+"'and delete_flag = 'N' and complete_flag = 'N' order by runno";
	DBConnect objcon = new DBConnect();
	Connection con =objcon.openNewConnection();
	ResultSet rs = null;
        rs =con.createStatement().executeQuery(SQL);
	while(rs.next())
	{
	strOutput +="<tr>";
        strOutput +="<td class='forborder' width='3px'><input type='checkbox' id='ckbox' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>";
        strOutput +="<td class='forborder' width='7%'><a href=\"#\"  class='link_data_transparent' onclick=\"OpenEdit(URLsend('line_no_"+rs.getString("line_no")+",doc_id,username','../SCREEN/CS_026.jsp'))\"><input type='hidden' id='line_no_"+rs.getString("line_no")+"' value=\""+rs.getString("line_no")+"\"><input type='hidden' id='doc_id' value=\""+rs.getString("doc_id")+"\">"+rs.getString("line_no")+"</a></td>";
        strOutput +="<td class='forborder' width='45%'>"+rs.getString("product_id")+"</td>";
        strOutput +="<td class='forborder' width='15%'>"+rs.getString("weight_balance")+"</td>";
        strOutput +="<td class='forborder' width='15%'>"+rs.getString("silo_no")+"</td>";
	strOutput +="<td class='forborder' width='15%'>"+rs.getString("location_id")+"</td>";
	strOutput +="</tr>";
	}
	rs.close();
        con.close();
        strOutput +="</table>";
        return strOutput;
    }
}

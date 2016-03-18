/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cgc.DB;

import com.cgc.Util.ThaiUtil;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_product_receive_detail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Administrator
 */
public class D_product_receive_detail_whDAO {

    private int Returnvalue;

    public int insert(DataBeanD_product_receive_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_product_receive_detail "
                +"(doc_id,doc_date,line_no,wh_in,wh_out,burn_no,location_id,size,job_edit_no,ctc_i2,qty,shift,palate_no,emp_id,create_date,wh_id,create_by,unit_id,c_type,job_type_id,job_type_desc,remark)"
                +" values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getDoc_date());
            p.setString(3, dataBean.getLine_no());
            p.setString(4, dataBean.getWh_in());
            p.setString(5, dataBean.getWh_out());
            p.setString(6, dataBean.getBurn_no());
            p.setString(7, dataBean.getLocation_id());
            p.setString(8, dataBean.getSize());
            p.setString(9, dataBean.getJob_edit_no());
            p.setString(10, dataBean.getCtc_i2());
            p.setString(11, dataBean.getQty());
            p.setString(12, dataBean.getShift());
            p.setString(13, dataBean.getPalate_no());
            p.setString(14, dataBean.getEmp_id());
            p.setTimestamp(15, dataBean.getDate());
            p.setString(16, dataBean.getWh_id());
            p.setString(17, dataBean.getBy());
            p.setString(18,dataBean.getUnit_id());
            p.setString(19, dataBean.getProduct_id());
            p.setString(20, dataBean.getJob_type_id());
            p.setString(21, dataBean.getJob_type_desc());
            p.setString(22, dataBean.getRemark());
            //p.setString(20, dataBean.get)
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

    public int update(DataBeanD_product_receive_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();

        String sql =
                "update d_product_receive_detail "
                + "set  doc_date=?,wh_in=?,wh_out=?,burn_no=?,location_id=?,size=?,job_edit_no=?,ctc_i2=?,qty=?,shift=?,palate_no=?,emp_id=?,update_date=?,wh_id=?,update_by=?,unit_id=?,c_type=?,job_type_id=?,job_type_desc=?,remark=? "
                + "where doc_id=? and line_no=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_date());
            p.setString(2, dataBean.getWh_in());
            p.setString(3, dataBean.getWh_out());
            p.setString(4, dataBean.getBurn_no());
            p.setString(5, dataBean.getLocation_id());
            p.setString(6, dataBean.getSize());
            p.setString(7, dataBean.getJob_edit_no());
            p.setString(8, dataBean.getCtc_i2());
            p.setString(9, dataBean.getQty());
            p.setString(10, dataBean.getShift());
            p.setString(11, dataBean.getPalate_no());
            p.setString(12, dataBean.getEmp_id());
            p.setTimestamp(13, dataBean.getDate());
            p.setString(14, dataBean.getWh_id());
            p.setString(15, dataBean.getBy());
            p.setString(16, dataBean.getUnit_id());
            p.setString(17, dataBean.getProduct_id());
            p.setString(18, dataBean.getJob_type_id());
            p.setString(19, dataBean.getJob_type_desc());
            p.setString(20, dataBean.getRemark());
            p.setString(21, dataBean.getDoc_id());
            p.setString(22, dataBean.getLine_no());
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

    public DataBeanD_product_receive_detail ReturnEdit(String Doc_id, String Line_no, DataBeanD_product_receive_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        //JOptionPane.showConfirmDialog(null, "test");
        String SQL = "Select "
                + "doc_id,doc_date,line_no,wh_id,wh_in,wh_out,burn_no,location_id,size,job_edit_no,ctc_i2,qty,shift,palate_no,emp_id,unit_id,c_type,job_type_id,job_type_desc,remark,"
                + "(select munit_code.name_t from munit_code where munit_code.unit_id = d_product_receive_detail_wh.unit_id) as unit_name "
                + "from d_product_receive_detail_wh where doc_id = '" + Doc_id + "' and line_no ='" + Line_no + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
        ResultSet rs = con.createStatement().executeQuery(SQL);
        try {
            while (rs.next()) {
                bean.setDoc_id(rs.getString("doc_id"));
                bean.setDoc_date(rs.getString("doc_date"));
                bean.setLine_no(rs.getString("line_no"));
                bean.setWh_id(rs.getString("wh_id"));
                bean.setWh_in(rs.getString("wh_in"));
                bean.setWh_out(rs.getString("wh_out"));
                bean.setBurn_no(rs.getString("burn_no"));
                bean.setLocation_id(rs.getString("location_id"));
                bean.setSize(rs.getString("size"));
                bean.setJob_edit_no(rs.getString("job_edit_no"));
                bean.setCtc_i2(rs.getString("ctc_i2"));
                bean.setQty(rs.getString("qty"));
                bean.setShift(rs.getString("shift"));
                bean.setPalate_no(rs.getString("palate_no"));
                //bean.setEmp_id(rs.getString("emp_id"));
                bean.setUnit_id(rs.getString("unit_id"));
                bean.setProduct_id(rs.getString("c_type"));
                bean.setJob_type_id(rs.getString("job_type_id"));
                bean.setJob_type_desc(rs.getString("job_type_desc"));
                bean.setUnit_name(rs.getString("unit_name"));
                bean.setRemark(rs.getString("remark"));
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

    public void DeleteLine_no(String inputarry, DataBeanD_product_receive_detail bean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        boolean ckclose = false;
        boolean pclose = false;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        int count = 1;
        ResultSet rs = null;
        PreparedStatement p = null;
        String sql, sql2 = "";
        try {

            if (inputarry.length() != 0) {
                String[] strarry = inputarry.split(",");
                for (int i = 0; i < strarry.length; i++) {
                    sql = "update d_product_receive_detail set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and line_no=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
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
                    sql = "select count(doc_id) as num from d_product_receive_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y'";
                    if (objuti.numRowdatabase(sql) != 0) {
                        p = null;
                        sql2 = "Select line_no from  d_product_receive_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag <> 'Y' and complete_flag <> 'Y' order by runno ";
                        rs = con.createStatement().executeQuery(sql2);
                        while (rs.next()) {
                            sql = "update d_product_receive_detail set line_no=? where doc_id=? and line_no=?";
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
                    rs.close();
                }
                if(pclose){
                    p.close();
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace(System.out);
            }
        }
        //JOptionPane.showConfirmDialog(null, total);

    }

    public int Delete_line_no_All(DataBeanD_product_receive_detail dataBean) throws Exception {
        int total = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqldetail = "update d_product_receive_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y' and complete_flag <> 'Y'";
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
        return total;
    }

    public String showDetail(String doc_id) throws Exception {
        ThaiUtil objth = new ThaiUtil();
        UtiDatabase objuti = new UtiDatabase();
        String SQL1, SQL, strOutput = "";
        strOutput += "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>";


        SQL1 = "Select Count(doc_id) As num from  d_product_receive_detail_wh where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag <> 'Y' and complete_flag <> 'Y' ";
        int a = objuti.numRowdatabase(SQL1);
        SQL = "Select doc_id,line_no,burn_no,location_id,wh_id,size,job_edit_no,ctc_i2,qty,(select munit_code.name_t from munit_code where munit_code.unit_id=d_product_receive_detail_wh.unit_id) as unit_name,c_type,shift,(select mjob_type.name_t from mjob_type where mjob_type.job_type_id = d_product_receive_detail_wh.job_type_id) as job_type_name,job_type_desc from d_product_receive_detail_wh where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag <> 'Y' and complete_flag <> 'Y' order by runno";
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        rs = con.createStatement().executeQuery(SQL);
        while (rs.next()) {

            strOutput += "<tr>";
            strOutput += "<td class='forborder' width='3px'><input type='checkbox' id='ckbox' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>";
            strOutput += "<td class='forborder' width='7%'><a href=\"#\"  class='link_data_transparent' onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("line_no") + ",doc_id,doc_date,username','../SCREEN/CS_037_2.jsp'))\"><input type='hidden' id='line_no_" + rs.getString("line_no") + "' value=\"" + rs.getString("line_no") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\">" + rs.getString("line_no") + "</a></td>";
            strOutput += "<td class='forborder' width='15%'>" + rs.getString("c_type") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='15%'>" + rs.getString("job_type_name") + rs.getString("job_type_desc")+"&nbsp;</td>";
            strOutput += "<td class='forborder' width='10%'>" + rs.getString("size") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='15%'>" + rs.getString("job_edit_no") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='15%'>" + rs.getString("ctc_i2") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='10%'>" + rs.getString("qty") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='10%'>" + rs.getString("shift") + "&nbsp;</td>";
            strOutput += "</tr>";
        }
        rs.close();
        con.close();
        strOutput += "</table>";
        return strOutput;
    }
}

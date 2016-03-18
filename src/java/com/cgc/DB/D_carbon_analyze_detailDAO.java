/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.ThaiUtil;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_carbon_analyze_detail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Beckpalmx No7
 */
public class D_carbon_analyze_detailDAO {

    private int Returnvalue;
    public int insert(DataBeanD_carbon_analyze_detail dataBean) throws Exception {
        Returnvalue = 0;
        UtiDatabase objuti = new UtiDatabase();
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_carbon_analyze_detail "
                + "(doc_id,header_id,bag,prd_place,p_type,prd_code,h2o,butane,iod,hd1,hd2,hd3,hd4,hd5,hd6,hd7,hd8,hd9,hd10,hd11,hd12,hd13,hd14,hd15,pass,grade,remark,create_date,create_by,job_id)"
                + " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getLine_no());
            p.setString(3, dataBean.getBag());
            p.setString(4, dataBean.getPrd_place());
            p.setString(5, dataBean.getP_type());
            p.setString(6, dataBean.getPrd_code());
            p.setString(7, dataBean.getH2o());
            p.setString(8, dataBean.getButane());
            p.setString(9, dataBean.getIod());
            p.setString(10, dataBean.getHc1());
            p.setString(11, dataBean.getHc2());
            p.setString(12, dataBean.getHc3());
            p.setString(13, dataBean.getHc4());
            p.setString(14, dataBean.getHc5());
            p.setString(15, dataBean.getHc6());
            p.setString(16, dataBean.getHc7());
            p.setString(17, dataBean.getHc8());
            p.setString(18, dataBean.getHc9());
            p.setString(19, dataBean.getHc10());
            p.setString(20, dataBean.getHc11());
            p.setString(21, dataBean.getHc12());
            p.setString(22, dataBean.getHc13());
            p.setString(23, dataBean.getHc14());
            p.setString(24, dataBean.getHc15());
            p.setString(25, dataBean.getPass());
            p.setString(26, dataBean.getGrade());
            p.setString(27, dataBean.getRemark());
            p.setTimestamp(28, dataBean.getDate());
            p.setString(29, dataBean.getBy());
            p.setString(30, dataBean.getJob_id());
            Returnvalue = p.executeUpdate();
            /*if(objuti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_analyze_value_detail where doc_id = '"+dataBean.getDoc_id()+"' and header_id = '"+dataBean.getLine_no()+"' and delete_flag = 'N' and complete_flag ='N'") != 0){
                p = null;
                sql = "update d_carbon_analyze_value_detail set job_id=? where doc_id =? and header_id = ? and delete_flag ='N' and complete_flag = 'N'";
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getJob_id());
                p.setString(2, dataBean.getDoc_id());
                p.setString(3, dataBean.getLine_no());
                p.executeUpdate();
            }*/
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

    public int update(DataBeanD_carbon_analyze_detail dataBean) throws Exception {
        Returnvalue = 0;
        UtiDatabase objuti = new UtiDatabase();
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();

        String sql =
                "update d_carbon_analyze_detail set  "
                + "bag=?,prd_place=?,p_type=?,prd_code=?,h2o=?,butane=?,iod=?,hd1=?,hd2=?,hd3=?,hd4=?,hd5=?,hd6=?,hd7=?,hd8=?,hd9=?,hd10=?,hd11=?,hd12=?,hd13=?,hd14=?,hd15=?,pass=?,grade=?,remark=?,update_date=?,update_by=?,job_id=? "
                + "where doc_id=? and header_id=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getBag());
            p.setString(2, dataBean.getPrd_place());
            p.setString(3, dataBean.getP_type());
            p.setString(4, dataBean.getPrd_code());
            p.setString(5, dataBean.getH2o());
            p.setString(6, dataBean.getButane());
            p.setString(7, dataBean.getIod());
            p.setString(8, dataBean.getHc1());
            p.setString(9, dataBean.getHc2());
            p.setString(10, dataBean.getHc3());
            p.setString(11, dataBean.getHc4());
            p.setString(12, dataBean.getHc5());
            p.setString(13, dataBean.getHc6());
            p.setString(14, dataBean.getHc7());
            p.setString(15, dataBean.getHc8());
            p.setString(16, dataBean.getHc9());
            p.setString(17, dataBean.getHc10());
            p.setString(18, dataBean.getHc11());
            p.setString(19, dataBean.getHc12());
            p.setString(20, dataBean.getHc13());
            p.setString(21, dataBean.getHc14());
            p.setString(22, dataBean.getHc15());
            p.setString(23, dataBean.getPass());
            p.setString(24, dataBean.getGrade());
            p.setString(25, dataBean.getRemark());
            p.setTimestamp(26, dataBean.getDate());
            p.setString(27, dataBean.getBy());
            p.setString(28, dataBean.getJob_id());
            p.setString(29, dataBean.getDoc_id());
            p.setString(30, dataBean.getLine_no());
            Returnvalue = p.executeUpdate();
            /*if(objuti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_analyze_value_detail where doc_id = '"+dataBean.getDoc_id()+"' and header_id = '"+dataBean.getLine_no()+"' and delete_flag = 'N' and complete_flag ='N'") != 0){
                p = null;
                sql = "update d_carbon_analyze_value_detail set job_id=? where doc_id =? and header_id = ? and delete_flag ='N' and complete_flag = 'N'";
                p = con.prepareStatement(sql);
                p.setString(1, dataBean.getJob_id());
                p.setString(2, dataBean.getDoc_id());
                p.setString(3, dataBean.getLine_no());
                p.executeUpdate();
            }*/
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

    public DataBeanD_carbon_analyze_detail ReturnEdit(String Doc_id, String Line_no, DataBeanD_carbon_analyze_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        UtiDatabase objuti = new UtiDatabase();
        //JOptionPane.showConfirmDialog(null, "test");
        String SQL = "Select doc_id,doc_date,header_id,bag,prd_place,p_type,prd_code,h2o,butane,iod,hd1,hd2,hd3,hd4,hd5,hd6,hd7,hd8,hd9,hd10,hd11,hd12,hd13,hd14,hd15"
                + ",pass,grade,remark,job_id"
                //+ "(select vd_job_order_header.cust_name from vd_job_order_header where vd_job_order_header.doc_id = d_carbon_analyze_detail.job_id) as job_id_desc "
                + " from d_carbon_analyze_detail where doc_id = '" + Doc_id + "' and header_id ='" + Line_no + "' and complete_flag = 'N' and delete_flag = 'N'";
        ResultSet rs = con.createStatement().executeQuery(SQL);
        try {
            while (rs.next()) {
                bean.setDoc_id(rs.getString("doc_id"));
                bean.setDoc_date(rs.getString("doc_date"));
                bean.setLine_no(rs.getString("header_id"));
                bean.setBag(rs.getString("bag"));
                bean.setPrd_place(rs.getString("prd_place"));
                bean.setP_type(rs.getString("p_type"));
                bean.setPrd_code(rs.getString("prd_code"));
                bean.setH2o(rs.getString("h2o"));
                bean.setButane(rs.getString("butane"));
                bean.setIod(rs.getString("iod"));
                bean.setHc1(rs.getString("hd1"));
                bean.setHc2(rs.getString("hd2"));
                bean.setHc3(rs.getString("hd3"));
                bean.setHc4(rs.getString("hd4"));
                bean.setHc5(rs.getString("hd5"));
                bean.setHc6(rs.getString("hd6"));
                bean.setHc7(rs.getString("hd7"));
                bean.setHc8(rs.getString("hd8"));
                bean.setHc9(rs.getString("hd9"));
                bean.setHc10(rs.getString("hd10"));
                bean.setHc11(rs.getString("hd11"));
                bean.setHc12(rs.getString("hd12"));
                bean.setHc13(rs.getString("hd13"));
                bean.setHc14(rs.getString("hd14"));
                bean.setHc15(rs.getString("hd15"));
                bean.setPass(rs.getString("pass"));
                bean.setGrade(rs.getString("grade"));
                bean.setRemark(rs.getString("remark"));
                //bean.setJob_id_desc(objuti.NotNull(rs.getString("job_id_desc")));
                bean.setJob_id(rs.getString("job_id"));

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

    public void DeleteLine_no(String inputarry, DataBeanD_carbon_analyze_detail bean) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        int count = 1;
        int total = 0;
        ResultSet rs = null;
        PreparedStatement p = null;
        String sql, sql2 = "";
        try {
            //JOptionPane.showConfirmDialog(null,inputarry.length());
            if (inputarry.length() != 0) {
                String[] strarry = inputarry.split(",");
                for (int i = 0; i < strarry.length; i++) {

                    sql = "update d_carbon_analyze_detail set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and header_id=? and delete_flag = 'N' and complete_flag = 'N'";
                    p = con.prepareStatement(sql);
                    p.setString(1, "Y");
                    p.setTimestamp(2, bean.getDate());
                    p.setString(3, bean.getBy());
                    p.setString(4, bean.getDoc_id());
                    p.setString(5, strarry[i]);
                    p.executeUpdate();
                    if (objuti.numRowdatabase("select count(doc_id) as num from d_carbon_analyze_value_detail where doc_id ='" + bean.getDoc_id() + "' and header_id = '" + strarry[i] + "' and delete_flag = 'N' and complete_flag = 'N'") != 0) {
                        sql = "update d_carbon_analyze_value_detail set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and header_id=? and delete_flag = 'N' and complete_flag = 'N'";
                        p = con.prepareStatement(sql);
                        p.setString(1, "Y");
                        p.setTimestamp(2, bean.getDate());
                        p.setString(3, bean.getBy());
                        p.setString(4, bean.getDoc_id());
                        p.setString(5, strarry[i]);
                        p.executeUpdate();
                    }
                }
                if (strarry.length != -1) {
                    sql = "select count(doc_id) as num from d_carbon_analyze_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
                    if (objuti.numRowdatabase(sql) != 0) {
                        p = null;
                        sql2 = "Select header_id  from  d_carbon_analyze_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag = 'N' and complete_flag ='N' order by runno ";
                        rs = con.createStatement().executeQuery(sql2);
                        while (rs.next()) {
                            sql = "update d_carbon_analyze_detail set header_id=? where doc_id=? and header_id=?";
                            p = con.prepareStatement(sql);
                            p.setString(1, Integer.toString(count));
                            p.setString(2, bean.getDoc_id());
                            p.setString(3, rs.getString("header_id"));
                            p.executeUpdate();
                            if (objuti.numRowdatabase("select count(doc_id) as num from d_carbon_analyze_value_detail where doc_id ='" + bean.getDoc_id() + "' and header_id = '" + rs.getString("header_id") + "' and delete_flag = 'N' and complete_flag = 'N'") != 0) {
                                sql2 = "update d_carbon_analyze_value_detail set header_id=? where doc_id=? and header_id=? and delete_flag = 'N' and complete_flag = 'N'";
                                p = con.prepareStatement(sql2);
                                p.setString(1, Integer.toString(count));
                                p.setString(2, bean.getDoc_id());
                                p.setString(3, rs.getString("header_id"));
                                p.executeUpdate();
                            }
                            count = count + 1;
                        }
                    }
                }
            }

        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
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

    }

    public int Delete_line_no_All(DataBeanD_carbon_analyze_detail dataBean) throws Exception {

        DBConnect dbConnect = new DBConnect();
        int total = 0;
        Connection con = dbConnect.openNewConnection();
        String sqldetail = "update d_carbon_analyze_detail set delete_flag = ?,delete_date=?,delete_by=?  where doc_id=? and delete_flag = 'N' and complete_flag = 'N'";
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
        String SQL, SQL1, strOutput = "";
        SQL1 = "Select Count(doc_id) As num from  d_carbon_analyze_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag = 'N' and complete_flag ='N' ";
        int a = objuti.numRowdatabase(SQL1);
        //JOptionPane.showConfirmDialog(null, objuti.numRowdatabase(SQL1));
        strOutput += "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>";
        SQL = "Select * from d_carbon_analyze_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag = 'N' and complete_flag = 'N' order by runno";
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        rs = con.createStatement().executeQuery(SQL);
        while (rs.next()) {
            strOutput += "<tr>";
            strOutput += "<td class='forborder' width='3px'><input type='checkbox' id='ckbox' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>";
            strOutput += "<td class='forborder' width='7%'><a href=\"#\"  class='link_data_transparent' onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("header_id") + ",doc_id,hc1,hc2,hc3,hc4,hc5,hc6,hc7,hc8,hc9,hc10,hc11,hc12,hc13,hc14,hc15,username','../SCREEN/CS_109.jsp'))\"><input type='hidden' id='line_no_" + rs.getString("header_id") + "' value=\"" + rs.getString("header_id") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\"><input type='hidden' id='runno_" + rs.getString("runno") + "'' value=\"" + rs.getString("runno") + "\">" + rs.getString("header_id") + "</a></td>";
            strOutput += "<td class='forborder' width='7%'>" + rs.getString("prd_place") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='10%'>" + rs.getString("p_type") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='10%'>" + rs.getString("prd_code") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='8%'>" + rs.getString("h2o") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='8%'>" + rs.getString("butane") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='9%'>" + rs.getString("iod") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='7%'>" + rs.getString("hd1") + "&nbsp;</td>";
            strOutput += "<td class='forborder' width='7%'>&nbsp;</td>";
            strOutput += "<td class='forborder' width='7%'>&nbsp;</td>";
            strOutput += "<td class='forborder' width='14%'>" + rs.getString("remark") + "&nbsp;</td>";
            strOutput += "</tr>";
        }
        rs.close();
        con.close();
        strOutput += "</table>";
        return strOutput;
    }

    
}

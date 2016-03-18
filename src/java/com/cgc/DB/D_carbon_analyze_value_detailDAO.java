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
 * @author Beck
 */
public class D_carbon_analyze_value_detailDAO {
    private int Returnvalue;
    private UtiDatabase objuti = new UtiDatabase();
    public int insert(DataBeanD_carbon_analyze_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_carbon_analyze_value_detail "
                + "(doc_id,line_no,header_id,hd1,hd2,hd3,hd4,hd5,hd6,hd7,hd8,hd9,hd10,hd11,hd12,hd13,hd14,hd15,create_date,create_by,"
                + "bag,prd_place,p_type,prd_code,h2o,butane,iod,job_id,pass,grade,remark)"
                + " values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getLine_no());
            p.setString(3, dataBean.getHeader_id());
            p.setString(4, dataBean.getHc1());
            p.setString(5, dataBean.getHc2());
            p.setString(6, dataBean.getHc3());
            p.setString(7, dataBean.getHc4());
            p.setString(8, dataBean.getHc5());
            p.setString(9, dataBean.getHc6());
            p.setString(10, dataBean.getHc7());
            p.setString(11, dataBean.getHc8());
            p.setString(12, dataBean.getHc9());
            p.setString(13, dataBean.getHc10());
            p.setString(14, dataBean.getHc11());
            p.setString(15, dataBean.getHc12());
            p.setString(16, dataBean.getHc13());
            p.setString(17, dataBean.getHc14());
            p.setString(18, dataBean.getHc15());
            p.setTimestamp(19, dataBean.getDate());
            p.setString(20, dataBean.getBy());
            p.setString(21, dataBean.getBag());
            p.setString(22, dataBean.getPrd_place());
            p.setString(23, dataBean.getP_type());
            p.setString(24, dataBean.getPrd_code());
            p.setString(25, dataBean.getH2o());
            p.setString(26, dataBean.getButane());
            p.setString(27, dataBean.getIod());
            p.setString(28, dataBean.getJob_id());
            p.setString(29, dataBean.getPass());
            p.setString(30, dataBean.getGrade());
            p.setString(31, objuti.EncodeNewLine(dataBean.getRemark()));
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

    public int update(DataBeanD_carbon_analyze_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();

        String sql =
                "update d_carbon_analyze_value_detail set  "
                + "hd1=?,hd2=?,hd3=?,hd4=?,hd5=?,hd6=?,hd7=?,hd8=?,hd9=?,hd10=?,hd11=?,hd12=?,hd13=?,hd14=?,hd15=?,update_date=?,update_by=?,"
                + "bag=?,prd_place=?,p_type=?,prd_code=?,h2o=?,butane=?,iod=?,job_id=?,pass=?,grade=?,remark=?"
                + " where doc_id=? and line_no=? and header_id=? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getHc1());
            p.setString(2, dataBean.getHc2());
            p.setString(3, dataBean.getHc3());
            p.setString(4, dataBean.getHc4());
            p.setString(5, dataBean.getHc5());
            p.setString(6, dataBean.getHc6());
            p.setString(7, dataBean.getHc7());
            p.setString(8, dataBean.getHc8());
            p.setString(9, dataBean.getHc9());
            p.setString(10, dataBean.getHc10());
            p.setString(11, dataBean.getHc11());
            p.setString(12, dataBean.getHc12());
            p.setString(13, dataBean.getHc13());
            p.setString(14, dataBean.getHc14());
            p.setString(15, dataBean.getHc15());
            p.setTimestamp(16, dataBean.getDate());
            p.setString(17, dataBean.getBy());
            p.setString(18, dataBean.getBag());
            p.setString(19, dataBean.getPrd_place());
            p.setString(20, dataBean.getP_type());
            p.setString(21, dataBean.getPrd_code());
            p.setString(22, dataBean.getH2o());
            p.setString(23, dataBean.getButane());
            p.setString(24, dataBean.getIod());
            p.setString(25, dataBean.getJob_id());
            p.setString(26, dataBean.getPass());
            p.setString(27, dataBean.getGrade());
            p.setString(28, objuti.EncodeNewLine(dataBean.getRemark()));
            p.setString(29, dataBean.getDoc_id());
            p.setString(30, dataBean.getLine_no());
            p.setString(31, dataBean.getHeader_id());
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

    public DataBeanD_carbon_analyze_detail ReturnEdit(String Doc_id, String Line_no,String Header_id, DataBeanD_carbon_analyze_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        //JOptionPane.showConfirmDialog(null, "test");
        String SQL = "Select  doc_id,line_no,header_id,hd1,hd2,hd3,hd4,hd5,hd6,hd7,hd8,hd9,hd10,hd11,hd12,hd13,hd14,hd15"
                + ",remark,pass,bag,prd_place,p_type,prd_code,h2o,butane,iod,job_id,grade,"
                + "(select vd_job_order_header.cust_name from vd_job_order_header where vd_job_order_header.doc_id = d_carbon_analyze_value_detail.job_id) as job_id_desc"
                + " from d_carbon_analyze_value_detail where doc_id = '" + Doc_id + "' and line_no ='" + Line_no + "' and header_id = '"+Header_id+"' and complete_flag ='N' and delete_flag = 'N'";
        ResultSet rs = con.createStatement().executeQuery(SQL);
        try {
            while (rs.next()) {
                bean.setDoc_id(rs.getString("doc_id"));
                bean.setLine_no(rs.getString("line_no"));
                bean.setHeader_id(rs.getString("header_id"));
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
                bean.setRemark(rs.getString("remark"));
                bean.setPass(rs.getString("pass"));
                bean.setJob_id_desc(objuti.NotNull(rs.getString("job_id_desc")));
                bean.setJob_id(objuti.NotNull(rs.getString("job_id")));
                bean.setBag(rs.getString("bag"));
                bean.setPrd_place(rs.getString("prd_place"));
                bean.setP_type(rs.getString("p_type"));
                bean.setPrd_code(rs.getString("prd_code"));
                bean.setH2o(rs.getString("h2o"));
                bean.setButane(rs.getString("butane"));
                bean.setIod(rs.getString("iod"));
                bean.setGrade(rs.getString("grade"));
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

                    sql = "update d_carbon_analyze_value_detail set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and line_no=? and header_id =? and delete_flag = 'N' and complete_flag = 'N'";
                    p = con.prepareStatement(sql);
                    p.setString(1, "Y");
                    p.setTimestamp(2, bean.getDate());
                    p.setString(3, bean.getBy());
                    p.setString(4, bean.getDoc_id());
                    p.setString(5, strarry[i]);
                    p.setString(6, bean.getHeader_id());
                    p.executeUpdate();
                }
                if (strarry.length != -1) {
                    sql = "select count(doc_id) as num from d_carbon_analyze_value_detail where doc_id ='" + bean.getDoc_id() + "' and header_id = '"+bean.getHeader_id()+"' and delete_flag = 'N' and complete_flag = 'N'";
                    if (objuti.numRowdatabase(sql) != 0) {
                        p = null;
                        sql2 = "Select line_no from  d_carbon_analyze_value_detail where doc_id ='" + bean.getDoc_id() + "' and header_id = '"+bean.getHeader_id()+"' and delete_flag = 'N' and complete_flag ='N' order by runno ";
                        rs = con.createStatement().executeQuery(sql2);
                        while (rs.next()) {
                            sql = "update d_carbon_analyze_value_detail set line_no=? where doc_id=?  and line_no=? and header_id=? and delete_flag = 'N' and complete_flag ='N'";
                            p = con.prepareStatement(sql);
                            p.setString(1, Integer.toString(count));
                            p.setString(2, bean.getDoc_id());
                            p.setString(3, rs.getString("line_no"));
                            p.setString(4, bean.getHeader_id());
                            p.executeUpdate();
                            count = count + 1;
                        }
                    }
                }
            }

        } finally {
            try {
                if(rs != null){
                    rs.close();
                }
                if(p != null){
                    p.close();
                }
                if(con != null){
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
        String sqldetail = "update d_carbon_analyze_value_detail set delete_flag = ?,delete_date=?,delete_by=?  where doc_id=? and header_id = ? and delete_flag = 'N' and complete_flag = 'N'";
        PreparedStatement p = null;
        try {

            p = con.prepareStatement(sqldetail);
            p.setString(1, "Y");
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getBy());
            p.setString(4, dataBean.getDoc_id());
            p.setString(5, dataBean.getHeader_id());
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

    public String showDetail(String doc_id,String header_id) throws Exception {
        ThaiUtil objth = new ThaiUtil();
        UtiDatabase objuti = new UtiDatabase();
        String SQL, SQL1, strOutput = "";
        SQL1 = "Select Count(doc_id) As num from  d_carbon_analyze_value_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag = 'N' and complete_flag ='N' ";
        int a = objuti.numRowdatabase(SQL1);
        //JOptionPane.showConfirmDialog(null, objuti.numRowdatabase(SQL1));
        strOutput += "<table width='100%' border='0'>\n";
        SQL = "Select * from d_carbon_analyze_value_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and header_id = '"+objth.EncodeTexttoTIS(header_id)+"' and delete_flag = 'N' and complete_flag = 'N' order by runno";
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        rs = con.createStatement().executeQuery(SQL);
        while (rs.next()) {
            strOutput += "<tr>";
            strOutput += "<td class='columnobject' width='3%'><input type='checkbox' id='ckbox' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>";
            strOutput += "<td class='row3' width='5%'>&nbsp;&nbsp;<a href=\"#\"  class='link_data_transparent' onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("line_no") + ",doc_id,username,header_id,hd1,hd2,hd3,hd4,hd5,hd6,hd7,hd8,hd9,hd10,hd11,hd12,hd13,hd14,hd15','../SCREEN/CS_Parameter109.jsp'))\"><input type='hidden' id='line_no_" + rs.getString("line_no") + "' value=\"" + rs.getString("line_no") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\"><input type='hidden' id='runno_" + rs.getString("runno") + "'' value=\"" + rs.getString("runno") + "\">" + rs.getString("line_no") + "</a>&nbsp;&nbsp;</td>\n";
            strOutput += "<td class='row3' width='5%' >"+objuti.NotNull(rs.getString("h2o"))+"&nbsp;</td>\n";
            strOutput += "<td class='row3' width='5%' >"+objuti.NotNull(rs.getString("butane"))+"&nbsp;</td>\n";
            strOutput += "<td class='row3' width='5%' >"+objuti.NotNull(rs.getString("iod"))+"&nbsp;</td>\n";
            strOutput += "<td class='columnobject' width='5%'><input name='hd1_"+rs.getString("line_no")+"' type='text' id='hd1_"+rs.getString("line_no")+"' size='4' value='"+objuti.NotNull(rs.getString("hd1"))+"'></td>\n";
            strOutput += "<td class='columnobject' width='5%'><input name='hd2_"+rs.getString("line_no")+"' type='text' id='hd2_"+rs.getString("line_no")+"' size='4' value='"+objuti.NotNull(rs.getString("hd2"))+"'></td>\n";
            strOutput += "<td class='columnobject' width='5%'><input name='hd3_"+rs.getString("line_no")+"' type='text' id='hd3_"+rs.getString("line_no")+"' size='4' value='"+objuti.NotNull(rs.getString("hd3"))+"'></td>\n";
            strOutput += "<td class='columnobject' width='5%'><input name='hd4_"+rs.getString("line_no")+"' type='text' id='hd4_"+rs.getString("line_no")+"' size='4' value='"+objuti.NotNull(rs.getString("hd4"))+"'></td>\n";
            strOutput += "<td class='columnobject' width='5%'><input name='hd5_"+rs.getString("line_no")+"' type='text' id='hd5_"+rs.getString("line_no")+"' size='4' value='"+objuti.NotNull(rs.getString("hd5"))+"'></td>\n";
            strOutput += "<td class='columnobject' width='5%'><input name='hd6_"+rs.getString("line_no")+"' type='text' id='hd6_"+rs.getString("line_no")+"' size='4' value='"+objuti.NotNull(rs.getString("hd6"))+"'></td>\n";
            strOutput += "<td class='columnobject' width='5%'><input name='hd7_"+rs.getString("line_no")+"' type='text' id='hd7_"+rs.getString("line_no")+"' size='4' value='"+objuti.NotNull(rs.getString("hd7"))+"'></td>\n";
            strOutput += "<td class='columnobject' width='5%'><input name='hd8_"+rs.getString("line_no")+"' type='text' id='hd8_"+rs.getString("line_no")+"' size='4' value='"+objuti.NotNull(rs.getString("hd8"))+"'></td>\n";
            strOutput += "<td class='columnobject' width='5%'><input name='hd9_"+rs.getString("line_no")+"' type='text' id='hd9_"+rs.getString("line_no")+"' size='4' value='"+objuti.NotNull(rs.getString("hd9"))+"'></td>\n";
            strOutput += "<td class='columnobject' width='5%'><input name='hd10_"+rs.getString("line_no")+"' type='text' id='hd10_"+rs.getString("line_no")+"' size='4' value='"+objuti.NotNull(rs.getString("hd10"))+"'></td>\n";
            strOutput += "<td class='columnobject' width='5%'><input name='hd11_"+rs.getString("line_no")+"' type='text' id='hd11_"+rs.getString("line_no")+"' size='4' value='"+objuti.NotNull(rs.getString("hd11"))+"'></td>\n";
            strOutput += "<td class='columnobject' width='5%'><input name='hd12_"+rs.getString("line_no")+"' type='text' id='hd12_"+rs.getString("line_no")+"' size='4' value='"+objuti.NotNull(rs.getString("hd12"))+"'></td>\n";
            strOutput += "<td class='columnobject' width='5%'><input name='hd13_"+rs.getString("line_no")+"' type='text' id='hd13_"+rs.getString("line_no")+"' size='4' value='"+objuti.NotNull(rs.getString("hd13"))+"'></td>\n";
            strOutput += "<td class='columnobject' width='5%'><input name='hd14_"+rs.getString("line_no")+"' type='text' id='hd14_"+rs.getString("line_no")+"' size='4' value='"+objuti.NotNull(rs.getString("hd14"))+"'></td>\n";
            strOutput += "<td class='columnobject' width='5%'><input name='hd15_"+rs.getString("line_no")+"' type='text' id='hd15_"+rs.getString("line_no")+"' size='4' value='"+objuti.NotNull(rs.getString("hd15"))+"'></td>\n";
            strOutput += "<td class='row3' width='7%'>"+ReturnStringPass(rs.getString("pass"))+"</td>\n";
            strOutput += "</tr>";
        }
        rs.close();
        con.close();
        strOutput += "</table>";
        return strOutput;
    }
    public String ReturnStringPass(String inputvalue) {
        String stroutput = "";
        if (inputvalue.equals("Y")) {
            stroutput = "ผ่าน";
        } else if (inputvalue.equals("N")) {
            stroutput = "ไม่ผ่าน";
        }else{
            stroutput = "";
        }
        return stroutput;
    }

}

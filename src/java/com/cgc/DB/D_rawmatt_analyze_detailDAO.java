/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.ThaiUtil;
import com.cgc.Util.UtiDatabase;
import com.cgc.Util.Decimal_Place;
import com.cgc.bean.DataBeanD_rawmatt_analyze_detail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;

/**
 *
 * @author Beckpalmx No7
 */
public class D_rawmatt_analyze_detailDAO {

    private int Returnvalue;
    private UtiDatabase objuti;
    private DecimalFormat df;
    private Double moise_avg;

    public int insert(DataBeanD_rawmatt_analyze_detail dataBean) throws Exception {
        objuti = new UtiDatabase();
        Returnvalue = 0;
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_rawmatt_analyze_detail (doc_id,line_no,weight,moisture_percent,ashes_percent,dust_percent,volatile_percent,mixed_percent,doc_date,remark,create_date,create_by) values(?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getLine_no());
            p.setString(3, dataBean.getWeight());
            p.setString(4, dataBean.getMoisture_percent());
            p.setString(5, dataBean.getAshes_percent());
            p.setString(6, dataBean.getDust_percent());
            p.setString(7, dataBean.getVolatile_percent());
            p.setString(8, dataBean.getMixed_percent());
            p.setString(9, dataBean.getDoc_date());
            //JOptionPane.showConfirmDialog(null, sql)
            p.setString(10, objuti.EncodeNewLine(dataBean.getRemark()));
            p.setTimestamp(11, dataBean.getDate());
            p.setString(12, dataBean.getBy());
            Returnvalue = p.executeUpdate();

            //showDatail(dataBean.getDoc_id());
        } finally {
            //JOptionPane.showConfirmDialog(null, "test");
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }

        }

        return Returnvalue;
    }

    public int update(DataBeanD_rawmatt_analyze_detail dataBean) throws Exception {
        Returnvalue = 0;
        objuti = new UtiDatabase();
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql
                = "update d_rawmatt_analyze_detail set  weight=?,moisture_percent=?,ashes_percent=?,dust_percent=?,volatile_percent=?,mixed_percent=?,doc_date=?,remark=?,update_date=?,update_by=? where doc_id=? and line_no=? and delete_flag ='N' and complete_flag = 'N'";
        PreparedStatement p;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getWeight());
            p.setString(2, dataBean.getMoisture_percent());
            p.setString(3, dataBean.getAshes_percent());
            p.setString(4, dataBean.getDust_percent());
            p.setString(5, dataBean.getVolatile_percent());
            p.setString(6, dataBean.getMixed_percent());
            p.setString(7, dataBean.getDoc_date());
            p.setString(8, objuti.EncodeNewLine(dataBean.getRemark()));
            p.setTimestamp(9, dataBean.getDate());
            p.setString(10, dataBean.getBy());
            p.setString(11, dataBean.getDoc_id());
            p.setString(12, dataBean.getLine_no());
            Returnvalue = p.executeUpdate();

            //showDatail(dataBean.getDoc_id());
        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }

        }
        return Returnvalue;

    }

    public int UpDel(DataBeanD_rawmatt_analyze_detail dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql = "update d_rawmatt_analyze_detail set delete_flag = ?,delete_date=? where doc_id=? and delete_flag ='N' and complete_flag = 'N'";
        PreparedStatement p = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, "Y");
            p.setTimestamp(2, dataBean.getDate());
            p.setString(3, dataBean.getDoc_id());
            Returnvalue = p.executeUpdate();

        } finally {
            try {
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
        return Returnvalue;
    }

    public DataBeanD_rawmatt_analyze_detail ReturnEdit(String Doc_id, String Line_no, DataBeanD_rawmatt_analyze_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        //JOptionPane.showConfirmDialog(null, "test");
        String SQL = "Select doc_date,weight,moisture_percent,ashes_percent,dust_percent,volatile_percent,mixed_percent,replace(remark,'<br>','\n') :: character varying as remark from d_rawmatt_analyze_detail where doc_id = '" + Doc_id + "' and line_no ='" + Line_no + "' and delete_flag ='N'";
        ResultSet rs = con.createStatement().executeQuery(SQL);
        try {
            while (rs.next()) {
                bean.setDoc_date(rs.getString("doc_date"));
                bean.setWeight(rs.getString("weight"));
                bean.setMoisture_percent(rs.getString("moisture_percent"));
                bean.setAshes_percent(rs.getString("ashes_percent"));
                bean.setDust_percent(rs.getString("dust_percent"));
                bean.setVolatile_percent(rs.getString("volatile_percent"));
                bean.setMixed_percent(rs.getString("mixed_percent"));
                bean.setRemark(rs.getString("remark"));

            }
        } finally {
            try {
                rs.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
        return bean;
    }
    //ทำการลบ Line_no ตามบรรทัดที่เลื่อกแล้วทำการ update ข

    public void DeleteLine_no(String inputarry, DataBeanD_rawmatt_analyze_detail bean) throws Exception {
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        int count = 1;
        boolean rclose = false;
        boolean pclose = false;
        ResultSet rs = null;
        PreparedStatement p = null;
        String sql, sql2 ;
        try {
            if (inputarry.length() != 0) {
                String[] strarry = inputarry.split(",");
                for (String strarry1 : strarry) {
                    sql = "update d_rawmatt_analyze_detail set delete_flag=?,delete_date=?,delete_by=? where doc_id=? and line_no=? and delete_flag ='N'";
                    p = con.prepareStatement(sql);
                    p.setString(1, "Y");
                    p.setTimestamp(2, bean.getDate());
                    p.setString(3, bean.getBy());
                    p.setString(4, bean.getDoc_id());
                    p.setString(5, strarry1);
                    p.executeUpdate();
                }
                pclose = true;
                if (strarry.length != -1) {
                    p = null;
                    sql2 = "Select line_no from  d_rawmatt_analyze_detail where doc_id ='" + bean.getDoc_id() + "' and delete_flag <> 'Y' order by runno ";
                    rs = con.createStatement().executeQuery(sql2);
                    while (rs.next()) {
                        sql = "update d_rawmatt_analyze_detail set line_no=? where doc_id=? and line_no=?";
                        p = con.prepareStatement(sql);
                        p.setString(1, Integer.toString(count));
                        p.setString(2, bean.getDoc_id());
                        p.setString(3, rs.getString("line_no"));
                        p.executeUpdate();
                        count = count + 1;
                        rclose = true;
                    }

                }
            }
        } finally {
            try {
                if (rclose) {
                    //rs.close();
                }
                if (pclose) {
                    //p.close();
                    con.close();
                }

            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }

    }

    public void Delete_line_no_All(DataBeanD_rawmatt_analyze_detail dataBean) throws Exception {

        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqldetail = "update d_rawmatt_analyze_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and delete_flag <> 'Y'";
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
                //p.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }
        }
    }

    public String showDatail(String doc_id) throws Exception {
        int count = 0;
        ThaiUtil objth = new ThaiUtil();
        UtiDatabase objuti = new UtiDatabase();
        String SQL1, SQL, strOutput = "";
        strOutput += "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>";
        SQL1 = "Select Count(doc_id) As num from  d_rawmatt_analyze_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "' and delete_flag <> 'Y' ";
        int a = objuti.numRowdatabase(SQL1);
        SQL = "Select doc_id,line_no,weight,moisture_percent,ashes_percent,dust_percent,volatile_percent,mixed_percent,remark from d_rawmatt_analyze_detail where doc_id ='" + objth.EncodeTexttoTIS(doc_id) + "'and delete_flag <> 'Y' order by runno";
        System.out.println("Show SQL = " + SQL);
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        rs = con.createStatement().executeQuery(SQL);
        while (rs.next()) {
            if (count == 0) {
                strOutput += "<tr>";
                strOutput += "<td class='forborder' width='3px'><input type='checkbox' id='ckbox2' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>";
                strOutput += "<td class='forborder' width='7%'><a href=\"#\"  class='link_data_transparent' onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("line_no") + ",doc_id,username','../SCREEN/CS_047.jsp'))\"><input type='hidden' id='line_no_" + rs.getString("line_no") + "' value=\"" + rs.getString("line_no") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\">" + rs.getString("line_no") + "</a></td>";
                strOutput += "<td class='forborder' width='10%'>" + rs.getString("weight") + "</td>";
                strOutput += "<td class='forborder' width='10%'>" + rs.getString("moisture_percent") + "</td>";
                strOutput += "<td class='forborder' width='10%'>" + rs.getString("ashes_percent") + "</td>";
                strOutput += "<td class='forborder' width='10%'>" + rs.getString("dust_percent") + "</td>";
                strOutput += "<td class='forborder' width='10%'>" + rs.getString("volatile_percent") + "</td>";
                strOutput += "<td class='forborder' width='10%'>" + rs.getString("mixed_percent") + "</td>";
                strOutput += "<td class='forborder' width='30%'>" + rs.getString("remark") + "&nbsp;</td>";
                strOutput += "</tr>";
            } else {
                strOutput += "<tr>";
                strOutput += "<td class='forborder' width='3px'><input type='checkbox' id='ckbox2' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>";
                strOutput += "<td class='forborder' width='7%'><a href=\"#\"  class='link_data_transparent' onclick=\"OpenEdit(URLsend('line_no_" + rs.getString("line_no") + ",doc_id,username','../SCREEN/CS_047.jsp'))\"><input type='hidden' id='line_no_" + rs.getString("line_no") + "' value=\"" + rs.getString("line_no") + "\"><input type='hidden' id='doc_id' value=\"" + rs.getString("doc_id") + "\">" + rs.getString("line_no") + "</a></td>";
                strOutput += "<td class='forborder' width='10%'>&nbsp;</td>";
                strOutput += "<td class='forborder' width='10%'>" + rs.getString("moisture_percent") + "</td>";
                strOutput += "<td class='forborder' width='10%'>&nbsp;</td>";
                strOutput += "<td class='forborder' width='10%'>&nbsp;</td>";
                strOutput += "<td class='forborder' width='10%'>&nbsp;</td>";
                strOutput += "<td class='forborder' width='10%'>&nbsp;</td>";
                strOutput += "<td class='forborder' width='30%'>&nbsp;</td>";
                strOutput += "</tr>";
            }
            count = count + 1;
        }
        rs.close();
        con.close();

        strOutput += "</table>";

        /*
         strOutput += "<table width='100%' align='left' border='0' cellpadding='0' cellspacing='1' class='inner'>";
         strOutput += "<tr>";                
         strOutput += "<td width='3%'></td>";
         strOutput += "<td width='10%'>&nbsp;ความชื้นเฉลี่ย&nbsp;<input name='moisture_average' type='text' class='inputs' id='moisture_average' value='" + Moisture_Avg(doc_id) + "' size='7' readonly='true'/> % </td>";
         strOutput += "<td width='10%'></td>";
        
         strOutput += "</tr>";
         strOutput += "</table>";
         */
        return strOutput;
    }

    public String Moisture_Avg(String doc_id) throws Exception {
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        UtiDatabase objuti = new UtiDatabase();
        String SQL1, SQL, strOutput = "";
        df = new DecimalFormat();
        df.applyPattern("###.00");
        SQL1 = "Select Count(doc_id) As num from  d_rawmatt_analyze_detail where doc_id ='" + doc_id + "' and delete_flag <> 'Y' ";
        System.out.println("SQL1 = " + SQL1);
        int Moisture_Record = objuti.numRowdatabase(SQL1);
        SQL = "Select sum(to_number(moisture_percent,'99.99')) as Sum_Moisture from d_rawmatt_analyze_detail where doc_id ='" + doc_id + "'and delete_flag <> 'Y' ";
        ResultSet rs = null;
        rs = con.createStatement().executeQuery(SQL);
        while (rs.next()) {
            moise_avg = Double.valueOf(rs.getDouble("Sum_Moisture") / Moisture_Record);
            System.out.println("Sum_Moisture = " + rs.getDouble("Sum_Moisture"));
            System.out.println("Moisture_Record = " + Moisture_Record);
            System.out.println("moise_avg = " + moise_avg);
            strOutput = df.format(Decimal_Place.Round(moise_avg, 2));
            System.out.println("strOutput Moisture_Avg = " + strOutput);
            if (strOutput.equals(".00")) {
                strOutput = "0.00";
            }
        }

        rs.close();
        con.close();
        return strOutput;
    }

}

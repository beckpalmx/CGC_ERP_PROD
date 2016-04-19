/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.bean.DataBeanD_rawmatt_analyze_header;
import java.sql.Connection;
import com.cgc.Util.UtiDatabase;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import com.cgc.DB.DBConnect;
import com.cgc.Calculator.D_rawmatt_receive_Calculat;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Beckpalmx No7
 */
public class D_rawmatt_analyze_headerDAO {

    private int Returnvalue;
    private String net_weight, weight, ashes_percent, dust_percent, volatile_percent, moise_percent, contamination_percent, remark, price;
    private DecimalFormat df;
    private String SQL, doc_type_check;
    private UtiDatabase objuti;
    private int countvalue;
    private float moise_mean;

    public int insert(DataBeanD_rawmatt_analyze_header dataBean) throws Exception {
        countvalue = 0;
        moise_mean = 0;
        boolean ckclose = false;
        Returnvalue = 0;
        D_rawmatt_receive_Calculat objcal = new D_rawmatt_receive_Calculat();
        String SQLnumrow;
        objuti = new UtiDatabase();
        df = new DecimalFormat();
        df.applyPattern("###.00");
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        String sql = "insert into d_rawmatt_analyze_header (doc_id,car_no,sender_id,c_type,doc_date,report_name,approve_name,create_date,update_date,create_by,car_date_in,approve_status,moisture_average) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement p;
        ResultSet rs;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getDoc_id());
            p.setString(2, dataBean.getCar_no());
            p.setString(3, dataBean.getSender_id());
            p.setString(4, dataBean.getC_type());
            p.setString(5, dataBean.getDoc_date());
            p.setString(6, dataBean.getReport_name());
            p.setString(7, dataBean.getApprove_name());
            p.setTimestamp(8, dataBean.getDate());
            p.setTimestamp(9, dataBean.getDate());
            p.setString(10, dataBean.getBy());
            p.setString(11, dataBean.getCar_date_in());
            p.setString(12, dataBean.getApprove_status());
            p.setString(13, dataBean.getMoisture_average());
            Returnvalue = p.executeUpdate();
            SQLnumrow = "Select Count(doc_id) As num from  d_rawmatt_analyze_detail where doc_id = '" + dataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
            if (objuti.numRowdatabase(SQLnumrow) != 0) {
                SQL = "update d_rawmatt_analyze_detail set  doc_date=?,update_date=?,create_by=? where doc_id=? and complete_flag ='N' and delete_flag ='N'";
                p = con.prepareStatement(SQL);
                p.setString(1, dataBean.getDoc_date());
                p.setTimestamp(2, dataBean.getDate());
                p.setString(3, dataBean.getBy());
                p.setString(4, dataBean.getDoc_id());
                p.executeUpdate();
                SQL = "select weight,ashes_percent,dust_percent,volatile_percent,moisture_percent,mixed_percent,remark from d_rawmatt_analyze_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N' order by line_no";
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    if (countvalue == 0) {
                        weight = rs.getString("weight");
                        ashes_percent = rs.getString("ashes_percent");
                        dust_percent = rs.getString("dust_percent");
                        volatile_percent = rs.getString("volatile_percent");
                        contamination_percent = rs.getString("mixed_percent");
                        remark = rs.getString("remark");
                        System.out.println("Remark : " + remark);
                    }

                    moise_mean = moise_mean + Float.parseFloat(rs.getString("moisture_percent"));
                    countvalue = countvalue + 1;
                }
                moise_mean = Round(moise_mean, 2);
                moise_percent = df.format(Round(moise_mean / countvalue, 2));
                System.out.println("moise_mean = " + moise_mean);
                System.out.println("moise_percent = " + moise_percent);
                Float PersentTotal = Float.parseFloat(ashes_percent) + Float.parseFloat(dust_percent) + Float.parseFloat(volatile_percent) + Float.parseFloat(moise_percent) + Float.parseFloat(contamination_percent);
                net_weight = df.format(Float.parseFloat(weight) - Float.parseFloat(objcal.Percent_to_Kg(weight, Float.toString(PersentTotal))));
                SQL = "update d_rawmatt_analyze_header set  moisture_average=?  where doc_id=? and complete_flag ='N' and delete_flag ='N'";
                p = con.prepareStatement(SQL);
                p.setString(1, moise_percent);
                p.setString(2, dataBean.getDoc_id());
                p.executeUpdate();

                System.out.println("getApprove_status = " + dataBean.getApprove_status());
                doc_type_check = dataBean.getApprove_status();
                System.out.println("doc_type_check = " + doc_type_check);

                if (doc_type_check.equalsIgnoreCase("Y") || doc_type_check.equalsIgnoreCase("N")) {
                    System.out.println("doc_type_check save data = " + doc_type_check);
                    SQL = "update d_rawmatt_receive set  ashes_percent=?,dust_percent=?,volatile_percent=?,moise_percent=?,contamination_percent=?,ashes_weight=?,dust_weight=?,volatile_weight=?,moise_weight=?,contamination_weight=?,net_weight=?,remark=?,update_date=?,update_by=?,doc_type=? where doc_id=? and complete_flag ='N' and delete_flag ='N'";
                    p = con.prepareStatement(SQL);
                    p.setString(1, ashes_percent);
                    p.setString(2, dust_percent);
                    p.setString(3, volatile_percent);
                    p.setString(4, moise_percent);
                    p.setString(5, contamination_percent);
                    p.setString(6, objcal.Percent_to_Kg(weight, ashes_percent));
                    p.setString(7, objcal.Percent_to_Kg(weight, dust_percent));
                    p.setString(8, objcal.Percent_to_Kg(weight, volatile_percent));
                    p.setString(9, objcal.Percent_to_Kg(weight, moise_percent));
                    p.setString(10, objcal.Percent_to_Kg(weight, contamination_percent));
                    p.setString(11, net_weight);
                    p.setString(12, remark.trim());
                    System.out.println("Remark : " + remark.trim());

                    p.setTimestamp(13, dataBean.getDate());
                    p.setString(14, dataBean.getBy());
                    p.setString(15, doc_type_check);
                    p.setString(16, dataBean.getDoc_id());
                    p.executeUpdate();

                }

                System.out.println("Insert Raw Analysis 1 ");

                /*
                 * SQL = "update d_rawmatt_receive set
                 * ashes_percent=?,dust_percent=?,volatile_percent=?,moise_percent=?,contamination_percent=?,ashes_weight=?,dust_weight=?,volatile_weight=?,moise_weight=?,contamination_weight=?,net_weight=?,remark=?,update_date=?,doc_type=?,update_by=?
                 * where doc_id=? and complete_flag ='N' and delete_flag ='N'";
                 * p = con.prepareStatement(SQL); p.setString(1, ashes_percent);
                 * p.setString(2, dust_percent); p.setString(3,
                 * volatile_percent); p.setString(4, moise_percent);
                 * p.setString(5, contamination_percent); p.setString(6,
                 * objcal.Percent_to_Kg(weight, ashes_percent)); p.setString(7,
                 * objcal.Percent_to_Kg(weight, dust_percent)); p.setString(8,
                 * objcal.Percent_to_Kg(weight, volatile_percent));
                 * p.setString(9, objcal.Percent_to_Kg(weight, moise_percent));
                 * p.setString(10, objcal.Percent_to_Kg(weight,
                 * contamination_percent)); p.setString(11, net_weight);
                 * p.setString(12, remark); p.setTimestamp(13,
                 * dataBean.getDate()); p.setString(14, "Y"); p.setString(15,
                 * dataBean.getBy()); p.setString(16, dataBean.getDoc_id());
                 * p.executeUpdate();
                 */
                ckclose = true;
            }

        } finally {
            try {
                //p.close();
                con.close();
                if (ckclose) {
                    //rs.close();
                }
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }

        }

        return Returnvalue;
    }

    public int update(DataBeanD_rawmatt_analyze_header dataBean) throws Exception {
        countvalue = 0;
        moise_mean = 0;
        Returnvalue = 0;
        boolean ckclose = false;
        D_rawmatt_receive_Calculat objcal = new D_rawmatt_receive_Calculat();
        String SQLnumrow;
        objuti = new UtiDatabase();
        df = new DecimalFormat();
        df.applyPattern("###.00");
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sql
                = "update d_rawmatt_analyze_header set  car_no=?,sender_id=?,c_type=?,doc_date=?,report_name=?,approve_name=?,update_date=?,update_by=?,car_date_in=?,approve_status=?,moisture_average=?  where doc_id=? and complete_flag ='N' and delete_flag ='N'";
        PreparedStatement p = null;
        ResultSet rs = null;
        try {
            p = con.prepareStatement(sql);
            p.setString(1, dataBean.getCar_no());
            p.setString(2, dataBean.getSender_id());
            p.setString(3, dataBean.getC_type());
            p.setString(4, dataBean.getDoc_date());
            p.setString(5, dataBean.getReport_name());
            p.setString(6, dataBean.getApprove_name());
            p.setTimestamp(7, dataBean.getDate());
            p.setString(8, dataBean.getBy());
            p.setString(9, dataBean.getCar_date_in());
            p.setString(10, dataBean.getApprove_status());
            p.setString(11, dataBean.getMoisture_average());
            p.setString(12, dataBean.getDoc_id());
            Returnvalue = p.executeUpdate();

            SQLnumrow = "Select Count(doc_id) As num from  d_rawmatt_analyze_detail where doc_id = '" + dataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N'";
            System.out.println("SQLnumrow = " + SQLnumrow);
            if (objuti.numRowdatabase(SQLnumrow) != 0) {
                //p = null;
                SQL = "update d_rawmatt_analyze_detail set  doc_date=?,update_date=?,update_by=?,approve_status=? where doc_id=? and complete_flag ='N' and delete_flag ='N'";
                p = con.prepareStatement(SQL);
                p.setString(1, dataBean.getDoc_date());
                p.setTimestamp(2, dataBean.getDate());
                p.setString(3, dataBean.getBy());
                p.setString(4, dataBean.getApprove_status());
                p.setString(5, dataBean.getDoc_id());
                p.executeUpdate();
                //p = null;
                SQL = "select weight,ashes_percent,dust_percent,volatile_percent,moisture_percent,mixed_percent,remark  from d_rawmatt_analyze_detail where doc_id ='" + dataBean.getDoc_id() + "' and delete_flag = 'N' and complete_flag = 'N' order by line_no";
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    if (countvalue == 0) {
                        weight = rs.getString("weight");
                        ashes_percent = rs.getString("ashes_percent");
                        dust_percent = rs.getString("dust_percent");
                        volatile_percent = rs.getString("volatile_percent");
                        contamination_percent = rs.getString("mixed_percent");
                        remark = rs.getString("remark");
                        System.out.println("Remark : " + remark);
                    }
                    moise_mean = moise_mean + Float.parseFloat(rs.getString("moisture_percent"));
                    countvalue = countvalue + 1;
                }
                moise_mean = Round(moise_mean, 2);

                // Calculate ค่าความชื้นเฉลี่ย
                moise_percent = df.format(Round(moise_mean / countvalue, 2));

                System.out.println("moise_mean = " + moise_mean);
                System.out.println("moise_percent = " + moise_percent);

                //JOptionPane.showConfirmDialog(null, moise_percent);
                Float PersentTotal = Float.parseFloat(ashes_percent) + Float.parseFloat(dust_percent) + Float.parseFloat(volatile_percent) + Float.parseFloat(moise_percent) + Float.parseFloat(contamination_percent);
                net_weight = df.format(Float.parseFloat(weight) - Float.parseFloat(objcal.Percent_to_Kg(weight, Float.toString(PersentTotal))));
                SQL = "update d_rawmatt_analyze_header set  moisture_average=?  where doc_id=? and complete_flag ='N' and delete_flag ='N'";
                System.out.println("Update SQL = " + SQL);
                p = con.prepareStatement(SQL);
                p.setString(1, moise_percent);
                p.setString(2, dataBean.getDoc_id());
                p.executeUpdate();

                System.out.println("doc_type_check before save = " + doc_type_check);
                System.out.println("Insert Raw Analysis 2 ");

                System.out.println("getApprove_status = " + dataBean.getApprove_status());
                doc_type_check = dataBean.getApprove_status();
                System.out.println("doc_type_check = " + doc_type_check);

                if (doc_type_check.equalsIgnoreCase("Y") || doc_type_check.equalsIgnoreCase("N")) {
                    System.out.println("doc_type_check save data = " + doc_type_check);
                    SQL = "update d_rawmatt_receive set  ashes_percent=?,dust_percent=?,volatile_percent=?,moise_percent=?,contamination_percent=?,ashes_weight=?,dust_weight=?,volatile_weight=?,moise_weight=?,contamination_weight=?,net_weight=?,remark=?,update_date=?,update_by=?,doc_type=? where doc_id=? and complete_flag ='N' and delete_flag ='N'";
                    p = con.prepareStatement(SQL);
                    p.setString(1, ashes_percent);
                    p.setString(2, dust_percent);
                    p.setString(3, volatile_percent);
                    p.setString(4, moise_percent);
                    p.setString(5, contamination_percent);
                    p.setString(6, objcal.Percent_to_Kg(weight, ashes_percent));
                    p.setString(7, objcal.Percent_to_Kg(weight, dust_percent));
                    p.setString(8, objcal.Percent_to_Kg(weight, volatile_percent));
                    p.setString(9, objcal.Percent_to_Kg(weight, moise_percent));
                    p.setString(10, objcal.Percent_to_Kg(weight, contamination_percent));
                    p.setString(11, net_weight);
                    p.setString(12, remark.trim());
                    System.out.println("Remark : " + remark.trim());
                    p.setTimestamp(13, dataBean.getDate());
                    p.setString(14, dataBean.getBy());
                    p.setString(15, doc_type_check);
                    p.setString(16, dataBean.getDoc_id());
                    p.executeUpdate();

                }
                ckclose = true;
            }
        } finally {
            try {
                //p.close();
                con.close();
                if (ckclose) {
                    //rs.close();
                }
            } catch (SQLException e) {
                e.printStackTrace(System.out);
            }

        }
        return Returnvalue;

    }

    public void UpDel(DataBeanD_rawmatt_analyze_header dataBean) throws Exception {
        Returnvalue = 0;
        DBConnect dbConnect = new DBConnect();
        Connection con = dbConnect.openNewConnection();
        String sqlheader = "update d_rawmatt_analyze_header set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and complete_flag ='N' and delete_flag ='N'";
        String sqldetail = "update d_rawmatt_analyze_detail set delete_flag = ?,delete_date=?,delete_by=? where doc_id=? and complete_flag ='N' and delete_flag ='N'";
        PreparedStatement p;
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
            sqlheader = "update d_rawmatt_receive set doc_type=? where doc_id=? and complete_flag ='N' and delete_flag ='N'";
            p = con.prepareStatement(sqlheader);
            p.setString(1, "N");
            p.setString(2, dataBean.getDoc_id());
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
//ปัดเศษทศนิยม 2 ตำแหน่ง ตัวอย่าง 18.657 เท่ากับ 18.66

    public static float Round(float Rval, int Rpl) {

        float p = (float) Math.pow(10, Rpl);
        //JOptionPane.showConfirmDialog(null, p);
        System.out.println("P = " + p);
        Rval = Rval * p;
        //JOptionPane.showConfirmDialog(null, Rval);
        System.out.println("Rval = " + Rval + "Replace = " + Rpl);
        float tmp = Math.round(Rval);
        //JOptionPane.showConfirmDialog(null, tmp);
        System.out.println("tmp = " + tmp);
        System.out.println("tmp/p = " + tmp / p);
        return (float) tmp / p;

    }
}

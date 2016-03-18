/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_product_receive_track_header;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.ArrayList;

/**
 *
 * @author Beck
 */
public class D_product_receive_track_headerDAO {

    UtiDatabase objuti = new UtiDatabase();

    public ArrayList<DataBeanD_product_receive_track_header> Select_d_transaction_product_receive(ArrayList<DataBeanD_product_receive_track_header> inputAL, Connection con, String job_id) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        DecimalFormat df = new DecimalFormat("00");
        ResultSet rs = null;
        String SQL = "";
        try {
            SQL = "select job_id,job_type_id,job_type_desc,((select mjob_type.name_t from mjob_type where mjob_type.job_type_id = d_transaction_product_receive.job_type_id and delete_flag = 'N') || job_type_desc) as machine"
                    + ",to_char(min(to_date(doc_date_system,('YYYY-MM-DD'))),'MM') as job_month_min"
                    + ",to_char(max(to_date(doc_date_system,('YYYY-MM-DD'))),'MM') as job_month_max"
                    + ",to_char(min(to_date(doc_date_system,('YYYY-MM-DD'))),'YYYY') as job_year_min"
                    + ",to_char(max(to_date(doc_date_system,('YYYY-MM-DD'))),'YYYY') as job_year_max"
                    + ",to_char(max(to_date(doc_date_system,('YYYY-MM-DD'))),'YYYY-MM-DD') as job_end_date"
                    + ",to_char(min(to_date(doc_date_system,('YYYY-MM-DD'))),'YYYY-MM-DD') as job_begin_date"
                    + " from d_transaction_product_receive  group by job_id,job_type_desc,job_type_id "
                    + "having job_id = '" + job_id + "'";
            rs = con.createStatement().executeQuery(SQL);
            System.out.println("SQL JAVA CALC = " + SQL);
            while (rs.next()) {
                if (rs.getString("job_month_min").equals(rs.getString("job_month_max"))) {
                    DataBeanD_product_receive_track_header bean = new DataBeanD_product_receive_track_header();
                    bean.setDoc_id(rs.getString("job_id") + "-" + rs.getString("job_type_id") + "-" + rs.getString("job_type_desc") + "-" + rs.getString("job_month_max"));
                    bean.setJob_id(rs.getString("job_id"));
                    bean.setJob_type_id(rs.getString("job_type_id"));
                    bean.setJob_type_desc(rs.getString("job_type_desc"));
                    bean.setMachine(rs.getString("machine"));
                    bean.setJob_month(rs.getString("job_month_min"));
                    bean.setJob_year(rs.getString("job_year_max"));
                    bean.setJob_begin_date(rs.getString("job_begin_date"));
                    bean.setJob_end_date(rs.getString("job_end_date"));
                    bean.setDoc_date(objuti.End_Date(rs.getString("job_month_min"), rs.getString("job_year_max"), "TH"));
                    inputAL.add(bean);
                } else {
                    int begin = Integer.parseInt(rs.getString("job_month_min"));
                    int end = Integer.parseInt(rs.getString("job_month_min")) <= Integer.parseInt(rs.getString("job_month_max")) ? Integer.parseInt(rs.getString("job_month_max")) : 12 + Integer.parseInt(rs.getString("job_month_max"));
                    for (int i = begin; i <= end; i++) {
                        DataBeanD_product_receive_track_header bean = new DataBeanD_product_receive_track_header();
                        bean.setDoc_id(rs.getString("job_id") + "-" + rs.getString("job_type_id") + "-" + rs.getString("job_type_desc") + "-" + df.format(i <= 12 ? i : i - 12));
                        bean.setJob_id(rs.getString("job_id"));
                        bean.setJob_type_id(rs.getString("job_type_id"));
                        bean.setJob_type_desc(rs.getString("job_type_desc"));
                        bean.setMachine(rs.getString("machine"));
                        bean.setJob_month(df.format(i <= 12 ? i : i - 12));
                        bean.setJob_year(i <= 12 ? rs.getString("job_year_min") : rs.getString("job_year_max"));
                        bean.setJob_begin_date(rs.getString("job_begin_date"));
                        bean.setJob_end_date(rs.getString("job_end_date"));
                        bean.setDoc_date(objuti.End_Date(df.format(i <= 12 ? i : i - 12),i <= 12 ? rs.getString("job_year_min") : rs.getString("job_year_max"),"TH"));
                        inputAL.add(bean);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null);
            {
                rs.close();
            }
            return inputAL;
        }

    }

    public void insert(Connection con, PreparedStatement p, ArrayList<DataBeanD_product_receive_track_header> inputAL) throws Exception {
        String SQL = "";
        try {
            SQL = "insert into d_product_receive_track_header"
                    + "(doc_id,job_id,job_type_id,job_type_desc,job_month,job_year,job_begin_date,job_end_date,doc_date) "
                    + "values(?,?,?,?,?,?,?,?,?)";
            for (int i = 0; i < inputAL.size(); i++) {
                p = null;
                p = con.prepareStatement(SQL);
                p.setString(1, inputAL.get(i).getDoc_id());
                p.setString(2, inputAL.get(i).getJob_id());
                p.setString(3, inputAL.get(i).getJob_type_id());
                p.setString(4, inputAL.get(i).getJob_type_desc());
                p.setString(5, inputAL.get(i).getJob_month());
                p.setString(6, inputAL.get(i).getJob_year());
                p.setString(7, inputAL.get(i).getJob_begin_date());
                p.setString(8, inputAL.get(i).getJob_end_date());
                p.setString(9, inputAL.get(i).getDoc_date());
                p.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                p.close();
            }
        }
    }
}

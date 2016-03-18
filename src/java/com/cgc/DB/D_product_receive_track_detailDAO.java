/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_product_receive_detail;
import com.cgc.bean.DataBeanD_product_receive_track_detail;
import com.cgc.bean.DataBeanD_product_receive_track_header;
import com.lowagie.text.pdf.ArabicLigaturizer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Beck
 */
public class D_product_receive_track_detailDAO {

    public ArrayList<DataBeanD_product_receive_track_detail> Select_Data(Connection con, ArrayList<DataBeanD_product_receive_track_header> inputAL, ArrayList<DataBeanD_product_receive_track_detail> outputAL) throws Exception {

        int check_value_total = 0;
        //ArrayList<DataBeanD_product_receive_track_detail> obj_detail = new ArrayList<DataBeanD_product_receive_track_detail>();
        UtiDatabase objuti = new UtiDatabase();
        String SQL_Count = "";
        String SQL = "";
        ResultSet rs = null;
        String[] shift = Select_DataTo_Array(con, "mshift", "shift_id").split(",");
        String[] job_type = Select_DataTo_Array(con, "mjob_type", "job_type_id").split(",");
        try {
            for (int i = 0; i < inputAL.size(); i++) {
                //for (int k = 0; k < job_type.length; k++) {
                for (int l = 0; l <= 1; l++) {
                    SQL_Count = "select count(*) as num "
                            + "from d_transaction_product_receive  "
                            + "where job_id = '" + inputAL.get(i).getJob_id() + "' and "
                            + "job_type_id = '" + inputAL.get(i).getJob_type_id() + "' and "
                            + "job_type_desc = '" + inputAL.get(i).getJob_type_desc() + "' and "
                            + "size = (select vd_job_order_header.spec_size from vd_job_order_header where vd_job_order_header.doc_id = '" + inputAL.get(i).getJob_id() + "')  and "
                            + "withdraw_type = '";
                    SQL_Count += (l == 0) ? "N'" : "Y'";
                    if (objuti.numRowdatabase(SQL_Count) != 0) {
                        check_value_total = 0;
                        for (int j = 0; j < shift.length; j++) {
                            SQL_Count = "select count(*) as num "
                                    + "from d_transaction_product_receive  "
                                    + "where job_id = '" + inputAL.get(i).getJob_id() + "' and "
                                    + "job_type_id = '" + inputAL.get(i).getJob_type_id() + "' and "
                                    + "job_type_desc = '" + inputAL.get(i).getJob_type_desc() + "' and "
                                    + "size = (select vd_job_order_header.spec_size from vd_job_order_header where vd_job_order_header.doc_id = '" + inputAL.get(i).getJob_id() + "')  and "
                                    + "withdraw_type = '";
                            SQL_Count += (l == 0) ? "N" : "Y";
                            SQL_Count += "' and  shift = '" + shift[j] + "'";
                            if (objuti.numRowdatabase(SQL_Count) != 0) {
                                check_value_total = 1;
                                SQL = "select job_id,size,doc_date,weight,shift,job_type_id,job_type_desc,doc_date_system,(select mjob_type.doc_type from mjob_type where mjob_type.job_type_id = d_transaction_product_receive.job_type_id and delete_flag ='N') as job_doc_type  "
                                        + "from d_transaction_product_receive  "
                                        + "where job_id = '" + inputAL.get(i).getJob_id() + "' and "
                                        + "job_type_id = '" + inputAL.get(i).getJob_type_id() + "' and "
                                        + "job_type_desc = '" + inputAL.get(i).getJob_type_desc() + "' and "
                                        + " size = (select vd_job_order_header.spec_size from vd_job_order_header where vd_job_order_header.doc_id = '" + inputAL.get(i).getJob_id() + "') and "
                                        + "withdraw_type = '";
                                SQL += (l == 0) ? "N" : "Y";
                                SQL += "' and shift = '" + shift[j] + "' and "
                                        + "to_date(doc_date_system,'YYYY-MM-DD') between '" + inputAL.get(i).getJob_year() + "-" + inputAL.get(i).getJob_month() + "-01' and '" + objuti.End_Date(inputAL.get(i).getJob_month(), inputAL.get(i).getJob_year()) + "'";
                                rs = con.createStatement().executeQuery(SQL);
                                DataBeanD_product_receive_track_detail bean = new DataBeanD_product_receive_track_detail();
                                System.out.println("SQL = " + SQL);

                                while (rs.next()) {
                                    if (rs.getString("job_doc_type").equals("1")) {
                                        bean.setDoc_type("1");
                                    } else {
                                        bean.setDoc_type(l == 0 ? "N" : "Y");
                                    }
                                    bean.setD_1(rs.getString("doc_date").substring(0, 2).equals("01") ? Sum(rs.getString("weight"), bean.getD_1()) : bean.getD_1());
                                    bean.setD_2(rs.getString("doc_date").substring(0, 2).equals("02") ? Sum(rs.getString("weight"), bean.getD_2()) : bean.getD_2());
                                    bean.setD_3(rs.getString("doc_date").substring(0, 2).equals("03") ? Sum(rs.getString("weight"), bean.getD_3()) : bean.getD_3());
                                    bean.setD_4(rs.getString("doc_date").substring(0, 2).equals("04") ? Sum(rs.getString("weight"), bean.getD_4()) : bean.getD_4());
                                    bean.setD_5(rs.getString("doc_date").substring(0, 2).equals("05") ? Sum(rs.getString("weight"), bean.getD_5()) : bean.getD_5());
                                    bean.setD_6(rs.getString("doc_date").substring(0, 2).equals("06") ? Sum(rs.getString("weight"), bean.getD_6()) : bean.getD_6());
                                    bean.setD_7(rs.getString("doc_date").substring(0, 2).equals("07") ? Sum(rs.getString("weight"), bean.getD_7()) : bean.getD_7());
                                    bean.setD_8(rs.getString("doc_date").substring(0, 2).equals("08") ? Sum(rs.getString("weight"), bean.getD_8()) : bean.getD_8());
                                    bean.setD_9(rs.getString("doc_date").substring(0, 2).equals("09") ? Sum(rs.getString("weight"), bean.getD_9()) : bean.getD_9());
                                    bean.setD_10(rs.getString("doc_date").substring(0, 2).equals("10") ? Sum(rs.getString("weight"), bean.getD_10()) : bean.getD_10());
                                    bean.setD_11(rs.getString("doc_date").substring(0, 2).equals("11") ? Sum(rs.getString("weight"), bean.getD_11()) : bean.getD_11());
                                    bean.setD_12(rs.getString("doc_date").substring(0, 2).equals("12") ? Sum(rs.getString("weight"), bean.getD_12()) : bean.getD_12());
                                    bean.setD_13(rs.getString("doc_date").substring(0, 2).equals("13") ? Sum(rs.getString("weight"), bean.getD_13()) : bean.getD_13());
                                    bean.setD_14(rs.getString("doc_date").substring(0, 2).equals("14") ? Sum(rs.getString("weight"), bean.getD_14()) : bean.getD_14());
                                    bean.setD_15(rs.getString("doc_date").substring(0, 2).equals("15") ? Sum(rs.getString("weight"), bean.getD_15()) : bean.getD_15());
                                    bean.setD_16(rs.getString("doc_date").substring(0, 2).equals("16") ? Sum(rs.getString("weight"), bean.getD_16()) : bean.getD_16());
                                    bean.setD_17(rs.getString("doc_date").substring(0, 2).equals("17") ? Sum(rs.getString("weight"), bean.getD_17()) : bean.getD_17());
                                    bean.setD_18(rs.getString("doc_date").substring(0, 2).equals("18") ? Sum(rs.getString("weight"), bean.getD_18()) : bean.getD_18());
                                    bean.setD_19(rs.getString("doc_date").substring(0, 2).equals("19") ? Sum(rs.getString("weight"), bean.getD_19()) : bean.getD_19());
                                    bean.setD_20(rs.getString("doc_date").substring(0, 2).equals("20") ? Sum(rs.getString("weight"), bean.getD_20()) : bean.getD_20());
                                    bean.setD_21(rs.getString("doc_date").substring(0, 2).equals("21") ? Sum(rs.getString("weight"), bean.getD_21()) : bean.getD_21());
                                    bean.setD_22(rs.getString("doc_date").substring(0, 2).equals("22") ? Sum(rs.getString("weight"), bean.getD_22()) : bean.getD_22());
                                    bean.setD_23(rs.getString("doc_date").substring(0, 2).equals("23") ? Sum(rs.getString("weight"), bean.getD_23()) : bean.getD_23());
                                    bean.setD_24(rs.getString("doc_date").substring(0, 2).equals("24") ? Sum(rs.getString("weight"), bean.getD_24()) : bean.getD_24());
                                    bean.setD_25(rs.getString("doc_date").substring(0, 2).equals("25") ? Sum(rs.getString("weight"), bean.getD_25()) : bean.getD_25());
                                    bean.setD_26(rs.getString("doc_date").substring(0, 2).equals("26") ? Sum(rs.getString("weight"), bean.getD_26()) : bean.getD_26());
                                    bean.setD_27(rs.getString("doc_date").substring(0, 2).equals("27") ? Sum(rs.getString("weight"), bean.getD_27()) : bean.getD_27());
                                    bean.setD_28(rs.getString("doc_date").substring(0, 2).equals("28") ? Sum(rs.getString("weight"), bean.getD_28()) : bean.getD_28());
                                    bean.setD_29(rs.getString("doc_date").substring(0, 2).equals("29") ? Sum(rs.getString("weight"), bean.getD_29()) : bean.getD_29());
                                    bean.setD_30(rs.getString("doc_date").substring(0, 2).equals("30") ? Sum(rs.getString("weight"), bean.getD_30()) : bean.getD_30());
                                    bean.setD_31(rs.getString("doc_date").substring(0, 2).equals("31") ? Sum(rs.getString("weight"), bean.getD_31()) : bean.getD_31());
                                    bean.setJob_id(rs.getString("job_id"));
                                    bean.setSize(rs.getString("size"));
                                }
                                if (bean != null) {
                                    bean.setDoc_id(inputAL.get(i).getDoc_id());
                                    bean.setShift(shift[j]);
                                    outputAL.add(bean);
                                }

                            }
                            if (j == (shift.length - 1) && check_value_total == 1) {
                                SQL = "select job_id,doc_date,total_weight_daily,shift,job_type_id,job_type_desc,(select mjob_type.doc_type from mjob_type where mjob_type.job_type_id = d_transaction_total_product_receive.job_type_id and delete_flag ='N') as job_doc_type  "
                                        + "from d_transaction_total_product_receive  "
                                        + "where job_id = '" + inputAL.get(i).getJob_id() + "' and "
                                        + "job_type_id = '" + inputAL.get(i).getJob_type_id() + "' and "
                                        + "job_type_desc = '" + inputAL.get(i).getJob_type_desc() + "' and "
                                        + "withdraw_type = '";
                                SQL += (l == 0) ? "N" : "Y";
                                SQL += "' and  size = (select vd_job_order_header.spec_size from vd_job_order_header where vd_job_order_header.doc_id = '" + inputAL.get(i).getJob_id() + "') and "
                                        + "to_date(doc_date_system,'YYYY-MM-DD') between '" + inputAL.get(i).getJob_year() + "-" + inputAL.get(i).getJob_month() + "-01' and '" + objuti.End_Date(inputAL.get(i).getJob_month(), inputAL.get(i).getJob_year()) + "'";

                                System.out.println("SQL = " + SQL);
                                rs = con.createStatement().executeQuery(SQL);
                                DataBeanD_product_receive_track_detail bean2 = new DataBeanD_product_receive_track_detail();
                                while (rs.next()) {
                                    if (rs.getString("job_doc_type").equals("1")) {
                                        bean2.setDoc_type("1");
                                    } else {
                                        bean2.setDoc_type(l == 0 ? "N" : "Y");
                                    }
                                    bean2.setD_1(rs.getString("doc_date").substring(0, 2).equals("01") ? rs.getString("total_weight_daily") : bean2.getD_1());
                                    bean2.setD_2(rs.getString("doc_date").substring(0, 2).equals("02") ? rs.getString("total_weight_daily") : bean2.getD_2());
                                    bean2.setD_3(rs.getString("doc_date").substring(0, 2).equals("03") ? rs.getString("total_weight_daily") : bean2.getD_3());
                                    bean2.setD_4(rs.getString("doc_date").substring(0, 2).equals("04") ? rs.getString("total_weight_daily") : bean2.getD_4());
                                    bean2.setD_5(rs.getString("doc_date").substring(0, 2).equals("05") ? rs.getString("total_weight_daily") : bean2.getD_5());
                                    bean2.setD_6(rs.getString("doc_date").substring(0, 2).equals("06") ? rs.getString("total_weight_daily") : bean2.getD_6());
                                    bean2.setD_7(rs.getString("doc_date").substring(0, 2).equals("07") ? rs.getString("total_weight_daily") : bean2.getD_7());
                                    bean2.setD_8(rs.getString("doc_date").substring(0, 2).equals("08") ? rs.getString("total_weight_daily") : bean2.getD_8());
                                    bean2.setD_9(rs.getString("doc_date").substring(0, 2).equals("09") ? rs.getString("total_weight_daily") : bean2.getD_9());
                                    bean2.setD_10(rs.getString("doc_date").substring(0, 2).equals("10") ? rs.getString("total_weight_daily") : bean2.getD_10());
                                    bean2.setD_11(rs.getString("doc_date").substring(0, 2).equals("11") ? rs.getString("total_weight_daily") : bean2.getD_11());
                                    bean2.setD_12(rs.getString("doc_date").substring(0, 2).equals("12") ? rs.getString("total_weight_daily") : bean2.getD_12());
                                    bean2.setD_13(rs.getString("doc_date").substring(0, 2).equals("13") ? rs.getString("total_weight_daily") : bean2.getD_13());
                                    bean2.setD_14(rs.getString("doc_date").substring(0, 2).equals("14") ? rs.getString("total_weight_daily") : bean2.getD_14());
                                    bean2.setD_15(rs.getString("doc_date").substring(0, 2).equals("15") ? rs.getString("total_weight_daily") : bean2.getD_15());
                                    bean2.setD_16(rs.getString("doc_date").substring(0, 2).equals("16") ? rs.getString("total_weight_daily") : bean2.getD_16());
                                    bean2.setD_17(rs.getString("doc_date").substring(0, 2).equals("17") ? rs.getString("total_weight_daily") : bean2.getD_17());
                                    bean2.setD_18(rs.getString("doc_date").substring(0, 2).equals("18") ? rs.getString("total_weight_daily") : bean2.getD_18());
                                    bean2.setD_19(rs.getString("doc_date").substring(0, 2).equals("19") ? rs.getString("total_weight_daily") : bean2.getD_19());
                                    bean2.setD_20(rs.getString("doc_date").substring(0, 2).equals("20") ? rs.getString("total_weight_daily") : bean2.getD_20());
                                    bean2.setD_21(rs.getString("doc_date").substring(0, 2).equals("21") ? rs.getString("total_weight_daily") : bean2.getD_21());
                                    bean2.setD_22(rs.getString("doc_date").substring(0, 2).equals("22") ? rs.getString("total_weight_daily") : bean2.getD_22());
                                    bean2.setD_23(rs.getString("doc_date").substring(0, 2).equals("23") ? rs.getString("total_weight_daily") : bean2.getD_23());
                                    bean2.setD_24(rs.getString("doc_date").substring(0, 2).equals("24") ? rs.getString("total_weight_daily") : bean2.getD_24());
                                    bean2.setD_25(rs.getString("doc_date").substring(0, 2).equals("25") ? rs.getString("total_weight_daily") : bean2.getD_25());
                                    bean2.setD_26(rs.getString("doc_date").substring(0, 2).equals("26") ? rs.getString("total_weight_daily") : bean2.getD_26());
                                    bean2.setD_27(rs.getString("doc_date").substring(0, 2).equals("27") ? rs.getString("total_weight_daily") : bean2.getD_27());
                                    bean2.setD_28(rs.getString("doc_date").substring(0, 2).equals("28") ? rs.getString("total_weight_daily") : bean2.getD_28());
                                    bean2.setD_29(rs.getString("doc_date").substring(0, 2).equals("29") ? rs.getString("total_weight_daily") : bean2.getD_29());
                                    bean2.setD_30(rs.getString("doc_date").substring(0, 2).equals("30") ? rs.getString("total_weight_daily") : bean2.getD_30());
                                    bean2.setD_31(rs.getString("doc_date").substring(0, 2).equals("31") ? rs.getString("total_weight_daily") : bean2.getD_31());
                                    bean2.setJob_id(rs.getString("job_id"));
                                    //bean2.setSize(rs.getString("size"));
                                }
                                if (bean2 != null) {
                                    bean2.setDoc_id(inputAL.get(i).getDoc_id());
                                    bean2.setShift("4");
                                    outputAL.add(bean2);
                                }
                            }

                        }

                    }
                }

                //}
            }

            //---------------------------------------------------------------------------------
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            shift = null;
            job_type = null;
            return outputAL;
        }
    }

    public String Select_DataTo_Array(Connection con, String Table_name, String Coloum_return) throws Exception {
        int i = 0;
        String SQL = "";
        String str_return = "";
        ResultSet rs = null;
        //input = new String[objuti.numRowdatabase("select count(" + Coloum_return + ") from " + Table_name + " where delete_flag = 'N'")];
        try {
            SQL = "Select " + Coloum_return + " from " + Table_name + " where delete_flag = 'N'";
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                str_return += rs.getString(Coloum_return) + ",";
            }
            str_return = str_return.substring(0, str_return.length() - 1);
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            return str_return;
        }
    }

    public void insert(Connection con, PreparedStatement p, ArrayList<DataBeanD_product_receive_track_detail> inputAL) throws Exception {
        String SQL = "";
        try {
            SQL = "insert into d_product_receive_track_detail"
                    + "(d_1,d_2,d_3,d_4,d_5,d_6,d_7,d_8,d_9,d_10,d_11,d_12,d_13,d_14,d_15,d_16,d_17,d_18,d_19,d_20,d_21,d_22,d_23,d_24,d_25,d_26,d_27,d_28,d_29,d_30,d_31,doc_id,doc_type,job_id,shift) "
                    + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            p = null;
            p = con.prepareStatement(SQL);
            for (int i = 0; i < inputAL.size(); i++) {
                p.setString(1, inputAL.get(i).getD_1());
                p.setString(2, inputAL.get(i).getD_2());
                p.setString(3, inputAL.get(i).getD_3());
                p.setString(4, inputAL.get(i).getD_4());
                p.setString(5, inputAL.get(i).getD_5());
                p.setString(6, inputAL.get(i).getD_6());
                p.setString(7, inputAL.get(i).getD_7());
                p.setString(8, inputAL.get(i).getD_8());
                p.setString(9, inputAL.get(i).getD_9());
                p.setString(10, inputAL.get(i).getD_10());
                p.setString(11, inputAL.get(i).getD_11());
                p.setString(12, inputAL.get(i).getD_12());
                p.setString(13, inputAL.get(i).getD_13());
                p.setString(14, inputAL.get(i).getD_14());
                p.setString(15, inputAL.get(i).getD_15());
                p.setString(16, inputAL.get(i).getD_16());
                p.setString(17, inputAL.get(i).getD_17());
                p.setString(18, inputAL.get(i).getD_18());
                p.setString(19, inputAL.get(i).getD_19());
                p.setString(20, inputAL.get(i).getD_20());
                p.setString(21, inputAL.get(i).getD_21());
                p.setString(22, inputAL.get(i).getD_22());
                p.setString(23, inputAL.get(i).getD_23());
                p.setString(24, inputAL.get(i).getD_24());
                p.setString(25, inputAL.get(i).getD_25());
                p.setString(26, inputAL.get(i).getD_26());
                p.setString(27, inputAL.get(i).getD_27());
                p.setString(28, inputAL.get(i).getD_28());
                p.setString(29, inputAL.get(i).getD_29());
                p.setString(30, inputAL.get(i).getD_30());
                p.setString(31, inputAL.get(i).getD_31());
                p.setString(32, inputAL.get(i).getDoc_id());
                p.setString(33, inputAL.get(i).getDoc_type());
                p.setString(34, inputAL.get(i).getJob_id());
                p.setString(35, inputAL.get(i).getShift());
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

    public String Sum(String input, String get_bean) {
        int sum = get_bean == null ? 0 : Integer.parseInt(get_bean);
        sum = Integer.parseInt(input) + sum;
        System.out.println("sum " + input + " = " + sum);
        return Integer.toString(sum);
    }
}

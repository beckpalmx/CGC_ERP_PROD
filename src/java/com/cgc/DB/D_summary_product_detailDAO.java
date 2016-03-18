/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.DB;

import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBeanD_summary_product_detail;
import com.cgc.bean.DataBeanD_summary_product_header;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Beck
 */
public class D_summary_product_detailDAO {

    public ArrayList<DataBeanD_summary_product_detail> Select_Case_Calculator(String job_id, Connection con, ArrayList<DataBeanD_summary_product_detail> input_AL) throws Exception {
        String SQL = "";
        UtiDatabase objuti = new UtiDatabase();
        for (int i = 1; i <= 3; i++) {
            SQL = "select  count(*) as num from vd_generate_summary_product  "
                    + "where job_id = '" + job_id + "' and "
                    + " mjob_type_doc_type = '" + Integer.toString(i) + "' ";
            System.out.println("SQL = " + SQL);
            if (objuti.numRowdatabase(SQL) != 0 && i == 1) {
                input_AL = Case_Calculator_Main(i, job_id, con, input_AL);
                break;
            } else if (objuti.numRowdatabase(SQL) != 0 && i == 2) {
                input_AL = Case_Calculator_Main(i, job_id, con, input_AL);
                break;
            } else if (objuti.numRowdatabase(SQL) != 0 && i == 3) {
                input_AL = Case_Calculator_Main(i, job_id, con, input_AL);
                break;
            }
        }
        return input_AL;
    }

    public ArrayList<DataBeanD_summary_product_detail> Case_Calculator_Main(int input_case, String job_id, Connection con, ArrayList<DataBeanD_summary_product_detail> input_AL) throws Exception {

        switch (input_case) {
            case 1:
                input_AL = Case_Cal_1(job_id, con, input_AL);
                break;
            case 2:
                input_AL = Case_Cal_2(job_id, con, input_AL);
                break;
            case 3:
                input_AL = Case_Cal_3(job_id, con, input_AL);
                break;
            default:
                break;
        }
        return input_AL;
    }

    public ArrayList<DataBeanD_summary_product_detail> Case_Cal_1(String job_id, Connection con, ArrayList<DataBeanD_summary_product_detail> input_AL) throws Exception {
        String SQL = "";
        String order_size_job = "";
        ResultSet rs = null;
        int sum = 0;
        try {
            SQL = "select job_id,trim(to_char(sum(to_number(weight,'99999999999999')),'99999999999999')) as weight,size,withdraw_type,mjob_type_doc_type from vd_generate_summary_product  "
                    + "where  job_id='" + job_id + "' and "
                    + "size = (select vd_job_order_header.spec_size from vd_job_order_header where vd_job_order_header.doc_id = '" + job_id + "') "
                    + "group by job_id,withdraw_type,mjob_type_doc_type,size,job_type_desc "
                    + "order by to_number(mjob_type_doc_type,'0'),job_type_desc";
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                order_size_job = rs.getString("size");
                if (rs.getString("withdraw_type").equals("N")) {
                    sum = sum - Integer.parseInt(rs.getString("weight"));
                } else {
                    sum = sum + Integer.parseInt(rs.getString("weight"));
                }
            }
            DataBeanD_summary_product_detail bean = new DataBeanD_summary_product_detail();
            bean.setSize(order_size_job);
            bean.setJob_id(job_id);
            bean.setWeight(Integer.toString(sum));
            bean.setDoc_type("Y");
            input_AL.add(bean);
            rs = null;
            SQL = "select job_id,trim(to_char(sum(to_number(weight,'99999999999999')),'99999999999999')) as weight,size,job_type_id,ctc_i2,withdraw_type,mjob_type_doc_type from vd_generate_summary_product  "
                    + "where  job_id='" + job_id + "' and size <> (select vd_job_order_header.spec_size from vd_job_order_header where vd_job_order_header.doc_id = '" + job_id + "') "
                    + "group by job_id,withdraw_type,mjob_type_doc_type,size,ctc_i2,job_type_id";
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                bean = new DataBeanD_summary_product_detail();
                bean.setJob_id(job_id);
                bean.setCtc_i2(rs.getString("ctc_i2"));
                bean.setSize(rs.getString("size"));
                bean.setWeight(rs.getString("weight"));
                bean.setJob_type_id(rs.getString("job_type_id"));
                bean.setDoc_type(rs.getString("withdraw_type"));
                input_AL.add(bean);
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            return input_AL;
        }
    }

    public ArrayList<DataBeanD_summary_product_detail> Case_Cal_2(String job_id, Connection con, ArrayList<DataBeanD_summary_product_detail> input_AL) throws Exception {
        String mjob_type_select = "";
        String SQL = "", order_size_job = "", ctc_i2 = "";
        int check_work = 0;
        int sum_withdrew = 0;
        int sum = 0;
        ResultSet rs = null;
        String[] mjob_type = Select_DataTo_Array(con, "mjob_type", "job_type_id", " and doc_type <> '1'").split(",");
        try {
            for (int i = 0; i < mjob_type.length; i++) {
                if (Check_value(job_id, mjob_type[i]) != 0 && check_work == 0) {
                    mjob_type_select = mjob_type[i];
                    check_work += 1;
                } else if (Check_value(job_id, mjob_type[i]) != 0 && check_work != 0) {
                    check_work += 1;
                }
            }
            if (check_work == 1) {
                SQL = "select job_id,trim(to_char(sum(to_number(weight,'99999999999999')),'99999999999999')) as weight,ctc_i2,size,job_type_id,withdraw_type,mjob_type_doc_type from vd_generate_summary_product  "
                        + "where  job_id= '" + job_id + "' and size = (select vd_job_order_header.spec_size from vd_job_order_header where vd_job_order_header.doc_id = '" + job_id + "')  and job_type_id = '" + mjob_type_select + "'"
                        + "group by job_id,withdraw_type,mjob_type_doc_type,size,ctc_i2,job_type_id ";
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    DataBeanD_summary_product_detail bean = new DataBeanD_summary_product_detail();
                    bean.setJob_id(job_id);
                    bean.setCtc_i2("ctc_i2");
                    bean.setSize("size");
                    bean.setWeight("weight");
                    bean.setJob_type_id("job_type_id");
                    bean.setDoc_type("withdraw_type");
                    input_AL.add(bean);
                }
                rs = null;
                SQL = "select job_id,trim(to_char(sum(to_number(weight,'99999999999999')),'99999999999999')) as weight,ctc_i2,size,job_type_id,withdraw_type,mjob_type_doc_type from vd_generate_summary_product  "
                        + "where  job_id= '" + job_id + "' and size <> (select vd_job_order_header.spec_size from vd_job_order_header where vd_job_order_header.doc_id = '" + job_id + "')  and job_type_id = '" + mjob_type_select + "' and withdraw_type = 'Y' "
                        + "group by job_id,withdraw_type,mjob_type_doc_type,size,ctc_i2,job_type_id";
                while (rs.next()) {
                    DataBeanD_summary_product_detail bean = new DataBeanD_summary_product_detail();
                    bean.setJob_id(job_id);
                    bean.setCtc_i2(rs.getString("ctc_i2"));
                    bean.setSize(rs.getString("size"));
                    bean.setWeight(rs.getString("weight"));
                    bean.setJob_type_id(rs.getString("job_type_id"));
                    bean.setDoc_type(rs.getString("withdraw_type"));
                    input_AL.add(bean);
                }
            } else {
                SQL = "select job_id,trim(to_char(sum(to_number(weight,'99999999999999')),'99999999999999')) as weight,ctc_i2,size,withdraw_type,mjob_type_doc_type from vd_generate_summary_product  "
                        + "where  job_id= '" + job_id + "' and size = (select vd_job_order_header.spec_size from vd_job_order_header where vd_job_order_header.doc_id = '" + job_id + "')  and job_type_id = '" + mjob_type_select + "' and withdraw_type = 'Y'"
                        + "group by job_id,withdraw_type,mjob_type_doc_type,size,ctc_i2";
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    sum = Integer.parseInt(rs.getString("weight"));
                }
                SQL = "select job_id,trim(to_char(sum(to_number(weight,'99999999999999')),'99999999999999')) as weight,ctc_i2,size,withdraw_type,mjob_type_doc_type,job_type_desc from vd_generate_summary_product  "
                        + "where  job_id= '" + job_id + "' and size = (select vd_job_order_header.spec_size from vd_job_order_header where vd_job_order_header.doc_id = '" + job_id + "')  and job_type_id <> '" + mjob_type_select + "' "
                        + "group by job_id,withdraw_type,mjob_type_doc_type,size,ctc_i2,job_type_desc";
                rs = null;
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    order_size_job = rs.getString("size");
                    ctc_i2 = rs.getString("ctc_i2");
                    if (rs.getString("withdraw_type").equals("N")) {
                        sum = sum - Integer.parseInt(rs.getString("weight"));
                        if (rs.getString("mjob_type_doc_type").equals("2")) {
                            sum_withdrew = sum_withdrew + Integer.parseInt(rs.getString("weight"));
                        }
                    } else {
                        sum = sum + Integer.parseInt(rs.getString("weight"));
                    }
                }
                DataBeanD_summary_product_detail bean = new DataBeanD_summary_product_detail();
                bean.setJob_id(job_id);
                bean.setCtc_i2(ctc_i2);
                bean.setSize(order_size_job);
                bean.setWeight(Integer.toString(sum));
                bean.setDoc_type("Y");
                input_AL.add(bean);
                bean = new DataBeanD_summary_product_detail();
                bean.setJob_id(job_id);
                bean.setCtc_i2(ctc_i2);
                bean.setSize(order_size_job);
                bean.setWeight(Integer.toString(sum_withdrew));
                bean.setDoc_type("N");
                input_AL.add(bean);
                SQL = "select job_id,trim(to_char(sum(to_number(weight,'99999999999999')),'99999999999999')) as weight,size,job_type_id,ctc_i2,withdraw_type,mjob_type_doc_type from vd_generate_summary_product  "
                        + "where  job_id='" + job_id + "' and size <> (select vd_job_order_header.spec_size from vd_job_order_header where vd_job_order_header.doc_id = '" + job_id + "') "
                        + "group by job_id,withdraw_type,mjob_type_doc_type,size,ctc_i2,job_type_id";
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    bean = new DataBeanD_summary_product_detail();
                    bean.setJob_id(job_id);
                    bean.setCtc_i2(rs.getString("ctc_i2"));
                    bean.setSize(rs.getString("size"));
                    bean.setWeight(rs.getString("weight"));
                    bean.setJob_type_id(rs.getString("job_type_id"));
                    bean.setDoc_type(rs.getString("withdraw_type"));
                    input_AL.add(bean);
                }
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            return input_AL;
        }
    }

    public ArrayList<DataBeanD_summary_product_detail> Case_Cal_3(String job_id, Connection con, ArrayList<DataBeanD_summary_product_detail> input_AL) throws Exception {
        String mjob_type_select = "";
        String SQL = "", order_size_job = "", ctc_i2 = "",job_type_id = "",job_type_desc = "";
        int check_work = 0;
        int sum_withdrew = 0;
        int sum = 0;
        ResultSet rs = null;
        String[] mjob_type = Select_DataTo_Array(con, "mjob_type", "job_type_id", " and doc_type <> '1' and doc_type <> '2' ").split(",");
        try {
            for (int i = 0; i < mjob_type.length; i++) {
                if (Check_value(job_id, mjob_type[i]) != 0 && check_work == 0) {
                    mjob_type_select = mjob_type[i];
                    check_work += 1;
                } else if (Check_value(job_id, mjob_type[i]) != 0 && check_work != 0) {
                    check_work += 1;
                }
            }
            if (check_work == 1) {
                int check_weight_withdraw = 0,sum_weight = 0;
                SQL = "select job_id,trim(to_char(sum(to_number(weight,'99999999999999')),'99999999999999')) as weight,ctc_i2,size,job_type_id,withdraw_type,mjob_type_doc_type,job_type_desc from vd_generate_summary_product  "
                        + "where  job_id= '" + job_id + "' and size = (select vd_job_order_header.spec_size from vd_job_order_header where vd_job_order_header.doc_id = '" + job_id + "')  and job_type_id = '" + mjob_type_select + "'"
                        + "group by job_id,withdraw_type,mjob_type_doc_type,size,ctc_i2,job_type_id,job_type_desc "
                        + "order by withdraw_type,to_number(mjob_type_doc_type,'0'),job_type_desc";
                System.out.println("1 Loop SQL = " + SQL);
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    order_size_job = rs.getString("size");
                    ctc_i2 = rs.getString("ctc_i2");
                    job_type_id = rs.getString("job_type_id");
                    if(check_weight_withdraw < Integer.parseInt(rs.getString("weight")) && rs.getString("withdraw_type").equals("N")){
                        check_weight_withdraw = Integer.parseInt(rs.getString("weight"));
                    }
                    if(rs.getString("job_type_desc").indexOf("-") != -1 && rs.getString("withdraw_type").equals("N")){
                        sum_weight = sum_weight - Integer.parseInt(rs.getString("weight"));
                    }else if(rs.getString("withdraw_type").equals("Y")){
                        sum_weight = sum_weight + Integer.parseInt(rs.getString("weight"));
                    }
                }

                DataBeanD_summary_product_detail bean = new DataBeanD_summary_product_detail();
                    bean.setJob_id(job_id);
                    bean.setCtc_i2(ctc_i2);
                    bean.setSize(order_size_job);
                    bean.setWeight(Integer.toString(check_weight_withdraw));
                    bean.setJob_type_id(job_type_id);
                    bean.setDoc_type("N");
                    input_AL.add(bean);
                    bean = new DataBeanD_summary_product_detail();
                    bean.setJob_id(job_id);
                    bean.setCtc_i2(ctc_i2);
                    bean.setSize(order_size_job);
                    bean.setWeight(Integer.toString(sum_weight));
                    bean.setJob_type_id(job_type_id);
                    bean.setDoc_type("Y");
                    input_AL.add(bean);

                rs = null;
                SQL = "select job_id,trim(to_char(sum(to_number(weight,'99999999999999')),'99999999999999')) as weight,ctc_i2,size,job_type_id,withdraw_type,mjob_type_doc_type from vd_generate_summary_product  "
                        + "where  job_id= '" + job_id + "' and size <> (select vd_job_order_header.spec_size from vd_job_order_header where vd_job_order_header.doc_id = '" + job_id + "')  and job_type_id = '" + mjob_type_select + "'"
                        + "group by job_id,withdraw_type,mjob_type_doc_type,size,ctc_i2,job_type_id";
                System.out.println("2 Loop SQL = " + SQL);
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                     bean = new DataBeanD_summary_product_detail();
                    bean.setJob_id(job_id);
                    bean.setCtc_i2(rs.getString("ctc_i2"));
                    bean.setSize(rs.getString("size"));
                    bean.setWeight(rs.getString("weight"));
                    bean.setJob_type_id(rs.getString("job_type_id"));
                    bean.setDoc_type(rs.getString("withdraw_type"));
                    input_AL.add(bean);
                }
            } else {
                ///หาถ่านเบิก
                SQL = "select job_id,trim(to_char(sum(to_number(weight,'99999999999999')),'99999999999999')) as weight,size,withdraw_type,mjob_type_doc_type,job_type_desc,job_type_id from vd_generate_summary_product  "
                        + "group by job_id,withdraw_type,mjob_type_doc_type,size,job_type_desc,job_type_id "
                        + "having job_id='"+job_id+"' and "
                        + "size = (select vd_job_order_header.spec_size from vd_job_order_header where vd_job_order_header.doc_id = '"+job_id+"') and "
                        + "withdraw_type = 'N' "
                        + "order by withdraw_type,to_number(mjob_type_doc_type,'0'),job_type_desc";
                System.out.println("3 Loop SQL = " + SQL);
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    if(sum_withdrew < Integer.parseInt(rs.getString("weight"))){
                        mjob_type_select = rs.getString("job_type_id");
                        sum_withdrew = Integer.parseInt(rs.getString("weight"));
                    }
                }
                //หาถ่านได้
                SQL = "select job_id,trim(to_char(sum(to_number(weight,'99999999999999')),'99999999999999')) as weight,size,withdraw_type,mjob_type_doc_type,job_type_desc,job_type_id from vd_generate_summary_product  "
                        + "group by job_id,withdraw_type,mjob_type_doc_type,size,job_type_desc,job_type_id "
                        + "having job_id='"+job_id+"' and "
                        + "size = (select vd_job_order_header.spec_size from vd_job_order_header where vd_job_order_header.doc_id = '"+job_id+"') and "
                        + "withdraw_type = 'Y' "
                        + "order by withdraw_type,to_number(mjob_type_doc_type,'0'),job_type_desc";
                System.out.println("4 Loop SQL = " + SQL);
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    if(sum < Integer.parseInt(rs.getString("weight"))){
                        mjob_type_select = rs.getString("job_type_id");
                        job_type_desc = rs.getString("job_type_desc");
                        sum = Integer.parseInt(rs.getString("weight"));
                    }
                }
                ///-------หาค่าของ
                SQL = "select job_id,trim(to_char(sum(to_number(weight,'99999999999999')),'99999999999999')) as weight,ctc_i2,size,withdraw_type,mjob_type_doc_type from vd_generate_summary_product  "
                        + "where  job_id= '" + job_id + "' and size = (select vd_job_order_header.spec_size from vd_job_order_header where vd_job_order_header.doc_id = '" + job_id + "')  and job_type_id <> '" + mjob_type_select + "' and job_type_desc <> '"+job_type_desc+"' "
                        + "group by job_id,withdraw_type,mjob_type_doc_type,size,ctc_i2,job_type_desc";
                
                System.out.println("5 Loop SQL = " + SQL);
                rs = null;
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    order_size_job = rs.getString("size");
                    ctc_i2 = rs.getString("ctc_i2");
                    if (rs.getString("withdraw_type").equals("N")) {
                        sum = sum - Integer.parseInt(rs.getString("weight"));
                    } else {
                        sum = sum + Integer.parseInt(rs.getString("weight"));
                    }
                }
                DataBeanD_summary_product_detail bean = new DataBeanD_summary_product_detail();
                bean.setJob_id(job_id);
                bean.setCtc_i2(ctc_i2);
                bean.setSize(order_size_job);
                bean.setWeight(Integer.toString(sum));
                bean.setDoc_type("Y");
                input_AL.add(bean);
                bean = new DataBeanD_summary_product_detail();
                bean.setJob_id(job_id);
                bean.setCtc_i2(ctc_i2);
                bean.setSize(order_size_job);
                bean.setWeight(Integer.toString(sum_withdrew));
                bean.setDoc_type("N");
                input_AL.add(bean);
                SQL = "select job_id,trim(to_char(sum(to_number(weight,'99999999999999')),'99999999999999')) as weight,size,job_type_id,ctc_i2,withdraw_type,mjob_type_doc_type from vd_generate_summary_product  "
                        + "where  job_id='" + job_id + "' and size <> (select vd_job_order_header.spec_size from vd_job_order_header where vd_job_order_header.doc_id = '" + job_id + "') "
                        + "group by job_id,withdraw_type,mjob_type_doc_type,size,ctc_i2,job_type_id";
                System.out.println("6 Loop SQL = " + SQL);
                rs = con.createStatement().executeQuery(SQL);
                while (rs.next()) {
                    bean = new DataBeanD_summary_product_detail();
                    bean.setJob_id(job_id);
                    bean.setCtc_i2(rs.getString("ctc_i2"));
                    bean.setSize(rs.getString("size"));
                    bean.setWeight(rs.getString("weight"));
                    bean.setJob_type_id(rs.getString("job_type_id"));
                    bean.setDoc_type(rs.getString("withdraw_type"));
                    input_AL.add(bean);
                }
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            return input_AL;
        }
    }

    public String Select_DataTo_Array(Connection con, String Table_name, String Coloum_return, String Stadment_Where) throws Exception {
        int i = 0;
        String SQL = "";
        String str_return = "";
        ResultSet rs = null;
        try {
            SQL = "Select " + Coloum_return + " from " + Table_name + " where delete_flag = 'N' " + Stadment_Where + " order by to_number(job_type_id,'999')";
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

    public int Check_value(String job_id, String job_type_id) throws Exception {
        UtiDatabase objuti = new UtiDatabase();
        String SQL = "select count(*) as num  from vd_generate_summary_product where job_type_id = '" + job_type_id + "' and job_id = '" + job_id + "' and size = (select vd_job_order_header.spec_size from vd_job_order_header where vd_job_order_header.doc_id = '" + job_id + "')";
        return objuti.numRowdatabase(SQL);
    }

    public void insert(Connection con, PreparedStatement p, ArrayList<DataBeanD_summary_product_detail> input_AL) throws Exception {
        String SQL = "";
        try {
            for (int i = 0; i < input_AL.size(); i++) {
                if (input_AL.get(i).getDoc_type().equals("N")) {
                    SQL = "insert into d_summary_product_detail(job_id,size,ctc_i2,job_type_id,weight,percent)"
                            + "values(?,?,?,?,?,?)";
                    p = con.prepareStatement(SQL);
                    p.setString(1, input_AL.get(i).getJob_id());
                    p.setString(2, input_AL.get(i).getSize());
                    p.setString(3, input_AL.get(i).getCtc_i2());
                    p.setString(4, input_AL.get(i).getJob_type_id());
                    p.setString(5, input_AL.get(i).getWeight());
                    p.setString(6, input_AL.get(i).getPercent());
                } else if (input_AL.get(i).getDoc_type().equals("Y")) {
                    SQL = "insert into d_summary_product_detail_prod(job_id,size,ctc_i2,job_type_id,weight,percent)"
                            + "values(?,?,?,?,?,?)";
                    p = con.prepareStatement(SQL);
                    p.setString(1, input_AL.get(i).getJob_id());
                    p.setString(2, input_AL.get(i).getSize());
                    p.setString(3, input_AL.get(i).getCtc_i2());
                    p.setString(4, input_AL.get(i).getJob_type_id());
                    p.setString(5, input_AL.get(i).getWeight());
                    p.setString(6, input_AL.get(i).getPercent());
                }
                p.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (p != null) {
                //p.clearBatch();
                p.close();
            }
        }
    }
}

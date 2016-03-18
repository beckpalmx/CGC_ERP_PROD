/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.report;

import com.cgc.DB.DBConnect;
import com.cgc.Util.ThaiUtil;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBean_Temp;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Beck
 */
public class PrintTemp {

    private static ArrayList<DataBean_Temp> obj_detail = new ArrayList<DataBean_Temp>();
    private static ArrayList<DataBean_Temp> obj_prod = new ArrayList<DataBean_Temp>();
    private static ArrayList<DataBean_Temp> obj_print = new ArrayList<DataBean_Temp>();

    private void Select_D_product_receive_detail(Connection con, String job_id, String job_type_id, String job_type_desc) throws Exception {
        String SQL = "";
        if (job_id.equals("")) {
            SQL = "select job_id,size,job_type_id,job_type_desc,"
                    + "trim(to_char(sum(to_number(qty,'9999999999999999999990')),'9999999999999999999990')) as weight_total,"
                    + "(select d_job_order_detail.spec from d_job_order_detail where d_job_order_detail.doc_id = d_product_receive_detail.job_id and line_no = '2' and delete_flag = 'N')  as spec_order,"
                    + "((select mjob_type.name_t from mjob_type where mjob_type.job_type_id = d_product_receive_detail.job_type_id) || job_type_desc) as machine"
                    //+ " from d_product_receive_detail  group by size,job_type_id,job_id,job_type_desc,delete_flag,complete_flag HAVING  "
                    + " from d_product_receive_detail  group by size,job_type_id,job_id,job_type_desc,delete_flag HAVING  "
                    + " job_id <> '' and job_type_id = '" + job_type_id + "' and job_type_desc = '" + job_type_desc + "' "
                    //+ "and  delete_flag = 'N' and complete_flag = 'N'     "
                    + "and  delete_flag = 'N' "
                    + "order by (to_number(job_type_id,'999'))";
            System.out.println("SQL1 = "+SQL);
        } else {
            SQL = "select job_id,size,job_type_id,job_type_desc,"
                    + "trim(to_char(sum(to_number(qty,'9999999999999999999990')),'9999999999999999999990')) as weight_total,"
                    + "(select d_job_order_detail.spec from d_job_order_detail where d_job_order_detail.doc_id = d_product_receive_detail.job_id and line_no = '2' and delete_flag = 'N')  as spec_order,"
                    + "((select mjob_type.name_t from mjob_type where mjob_type.job_type_id = d_product_receive_detail.job_type_id) || job_type_desc) as machine"
                    //+ " from d_product_receive_detail  group by size,job_type_id,job_id,job_type_desc,delete_flag,complete_flag HAVING  "
                    + " from d_product_receive_detail  group by size,job_type_id,job_id,job_type_desc,delete_flag HAVING  "
                    + "job_id = '" + job_id + "' and  job_type_id = '" + job_type_id + "' and job_type_desc = '" + job_type_desc + "' "
                    //+ "and  delete_flag = 'N' and complete_flag = 'N'  "
                    + "and  delete_flag = 'N' "
                    + "order by (to_number(job_type_id,'999'))";
            System.out.println("SQL2 = "+SQL);
        }
        ResultSet rs = null;
        try {
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                DataBean_Temp bean_detail = new DataBean_Temp();
                bean_detail.setJob_id(rs.getString("job_id"));
                bean_detail.setSize(rs.getString("size"));
                bean_detail.setJob_type_id(rs.getString("job_type_id"));
                bean_detail.setJob_type_desc(rs.getString("job_type_desc"));
                bean_detail.setSpec_order(rs.getString("spec_order"));
                bean_detail.setMachine(rs.getString("machine"));
                bean_detail.setWeight(rs.getString("weight_total"));
                //bean_detail.setWithdraw_dry(rs.getString("job_type_id").equals("009") ? rs.getString("weight_total") : null);
                obj_detail.add(bean_detail);
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
        }
    }

    private void Select_D_product_receive_detail_prod(Connection con, String job_id) throws Exception {
        String SQL = "";
        if (job_id.equals("")) {
            SQL = "select CURRENT_DATE as doc_date,job_id,size,job_type_id,job_type_desc,"
                    + "trim(to_char(sum(to_number(weight,'9999999999999999999990')),'9999999999999999999990')) as weight_total,"
                    + "(select d_job_order_detail.spec from d_job_order_detail where d_job_order_detail.doc_id = d_product_receive_detail_prod.job_id and line_no = '2' and delete_flag = 'N')  as spec_order,"
                    + "((select mjob_type.name_t from mjob_type where mjob_type.job_type_id = d_product_receive_detail_prod.job_type_id) || job_type_desc) as machine "
                    //+ "from d_product_receive_detail_prod  group by size,job_type_id,job_id,job_type_desc,delete_flag,complete_flag HAVING  delete_flag = 'N' and complete_flag = 'N'  and job_id <> '' "
                    + "from d_product_receive_detail_prod  group by size,job_type_id,job_id,job_type_desc,delete_flag HAVING  delete_flag = 'N' and job_id <> '' "                    
                    + "order by (to_number(job_type_id,'999'))";
            System.out.println("SQL3 = "+SQL);
        } else {
            SQL = "select CURRENT_DATE as doc_date,job_id,size,job_type_id,job_type_desc,"
                    + "trim(to_char(sum(to_number(weight,'9999999999999999999990')),'9999999999999999999990')) as weight_total,"
                    + "(select d_job_order_detail.spec from d_job_order_detail where d_job_order_detail.doc_id = d_product_receive_detail_prod.job_id and line_no = '2' and delete_flag = 'N')  as spec_order,"
                    + "((select mjob_type.name_t from mjob_type where mjob_type.job_type_id = d_product_receive_detail_prod.job_type_id) || job_type_desc) as machine "
                    //+ "from d_product_receive_detail_prod  group by size,job_type_id,job_id,job_type_desc,delete_flag,complete_flag HAVING  delete_flag = 'N' and complete_flag = 'N' and  "
                    + "from d_product_receive_detail_prod  group by size,job_type_id,job_id,job_type_desc,delete_flag HAVING  delete_flag = 'N' and  "
                    + "job_id = '" + job_id + "' "
                    + "order by (to_number(job_type_id,'999'))";
            System.out.println("SQL4 = "+SQL);
        }
        ResultSet rs = null;
        try {
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                DataBean_Temp bean_prod = new DataBean_Temp();
                bean_prod.setDoc_date(rs.getString("doc_date"));
                bean_prod.setJob_id(rs.getString("job_id"));
                bean_prod.setSize(rs.getString("size"));
                bean_prod.setJob_type_id(rs.getString("job_type_id"));
                bean_prod.setJob_type_desc(rs.getString("job_type_desc"));
                bean_prod.setSpec_order(rs.getString("spec_order"));
                bean_prod.setMachine(rs.getString("machine"));
                bean_prod.setWeight(rs.getString("weight_total"));
                obj_prod.add(bean_prod);
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
        }
    }

    public void Print(HttpServletRequest request, HttpServletResponse response) throws IOException, Exception {
        //String SQL = "select job_id from d_product_receive_header  group by job_id,doc_date,complete_flag,delete_flag having doc_date = '" + request.getParameter("doc_date") + "' and complete_flag ='N' and delete_flag = 'N'";
        String SQL = "select job_id from d_product_receive_header  group by job_id,doc_date,delete_flag having doc_date = '" + request.getParameter("doc_date") + "' and delete_flag = 'N'";        
        int count = 0;
        UtiDatabase objuti = new UtiDatabase();
        ThaiUtil en = new ThaiUtil();
        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        String job_id = "";
        //String job_id = en.EncodeTexttoTIS(request.getParameter("job_id").trim());
        try {
            rs = con.createStatement().executeQuery(SQL);
            while (rs.next()) {
                job_id = rs.getString("job_id");
                Select_D_product_receive_detail_prod(con, job_id);
                while (count < obj_prod.size()) {
                    if (obj_prod.get(count).getJob_type_id().equals("001")
                            || obj_prod.get(count).getJob_type_id().equals("002")
                            || obj_prod.get(count).getJob_type_id().equals("003")
                            || obj_prod.get(count).getJob_type_id().equals("007")
                            || obj_prod.get(count).getJob_type_id().equals("010")) {
                        DataBean_Temp beanprint = new DataBean_Temp();
                        beanprint.setDoc_date(obj_prod.get(count).getDoc_date());
                        beanprint.setJob_id(obj_prod.get(count).getJob_id());
                        beanprint.setSpec_order(obj_prod.get(count).getSpec_order());
                        beanprint.setSize(obj_prod.get(count).getSize());
                        beanprint.setWeight(obj_prod.get(count).getWeight());
                        beanprint.setMachine(obj_prod.get(count).getMachine());
                        obj_print.add(beanprint);
                        count++;
                    } else if (obj_prod.get(count).getJob_type_id().equals("008")
                            || obj_prod.get(count).getJob_type_id().equals("009")
                            || obj_prod.get(count).getJob_type_id().equals("006")) {
                        Select_D_product_receive_detail(con, job_id, obj_prod.get(count).getJob_type_id(), obj_prod.get(count).getJob_type_desc());
                        if (obj_prod.get(count).getJob_type_id().equals("006")) {
                            DataBean_Temp beanprint = new DataBean_Temp();
                            beanprint.setDoc_date(obj_prod.get(count).getDoc_date());
                            beanprint.setJob_id(obj_prod.get(count).getJob_id());
                            beanprint.setSpec_order(obj_prod.get(count).getSpec_order());
                            beanprint.setSize(obj_prod.get(count).getSize());
                            beanprint.setResolt_mag(obj_prod.get(count).getWeight());
                            beanprint.setMachine(obj_prod.get(count).getMachine());
                            obj_print.add(beanprint);
                            Select_D_product_receive_detail(con, job_id, obj_prod.get(count).getJob_type_id(), obj_prod.get(count).getJob_type_desc());
                            obj_print = Math_Withdraw(obj_detail, obj_print);
                            obj_detail.clear();
                        } else if (obj_prod.get(count).getJob_type_id().equals("008")) {
                            DataBean_Temp beanprint = new DataBean_Temp();
                            beanprint.setDoc_date(obj_prod.get(count).getDoc_date());
                            beanprint.setJob_id(obj_prod.get(count).getJob_id());
                            beanprint.setSpec_order(obj_prod.get(count).getSpec_order());
                            beanprint.setSize(obj_prod.get(count).getSize());
                            beanprint.setResolt_it(obj_prod.get(count).getWeight());
                            beanprint.setMachine(obj_prod.get(count).getMachine());
                            obj_print.add(beanprint);
                            Select_D_product_receive_detail(con, job_id, obj_prod.get(count).getJob_type_id(), obj_prod.get(count).getJob_type_desc());
                            obj_print = Math_Withdraw(obj_detail, obj_print);
                            obj_detail.clear();
                        } else {
                            DataBean_Temp beanprint = new DataBean_Temp();
                            beanprint.setDoc_date(obj_prod.get(count).getDoc_date());
                            beanprint.setJob_id(obj_prod.get(count).getJob_id());
                            beanprint.setSpec_order(obj_prod.get(count).getSpec_order());
                            beanprint.setSize(obj_prod.get(count).getSize());
                            beanprint.setResolt_dry(obj_prod.get(count).getWeight());
                            beanprint.setMachine(obj_prod.get(count).getMachine());
                            obj_print.add(beanprint);
                            Select_D_product_receive_detail(con, job_id, obj_prod.get(count).getJob_type_id(), obj_prod.get(count).getJob_type_desc());
                            obj_print = Math_Withdraw(obj_detail, obj_print);
                            obj_detail.clear();
                        }
                        count++;
                    } else if (obj_prod.get(count).getJob_type_id().equals("004")) {
                        DataBean_Temp beanprint = new DataBean_Temp();
                        beanprint.setDoc_date(obj_prod.get(count).getDoc_date());
                        beanprint.setJob_id(obj_prod.get(count).getJob_id());
                        beanprint.setSpec_order(obj_prod.get(count).getSpec_order());
                        beanprint.setSize(obj_prod.get(count).getSize());
                        beanprint.setWash(obj_prod.get(count).getWeight());
                        beanprint.setMachine(obj_prod.get(count).getMachine());
                        obj_print.add(beanprint);
                        count++;
                    } else if (obj_prod.get(count).getJob_type_id().equals("005")) {
                        DataBean_Temp beanprint = new DataBean_Temp();
                        beanprint.setDoc_date(obj_prod.get(count).getDoc_date());
                        beanprint.setJob_id(obj_prod.get(count).getJob_id());
                        beanprint.setSpec_order(obj_prod.get(count).getSpec_order());
                        beanprint.setSize(obj_prod.get(count).getSize());
                        beanprint.setDry(obj_prod.get(count).getWeight());
                        beanprint.setMachine(obj_prod.get(count).getMachine());
                        obj_print.add(beanprint);
                        count++;
                    }
                }
            }
            count = 0;
            response.setContentType("application/csv");
            response.setHeader("Content-Disposition", "inline; filename=\"filename.csv\"");
            response.setBufferSize(1024);
            PrintWriter pw = response.getWriter();
            pw.println("ว.ด.ป,ใบแจ้งการผลิต,ยอดที่สั่งซื้อ(ตัน),ขนาดถ่าน,ผลิตได้(KG.),เบิกงานแก้(KG.),แก้งานได้(KG.),ล้างถ่าน(KG.),อบแห้ง(KG.),เบิกถ่านอบแห้ง(KG.),อบแห้งแก้ได้(KG.),เบิกแก้MAG(KG.),แก้ได้MAG(KG.),เครื่องผลิต");
            String line;
            while (count < obj_print.size()) {
                //line = null;
                line = obj_print.get(count).getDoc_date() + ",";
                line += obj_print.get(count).getJob_id() + ",";
                line += obj_print.get(count).getSpec_order() + ",";
                line += obj_print.get(count).getSize().indexOf("+") == -1 ?   obj_print.get(count).getSize()+"," : "\'"+obj_print.get(count).getSize()+",";
                line += obj_print.get(count).getWeight() != null ? obj_print.get(count).getWeight() + "," : "" + ",";
                line += obj_print.get(count).getWithdraw_resolution() != null ? obj_print.get(count).getWithdraw_resolution() + "," : "" + ",";
                line += obj_print.get(count).getResolt_it() != null ? obj_print.get(count).getResolt_it() + "," : "" + ",";
                line += obj_print.get(count).getWash() != null ? obj_print.get(count).getWash() + "," : "" + ",";
                line += obj_print.get(count).getDry() != null ? obj_print.get(count).getDry() + "," : "" + ",";
                line += obj_print.get(count).getWithdraw_dry() != null ? obj_print.get(count).getWithdraw_dry() + "," : "" + ",";
                line += obj_print.get(count).getResolt_dry() != null ? obj_print.get(count).getResolt_dry() + "," : "" + ",";
                line += obj_print.get(count).getWithdraw_mag() != null ? obj_print.get(count).getWithdraw_mag() + "," : "" + ",";
                line += obj_print.get(count).getResolt_mag() != null ? obj_print.get(count).getResolt_mag() + "," : "" + ",";
                line += obj_print.get(count).getMachine() + ",";
                pw.println(line);
                count++;
            }
            pw.close();
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (con != null) {
                con.close();
            }

            obj_detail.clear();
            obj_print.clear();
            obj_prod.clear();
            //if(obj_detail.isEmpty())
        }
    }

    public ArrayList<DataBean_Temp> Math_Withdraw(ArrayList<DataBean_Temp> obj_detail, ArrayList<DataBean_Temp> obj_print) {
        for (int i = 0; i < obj_detail.size(); i++) {
            obj_print = Update_Withdraw(obj_detail.get(i).getJob_id(), obj_detail.get(i).getJob_type_id(), obj_detail.get(i).getSize(), obj_detail.get(i).getMachine(), obj_detail.get(i).getSpec_order(), obj_detail.get(i).getWeight(), obj_print);
        }
        return obj_print;
    }

    public ArrayList<DataBean_Temp> Update_Withdraw(String job_id, String job_type_id, String size, String machine, String spec_order, String Weight, ArrayList<DataBean_Temp> obj_print) {
        for (int i = 0; i < obj_print.size(); i++) {
            if (obj_print.get(i).getJob_id().equals(job_id)
                    && obj_print.get(i).getSize().equals(size)
                    && obj_print.get(i).getMachine().equals(machine)
                    && obj_print.get(i).getSpec_order().equals(spec_order)) {
                if(job_type_id.equals("006")){
                    obj_print.get(i).setWithdraw_mag(Weight);
                }else if(job_type_id.equals("008")) {
                    obj_print.get(i).setWithdraw_resolution(Weight);
                } else {
                    obj_print.get(i).setWithdraw_dry(Weight);
                }
            }
        }
        return obj_print;
    }
}

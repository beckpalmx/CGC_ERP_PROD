/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.report;

import com.cgc.DB.DBConnect;
import com.cgc.Util.UtiDatabase;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Administrator
 */
public class PrintCSV_Summary_Warehouse_1 {
    UtiDatabase objuti;
    public void PrintExport_Summary_Warehouse(HttpServletRequest request, HttpServletResponse response)throws Exception{
        Connection con = new DBConnect().openNewConnection();
        objuti = new UtiDatabase();
        ResultSet rs = null;
        String process_id = request.getParameter("process_id");
        String date_from = request.getParameter("date_from");
        String date_to = request.getParameter("date_to");
        String SQL = "select process_id,(select name_t from mprocess where mprocess.process_id = t_transaction_stock.process_id and delete_flag = 'N') as process_name,"
                + "product_id,(select name_t from mproduct where mproduct.product_id = t_transaction_stock.product_id and delete_flag = 'N') as product_name"
                + ",location_id,wh_in,wh_out,doc_type,trim(to_char(sum(to_number(weight,'99999999999999999999.00')),'99999999999999999999.00')) :: character varying as total_weight,trim(to_char(sum(to_number(weight_withdraw,'99999999999999999999.00')),'99999999999999999999.00')) :: character varying as total_weight_withdraw"
                + " from t_transaction_stock "
                + "where process_id = '"+process_id+"' and "
                + "to_date(format_date(doc_date),'YYYY-MM-DD') between to_date(format_date('"+date_from+"'),'YYYY-MM-DD') and to_date(format_date('"+date_to+"'),'YYYY-MM-DD')"
                + "group by process_id,product_id,location_id,wh_in,wh_out,doc_type order by process_id,product_id,location_id,wh_out,doc_type";
        try{
            response.setContentType("application/csv");
            response.setHeader("Content-Disposition", "inline; filename=\"filename.csv\"");
            response.setBufferSize(1024);
            PrintWriter pw = response.getWriter();
            pw.println("ตั้งแต่วันที่,"+date_from+",จนถึง,"+date_to);
            
            rs = con.createStatement().executeQuery(SQL);
            while(rs.next()){
                pw.println("รหัสprocess,ชื่อprocess,,รหัสสินค้า,ชื่อสินค้า,โกดัง,กองที่,สถานะ,");
                pw.println(
                        rs.getString("process_id")+","
                        +rs.getString("process_name")+",,"
                        +rs.getString("product_id")+","
                        +rs.getString("product_name")+","
                        +rs.getString((rs.getString("doc_type").equals("+")?"wh_out":"wh_in"))+","
                        +rs.getString("location_id")+","
                        +Status_Doc_Type(rs.getString("doc_type"))+","
                        );
                pw.println(Detail_Transection_Stock(con, rs.getString("process_id"), rs.getString("product_id"), rs.getString("location_id"), rs.getString("doc_type"),rs.getString("doc_type").equals("+")?rs.getString("wh_out"):rs.getString("wh_in"),date_from,date_to));
                pw.println(",,,,,,,รวมทั้งหมด,"+rs.getString("total_weight")+","+rs.getString("total_weight_withdraw")+"");
            }

            pw.close();
        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            if(rs != null){
                rs.close();
            }
            if(con != null){
                con.close();
            }
        }
    }
    public String Status_Doc_Type(String input_doc_type){
        return input_doc_type.equals("-")?"จ่ายออก":"รับเข้า";
    }
    //select ข้อมูลของสินค้านั้นๆว่ามีการรับเข้าจ่ายออกอย่างไรบ้าง
    public String Detail_Transection_Stock(Connection con,String process_id,String product_id,String location_id,String doc_type,String warehouse_id,String doc_from,String doc_to)throws  Exception{
        ResultSet rs = null;
        String SQL_Detail = null;
        StringBuffer output_string = new StringBuffer();
        try{
            SQL_Detail = "select "
                    + "runno,doc_no,doc_date,job_id,location_id,product_id,wh_in,wh_out,doc_type,weight,weight_withdraw,"
                    + "(select name_t from mproduct where mproduct.product_id = t_transaction_stock.product_id and mproduct.delete_flag = 'N') as product_name"
                    + " from t_transaction_stock  "
                    + "where process_id = '"+process_id+"' and product_id = '"+product_id+"' and location_id = '"+location_id+"' and doc_type = '"+doc_type+"' and "+(doc_type.equals("+")?"wh_out":"wh_in")+" = '"+warehouse_id+"' and "
                    + "to_date(format_date(doc_date),'YYYY-MM-DD')  between to_date(format_date('"+doc_from+"'),'YYYY-MM-DD') and to_date(format_date('"+doc_to+"'),'YYYY-MM-DD') "
                    + "order by doc_date,runno";
            rs = con.createStatement().executeQuery(SQL_Detail);
            output_string.append("รหัสเอกสาร,วันที่บันทึกเอกสาร,รหัสใบสั่งซื้อสินค้า,รหัสสินค้า,ชื่อสินค้า,โกดัง,กองที่,สถานะ,น้ำหนัก(คลังสินค้า),น้ำหนัก(เอกสาร),\n");
            while(rs.next()){
                output_string.append(
                        rs.getString("doc_no")+","
                        +rs.getString("doc_date")+","
                        +rs.getString("job_id")+","
                        +rs.getString("product_id")+","
                        +rs.getString("product_name")+","
                        +rs.getString((doc_type.equals("+")?"wh_out":"wh_in"))+","
                        +rs.getString("location_id")+","
                        +Status_Doc_Type(rs.getString("doc_type"))+","
                        +rs.getString("weight")+","
                        +rs.getString("weight_withdraw")+"\n"
                        );
            }

        }catch(Exception e){
            e.printStackTrace(System.out);
        }finally{
            if(rs != null){
                rs.close();
            }
            return  output_string.toString();
        }
    }
    
}

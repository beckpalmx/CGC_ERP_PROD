/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cgc.report;

import com.cgc.DB.DBConnect;
import com.cgc.Util.UtiDatabase;
import com.cgc.bean.DataBean_MData_export;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;

/**
 *
 * @author Beck
 */
public class PrintCSV_WAREHOUSE_TRANSFER {

    static DataBean_MData_export objMdata_export;
    UtiDatabase objuti;

    public void ExportCSV(HttpServletRequest request, HttpServletResponse response) throws IOException, Exception {
        String[] Return_param_value = new String[]{};
        String Str_Writer = "";
        String SQL = "" , Str_Balance;
        int count = 1;
        String location_id = "1";
        String doc_type = "+";
        String iodine = "0";
        String doc_date_transfer_from = request.getParameter("date_from");
        String doc_date_transfer_to = request.getParameter("date_to");

        DBConnect objcon = new DBConnect();
        Connection con = objcon.openNewConnection();
        ResultSet rs = null;
        Return_Fill_MData_Export(request.getParameter("export_id"), con, rs);

        if (request.getParameter("export_id").equals("EXP012")) {
            SQL = " select * from v_tmp_stock_3 ";
            Str_Balance = "ยอดสินค้าคงเหลือ : " ;
        } else {
            SQL = " select * from tmp_stock_4 ";
            Str_Balance = "ยอดวัตถุดิบคงเหลือ : " ;
        }

        System.out.println(SQL);

        objuti = new UtiDatabase();
        response.setContentType("application/csv");
        java.util.Date date = new java.util.Date();
        System.out.println(new Timestamp(date.getTime()));
        response.setHeader("Content-Disposition", "inline; filename=\"filename.csv\"");

        //response.setHeader( "Content-Disposition", "attachment;filename=" + new Timestamp(date.getTime())+".csv\"" );
        response.setBufferSize(1024);
        //ServletOutputStream out = response.getOutputStream();
        try {

            rs = con.createStatement().executeQuery(SQL);
            try (PrintWriter pw = response.getWriter()) {
                pw.println("product_id,warehouse,location_id,weight,doc_type,prod_name,pgroup_id,ptype_id,pcat_id,iodine,unit_name,weight_bag,doc_date,remark,price_per_unit");
                while (rs.next()) {
                    Str_Writer = objuti.NotNull(rs.getString("product_id")) + ",";
                    Str_Writer += objuti.NotNull(rs.getString("wh_id")) + ",";
                    Str_Writer += location_id + ",";
                    Str_Writer += objuti.NotNull(rs.getString("data_total")) + ",";
                    Str_Writer += doc_type + ",";
                    Str_Writer += objuti.NotNull(rs.getString("prod_name")) + ",";
                    Str_Writer += objuti.NotNull(rs.getString("pgroup_id")) + ",";
                    Str_Writer += objuti.NotNull(rs.getString("ptype_id")) + ",";
                    Str_Writer += objuti.NotNull(rs.getString("pcat_id")) + ",";
                    Str_Writer += iodine + ",";
                    Str_Writer += objuti.NotNull(rs.getString("unit_name")) + ",";
                    Str_Writer += objuti.NotNull(rs.getString("data_r")) + ",";
                    Str_Writer += "'" + doc_date_transfer_to + ",";
                    Str_Writer += Str_Balance + doc_date_transfer_from + ",";                    
                    Str_Writer += objuti.NotNull(rs.getString("price_per_unit")) + ",";

                    pw.println(Str_Writer);
                    System.out.println("Str_Writer = " + Str_Writer);
                    Str_Writer = null;
                }
            }

        } catch (SQLException | IOException e) {
            e.printStackTrace(System.out);
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    private void Return_Fill_MData_Export(String export_id, Connection con, ResultSet rs) throws Exception {
        String SQL_export = "select * from mdata_export where export_id = '" + export_id + "' and delete_flag = 'N'";
        objMdata_export = new DataBean_MData_export();
        objuti = new UtiDatabase();
        try {
            rs = con.createStatement().executeQuery(SQL_export);
            while (rs.next()) {
                objMdata_export.setParam_value(objuti.NotNull(rs.getString("param_value")));//จะได้ชื่อColoumภายในDataBaseเพื่อทำการดึงข้อมูลออกมา
                objMdata_export.setParam_name(objuti.NotNull(rs.getString("param_name")));//จะทำการระบุชื่อหัวของColoum
                objMdata_export.setParam_from(objuti.NotNull(rs.getString("param_from")));//จะเป็นช่องของ Doc_id
                objMdata_export.setParam_value_from(objuti.NotNull(rs.getString("param_value_from")));//จะเป็นชื่อของ Doc_date
                objMdata_export.setLookup_name(objuti.NotNull(rs.getString("lookup_name")));//ชื่อของTableที่จะExport
                objMdata_export.setStatus(objuti.NotNull(rs.getString("status")));
                objMdata_export.setName_t(objuti.NotNull(rs.getString("name_t")));//ชื่อของ Process นั้น
                objMdata_export.setOrder_by(objuti.NotNull(rs.getString("order_by")));//เป็น Statement ในการเรียงลำดับข้อมูล
                objMdata_export.setComplete_flag(objuti.NotNull(rs.getString("complete_flag")));
                objMdata_export.setDelete_flag(objuti.NotNull(rs.getString("delete_flag")));
                objMdata_export.setRetro_flag(objuti.NotNull(rs.getString("retro_flag")));
                objMdata_export.setCancel_flag(objuti.NotNull(rs.getString("cancel_flag")));
                //objMdata_export.setParam_type(objuti.NotNull(rs.getString("param_type")));//จะเป็นการระบุ flag ต่างๆๆ
            }

        } catch (SQLException e) {
            e.printStackTrace(System.out);
        }
    }

    private String[] String_sprit(String input) {
        return input.split(",");
    }
}

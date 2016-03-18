<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.DB.D_carbon_send_product_detailDAO"%>
<%@page import="com.cgc.bean.DataBeand_carbon_send_product_detail"%>
<%@page import="com.cgc.DB.MPROCESSDAO"%>
<%@page import="com.cgc.bean.DataBeanMPROCESS"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    Timestamp ts;
    DataBeand_carbon_send_product_detail objdb = new DataBeand_carbon_send_product_detail();
    D_carbon_send_product_detailDAO objex = new D_carbon_send_product_detailDAO();

%>
<%
    int statusck = 0;
    int statusnum = 0;
    System.out.println("status_a : " + request.getParameter("status_a"));
    System.out.println("Send : " + request.getParameter("doc_id"));
    if (request.getParameter("status_a") != null) {
        if (uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_send_product_detail where doc_id = '" + request.getParameter("doc_id") + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
            statusck = -1;
        } else {
            statusck = 1;
            statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_send_product_detail where doc_id = '" + request.getParameter("doc_id") + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
            objdb.setLine_no(Integer.toString(statusnum + 1));
            System.out.println("Line No : " + Integer.toString(statusnum + 1));
        }
    } else if (request.getParameter("status_u") != null) {
        if (uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_send_product_detail where doc_id = '" + request.getParameter("doc_id") + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
            statusck = -1;
        } else {
            statusck = 2;
        }
        objdb.setLine_no(request.getParameter("line_no"));

    } else if (request.getParameter("status_d") != null) {
        statusck = Integer.parseInt(request.getParameter("status_d"));
        System.out.println("Delete status_d = " + request.getParameter("status_d"));
        objdb.setDoc_id(request.getParameter("A_doc_id"));
        System.out.println("Delete Doc ID = " + request.getParameter("A_doc_id"));
    }
    /*else {
     statusck = -1;
     }*/

    if (statusck == 1 || statusck == 2) {

        System.out.println("Line No JSP : " + request.getParameter("line_no"));
        objdb.setDoc_id(request.getParameter("doc_id"));
        objdb.setDoc_date((request.getParameter("doc_date")).equals("") ? "" : en.EncodeTexttoTIS(request.getParameter("doc_date")));
        objdb.setJob_id((request.getParameter("job_id")).equals("") ? "" : en.EncodeTexttoTIS(request.getParameter("job_id")));
        objdb.setParam_header_id((request.getParameter("job_id")).equals("") ? "" : en.EncodeTexttoTIS(request.getParameter("job_id")));
        objdb.setProduct_id((request.getParameter("product_id")).equals("") ? "" : en.EncodeTexttoTIS(request.getParameter("product_id")));
        objdb.setSize_name((request.getParameter("size_name")).equals("") ? "" : en.EncodeTexttoTIS(request.getParameter("size_name")));
        objdb.setIodine((request.getParameter("iodine")).equals("") ? "" : en.EncodeTexttoTIS(request.getParameter("iodine")));
        objdb.setMachine_id((request.getParameter("machine_id")).equals("") ? "" : en.EncodeTexttoTIS(request.getParameter("machine_id")));
        objdb.setPallet((request.getParameter("pallet")).equals("") ? "" : en.EncodeTexttoTIS(request.getParameter("pallet")));
        objdb.setProduct_no((request.getParameter("product_no")).equals("") ? "" : en.EncodeTexttoTIS(request.getParameter("product_no")));
        objdb.setBag_quatity((request.getParameter("bag_quatity")).equals("")||request.getParameter("bag_quatity") == null ? "0" : en.EncodeTexttoTIS(request.getParameter("bag_quatity")));
        objdb.setBag_weight((request.getParameter("bag_weight")).equals("")||request.getParameter("bag_weight") == null ? "0" : en.EncodeTexttoTIS(request.getParameter("bag_weight")));
        objdb.setWeight((request.getParameter("weight")).equals("")||request.getParameter("weight") == null ? "0" : en.EncodeTexttoTIS(request.getParameter("weight")));
        System.out.print("Last " + request.getParameter("wh_id"));
        System.out.print("Last " + request.getParameter("location_id"));        
        objdb.setWh_id(((request.getParameter("wh_id")) == null || request.getParameter("wh_id").equals("")) ? "-" : request.getParameter("wh_id"));        
        objdb.setLocation_id(((request.getParameter("location_id")) == null || request.getParameter("location_id").equals("")) ? "-" : request.getParameter("location_id"));                
        objdb.setWh_product_id(((request.getParameter("wh_product_id")) == null || request.getParameter("wh_product_id").equals("")) ? "-" : request.getParameter("wh_product_id"));
        objdb.setFraction(((request.getParameter("fraction")) == null || request.getParameter("fraction").equals("")) ? "0" : request.getParameter("fraction"));
        objdb.setJob_type(((request.getParameter("job_type")) == null || request.getParameter("job_type").equals("")) ? "-" : en.EncodeTexttoTIS(request.getParameter("job_type")));
        objdb.setDoc_type(((request.getParameter("doc_type")) == null || request.getParameter("doc_type").equals("")) ? "-" : en.EncodeTexttoTIS(request.getParameter("doc_type")));
        objdb.setWh_iodine(((request.getParameter("wh_iodine")) == null || request.getParameter("wh_iodine").equals("")) ? "0" : request.getParameter("wh_iodine"));        
        objdb.setWh_iodine_real(((request.getParameter("wh_iodine_real")) == null || request.getParameter("wh_iodine_real").equals("")) ? "0" : request.getParameter("wh_iodine_real"));        
        System.out.print("setFraction " + request.getParameter("fraction"));
        System.out.print("setJob_type " + request.getParameter("job_type"));
        /*                
         objdb.setWh_weight((request.getParameter("wh_weight")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("wh_weight")));  
         objdb.setLab_analyze_flag((request.getParameter("lab_analyze_flag")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("lab_analyze_flag")));
         objdb.setJob_edit_detail((request.getParameter("job_edit_detail")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("job_edit_detail")));          
         objdb.setWh_id((request.getParameter("wh_id")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("wh_id")));                  
         objdb.setLocation_id((request.getParameter("location_id")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("location_id")));                    
         objdb.setRemark((request.getParameter("remark")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("remark")));
         */

    }

    objdb.setDate(new Timestamp(new java.util.Date().getTime()));
    objdb.setBy(((UserBean) session.getAttribute("user")).getUsername());

    System.out.print("Final " + request.getParameter("weight"));

    System.out.println("Final statusck = " + statusck);

    switch (statusck) {
        case -1:
            out.print("ไม่สามารถบันทึกข้อมูลนี้ได้เนื่องจากมีเลขที่เอกสารที่สมบูรณ์แล้ว");
            break;
        case 1:
            objex.insert(objdb);
            out.print("บันทึกสำเร็จ");
            break;
        case 2:
            objex.update(objdb);
            out.print("แก้ไขสำเร็จ");
            break;
        case 3:
            if (request.getParameter("chk_all") != null) {
                System.out.println("Delete All");
                objex.Delete_all_line_no(objdb, "d_carbon_send_product_detail");
            } else {
                System.out.println("Delete line");
                objex.Delete_line_no(request.getParameter("ckbox"), objdb, "d_carbon_send_product_detail");
            }
            break;
        default:
            out.print("No Statment");
    }
%>
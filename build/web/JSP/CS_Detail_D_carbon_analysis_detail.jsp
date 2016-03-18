<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.DB.CS_D_carbon_analysis_detailDAO"%>
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
    CS_D_carbon_analysis_detailDAO objex = new CS_D_carbon_analysis_detailDAO();

%>
<%
    int statusck = 0;
    int statusnum = 0;
    System.out.println("status_a : " + request.getParameter("status_a"));
    System.out.println("Send : " + request.getParameter("doc_id"));
    if (request.getParameter("status_a") != null) {
        if (uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_analysis_all_detail where doc_id = '" + request.getParameter("doc_id") + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
            statusck = -1;
        } else {
            statusck = 1;
            statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_analysis_all_detail where doc_id = '" + request.getParameter("doc_id") + "' and delete_flag <> 'Y' and complete_flag <> 'Y' ");
            objdb.setLine_no(Integer.toString(statusnum + 1));
            System.out.println("Line No : " + Integer.toString(statusnum + 1));
        }
    } else if (request.getParameter("status_u") != null) {
        if (uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_send_product_detail where doc_id = '" + request.getParameter("doc_id") + "' and delete_flag = 'N' and complete_flag = 'Y' ") != 0) {
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
        objdb.setProduct_id((request.getParameter("product_id")).equals("") ? "" : en.EncodeTexttoTIS(request.getParameter("product_id")));
        objdb.setSize_name((request.getParameter("size_name")).equals("") ? "" : en.EncodeTexttoTIS(request.getParameter("size_name")));
        objdb.setIodine((request.getParameter("iodine")).equals("") ? "" : en.EncodeTexttoTIS(request.getParameter("iodine")));
        objdb.setMachine_id((request.getParameter("machine_id")).equals("") ? "" : en.EncodeTexttoTIS(request.getParameter("machine_id")));
        objdb.setPallet((request.getParameter("pallet")).equals("") ? "" : en.EncodeTexttoTIS(request.getParameter("pallet")));
        objdb.setProduct_no((request.getParameter("product_no")).equals("") ? "" : en.EncodeTexttoTIS(request.getParameter("product_no")));
        objdb.setBag_quatity((request.getParameter("bag_quatity")).equals("")||request.getParameter("bag_quatity") == null  ? "0" : en.EncodeTexttoTIS(request.getParameter("bag_quatity")));
        objdb.setBag_weight((request.getParameter("bag_weight")).equals("")||request.getParameter("bag_weight") == null ? "0" : en.EncodeTexttoTIS(request.getParameter("bag_weight")));
        objdb.setWeight((request.getParameter("weight")).equals("")||request.getParameter("weight") == null ? "0" : en.EncodeTexttoTIS(request.getParameter("weight")));
        System.out.print("Last " + request.getParameter("wh_id"));
        System.out.print("Last " + request.getParameter("location_id"));
        objdb.setWh_id(((request.getParameter("wh_id")) == null) ? "-" : request.getParameter("wh_id"));
        objdb.setLocation_id(((request.getParameter("location_id")) == null) ? "-" : request.getParameter("location_id"));
        objdb.setWh_product_id(((request.getParameter("wh_product_id")) == null) ? "-" : request.getParameter("wh_product_id"));
        objdb.setFraction(((request.getParameter("fraction")) == null || request.getParameter("fraction").equals("")) ? "0" : request.getParameter("fraction"));
        objdb.setJob_type(((request.getParameter("job_type")) == null || request.getParameter("job_type").equals("")) ? "-" : en.EncodeTexttoTIS(request.getParameter("job_type")));
        objdb.setDoc_type(((request.getParameter("doc_type")) == null || request.getParameter("doc_type").equals("")) ? "-" : en.EncodeTexttoTIS(request.getParameter("doc_type")));
        System.out.print("setFraction " + request.getParameter("fraction"));
        System.out.print("setJob_type " + en.EncodeTexttoTIS(request.getParameter("job_type")));
        /*                
         objdb.setWh_weight((request.getParameter("wh_weight")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("wh_weight")));  
         objdb.setLab_analyze_flag((request.getParameter("lab_analyze_flag")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("lab_analyze_flag")));
         objdb.setJob_edit_detail((request.getParameter("job_edit_detail")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("job_edit_detail")));          
         objdb.setWh_id((request.getParameter("wh_id")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("wh_id")));                  
         objdb.setLocation_id((request.getParameter("location_id")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("location_id")));                    
         objdb.setRemark((request.getParameter("remark")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("remark")));
         */
        
        objdb.setH2o(((request.getParameter("h2o")) == null || request.getParameter("h2o").equals("")) ? "-" : en.EncodeTexttoTIS(request.getParameter("h2o")));           
        objdb.setButane(((request.getParameter("butane")) == null || request.getParameter("butane").equals("")) ? "-" : en.EncodeTexttoTIS(request.getParameter("butane")));           
        objdb.setIod(((request.getParameter("iod")) == null || request.getParameter("iod").equals("")) ? "-" : en.EncodeTexttoTIS(request.getParameter("iod")));        
        
        System.out.println("h2o " + request.getParameter("h2o"));
        System.out.println("butane " + request.getParameter("butane"));
        System.out.println("iod " + request.getParameter("iod"));
        
        objdb.setPsd_1((request.getParameter("psd_1")).equals("")?"":request.getParameter("psd_1"));
        objdb.setPsd_2((request.getParameter("psd_2")).equals("")?"":request.getParameter("psd_2"));
        objdb.setPsd_3((request.getParameter("psd_3")).equals("")?"":request.getParameter("psd_3"));
        objdb.setPsd_4((request.getParameter("psd_4")).equals("")?"":request.getParameter("psd_4"));
        objdb.setPsd_5((request.getParameter("psd_5")).equals("")?"":request.getParameter("psd_5"));
        objdb.setPsd_6((request.getParameter("psd_6")).equals("")?"":request.getParameter("psd_6"));
        objdb.setPsd_7((request.getParameter("psd_7")).equals("")?"":request.getParameter("psd_7"));
        objdb.setPsd_8((request.getParameter("psd_8")).equals("")?"":request.getParameter("psd_8"));
        objdb.setPsd_9((request.getParameter("psd_9")).equals("")?"":request.getParameter("psd_9"));
        objdb.setPsd_10((request.getParameter("psd_10")).equals("")?"":request.getParameter("psd_10"));
        objdb.setPsd_11((request.getParameter("psd_11")).equals("")?"":request.getParameter("psd_11"));        
        objdb.setPsd_12((request.getParameter("psd_12")).equals("")?"":request.getParameter("psd_12"));        
        objdb.setPsd_13((request.getParameter("psd_13")).equals("")?"":request.getParameter("psd_13"));        
        objdb.setPsd_14((request.getParameter("psd_14")).equals("")?"":request.getParameter("psd_14"));        
        objdb.setPsd_15((request.getParameter("psd_15")).equals("")?"":request.getParameter("psd_15"));                
        
        System.out.println("Fst psd 1 = " + request.getParameter("psd_1"));
        objdb.setPsd_1_header(request.getParameter("psd_1_header")==null||(request.getParameter("psd_1_header")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("psd_1_header")));
        objdb.setPsd_2_header(request.getParameter("psd_2_header")==null||(request.getParameter("psd_2_header")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("psd_2_header")));
        objdb.setPsd_3_header(request.getParameter("psd_3_header")==null||(request.getParameter("psd_3_header")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("psd_3_header")));
        objdb.setPsd_4_header(request.getParameter("psd_4_header")==null||(request.getParameter("psd_4_header")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("psd_4_header")));
        objdb.setPsd_5_header(request.getParameter("psd_5_header")==null||(request.getParameter("psd_5_header")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("psd_5_header")));      
        objdb.setPsd_6_header(request.getParameter("psd_6_header")==null||(request.getParameter("psd_6_header")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("psd_6_header")));
        objdb.setPsd_7_header(request.getParameter("psd_7_header")==null||(request.getParameter("psd_7_header")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("psd_7_header")));
        objdb.setPsd_8_header(request.getParameter("psd_8_header")==null||(request.getParameter("psd_8_header")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("psd_8_header")));
        objdb.setPsd_9_header(request.getParameter("psd_9_header")==null||(request.getParameter("psd_9_header")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("psd_9_header")));
        objdb.setPsd_10_header(request.getParameter("psd_10_header")==null||(request.getParameter("psd_10_header")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("psd_10_header")));                
        objdb.setPsd_11_header(request.getParameter("psd_11_header")==null||(request.getParameter("psd_11_header")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("psd_11_header")));                
        objdb.setPsd_12_header(request.getParameter("psd_12_header")==null||(request.getParameter("psd_12_header")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("psd_12_header")));                        
        objdb.setPsd_13_header(request.getParameter("psd_13_header")==null||(request.getParameter("psd_13_header")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("psd_13_header")));                        
        objdb.setPsd_14_header(request.getParameter("psd_14_header")==null||(request.getParameter("psd_14_header")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("psd_14_header")));                        
        objdb.setPsd_15_header(request.getParameter("psd_15_header")==null||(request.getParameter("psd_15_header")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("psd_15_header")));   

        System.out.println("Final psd_15_header = " + request.getParameter("psd_15_header"));
        
        objdb.setPass(request.getParameter("valuepass"));
        
        System.out.println("Final valuepass 1 = " + request.getParameter("valuepass"));
        
        objdb.setGrade(request.getParameter("grade"));
        
        System.out.println("Final grade 1 = " + request.getParameter("grade"));        
        objdb.setRemark(request.getParameter("remark")==null||(request.getParameter("remark")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("remark")));   
        System.out.println("Final remark 1 = " + request.getParameter("remark"));
        
        objdb.setParam_header_id(request.getParameter("param_header_id"));
        
        System.out.println("Final param_header_id 1 = " + request.getParameter("param_header_id"));
        
        objdb.setWh_iodine(request.getParameter("grade"));
        
        System.out.println("Final lab_emp_id 1 = " + request.getParameter("lab_emp_id"));
        
        objdb.setLab_analyze_flag((request.getParameter("valuepass")).equals("") || request.getParameter("valuepass")==null ? "N" : "Y");
        
        objdb.setLab_emp_id(request.getParameter("lab_emp_id")==null||(request.getParameter("lab_emp_id")).equals("")?"":en.EncodeTexttoTIS(request.getParameter("lab_emp_id")));           
        
        System.out.println("psd 1 = " + request.getParameter("psd_1"));
        System.out.println("psd 2 = " + request.getParameter("psd_2"));
        System.out.println("psd 3 = " + request.getParameter("psd_3"));
        System.out.println("valuepass = " + request.getParameter("valuepass"));
        System.out.println("grade = " + request.getParameter("grade"));
        System.out.println("wh_iodine = " + request.getParameter("wh_iodine"));
        
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
            objex.insert_detail(objdb);
            out.print("บันทึกสำเร็จ");
            break;
        case 2:
            objex.update(objdb);
            out.print("แก้ไขสำเร็จ");
            break;
        case 3:
            if (request.getParameter("chk_all") != null) {
                System.out.println("Delete All");
                objex.Delete_all_line_no(objdb, "d_carbon_analysis_all_detail");
            } else {
                System.out.println("Delete line");
                objex.Delete_line_no(request.getParameter("ckbox"), objdb, "d_carbon_analysis_all_detail");
            }
            break;
        default:
            out.print("No Statment");
    }
%>
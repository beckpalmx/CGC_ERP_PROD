<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.DB.D_carbon_out_analysis_detailDAO"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_out_analysis_detail"%>
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
    DataBeanD_carbon_out_analysis_detail objdb = new DataBeanD_carbon_out_analysis_detail();
    D_carbon_out_analysis_detailDAO objex = new D_carbon_out_analysis_detailDAO();
    
%>
<%    
    int statusck = 0;
    int statusnum = 0;
    if (request.getParameter("status_a") != null) {
        if (uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_out_analysis_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
            statusck = -1;
        } else {
            statusck = 1;
            statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_out_analysis_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
            objdb.setLine_no(Integer.toString(statusnum + 1));
        }
    } else if (request.getParameter("status_u") != null) {
        statusck = 2;
        objdb.setLine_no(request.getParameter("line_no"));
        
    } else if (request.getParameter("status_d") != null) {
        statusck = Integer.parseInt(request.getParameter("status_d"));
        objdb.setDoc_id(request.getParameter("doc_id"));
    } else {
        statusck = -1;
    }
    if (statusck == 1 || statusck == 2) {
        objdb.setDoc_id(request.getParameter("doc_id"));
        
        objdb.setC_type1((request.getParameter("c_type1")).trim().equals("")?"":en.EncodeTexttoTIS(request.getParameter("c_type1")).trim());
        objdb.setBu1((request.getParameter("bu1")).trim().equals("")?"0":en.EncodeTexttoTIS(request.getParameter("bu1")).trim());
        objdb.setAvg1((request.getParameter("avg1")).trim().equals("")?"0":en.EncodeTexttoTIS(request.getParameter("avg1")).trim());

        objdb.setC_type2((request.getParameter("c_type2")).trim().equals("")?"":en.EncodeTexttoTIS(request.getParameter("c_type2")).trim());
        objdb.setBu2((request.getParameter("bu2")).trim().equals("")?"0":en.EncodeTexttoTIS(request.getParameter("bu2")).trim());
        objdb.setAvg2((request.getParameter("avg2")).trim().equals("")?"0":en.EncodeTexttoTIS(request.getParameter("avg2")).trim());

        objdb.setC_type3((request.getParameter("c_type3")).trim().equals("")?"":en.EncodeTexttoTIS(request.getParameter("c_type3")).trim());
        objdb.setBu3((request.getParameter("bu3")).trim().equals("")?"0":en.EncodeTexttoTIS(request.getParameter("bu3")).trim());
        objdb.setAvg3((request.getParameter("avg3")).trim().equals("")?"0":en.EncodeTexttoTIS(request.getParameter("avg3")).trim());
                                   
        /*
        objdb.setC_type1(request.getParameter("c_type1"));
        objdb.setBu1(request.getParameter("bu1"));
        objdb.setAvg1(request.getParameter("avg1"));        
        objdb.setC_type2(request.getParameter("c_type2"));
        objdb.setBu2(request.getParameter("bu2"));
        objdb.setAvg2(request.getParameter("avg2"));
        objdb.setC_type3(request.getParameter("c_type3"));
        objdb.setBu3(request.getParameter("bu3"));
        objdb.setAvg3(request.getParameter("avg3"));        
        */ 
    }
    
    objdb.setDate(new Timestamp(new java.util.Date().getTime()));
    objdb.setBy(((UserBean) session.getAttribute("user")).getUsername());
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
                objex.Delete_all_line_no(objdb, "d_carbon_out_analysis_detail");
            } else {
                objex.Delete_line_no(request.getParameter("ckbox"), objdb, "d_carbon_out_analysis_detail");
            }
            break;
        default:
            out.print("No Statment");
    }
%>
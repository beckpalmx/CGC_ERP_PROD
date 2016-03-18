
<%@page import="com.cgc.Util.Runer_Doc_id"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_out_analysis_header"%>
<%@page import="com.cgc.DB.D_carbon_out_analysis_headerDAO"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_out_analysis_detail"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>

<%!    ThaiUtil en = new ThaiUtil();
    DataBeanD_carbon_out_analysis_header objdb = new DataBeanD_carbon_out_analysis_header();
    D_carbon_out_analysis_headerDAO objex = new D_carbon_out_analysis_headerDAO();
    UtiDatabase uti = new UtiDatabase();
    ArrayList<DataBeanD_carbon_out_analysis_detail> objDetail;
    String param, method, spec, add_desc;
    int maxline = 0;
%>
<%
    objDetail = new ArrayList<DataBeanD_carbon_out_analysis_detail>();

    int statusck = 0;
    int statusnum = 0;
    if (request.getParameter("status_d") == null) {
        statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_out_analysis_header where doc_id = '" + request.getParameter("doc_id") + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
        if (statusnum == 0) {
            if (uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_out_analysis_header where doc_id = '" + request.getParameter("doc_id") + "' and delete_flag = 'N' and complete_flag = 'Y'") == 1) {
                statusck = -1;
            } else {
                statusck = 1;
            }
        } else if (statusnum == 1) {
            statusck = 2;
        } else {
            statusck = -1;
        }
    } else {
        statusck = Integer.parseInt(request.getParameter("status_d"));
    }
    if (statusck == 1 || statusck == 2) {
        objdb.setDoc_id(request.getParameter("doc_id"));
        objdb.setDoc_date(request.getParameter("doc_date"));
        objdb.setC_type(request.getParameter("c_type"));        
        objdb.setTdate1(request.getParameter("tdate1"));
        objdb.setTname1(request.getParameter("tname1"));
        objdb.setTtime1(request.getParameter("ttime1"));
        objdb.setTdate2(request.getParameter("tdate2"));
        objdb.setTname2(request.getParameter("tname2"));
        objdb.setTtime2(request.getParameter("ttime2"));
        objdb.setTdate3(request.getParameter("tdate3"));
        objdb.setTname3(request.getParameter("tname3"));
        objdb.setTtime3(request.getParameter("ttime3"));        
        objdb.setReporter_id(request.getParameter("reporter_id"));
        objdb.setApprove_id(request.getParameter("approve_id"));
        //objdb.setApprove_status(request.getParameter("approve_status"));
        objdb.setApprove_status((request.getParameter("approve_status")).trim().equals("")?"N":en.EncodeTexttoTIS(request.getParameter("approve_status")).trim()); 
        System.out.println("Approve Status : "+request.getParameter("approve_status"));
        objdb.setDate(new Timestamp(new java.util.Date().getTime()));
        objdb.setBy(request.getParameter("username"));
        maxline = Integer.parseInt(request.getParameter("maxline"));
        System.out.println("maxline = " + maxline);
        if (maxline != 0) {
            for (int count = 1; count <= maxline; count++) {
                
                System.out.println("BU1 = " + request.getParameter("bu1_"+count) + " | AVG1 = " + request.getParameter("avg1_"+count));
                        
                DataBeanD_carbon_out_analysis_detail bean = new DataBeanD_carbon_out_analysis_detail();
                bean.setLine_no(Integer.toString(count));
                bean.setC_type1((request.getParameter("c_type1_"+count)).trim().equals("")?"":en.EncodeTexttoTIS(request.getParameter("c_type1_"+count)).trim());
                bean.setBu1((request.getParameter("bu1_"+count)).trim().equals("")?"0":en.EncodeTexttoTIS(request.getParameter("bu1_"+count)).trim());
                bean.setAvg1((request.getParameter("avg1_"+count)).trim().equals("")?"0":en.EncodeTexttoTIS(request.getParameter("avg1_"+count)).trim());
                //bean.setAvg1(en.EncodeTexttoTIS(request.getParameter("avg1_"+count)));
                bean.setC_type2((request.getParameter("c_type2_"+count)).trim().equals("")?"":(request.getParameter("c_type2_"+count)).trim());
                bean.setBu2((request.getParameter("bu2_"+count)).trim().equals("")?"0":(request.getParameter("bu2_"+count)).trim());
                bean.setAvg2((request.getParameter("avg2_"+count)).trim().equals("")?"0":en.EncodeTexttoTIS(request.getParameter("avg2_"+count)).trim());
                //bean.setAvg2(request.getParameter("avg2_"+count));
                bean.setC_type3((request.getParameter("c_type3_"+count)).trim().equals("")?"":(request.getParameter("c_type3_"+count)).trim());
                bean.setBu3((request.getParameter("bu3_"+count)).trim().equals("")?"0":(request.getParameter("bu3_"+count)).trim());
                bean.setAvg3((request.getParameter("avg3_"+count)).trim().equals("")?"0":en.EncodeTexttoTIS(request.getParameter("avg3_"+count)).trim());
                //bean.setAvg3(request.getParameter("avg3_"+count));                
                objDetail.add(bean);
            }
        }

    }else{
        objdb.setDoc_id(en.EncodeTexttoTIS(request.getParameter("doc_id").trim()));
        objdb.setDate(new Timestamp(new java.util.Date().getTime()));
        objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));
    }

    switch (statusck) {
        case -1:
            out.print("ไม่สามารถบันทึกข้อมูลนี้ได้เนื่องจากมีเลขที่เอกสารที่สมบูรณ์แล้ว");
            break;
        case 1:
            objdb.setDoc_id(new Runer_Doc_id().Run_id_date("d_carbon_out_analysis_header", objdb.getDoc_date()));
            if (objex.insert(objdb, objDetail) != 0) {
                out.print("บันทึกสำเร็จ");
                objDetail.clear();
            }
            break;
        case 2:
            if (request.getParameter("confirm") != null && request.getParameter("confirm").equals("true")) {
                objex.update(objdb);
                out.print("แก้ไขสำเร็จ");
                objDetail.clear();
            } else {
                out.print("edit");

            }
            break;
        case 3:
            objex.updel(objdb);
            out.print("ลบข้อมูลสำเร็จ");
            break;
        default:
            out.print("No Statment");
            break;
    }
%>
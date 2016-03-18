
<%@page import="com.cgc.Util.Runer_Doc_id"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_friction_burn"%>
<%@page import="com.cgc.DB.D_friction_burn_DAO"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>

<%!    
    ThaiUtil en = new ThaiUtil();
    DataBeanD_carbon_friction_burn objdb = new DataBeanD_carbon_friction_burn();
    D_friction_burn_DAO objex = new D_friction_burn_DAO();
    UtiDatabase uti = new UtiDatabase();
    Timestamp ts;
%>
<%   
    int statusck = 0;
    int statusnum = 0;
    
    System.out.println("Doc Date : " + request.getParameter("doc_date"));
    
    if (request.getParameter("status_d") == null) {
        statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_friction_burn_detail where doc_id = '" + request.getParameter("doc_id") + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
        if (statusnum == 0) {
            if (uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_friction_burn_detail where doc_id = '" + request.getParameter("doc_id") + "' and delete_flag = 'N' and complete_flag = 'Y'") == 1) {
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
    
    System.out.println("Location : " + request.getParameter("location_id"));
    
    if (statusck == 1 || statusck == 2) {
        System.out.println("weight_carbon_in : " + request.getParameter("weight_carbon_in"));     
        System.out.println("complete_flag : " + request.getParameter("complete_flag"));                    
               
        objdb.setComplete_flag(request.getParameter("complete_flag"));   
        
        objdb.setDoc_id(request.getParameter("doc_id"));
        objdb.setDoc_date(request.getParameter("doc_date"));
        System.out.println("doc_date : " + request.getParameter("doc_date"));
        objdb.setProduct_id((request.getParameter("product_id")).trim().equals("") ? "-" : request.getParameter("product_id"));
        objdb.setWh_id((request.getParameter("wh_id")).trim().equals("") ? "-" : request.getParameter("wh_id"));
        objdb.setLocation_id((request.getParameter("location_id")).trim().equals("") ? "-" : request.getParameter("location_id"));
        System.out.println("0 : " + request.getParameter("location_id"));        
        objdb.setWeight_carbon_in((request.getParameter("weight_carbon_in")).equals("") ? "0" : request.getParameter("weight_carbon_in"));   
        System.out.println("1 : " + request.getParameter("weight_carbon_in"));
        objdb.setWeight_carbon_friction((request.getParameter("weight_carbon_friction")).equals("") ? "0" : request.getParameter("weight_carbon_friction"));        
        System.out.println("2 : " + request.getParameter("weight_carbon_friction"));
    
        objdb.setWeight_carbon_dust((request.getParameter("weight_carbon_dust")).equals("") ? "0" : request.getParameter("weight_carbon_dust"));
        System.out.println("3 : " + request.getParameter("weight_carbon_dust"));        

        objdb.setWeight_carbon_iron((request.getParameter("weight_carbon_iron")).equals("") ? "0" : request.getParameter("weight_carbon_iron"));
        System.out.println("4 : " + request.getParameter("weight_carbon_iron"));        
        objdb.setWeight_carbon_total((request.getParameter("weight_carbon_total")).equals("") ? "0" : request.getParameter("weight_carbon_total"));
        System.out.println("5 : " + request.getParameter("weight_carbon_total"));        
        objdb.setWeight_carbon_bigbag((request.getParameter("weight_carbon_bigbag")).equals("") ? "0" : request.getParameter("weight_carbon_bigbag"));        
        System.out.println("6 : " + request.getParameter("weight_carbon_bigbag"));        
        objdb.setWeight_carbon_burn_in((request.getParameter("weight_carbon_burn_in")).equals("") ? "0" : request.getParameter("weight_carbon_burn_in"));        
        System.out.println("7 : " + request.getParameter("weight_carbon_burn_in"));        
        objdb.setWeight_carbon_real_lost((request.getParameter("weight_carbon_real_lost")).equals("") ? "0" : request.getParameter("weight_carbon_real_lost"));
        System.out.println("8 : " + request.getParameter("weight_carbon_real_lost"));
        objdb.setPercent_carbon_real_lost((request.getParameter("percent_carbon_real_lost")).equals("") ? "0" : request.getParameter("percent_carbon_real_lost"));
        System.out.println("9 : " + request.getParameter("percent_carbon_real_lost"));
        objdb.setWeight_carbon_lost((request.getParameter("weight_carbon_lost")).equals("") ? "0" : request.getParameter("weight_carbon_lost"));
        System.out.println("10 : " + request.getParameter("weight_carbon_lost"));
        objdb.setPercent_carbon_lost((request.getParameter("percent_carbon_lost")).equals("") ? "0" : request.getParameter("percent_carbon_lost"));
        System.out.println("11 : " + request.getParameter("percent_carbon_lost"));
        objdb.setPercent_moisture((request.getParameter("percent_moisture")).equals("") ? "0" : request.getParameter("percent_moisture"));                                                          
        System.out.println("Percent_moisture : " + request.getParameter("percent_moisture"));        


        objdb.setWeight_carbon_burn_in_2((request.getParameter("weight_carbon_burn_in_2")).equals("") ? "0" : request.getParameter("weight_carbon_burn_in_2"));                
        objdb.setWeight_carbon_burn_in_3((request.getParameter("weight_carbon_burn_in_3")).equals("") ? "0" : request.getParameter("weight_carbon_burn_in_3"));                
        objdb.setWeight_carbon_burn_in_4((request.getParameter("weight_carbon_burn_in_4")).equals("") ? "0" : request.getParameter("weight_carbon_burn_in_4"));                
        objdb.setWeight_carbon_burn_in_5((request.getParameter("weight_carbon_burn_in_5")).equals("") ? "0" : request.getParameter("weight_carbon_burn_in_5"));                
        objdb.setWeight_carbon_burn_in_6((request.getParameter("weight_carbon_burn_in_6")).equals("") ? "0" : request.getParameter("weight_carbon_burn_in_6"));                        
        objdb.setWeight_carbon_burn_in_7((request.getParameter("weight_carbon_burn_in_7")).equals("") ? "0" : request.getParameter("weight_carbon_burn_in_7"));                
        objdb.setWeight_carbon_burn_in_8((request.getParameter("weight_carbon_burn_in_8")).equals("") ? "0" : request.getParameter("weight_carbon_burn_in_8"));                
        objdb.setWeight_carbon_burn_in_9((request.getParameter("weight_carbon_burn_in_9")).equals("") ? "0" : request.getParameter("weight_carbon_burn_in_9"));                
        objdb.setWeight_carbon_burn_in_10((request.getParameter("weight_carbon_burn_in_10")).equals("") ? "0" : request.getParameter("weight_carbon_burn_in_10"));                        
        
        objdb.setWeight_carbon_burn_in_total((request.getParameter("weight_carbon_burn_in_total")).equals("") ? "0" : request.getParameter("weight_carbon_burn_in_total"));                        
        
        objdb.setBurn_no((request.getParameter("burn_no")).trim().equals("") ? "-" : request.getParameter("burn_no"));
        objdb.setChannel((request.getParameter("channel")).trim().equals("") ? "-" : request.getParameter("channel"));        
        objdb.setBurn_no_2((request.getParameter("burn_no_2")).trim().equals("") ? "-" : request.getParameter("burn_no_2"));
        objdb.setChannel_2((request.getParameter("channel_2")).trim().equals("") ? "-" : request.getParameter("channel_2"));
        objdb.setBurn_no_3((request.getParameter("burn_no_3")).trim().equals("") ? "-" : request.getParameter("burn_no_3"));
        objdb.setChannel_3((request.getParameter("channel_3")).trim().equals("") ? "-" : request.getParameter("channel_3"));
        objdb.setBurn_no_4((request.getParameter("burn_no_4")).trim().equals("") ? "-" : request.getParameter("burn_no_4"));
        objdb.setChannel_4((request.getParameter("channel_4")).trim().equals("") ? "-" : request.getParameter("channel_4"));
        objdb.setBurn_no_5((request.getParameter("burn_no_5")).trim().equals("") ? "-" : request.getParameter("burn_no_5"));
        objdb.setChannel_5((request.getParameter("channel_5")).trim().equals("") ? "-" : request.getParameter("channel_5")); 
        objdb.setBurn_no_6((request.getParameter("burn_no_6")).trim().equals("") ? "-" : request.getParameter("burn_no_6"));
        objdb.setChannel_6((request.getParameter("channel_6")).trim().equals("") ? "-" : request.getParameter("channel_6")); 
        objdb.setBurn_no_7((request.getParameter("burn_no_7")).trim().equals("") ? "-" : request.getParameter("burn_no_7"));
        objdb.setChannel_7((request.getParameter("channel_7")).trim().equals("") ? "-" : request.getParameter("channel_7")); 
        objdb.setBurn_no_8((request.getParameter("burn_no_8")).trim().equals("") ? "-" : request.getParameter("burn_no_8"));
        objdb.setChannel_8((request.getParameter("channel_8")).trim().equals("") ? "-" : request.getParameter("channel_8")); 
        objdb.setBurn_no_9((request.getParameter("burn_no_9")).trim().equals("") ? "-" : request.getParameter("burn_no_9"));
        objdb.setChannel_9((request.getParameter("channel_9")).trim().equals("") ? "-" : request.getParameter("channel_9")); 
        objdb.setBurn_no_10((request.getParameter("burn_no_10")).trim().equals("") ? "-" : request.getParameter("burn_no_10"));
        objdb.setChannel_10((request.getParameter("channel_10")).trim().equals("") ? "-" : request.getParameter("channel_10"));         
        
        objdb.setBurn_date_1(request.getParameter("burn_date_1"));
        objdb.setBurn_date_2(request.getParameter("burn_date_2"));
        objdb.setBurn_date_3(request.getParameter("burn_date_3"));
        objdb.setBurn_date_4(request.getParameter("burn_date_4"));
        objdb.setBurn_date_5(request.getParameter("burn_date_5"));        
        objdb.setBurn_date_6(request.getParameter("burn_date_6"));      
        objdb.setBurn_date_7(request.getParameter("burn_date_7"));      
        objdb.setBurn_date_8(request.getParameter("burn_date_8"));      
        objdb.setBurn_date_9(request.getParameter("burn_date_9"));              
        objdb.setBurn_date_10(request.getParameter("burn_date_10"));              
        
        objdb.setRawmat_emp_id((request.getParameter("rawmat_emp_id")).trim().equals("") ? "-" : request.getParameter("rawmat_emp_id"));        
        objdb.setProduct_emp_id((request.getParameter("product_emp_id")).trim().equals("") ? "-" : request.getParameter("product_emp_id"));                        
        objdb.setRemark(request.getParameter("remark") == null ? "" : en.EncodeTexttoTIS(request.getParameter("remark")));              
        objdb.setDate(new Timestamp(new java.util.Date().getTime()));
        objdb.setBy(request.getParameter("username"));
        
        System.out.println("User Name : " + request.getParameter("username"));
        
    } else {
        objdb.setDoc_id(request.getParameter("doc_id"));
        objdb.setDate(new Timestamp(new java.util.Date().getTime()));
        objdb.setBy(request.getParameter("username"));
    }

    switch (statusck) {
        case -1:
            out.print("ไม่สามารถบันทึกข้อมูลนี้ได้เนื่องจากมีเลขที่เอกสารที่สมบูรณ์แล้ว");
            break;
        case 1:
            objdb.setDoc_id(new Runer_Doc_id().Run_id_date("d_carbon_friction_burn_detail", objdb.getDoc_date()));
            if (objex.insert(objdb) != 0) {
                out.print("บันทึกสำเร็จ");
            }
            break;
        case 2:
            if (request.getParameter("confirm") != null && request.getParameter("confirm").equals("true")) {
                objex.update(objdb);
                out.print("แก้ไขสำเร็จ");
            } else {
                out.print("edit");

            }
            break;
        case 3:
            objex.UpDel(objdb);
            out.print("ลบข้อมูลสำเร็จ");
            break;
        default:
            out.print("No Statment");
            break;
    }
%>

<%@page import="com.cgc.Util.Runer_Doc_id"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.bean.DataBeanD_FUEL_Receive"%>
<%@page import="com.cgc.DB.D_fuel_receiveDAO"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>

<%!    ThaiUtil en = new ThaiUtil();
    DataBeanD_FUEL_Receive objdb = new DataBeanD_FUEL_Receive();
    D_fuel_receiveDAO objex = new D_fuel_receiveDAO();
    UtiDatabase uti = new UtiDatabase();
    Timestamp ts;
%>
<%
    int statusck = 0;
    int statusnum = 0;
    if (request.getParameter("status_d") == null) {
        statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_fuel_receive where doc_id = '" + request.getParameter("doc_id") + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
        if (statusnum == 0) {
            if (uti.numRowdatabase("Select Count(doc_id) As num from  d_fuel_receive where doc_id = '" + request.getParameter("doc_id") + "' and delete_flag = 'N' and complete_flag = 'Y'") == 1) {
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
        //objdb.setComplete_flag(request.getParameter("complete_flag"));
        objdb.setComplete_flag(request.getParameter("complete_flag"));   
        
        objdb.setDoc_id(request.getParameter("doc_id"));
        objdb.setDoc_date(request.getParameter("doc_date"));     
        //objdb.setSupplier_id(request.getParameter("supplier_id"));  
        objdb.setSupplier_id((request.getParameter("supplier_id")).trim().equals("")?"-":en.EncodeTexttoTIS(request.getParameter("supplier_id")).trim());
        //objdb.setCar_no(en.EncodeTexttoTIS(request.getParameter("car_no")));
        objdb.setCar_no((request.getParameter("car_no")).trim().equals("")?"-":en.EncodeTexttoTIS(request.getParameter("car_no")).trim());
        //objdb.setDriver_name(en.EncodeTexttoTIS(request.getParameter("driver_name")));
        objdb.setDriver_name((request.getParameter("driver_name")).trim().equals("")?"-":en.EncodeTexttoTIS(request.getParameter("driver_name")).trim());
        objdb.setCar_date_in(request.getParameter("car_date_in"));  
        objdb.setCar_time_in(request.getParameter("car_time_in"));  
        objdb.setCar_date_out(request.getParameter("car_date_out"));  
        objdb.setCar_time_out(request.getParameter("car_time_out"));  
        objdb.setProduct_id(request.getParameter("product_id")); 
        objdb.setWh_in(request.getParameter("wh_in")); 
        objdb.setPosition_no(request.getParameter("position_no"));
        //objdb.setScale_no(request.getParameter("scale_no"));        
        objdb.setScale_no((request.getParameter("scale_no")).trim().equals("")?"-":en.EncodeTexttoTIS(request.getParameter("scale_no")).trim());                            
        //objdb.setCar_weight_in(request.getParameter("car_weight_in"));  
        objdb.setCar_weight_in((request.getParameter("car_weight_in")).trim().equals("")?"0":en.EncodeTexttoTIS(request.getParameter("car_weight_in")).trim());                            
        //objdb.setCar_weight_out(request.getParameter("car_weight_out"));
        objdb.setCar_weight_out((request.getParameter("car_weight_out")).trim().equals("")?"0":en.EncodeTexttoTIS(request.getParameter("car_weight_out")).trim());             
        //objdb.setTotal_weight(request.getParameter("total_weight"));
        objdb.setTotal_weight((request.getParameter("total_weight")).trim().equals("")?"0":en.EncodeTexttoTIS(request.getParameter("total_weight")).trim());             
        //objdb.setReporter(request.getParameter("reporter_id"));
        objdb.setReporter((request.getParameter("reporter_id")).trim().equals("")?"-":en.EncodeTexttoTIS(request.getParameter("reporter_id")).trim());             
        //objdb.setChecker1(request.getParameter("checker1"));
        objdb.setChecker1((request.getParameter("checker1")).trim().equals("")?"-":en.EncodeTexttoTIS(request.getParameter("checker1")).trim());             
        //objdb.setPrice_unit(request.getParameter("price_unit"));
        objdb.setPrice_unit((request.getParameter("price_unit")).trim().equals("")?"0":en.EncodeTexttoTIS(request.getParameter("price_unit")).trim());             
        //objdb.setTotal_price(request.getParameter("total_price"));
        objdb.setTotal_price((request.getParameter("total_price")).trim().equals("")?"0":en.EncodeTexttoTIS(request.getParameter("total_price")).trim());             
        //objdb.setMoisture(request.getParameter("moisture"));
        objdb.setMoisture((request.getParameter("moisture")).trim().equals("")?"0":en.EncodeTexttoTIS(request.getParameter("moisture")).trim());             
        //objdb.setMoisture_std(request.getParameter("moisture_std"));
        objdb.setMoisture_std((request.getParameter("moisture_std")).trim().equals("")?"0":en.EncodeTexttoTIS(request.getParameter("moisture_std")).trim());             
        //objdb.setDeduct_weight_moisture(request.getParameter("deduct_weight_moisture"));  
        objdb.setDeduct_weight_moisture((request.getParameter("deduct_weight_moisture")).trim().equals("")?"0":en.EncodeTexttoTIS(request.getParameter("deduct_weight_moisture")).trim());             
        //objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
        objdb.setRemark((request.getParameter("remark")).trim().equals("")?"-":en.EncodeTexttoTIS(request.getParameter("remark")).trim());
        //objdb.setNet_weight_receive(request.getParameter("net_weight_receive"));
        objdb.setNet_weight_receive((request.getParameter("net_weight_receive")).trim().equals("")?"0":en.EncodeTexttoTIS(request.getParameter("net_weight_receive")).trim());
        //objdb.setNet_weight_payment(request.getParameter("net_weight_payment"));
        objdb.setNet_weight_payment((request.getParameter("net_weight_payment")).trim().equals("")?"-":en.EncodeTexttoTIS(request.getParameter("net_weight_payment")).trim());
        //objdb.setStatus(request.getParameter("status"));
        objdb.setStatus((request.getParameter("status")).trim().equals("")?"N":en.EncodeTexttoTIS(request.getParameter("status")).trim());
        objdb.setDate(new Timestamp(new java.util.Date().getTime()));
        objdb.setBy(request.getParameter("username"));
    } else {
        objdb.setDoc_id(en.EncodeTexttoTIS(request.getParameter("doc_id").trim()));
        objdb.setDate(new Timestamp(new java.util.Date().getTime()));
        objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));
    }

    switch (statusck) {
        case -1:
            out.print("ไม่สามารถบันทึกข้อมูลนี้ได้เนื่องจากมีเลขที่เอกสารที่สมบูรณ์แล้ว");
            break;
        case 1:
            objdb.setDoc_id(new Runer_Doc_id().Run_id_date("d_fuel_receive", objdb.getDoc_date()));
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
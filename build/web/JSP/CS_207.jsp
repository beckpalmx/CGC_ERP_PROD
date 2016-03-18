<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="com.cgc.DB.MLocationDAO"%>
<%@page import="com.cgc.bean.DataBeanMLocation"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="java.sql.*"%>

<%! 

    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    //Timestamp ts;
    DataBeanMLocation objdb = new DataBeanMLocation();
    MLocationDAO objex = new MLocationDAO();

%>

<%
    int statusck = 0;
    int statusnum = 0;
    if (request.getParameter("status_d") == null) {
        statusnum = uti.numRowdatabase("Select Count(location_id) As num from  mlocation where location_id = '" + en.EncodeTexttoTIS(request.getParameter("location_id").trim()) + "' and delete_flag <> 'Y'");
        if (statusnum == 0) {
            statusck = 1;
        } else if (statusnum == 1) {
            statusck = 2;
        } else {
            statusck = -1;
        }
    } else {
        statusck = Integer.parseInt(request.getParameter("status_d"));
    }    
    
    objdb.setRunno(request.getParameter("runno")==null||request.getParameter("runno").equals("")?0:Integer.parseInt(request.getParameter("runno")));
    
    objdb.setLocation_id(request.getParameter("location_id")==null||request.getParameter("location_id").equals("")?"":en.EncodeTexttoTIS(request.getParameter("location_id")));
    objdb.setName_t(request.getParameter("name_t")==null||request.getParameter("name_t").equals("")?"":en.EncodeTexttoTIS(request.getParameter("name_t")));
    objdb.setLocation_id_ref(request.getParameter("location_id_ref")==null||request.getParameter("location_id_ref").equals("")?"":en.EncodeTexttoTIS(request.getParameter("location_id_ref")));
    objdb.setPrice_per_unit(request.getParameter("price_per_unit")==null||request.getParameter("price_per_unit").equals("")?"":en.EncodeTexttoTIS(request.getParameter("price_per_unit")));
    objdb.setRemark(request.getParameter("remark")==null||request.getParameter("remark").equals("")?"":en.EncodeTexttoTIS(request.getParameter("remark")));
    
//    ts = new Timestamp(new java.util.Date().getTime());
//    objdb.setDate(ts);
    
    System.out.println("price_per_unit = " + request.getParameter("price_per_unit"));
    System.out.println("location_id_ref = " + request.getParameter("location_id_ref"));
    
    
    objdb.setDate(new Timestamp(new java.util.Date().getTime()));
    objdb.setBy(request.getParameter("username"));

    switch (statusck) {
        case 1:
            if (objex.insert(objdb) != -1) {
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
            if (objex.updateDel(objdb) != -1) {
                out.print("ลบข้อมูลสำเร็จ");
            }
            break;
        default:
            out.print("No Statment");
    }
%>
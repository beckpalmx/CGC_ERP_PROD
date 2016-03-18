
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.DB.D_packing_product_headerDAO"%>
<%@page import="com.cgc.bean.DataBeanD_packing_product_header"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.Util.Display_Document_Status"%>
<%@page import="com.cgc.bean.DataBean_Display_Document_Status"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.Util.Runer_Doc_id"%>
<%@ page language="java" contentType="text/html; charset=TIS-620"
         pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    ThaiUtil en = new ThaiUtil();
    DataBeanD_packing_product_header objdb = new DataBeanD_packing_product_header();
    D_packing_product_headerDAO objex = new D_packing_product_headerDAO();
    DataBean_Display_Document_Status obj_record = new DataBean_Display_Document_Status();
    Display_Document_Status r_c = new Display_Document_Status();

    Runer_Doc_id objrun = new Runer_Doc_id();
    UtiDatabase uti = new UtiDatabase();
    Timestamp ts;
    String runer_id, doc_id_last;
%>
<%

    int statusck = 0;
    int statusnum = 0;
    runer_id = request.getParameter("runer_id");
    //System.out.print("First runer_id = " + runer_id);
    if (runer_id != null) {
        if (runer_id.equals("1")) {
            statusck = 5;
            obj_record = r_c.Fn_Doc_ID_Last(obj_record, "select max(doc_id) as doc_id_last from d_packing_product_header where delete_flag = 'N'");
        } else {
            statusck = 4;
        }
    } else {
        if (request.getParameter("status_d") == null) {
            statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_packing_product_header where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
            if (statusnum == 0) {
                if (uti.numRowdatabase("Select Count(doc_id) As num from  d_packing_product_header where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") == 1) {
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
        objdb.setDoc_id(en.EncodeTexttoTIS(request.getParameter("doc_id").trim()));
        objdb.setDoc_date(request.getParameter("doc_date"));
        objdb.setWh_in(request.getParameter("wh_in"));
        objdb.setWh_out(request.getParameter("wh_out"));
        objdb.setJob_id(en.EncodeTexttoTIS(request.getParameter("job_id")));
        objdb.setEmp_id(en.EncodeTexttoTIS(request.getParameter("emp_id")));
        objdb.setTime_from(request.getParameter("time_from"));
        objdb.setTime_to(request.getParameter("time_to"));
        objdb.setShift(request.getParameter("shift"));
        objdb.setLost_weight(request.getParameter("lost_weight"));
        objdb.setTotal_bag_withdraw(request.getParameter("total_bag_withdraw"));
        objdb.setTotal_weight_withdraw(request.getParameter("total_weight_withdraw"));
        objdb.setTotal_bag(request.getParameter("total_bag"));
        objdb.setTotal_weight(request.getParameter("total_weight"));
        objdb.setSum_pack_month(request.getParameter("sum_pack_month"));
        objdb.setSum_pack_year(request.getParameter("sum_pack_year"));
        ts = new Timestamp(new java.util.Date().getTime());
        objdb.setDate(ts);
        objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));
        objdb.setRunner_id(request.getParameter("runner_id"));
        if (request.getParameter("complete_flag") != null) {
            objdb.setComplete_flag(request.getParameter("complete_flag"));
        }
    }
    switch (statusck) {
        case -1:
            out.print("ไม่สามารถบันทึกข้อมูลนี้ได้เนื่องจากมีเลขที่เอกสารที่สมบูรณ์แล้ว");
            break;
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
            objex.UpDel(objdb);
            out.print("ลบข้อมูลสำเร็จ");
            break;
        case 4:
            System.out.println("runer_id = " + runer_id);
            out.print(objrun.Run_Packing_id(runer_id, "d_packing_product_header", "d_packing_product_detail"));
            break;
        case 5:
            out.print(obj_record.getDoc_id_last());
            System.out.println("doc_id_last = " + obj_record.getDoc_id_last());
            break;
        default:
            out.print("No Statment");
    }
%>
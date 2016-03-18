
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.bean.DataBeanD_job_order_detail"%>
<%@page import="com.cgc.DB.D_job_order_headerDAO"%>
<%@page import="com.cgc.DB.D_job_order_detailDAO"%>
<%@page import="com.cgc.bean.DataBeanD_job_order_header"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%@page import="java.sql.*"%>
<%!    ThaiUtil en = new ThaiUtil();
    DataBeanD_job_order_header objdb = new DataBeanD_job_order_header();
    DataBeanD_job_order_detail objJobDetail = new DataBeanD_job_order_detail();
    D_job_order_headerDAO objex = new D_job_order_headerDAO();
    UtiDatabase uti = new UtiDatabase();
    ArrayList<DataBeanD_job_order_detail> objDetail;
    Timestamp ts;
    String param, method, spec, add_desc;
%>
<%
    int i = 1;
    objDetail = new ArrayList<DataBeanD_job_order_detail>();

    int statusck = 0;
    int statusnum = 0;
    if (request.getParameter("status_d") == null) {
        statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_job_order_header where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
        if (statusnum == 0) {
            if (uti.numRowdatabase("Select Count(doc_id) As num from  d_job_order_header where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") == 1) {
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
    objdb.setCompany_id(request.getParameter("cust_id"));
    objdb.setPo_no(request.getParameter("po_no"));
    objdb.setContain_date(request.getParameter("contain_date"));
    objdb.setIso_no(request.getParameter("iso_no"));
    objdb.setCountry_id(request.getParameter("country_id"));
    objdb.setLot_no(request.getParameter("lot_no"));
    objdb.setMark_sign(request.getParameter("mark_sign"));
    objdb.setBase_plate(request.getParameter("base_plate"));
    objdb.setWh_dep(request.getParameter("wh_dep"));
    objdb.setSale_confirm(request.getParameter("sale_confirm"));
    objdb.setQuality_confirm(request.getParameter("quality_confirm"));
    objdb.setProd_confirm(request.getParameter("prod_confirm"));
    objdb.setWh_confirm(request.getParameter("wh_confirm"));
    objdb.setStock_prod(request.getParameter("stock_prod"));
    System.out.println(request.getParameter("stock_prod"));
    System.out.println("----------Stock-----------");
    if (request.getParameter("base_plate_desc") != null) {
        objdb.setBase_plate_desc(en.EncodeTexttoTIS(request.getParameter("base_plate_desc")));
    }
    if (request.getParameter("base_plate_qty") != null) {
        objdb.setBase_plate_qty(en.EncodeTexttoTIS(request.getParameter("base_plate_qty")));
    }
    if (request.getParameter("mark_sign_desc") != null) {
        objdb.setMark_sign_desc(en.EncodeTexttoTIS(request.getParameter("mark_sign_desc")));
    }
    if (request.getParameter("approve") != null) {
        objdb.setApprove(request.getParameter("approve"));
    }
    if (request.getParameter("prod_dep") != null) {
        objdb.setProd_dep(request.getParameter("prod_dep"));
    }
    if (request.getParameter("quality_dep") != null) {
        objdb.setQuality_dep(request.getParameter("quality_dep"));
    }
    ts = new Timestamp(new java.util.Date().getTime());
    objdb.setDate(ts);
    objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));
    if (request.getParameter("remark") != null) {
        //JOptionPane.showConfirmDialog(null, request.getParameter("remark"));
        objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
    }
    while (i != 15) {

        param = "";
        method = "";
        spec = "";
        add_desc = "";
        DataBeanD_job_order_detail objJobDetail = new DataBeanD_job_order_detail();
        if (request.getParameter("param" + Integer.toString(i)) != null) {
            param = en.EncodeTexttoTIS(request.getParameter("param" + Integer.toString(i)));
            System.out.println("param : " + param);
        }
        if (request.getParameter("method" + Integer.toString(i)) != null) {
            method = en.EncodeTexttoTIS(request.getParameter("method" + Integer.toString(i)));
            System.out.println("method : " + method);
        }
        if (request.getParameter("spec" + Integer.toString(i)) != null) {
            if (i == 1) {
                spec = en.EncodeTexttoTIS(request.getParameter("spec" + Integer.toString(i))).toLowerCase();
                System.out.println("Update xx Spec 1 = " + spec);
            } else {
                spec = en.EncodeTexttoTIS(request.getParameter("spec" + Integer.toString(i)));
                System.out.println("spec : " + spec);
            }
        }

        if (request.getParameter("add_desc" + Integer.toString(i)) != null) {
            add_desc = en.EncodeTexttoTIS(request.getParameter("add_desc" + Integer.toString(i)));
            System.out.println("add_desc : " + add_desc);
        }
        objJobDetail.setLine_no(Integer.toString(i));
        objJobDetail.setParam(param);
        objJobDetail.setMethod(method);
        objJobDetail.setSpec(spec);
        objJobDetail.setAdd_desc(add_desc);
        objDetail.add(objJobDetail);
        i++;

        System.out.println("XXX final spec : " + spec);
        //JOptionPane.showConfirmDialog(null, objDetail.get(y++).getParam());
    }
            // JOptionPane.showConfirmDialog(null, objDetail.size());
    //for(DataBeanD_job_order_detail objloop : objDetail){
    //JOptionPane.showConfirmDialog(null, objloop.getParam()+":"+objloop.getMethod()+":"+objloop.getSpec()+":"+objloop.getAdd_desc());
    //}
    switch (statusck) {
        case -1:
            out.print("ไม่สามารถบันทึกข้อมูลนี้ได้เนื่องจากมีเลขที่เอกสารที่สมบูรณ์แล้ว");
            break;
        case 1:
            if (objex.insert(objdb, objDetail) != -1) {
                out.print("บันทึกสำเร็จ");
            }
            break;
        case 2:
            //if (request.getParameter("confirm") != null && request.getParameter("confirm").equals("true")) {
            objex.update_confirm(objdb);
            out.print("แก้ไขสำเร็จ");
            /* }else{
             out.print("edit");
             }*/
            break;
        case 3:
            objex.UpDel(objdb);

            out.print("ลบข้อมูลสำเร็จ");

            break;
        default:
            out.print("No Statment");
    }
%>
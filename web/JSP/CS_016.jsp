<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.bean.DataBeanCus_Sup"%>
<%@page import="com.cgc.DB.mSupplierDAO"%>
<%@ page language="java" contentType="text/html; charset=TIS-620"
         pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    ThaiUtil en = new ThaiUtil();
    DataBeanCus_Sup objdb = new DataBeanCus_Sup();
    mSupplierDAO objex = new mSupplierDAO();
    UtiDatabase uti = new UtiDatabase();
    Timestamp ts;
    String address1 ; 
%>
<%

            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_d") == null) {
                statusnum = uti.numRowdatabase("Select Count(*) As num from  msupplier where supplier_id = '" + request.getParameter("supplier_id").trim() + "' and delete_flag <> 'Y'");
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
            objdb.setSupplier_id(request.getParameter("supplier_id"));
            objdb.setTambol_code(request.getParameter("tambol_code"));
            objdb.setAmp_code(request.getParameter("amp_code"));
            objdb.setProv_code(request.getParameter("prov_code"));
            objdb.setZipcode(request.getParameter("zipcode"));
            objdb.setTel(request.getParameter("tel"));
            objdb.setFax(request.getParameter("fax"));

            ts = new Timestamp(new java.util.Date().getTime());
            objdb.setDate(ts);
            if (request.getParameter("name_t") != null) {
                objdb.setName_t(en.EncodeTexttoTIS(request.getParameter("name_t")));
            }
            if (request.getParameter("address1_t") != null) {                
                address1 = request.getParameter("address1_t").replace("<br>"," ");
                objdb.setAddress1_t(en.EncodeTexttoTIS(address1));
            }
            
            System.out.println("Address : " + en.EncodeTexttoTIS(request.getParameter("address1_t")));
            System.out.println("Address : " + en.EncodeTexttoTIS(address1));
                       
            if (request.getParameter("contact_name") != null) {
                objdb.setContact_name(en.EncodeTexttoTIS(request.getParameter("contact_name")));
            }
            if (request.getParameter("remark") != null) {
                objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
            }
            if (request.getParameter("price_unit") != null) {
                objdb.setPrice_unit(en.EncodeTexttoTIS(request.getParameter("price_unit")));
            }
            if (request.getParameter("location_id2") != null) {
                objdb.setBranch_id(en.EncodeTexttoTIS(request.getParameter("location_id2")));
            }            
            switch (statusck) {
                case 1:
                    if (objex.insert(objdb) != -1) {
                        out.print("บันทึกสำเร็จ");
                    }
                    break;
                case 2:
                    if (request.getParameter("confirm") != null && request.getParameter("confirm").equals("true")) {
                        objex.Update(objdb);
                        out.print("แก้ไขสำเร็จ");
                    } else {
                        out.print("edit");
                    }
                    break;
                case 3:
                    if (objex.UpDel(objdb) != -1) {
                        //objex.UpDel_Real(objdb);
                        out.print("ลบข้อมูลสำเร็จ");
                    }
                    break;
                default:
                    out.print("No Statment");
            }
%>
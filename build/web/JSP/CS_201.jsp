<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.DB.Mproduction_placeDAO"%>
<%@page import="com.cgc.bean.DataBeanMproduction_place"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    Timestamp ts;
    DataBeanMproduction_place objdb = new DataBeanMproduction_place();
    Mproduction_placeDAO objex = new Mproduction_placeDAO();

%>
<%
            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_d") == null) {
                statusnum = uti.numRowdatabase("Select Count(prd_place) As num from  mproduction_place where prd_place = '" + en.EncodeTexttoTIS(request.getParameter("prd_place").trim()) + "' and delete_flag <> 'Y'");
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
            objdb.setPrd_place(en.EncodeTexttoTIS(request.getParameter("prd_place")));             
            if (request.getParameter("name_t") != null) {
                objdb.setName_t(en.EncodeTexttoTIS(request.getParameter("name_t")));
            }            
            if (request.getParameter("job_type_id") != null) {
                objdb.setJob_type_id(en.EncodeTexttoTIS(request.getParameter("job_type_id")));
            }                        
            if (request.getParameter("remark") != null) {
                objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
            }
            ts = new Timestamp(new java.util.Date().getTime());
            objdb.setDate(ts);
            objdb.setBy(request.getParameter("username"));
            
            System.out.println("1 : "+request.getParameter("prd_place"));
            System.out.println("2 : "+request.getParameter("job_type_id"));
            System.out.println("3 : "+request.getParameter("name_t"));

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
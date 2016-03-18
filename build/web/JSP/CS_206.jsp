<%@page import="com.cgc.DB.Mjob_type_detailDAO"%>
<%@page import="com.cgc.bean.DataBeanMjob_type_detail"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    Timestamp ts;
    DataBeanMjob_type_detail objdb = new DataBeanMjob_type_detail();
    Mjob_type_detailDAO objex = new Mjob_type_detailDAO();

%>
<%
            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_d") == null) {
                statusnum = uti.numRowdatabase("Select Count(job_type_id) As num from  mjob_type_detail where job_type_id = '" + en.EncodeTexttoTIS(request.getParameter("job_type_id").trim()) + "' and delete_flag <> 'Y'");
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
           
          
            objdb.setJob_type_id(request.getParameter("job_type_id")==null ? "" : en.EncodeTexttoTIS(request.getParameter("job_type_id")));            
            objdb.setJob_type_desc(request.getParameter("job_type_desc")==null ? "" : en.EncodeTexttoTIS(request.getParameter("job_type_desc")));
            
            if (request.getParameter("remark") != null) {
                objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
            }
            ts = new Timestamp(new java.util.Date().getTime());
            objdb.setDate(ts);
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
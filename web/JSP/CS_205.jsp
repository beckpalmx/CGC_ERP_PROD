<%@page import="com.cgc.DB.M_iodineDAO"%>
<%@page import="com.cgc.bean.DataBeanM_iodine"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    Timestamp ts;
    DataBeanM_iodine objdb = new DataBeanM_iodine();
    M_iodineDAO objex = new M_iodineDAO();

%>
<%
            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_d") == null) {
                statusnum = uti.numRowdatabase("Select Count(iod_code) As num from  m_iodine where iod_code = '" + en.EncodeTexttoTIS(request.getParameter("iod_code").trim()) + "' and delete_flag <> 'Y'");
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
            objdb.setIod_code(en.EncodeTexttoTIS(request.getParameter("iod_code")));
            objdb.setIod_range(en.EncodeTexttoTIS(request.getParameter("iod_range")));
            objdb.setIod_ctype(en.EncodeTexttoTIS(request.getParameter("iod_ctype")));
            objdb.setButane(en.EncodeTexttoTIS(request.getParameter("butane")));
            objdb.setCtc(en.EncodeTexttoTIS(request.getParameter("ctc")));
            objdb.setName_t(en.EncodeTexttoTIS(request.getParameter("name_t")));
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
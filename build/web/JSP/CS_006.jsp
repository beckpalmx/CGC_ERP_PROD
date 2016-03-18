
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.DB.Muser_AccountDAO"%>
<%@page import="com.cgc.bean.DataBeanMuser_Account"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import ="org.apache.commons.codec.binary.Base64"%>
<%@page import="java.sql.*"%>
<%!
    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    Timestamp ts;
    DataBeanMuser_Account objdb = new DataBeanMuser_Account();
    Muser_AccountDAO objex = new Muser_AccountDAO();

%>
<%
    int statusck = 0;
    int statusnum = 0;
    if (request.getParameter("status_d") == null) {
        statusnum = uti.numRowdatabase("Select Count(*) As num from  muser_account "
                + " where username like '" + en.EncodeTexttoTIS(request.getParameter("username").trim()) + "' and delete_flag <> 'Y'");
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
    objdb.setUser(en.EncodeTexttoTIS(request.getParameter("username")));

    //objdb.setPassword(en.EncodeTexttoTIS(request.getParameter("passwordnew_1")));
    byte[] pass_encode = Base64.encodeBase64(request.getParameter("passwordnew_1").getBytes());
    objdb.setPassword(new String(pass_encode));

    ts = new Timestamp(new java.util.Date().getTime());
    objdb.setDate(ts);

    switch (statusck) {
        case 1:
            if (objex.insert(objdb) != -1) {
                out.print("บันทึกสำเร็จ");
            }
            break;
        case 2:
            if (objex.update(objdb) != -1) {
                out.print("แก้ไขสำเร็จ");
            }
            break;
        case 3:
            if (objex.UpDel(objdb) != -1) {
                out.print("ลบข้อมูลสำเร็จ");
            }
            break;
        default:
            out.print("No Statment");
    }
%>
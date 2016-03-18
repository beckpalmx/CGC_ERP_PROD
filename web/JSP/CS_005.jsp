<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.DB.UserDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import ="org.apache.commons.codec.binary.Base64"%>
<%!
    UserDAO userDAO = new UserDAO();
    UserBean userBean, selectUserBean;
    Timestamp ts;
    String user, pass, emp_id, pri_id, rm, status;
    ThaiUtil tu;
%>
<%
    tu = new ThaiUtil();
    user = (String) request.getParameter("username");
    pass = (String) request.getParameter("password");
    rm = (String) request.getParameter("remark");
    emp_id = (String) request.getParameter("emp_id");
    pri_id = (String) request.getParameter("priviledge_id");
    status = (String) request.getParameter("status");
    if (status.equals("1")) {
        status = "N";
    } else {
        status = "Y";
    }
    userBean = new UserBean();
    userBean.setUsername(tu.EncodeTexttoTIS(user));

    //userBean.setPassword(tu.EncodeTexttoTIS(pass));
    byte[] pass_encode = Base64.encodeBase64(pass.getBytes());
    userBean.setPassword(new String(pass_encode));

    userBean.setEmp_id(tu.EncodeTexttoTIS(emp_id));
    userBean.setPriviledge_id(tu.EncodeTexttoTIS(pri_id));
    userBean.setRemark(tu.EncodeTexttoTIS(rm));
    ts = new Timestamp(new java.util.Date().getTime());
    userBean.setCreate_date(ts);
    userBean.setUse_status(status);

    if (request.getParameter("chkstatus") == null) {
        selectUserBean = userDAO.selectChk(userBean);
        if (selectUserBean != null && selectUserBean.getDelete_flag().equals("N")) {
            userBean.setUpdate_date(ts);
            userDAO.update(userBean);
            out.print("แก้ไขสำเร็จ");
        } else {
            if (userDAO.insert(userBean)) {
                out.print("บันทึกสำเร็จ");
            } else {
                out.print("บันทึกไม่สำเร็จ");
            }
        }
    } else {
        userDAO.updateDel(userBean);
        out.print("ลบข้อมูลสำเร็จ");
    }

%>
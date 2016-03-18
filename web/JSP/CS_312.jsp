<%@page import="com.cgc.bean.MessageBean"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.DB.MessageDAO"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!    MessageDAO MessageDAO = new MessageDAO();
    MessageBean messageBean, selectMessageBean;
    Timestamp ts;
    String message_id, message_detail, status,username;
    ThaiUtil tu;
%>
<%
    tu = new ThaiUtil();
    message_id = (String) request.getParameter("message_id");
    message_detail = (String) request.getParameter("message_detail");
    status = (String) request.getParameter("status");
    username = (String) request.getParameter("username");
    if (status.equals("1")) {
        status = "N";
    } else {
        status = "Y";
    }
    messageBean = new MessageBean();
    messageBean.setMessage_id(tu.EncodeTexttoTIS(message_id));
    messageBean.setMessage_detail(tu.EncodeTexttoTIS(message_detail));
    messageBean.setStatus(status);
    ts = new Timestamp(new java.util.Date().getTime());
    messageBean.setCreate_date(ts);
    messageBean.setCreate_by(username);

    //System.out.println(ts);
    //System.out.println(username);
    
    if (request.getParameter("chkstatus") == null) {
        selectMessageBean = MessageDAO.selectChk(messageBean);
        if (selectMessageBean != null && selectMessageBean.getDelete_flag().equals("N")) {
            messageBean.setUpdate_date(ts);
            messageBean.setUpdate_by(username);
            MessageDAO.update(messageBean);
            out.print("แก้ไขสำเร็จ");
        } else {
            if (MessageDAO.insert(messageBean)) {
                out.print("บันทึกสำเร็จ");
            } else {
                out.print("บันทึกไม่สำเร็จ");
            }
        }
    } else {
        messageBean.setDelete_date(ts);
        messageBean.setDelete_by(username);
        MessageDAO.updateDel(messageBean);
        out.print("ลบข้อมูลสำเร็จ");
    }

%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.bean.ScreenBean"%>
<%@page import="com.cgc.DB.ScreenDAO"%>  

<%
    ScreenDAO scDAO = new ScreenDAO();
    ScreenBean scBean, selectScBean;
    Timestamp ts;
    String name, id, rm, process_id, dept_id, iso_no, effective_date, qc, email_from, email_to, email_server, email_port;
    ThaiUtil tu;
%>
<%
    tu = new ThaiUtil();
    name = (String) request.getParameter("name_t_screen");
    id = (String) request.getParameter("screen_id");
    rm = (String) request.getParameter("remark_screen");
    process_id = (String) request.getParameter("process_id");
    dept_id = (String) request.getParameter("dept_id");
    iso_no = (String) request.getParameter("iso_no");
    effective_date = (String) request.getParameter("effective_date");
    qc = (String) request.getParameter("qc_check");

    email_from = (String) request.getParameter("email_from");
    email_to = (String) request.getParameter("email_to");
    email_server = (String) request.getParameter("email_server");
    email_port = (String) request.getParameter("email_port");
    scBean = new ScreenBean();
    scBean.setName_t(tu.EncodeTexttoTIS(name));
    scBean.setScreen_id(id);
    scBean.setRemark(tu.EncodeTexttoTIS(rm));
    ts = new Timestamp(new java.util.Date().getTime());
    scBean.setProcess_id(process_id);
    scBean.setDept_id(dept_id);
    scBean.setIso_no(iso_no);
    scBean.setEffective_date(effective_date);
    scBean.setQc_check(qc);
    scBean.setCreate_date(ts);

    scBean.setEmail_from(email_from);
    scBean.setEmail_to(email_to);
    scBean.setEmail_server(email_server);
    scBean.setEmail_port(email_port);

    if (request.getParameter("chkstatus") == null) {
        selectScBean = scDAO.selectData(id);
        if (selectScBean != null && selectScBean.getDelete_flag().equals("N")) {
            scBean.setUpdate_date(ts);
            scDAO.update(scBean);
            out.println("บันทึกสำเร็จ");            
        } else {
            if (scDAO.insert(scBean)) {
                out.println("บันทึกสำเร็จ");
            } else {
                out.println("แก้ไขข้อมูลผิดพลาด");
            }
        }
    } else {
        scDAO.updateDel(scBean);
        out.println("ลบข้อมูลสำเร็จ");
    }
%>
<%@page import="com.cgc.bean.PtypeBean"%>
<%@page import="com.cgc.DB.PTypeDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%!    PTypeDAO ptDAO = new PTypeDAO();
    PtypeBean ptBean, selectPgBean;
    Timestamp ts;
    String name, id, rm;
    ThaiUtil tu;
%>
<%
            tu = new ThaiUtil();
            name = (String) request.getParameter("name_t_ptype");
            id = (String) request.getParameter("ptype_id");
            rm = (String) request.getParameter("remark_ptype");
            ptBean = new PtypeBean();
            ptBean.setName_t(tu.EncodeTexttoTIS(name));
            ptBean.setPtype_id(id);
            ptBean.setRemark(tu.EncodeTexttoTIS(rm));
            ts = new Timestamp(new java.util.Date().getTime());
            ptBean.setCreate_date(ts);
            if (request.getParameter("chkstatus") == null) {
                selectPgBean = ptDAO.selectData(id);
                if (selectPgBean != null && selectPgBean.getDelete_flag().equals("N")) {
                    ptBean.setUpdate_date(ts);
                    if (request.getParameter("confirm") != null && request.getParameter("confirm").equals("true")) {
                        ptDAO.update(ptBean);
                        out.print("แก้ไขสำเร็จ");
                    } else {
                        out.print("edit");
                    }
                } else {
                    if (ptDAO.insert(ptBean)) {
                        out.print("บันทึกสำเร็จ");
                    } else {
                        out.print("บันทึกไม่สำเร็จ");
                    }
                }
            } else {
                ptDAO.updateDel(ptBean);
                out.print("ลบข้อมูลสำเร็จ");
            }
%>
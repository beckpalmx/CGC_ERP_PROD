<%@page import="com.cgc.bean.PgroupBean"%>
<%@page import="com.cgc.DB.PGroupDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%!    PGroupDAO pgDAO = new PGroupDAO();
    PgroupBean pgBean, selectPgBean;
    Timestamp ts;
    String name, id, rm;
    ThaiUtil tu;
%>
<%
            tu = new ThaiUtil();
            name = (String) request.getParameter("name_t_pgroup");
            id = (String) request.getParameter("pgroup_id");
            rm = (String) request.getParameter("remark_pgroup");
            pgBean = new PgroupBean();
            pgBean.setName_t(tu.EncodeTexttoTIS(name));
            pgBean.setPgroup_id(id);
            pgBean.setRemark(tu.EncodeTexttoTIS(rm));
            ts = new Timestamp(new java.util.Date().getTime());
            pgBean.setCreate_date(ts);
            if (request.getParameter("chkstatus") == null) {
                selectPgBean = pgDAO.selectData(id);
                if (selectPgBean != null && selectPgBean.getDelete_flag().equals("N")) {
                    pgBean.setUpdate_date(ts);
                    if (request.getParameter("confirm") != null && request.getParameter("confirm").equals("true")) {
                        pgDAO.update(pgBean);
                        out.print("แก้ไขสำเร็จ");
                    } else {
                        out.print("edit");
                    }
                } else {
                    if (pgDAO.insert(pgBean)) {
                        out.print("บันทึกสำเร็จ");
                    } else {
                        out.print("บันทึกไม่สำเร็จ");
                    }
                }
            } else {
                pgDAO.updateDel(pgBean);
                out.print("ลบข้อมูลสำเร็จ");
            }
%>
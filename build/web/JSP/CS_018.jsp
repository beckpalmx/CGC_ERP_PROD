<%@page import="com.cgc.bean.PcatBean"%>
<%@page import="com.cgc.DB.PCatDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%!    PCatDAO pcDAO = new PCatDAO();
    PcatBean pcBean, selectPgBean;
    Timestamp ts;
    String name, id, rm;
    ThaiUtil tu;
%>
<%
            tu = new ThaiUtil();
            name = (String) request.getParameter("name_t_pcat");
            id = (String) request.getParameter("pcat_id");
            rm = (String) request.getParameter("remark_pcat");
            pcBean = new PcatBean();
            pcBean.setName_t(tu.EncodeTexttoTIS(name));
            pcBean.setPcat_id(id);
            pcBean.setRemark(tu.EncodeTexttoTIS(rm));
            ts = new Timestamp(new java.util.Date().getTime());
            pcBean.setCreate_date(ts);
            if (request.getParameter("chkstatus") == null) {
                selectPgBean = pcDAO.selectData(id);
                if (selectPgBean != null && selectPgBean.getDelete_flag().equals("N")) {
                    pcBean.setUpdate_date(ts);
                    if (request.getParameter("confirm") != null && request.getParameter("confirm").equals("true")) {
                        pcDAO.update(pcBean);
                        out.print("แก้ไขสำเร็จ");
                    } else {
                        out.print("edit");
                    }
                } else {
                    if (pcDAO.insert(pcBean)) {
                        out.print("บันทึกสำเร็จ");
                    } else {
                        out.print("บันทึกไม่สำเร็จ");
                    }
                }
            } else {
                pcDAO.updateDel(pcBean);
                out.print("ลบข้อมูลสำเร็จ");
            }
%>
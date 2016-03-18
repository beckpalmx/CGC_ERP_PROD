<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page import="com.cgc.DB.DeptDAO" %>
<%@page import="java.util.Date"%>
<%@page import="com.cgc.bean.DeptBean"%>
<%@page import="java.sql.Timestamp"%>
<%!    DeptDAO deptDAO = new DeptDAO();
    DeptBean deptBean, selectDeptBean;
    Timestamp ts;
    String name, id, rm;
    ThaiUtil tu;
%>
<%
            tu = new ThaiUtil();
            name = (String) request.getParameter("dept_name");
            id = (String) request.getParameter("dept_id");
            rm = (String) request.getParameter("remark");
            deptBean = new DeptBean();
            deptBean.setName_t(tu.EncodeTexttoTIS(name));
            deptBean.setDept_id(tu.EncodeTexttoTIS(id));
            deptBean.setRemark(tu.EncodeTexttoTIS(rm));
            ts = new Timestamp(new java.util.Date().getTime());
            deptBean.setCreate_date(ts);
            if (request.getParameter("chkstatus") == null) {
                selectDeptBean = deptDAO.selectData(id);
                if (selectDeptBean != null && selectDeptBean.getDelete_flag().equals("N")) {
                    deptBean.setUpdate_date(ts);
                    if (request.getParameter("confirm") != null && request.getParameter("confirm").equals("true")) {
                        deptDAO.update(deptBean);
                        deptDAO.update_MADB(deptBean);
                        out.print("แก้ไขสำเร็จ");
                    } else {
                        out.print("edit");
                    }
                } else {
                    //if (deptDAO.insert(deptBean)) {
                    if (deptDAO.insert(deptBean) && deptDAO.insert_MADB(deptBean)) {                        
                        out.print("บันทึกสำเร็จ");
                    } else {
                        out.print("บันทึกไม่สำเร็จ");
                    }
                }
            } else {
                deptDAO.updateDel(deptBean);
                deptDAO.updateDel_MADB(deptBean);
                out.print("ลบข้อมูลสำเร็จ");
            }
%>
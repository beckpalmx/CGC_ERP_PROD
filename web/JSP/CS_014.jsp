<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.DB.EmpDAO"%>
<%@page import="com.cgc.bean.EmpBean"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%!    EmpDAO empDAO = new EmpDAO();
    EmpBean empBean, selectEmpBean;
    Timestamp ts;
    String name, id, rm, lname, status, empId ,file_name;
    ThaiUtil tu;
%>
<%
    tu = new ThaiUtil();
    empId = (String) request.getParameter("emp_id");
    name = (String) request.getParameter("name");
    lname = (String) request.getParameter("lname");
    id = (String) request.getParameter("dept_id");
    status = (String) request.getParameter("status");
    file_name = (String) request.getParameter("str_file");
    System.out.println("str_file = " + file_name);
/*    
    if (status.equals("1")) {
        status = "N";
    } else {
        status = "Y";
    }
*/        
    
    rm = (String) request.getParameter("remark");
    System.out.println("RM = " + rm);
    empBean = new EmpBean();
    empBean.setEmp_id(empId);
    empBean.setFname(tu.EncodeTexttoTIS(name));
    empBean.setLname(tu.EncodeTexttoTIS(lname));
    empBean.setDept_id(id);
    empBean.setRemark(tu.EncodeTexttoTIS(rm));
    empBean.setStatus(status);
    empBean.setImage_url(file_name);    
    ts = new Timestamp(new java.util.Date().getTime());
    empBean.setCreate_date(ts);

    System.out.println("empId = " + tu.EncodeTexttoTIS(empId));
    System.out.println("Name = " + tu.EncodeTexttoTIS(name));
    System.out.println("Lname = " + tu.EncodeTexttoTIS(lname));
    System.out.println("id = " + tu.EncodeTexttoTIS(id));
    System.out.println("rm = " + tu.EncodeTexttoTIS(rm));
    System.out.println("status = " + tu.EncodeTexttoTIS(status));

    System.out.println("chkstatus = " + request.getParameter("chkstatus"));
    System.out.println("confirm = " + request.getParameter("confirm"));

    if (request.getParameter("chkstatus") == null) {
        selectEmpBean = empDAO.selectData(empId);
        if (selectEmpBean != null && selectEmpBean.getDelete_flag().equals("N")) {
            empBean.setUpdate_date(ts);
            if (request.getParameter("confirm") != null && request.getParameter("confirm").equals("true")) {
                empDAO.update(empBean);
                empDAO.update_MADB(empBean);
                out.print("แก้ไขสำเร็จ");
            } else {
                out.print("edit");
            }
        } else {
            if (empDAO.insert(empBean)) {
                if (empDAO.insert_MADB(empBean)) {
                    out.print("บันทึกสำเร็จ");
                } else {
                    out.print("บันทึกไม่สำเร็จ A");
                }
            } else {
                out.print("บันทึกไม่สำเร็จ B");
            }
        }
    } else {
        empDAO.updateDel(empBean);
        out.print("ลบข้อมูลสำเร็จ");
    }
%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.DB.LookupDAO"%>
<%@page import="com.cgc.bean.LookupBean"%>
<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%!
    LookupBean lookupBean = new LookupBean();
    LookupBean selectLookup = new LookupBean();
    LookupDAO lookupDAO = new LookupDAO();
    ThaiUtil tu;
    String lookup,name;
    Timestamp ts;
%>
<%
    ts = new Timestamp( new java.util.Date().getTime());
    tu = new ThaiUtil();
    lookup = (String) request.getParameter("lookup");
    name = (String) request.getParameter("remark");

    lookupBean.setLookup_name(lookup);
    lookupBean.setRemark(tu.EncodeTexttoTIS(name));

    if (request.getParameter("chkstatus")==null){
        selectLookup = lookupDAO.selectData(lookup);
        if(selectLookup != null && selectLookup.getDelete_flag().equals("N")){
            lookupBean.setUpdate_date(ts);
            lookupDAO.update(lookupBean);
            out.print("แก้ไขสำเร็จ");
        }else{
            if(lookupDAO.insert(lookupBean)){
                out.print("บันทึกสำเร็จ");
            }else {out.print("บันทึกไม่สำเร็จ");}
        }
    } else {
        lookupDAO.updateDel(lookupBean);
        out.print("ลบข้อมูลสำเร็จ");
    }
%>
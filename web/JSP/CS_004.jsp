<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.DB.PriviledgeDAO"%>
<%@page import="com.cgc.bean.PriviledgeBean"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
    PriviledgeBean pvBean,selectPV = new PriviledgeBean();
    PriviledgeDAO pvDAO = new PriviledgeDAO();
    String chkbox,main,sub,name,id,rm;
    String[] list;
    ThaiUtil tu;
    Timestamp ts;
%>
<%
    main = "";
    sub = "";
    chkbox = (String) request.getParameter("box");
    list = chkbox.split(",");
    for(String box : list){
        if(box.charAt(0) == 'M'){
            main = main + box+",";
        }else{
            sub = sub + box+",";
        }
    }

    tu = new ThaiUtil();
    name = (String)request.getParameter("name_t");
    id = (String)request.getParameter("priviledge_id");
    rm = (String)request.getParameter("remark");

    
    pvBean = new PriviledgeBean();
    pvBean.setPriviledge_id(id);
    pvBean.setName_t(tu.EncodeTexttoTIS(name));
    pvBean.setMain_menu_id(tu.EncodeTexttoTIS(main));
    pvBean.setSub_menu_id(sub);
    pvBean.setRemark(tu.EncodeTexttoTIS(rm));
    ts = new Timestamp( new java.util.Date().getTime());
    pvBean.setCreate_date(ts);
    if (request.getParameter("chkstatus")==null){
        selectPV = pvDAO.selectData(id);
        if(selectPV != null && selectPV.getDelete_flag().equals("N")){
            pvBean.setMain_menu_id(main);
            pvBean.setSub_menu_id(sub);
            pvBean.setUpdate_date(ts);
            pvDAO.update(pvBean);
            out.print("แก้ไขสำเร็จ");
        }else{
            if(pvDAO.insert(pvBean)){
                out.print("บันทึกสำเร็จ");
            }else {out.print("บันทึกไม่สำเร็จ");}
        }
    } else {
        pvDAO.updateDel(pvBean);
        out.print("ลบข้อมูลสำเร็จ");
    }
%>
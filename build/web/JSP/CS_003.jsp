<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.bean.MenuBean"%>
<%@page import="com.cgc.DB.MenuDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%!    MenuDAO menuDAO = new MenuDAO();
    MenuBean menuBean, selectMenuBean;
    Timestamp ts;
    String name, id_m, id_su, id_sc, rm, doc_no, eff_date, lookup, type, img, img_swap;
    ThaiUtil tu;
%>
<%
    tu = new ThaiUtil();
    name = (String) request.getParameter("name_t");
    id_su = (String) request.getParameter("sub_menu_id");
    rm = (String) request.getParameter("remark");
    id_m = (String) request.getParameter("main_menu_id");
    id_sc = (String) request.getParameter("screen_id");
    doc_no = (String) request.getParameter("doc_no");
    lookup = (String) request.getParameter("lookup");
    type = (String) request.getParameter("typesub");
    
    id_m = id_m.trim();
    
    if (id_m.equals("M001")) {
        img = "../IMAGES/ICON/file0.png";
        img_swap = "../IMAGES/ICON/file1.png";
        System.out.println("IMG 1");    
    } else if (id_m.equals("M002")) {
        img = "../IMAGES/ICON/file0a.png";
        img_swap = "../IMAGES/ICON/file1a.png";
        System.out.println("IMG 2");  
    } else if (id_m.equals("M003")) {
        img = "../IMAGES/ICON/file0e.png";
        img_swap = "../IMAGES/ICON/file1e.png";
        System.out.println("IMG 3");  
    } else if (id_m.equals("M004")) {
        img = "../IMAGES/ICON/file0b.png";
        img_swap = "../IMAGES/ICON/file1b.png";
        System.out.println("IMG 4");  
    } else if (id_m.equals("M005")) {
        img = "../IMAGES/ICON/file0c.png";
        img_swap = "../IMAGES/ICON/file1c.png";
        System.out.println("IMG 5");  
    } else if (id_m.equals("M006")) {
        img = "../IMAGES/ICON/file0d.png";
        img_swap = "../IMAGES/ICON/file1d.png";
        System.out.println("IMG 6");  
    } else if (id_m.equals("M007")) {
        img = "../IMAGES/ICON/file0e.png";
        img_swap = "../IMAGES/ICON/file1e.png";
        System.out.println("IMG 7");  
    } else if (id_m.equals("M008")) {
        img = "../IMAGES/ICON/file0d.png";
        img_swap = "../IMAGES/ICON/file1d.png";
        System.out.println("IMG 8");  
    } else if (id_m.equals("M009")) {
        img = "../IMAGES/ICON/file0d.png";
        img_swap = "../IMAGES/ICON/file1d.png";
        System.out.println("IMG 9");  
    } else if (id_m.equals("M010")) {
        img = "../IMAGES/ICON/file0d.png";
        img_swap = "../IMAGES/ICON/file1d.png";
        System.out.println("IMG 10");      
    } else if (id_m.equals("M00A")) {
        img = "../IMAGES/ICON/file0d.png";
        img_swap = "../IMAGES/ICON/file1d.png";
        System.out.println("IMG A");  
    } else {
        img = "../IMAGES/ICON/file0d.png";
        img_swap = "../IMAGES/ICON/file1d.png";        
    }    

    
    System.out.println("xxxxxxxxx MENU xxxxxxxxx");
    System.out.println(id_m);
    System.out.println(img);
    System.out.println(img_swap);
    System.out.println("xxxxxxxxx MENU xxxxxxxxx");
    
    menuBean = new MenuBean();
    if (!doc_no.equals("")) {

        eff_date = (String) request.getParameter("effective_date");
        menuBean.setDoc_no(tu.EncodeTexttoTIS(doc_no));
        menuBean.setDoc_eff_date(eff_date);
    } else {
        menuBean.setDoc_no(" ");
        menuBean.setDoc_eff_date(" ");
    }
    menuBean.setName_t(tu.EncodeTexttoTIS(name));
    menuBean.setMain_menu_id(tu.EncodeTexttoTIS(id_m));
    menuBean.setScreen_id(tu.EncodeTexttoTIS(id_sc));
    menuBean.setSub_menu_id(tu.EncodeTexttoTIS(id_su));
    menuBean.setRemark(tu.EncodeTexttoTIS(rm));
    menuBean.setImg(img);
    menuBean.setImg_swap(img_swap);
    menuBean.setPage_type(type);
    ts = new Timestamp(new java.util.Date().getTime());
    menuBean.setCreate_date(ts);
    if (request.getParameter("chkstatus") == null) {
        selectMenuBean = menuDAO.selectSubMenu(id_su);
        if (selectMenuBean != null && selectMenuBean.getDelete_flag().equals("N")) {
            menuBean.setUpdate_date(ts);
            menuDAO.updateSub(menuBean);
            if (!lookup.equals("") && !doc_no.equals("")) {
                menuDAO.updateParam(id_sc, lookup);
            }
            out.print("แก้ไขสำเร็จ");
        } else {
            if (menuDAO.insertSub(menuBean)) {
                if (!lookup.equals("")) {
                    if (menuDAO.InsertParam(id_sc, lookup)) {
                        out.print("บันทึกสำเร็จ");
                    } else {
                        out.print("Lookup Error");
                    }
                } else {
                    out.print("บันทึกสำเร็จ!!!");
                }
            } else {
                out.print("บันทึกไม่สำเร็จ");
            }
        }
    } else {
        menuDAO.updateDelSub(menuBean);
        out.print("ลบข้อมูลสำเร็จ");
    }
%>
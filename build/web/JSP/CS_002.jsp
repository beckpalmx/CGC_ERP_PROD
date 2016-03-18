<%@page import="com.cgc.Util.SendMultipartMail"%>
<%@page import="com.cgc.bean.MenuBean"%>
<%@page import="com.cgc.DB.MenuDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.Util.SendMail"%>

<%!
    MenuDAO menuDAO = new MenuDAO();
    MenuBean menuBean,selectMenuBean;
    Timestamp ts;
    String name,id,rm;
    ThaiUtil tu;
%>
<%
    tu = new ThaiUtil();
    name = (String)request.getParameter("name_t");
    id = (String)request.getParameter("main_menu_id");
    rm = (String)request.getParameter("remark");
    menuBean = new MenuBean();
    menuBean.setName_t(tu.EncodeTexttoTIS(name));
    menuBean.setMain_menu_id(tu.EncodeTexttoTIS(id));
    menuBean.setRemark(tu.EncodeTexttoTIS(rm));
    ts = new Timestamp( new java.util.Date().getTime());
    menuBean.setCreate_date(ts);
    if (request.getParameter("chkstatus")==null){
        selectMenuBean = menuDAO.selectMainMenu(id);
        if(selectMenuBean != null && selectMenuBean.getDelete_flag().equals("N")){
            menuBean.setUpdate_date(ts);
            menuDAO.updateMain(menuBean);


			/*** Send Mail ***/
/*         
            String from = "it@cgc-carbon.com";
            //String to = "product@cgc-carbon.com;sale@cgc-carbon.com;warehouse@cgc-carbon.com;lab@cgc-carbon.com;it@cgc-carbon.com";
            String to = "beckpalmx@hotmail.com;pongsak_p@hotmail.com;it@cgc-carbon.com";

            
            String subject = "CGC ERP System : SAVE DATA " + ts;
            String message = "CGC ERP System : UDPATE DATA " + ts;
            
            String[] array_to=to.split(";");
            
            for (int i = 0;i<array_to.length;i++) {
                SendMail sendMail = new SendMail(from, array_to[i], subject, message);
                sendMail.send();
                System.out.println(array_to[i]);
                System.out.println(subject);
                System.out.println(sendMail);
            }
*/                        
            //JOptionPane.showConfirmDialog(null, sendMail);
                        
            /*** Send Mail ***/      
                        
            //SendMultipartMail objMultimail = new SendMultipartMail(); 
            //objMultimail.sendmail();  

                                           
            out.print("แก้ไขสำเร็จ");
        }else{
            if(menuDAO.insertMain(menuBean)){
                out.print("บันทึกสำเร็จ");
            }else {out.print("บันทึกไม่สำเร็จ");}
        }
    } else {
        menuDAO.updateDelMain(menuBean);
        out.print("ลบข้อมูลสำเร็จ");
    }
    
%>
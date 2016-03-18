<%@page import="com.cgc.Util.ThaiBaht"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.bean.DataBean_D_rawmatt_receive"%>
<%@page import="com.cgc.DB.D_rawmatt_receiveDAO"%>
<%@page import="com.cgc.Calculator.D_rawmatt_receive_Calculat"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>

<%!    ThaiUtil en = new ThaiUtil();
    DataBean_D_rawmatt_receive objdb = new DataBean_D_rawmatt_receive();
    D_rawmatt_receiveDAO objex = new D_rawmatt_receiveDAO();
    UtiDatabase uti = new UtiDatabase();
    Timestamp ts;
    D_rawmatt_receive_Calculat objcal = new D_rawmatt_receive_Calculat();
%>
<%

            int statusck = 2;
            int statusnum = 0;
            
           /*
                if (request.getParameter("status_d") == null && request.getParameter("status_cal") == null) {
                statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_rawmatt_receive where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
                if (statusnum == 0) {
                    if (uti.numRowdatabase("Select Count(doc_id) As num from  d_rawmatt_receive where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") == 1) {
                        statusck = -1;
                    } else {
                        statusck = 1;
                    }
                    //statusck = 1;

                } else if (statusnum == 1) {
                    statusck = 2;
                } else {
                    statusck = -1;
                }
            } else if (request.getParameter("status_cal") != null) {
                statusck = Integer.parseInt(request.getParameter("status_cal"));
                //JOptionPane.showConfirmDialog(null, request.getParameter("status_cal"));
            } else {
                statusck = Integer.parseInt(request.getParameter("status_d"));
            }
            */
            System.out.println("statusnum = "+statusnum);       
            System.out.println("statusck = "+statusck);                 
            System.out.println("status_cal = "+request.getParameter("status_cal"));
            
            if(request.getParameter("status_cal") == null){
            objdb.setDoc_id(request.getParameter("doc_id"));
            objdb.setPrice_flag(request.getParameter("price_flag"));
            objdb.setPrice_unit(request.getParameter("price_unit"));
            objdb.setPayment_method(request.getParameter("payment_method"));
            objdb.setPayment_no(request.getParameter("payment_no"));
            objdb.setBank_id(request.getParameter("bank_id"));
            objdb.setCheque_no(request.getParameter("cheque_no"));
            objdb.setBank_acc_no(request.getParameter("bank_acc_no"));
            objdb.setNet_weight(request.getParameter("net_weight_payment"));
            
            System.out.println("X------------------------------------Pay Method");
            System.out.println(request.getParameter("payment_method"));
            System.out.println("X------------------------------------Pay Method");
            
            if (request.getParameter("text_price") != null) {
                    objdb.setText_price(en.EncodeTexttoTIS(request.getParameter("text_price")));
            }            
            
            //JOptionPane.showConfirmDialog(null, request.getParameter("total_price"));            
            //JOptionPane.showConfirmDialog(null, request.getParameter("scale_no"));
            //JOptionPane.showConfirmDialog(null, new ThaiBaht().TextThaiBaht(request.getParameter("total_price")));  
                     
            objdb.setTotal_price(request.getParameter("total_price").trim().equals("")||request.getParameter("total_price")==null ? "0.00":request.getParameter("total_price").trim());
            ts = new Timestamp(new java.util.Date().getTime());
            objdb.setDate(ts);
            objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));
            }
            switch (statusck) {
                case -1:
                    out.print("ไม่สามารถบันทึกข้อมูลนี้ได้เนื่องจากมีเลขที่เอกสารที่สมบูรณ์แล้ว");
                    break;
                case 1:
                    if (objex.insert(objdb) != -1) {
                        out.print("บันทึกสำเร็จ");
                    }
                    break;
                case 2:
                    if (request.getParameter("confirm") != null && request.getParameter("confirm").equals("true")) {
                        System.out.println("confirm = "+request.getParameter("confirm"));
                        objex.update_price(objdb);
                        out.print("แก้ไขสำเร็จ");
                    } else {
                        out.print("edit");
                    }
                    break;
                case 3:
                    if (objex.UpDel(objdb) != -1) {
                        out.print("ลบข้อมูลสำเร็จ");
                    }
                    break;
                case 4:
                    //JOptionPane.showConfirmDialog(null, request.getParameter("scale_no"));
                    out.print(objcal.Page_D_rawmat_receive_Cal(en.EncodeTexttoTIS(request.getParameter("scale_no")), en.EncodeTexttoTIS(request.getParameter("product_id"))));
                    break;
                 case 5:
                     out.print(objex.At_Payment(request.getParameter("doc_id")));
                     break;
                default:
                    out.print("No Statment");
            }
%>
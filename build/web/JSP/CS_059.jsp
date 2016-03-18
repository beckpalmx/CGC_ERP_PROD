
<%@page import="com.cgc.bean.ProductPriceBean"%>
<%@page import="com.cgc.DB.ProductPriceDAO"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page contentType="text/html" pageEncoding="TIS-620"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.Util.ThaiUtil"%>

<%!    ProductPriceDAO ppDAO = new ProductPriceDAO();
    ProductPriceBean ppBean, selectPpBean;
    Timestamp ts;    
    ThaiUtil en = new ThaiUtil();    
    String pgroup_id, price_year, iodine, product_id, lot_no ,start_year,current_date;
    int runno, statusnum;
    int statusck = 0;

%>
<%
    int statusck = 0;
    int statusnum = 0;
    ppBean = new ProductPriceBean();
    UtiDatabase uti = new UtiDatabase();
    pgroup_id = request.getParameter("pgroup_id");
    product_id = request.getParameter("product_id");
    price_year = request.getParameter("price_year");
    start_year = request.getParameter("start_year");
    current_date = request.getParameter("current_date");
    iodine = request.getParameter("iodine");
    runno = request.getParameter("runno").equals("") ? 0 : Integer.parseInt(request.getParameter("runno"));

    statusnum = uti.numRowdatabase("SELECT Count(runno) As num from  mproduct_price where runno = " + runno);
    if (request.getParameter("status_d") == null) {
        if (statusnum == 0) {
            statusck = 1;
            System.out.println("statusck = " + statusck);
        } else if (statusnum == 1) {
            statusck = 2;
            System.out.println("statusck = " + statusck);
        }
    } else {
        statusck = Integer.parseInt(request.getParameter("status_d"));
        System.out.println("statusck = " + statusck);
    }


        ppBean.setPgroup_id(request.getParameter("pgroup_id"));
        ppBean.setPrice_year(request.getParameter("price_year"));
        ppBean.setIodine(request.getParameter("iodine"));
        ppBean.setPrice_month_1(request.getParameter("price_month_1"));
        ppBean.setPrice_month_2(request.getParameter("price_month_2"));
        ppBean.setPrice_month_3(request.getParameter("price_month_3"));
        ppBean.setPrice_month_4(request.getParameter("price_month_4"));
        ppBean.setPrice_month_5(request.getParameter("price_month_5"));
        ppBean.setPrice_month_6(request.getParameter("price_month_6"));
        ppBean.setPrice_month_7(request.getParameter("price_month_7"));
        ppBean.setPrice_month_8(request.getParameter("price_month_8"));
        ppBean.setPrice_month_9(request.getParameter("price_month_9"));
        ppBean.setPrice_month_10(request.getParameter("price_month_10"));
        ppBean.setPrice_month_11(request.getParameter("price_month_11"));
        ppBean.setPrice_month_12(request.getParameter("price_month_12"));
        ppBean.setProduct_id(request.getParameter("product_id"));
        ppBean.setLot_no(request.getParameter("lot_no"));
        //ppBean.setRemark(request.getParameter("remark"));
        ppBean.setRemark(request.getParameter("remark") == null ? "" : en.EncodeTexttoTIS(request.getParameter("remark")));        
        ppBean.setRunno(runno);
        ts = new Timestamp(new java.util.Date().getTime());
        ppBean.setCreate_date(ts);
        ppBean.setUpdate_date(ts);
        ppBean.setCreate_by(request.getParameter("username"));
        ppBean.setUpdate_by(request.getParameter("username"));
        
        ppBean.setStart_year(start_year);
        ppBean.setCurrent_date(current_date);        
        

        System.out.println("Price Month 1 = " + request.getParameter("price_month_1"));
        System.out.println("chkstatus = " + request.getParameter("chkstatus"));

        if (request.getParameter("chkstatus") == null) {
            System.out.println("BSEL pgroup_id = " + pgroup_id);
            System.out.println("BSEL price_year = " + price_year);
        }

            //selectPpBean = ppDAO.selectData(pgroup_id, price_year, iodine, runno);           


            switch (statusck) {
                case 1:
                    ppDAO.insert(ppBean);
                    out.print("บันทึกสำเร็จ");
                    break;
                case 2:
                    ppDAO.update(ppBean);
                    out.print("แก้ไขสำเร็จ");
                    break;
                case 3:
                    ppDAO.updateDel(ppBean);
                    out.print("ลบข้อมูลสำเร็จ");
                    break;
                default:
                    out.print("No Statment");
                    break;
            }

%>
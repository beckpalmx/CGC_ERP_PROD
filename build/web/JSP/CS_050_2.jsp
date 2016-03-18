<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.DB.CS_050DAO"%>
<%@page import="com.cgc.bean.DataBeanCS_050"%>
<%@page import="com.cgc.DB.CS_048DAO"%>
<%@page import="com.cgc.Util.Chk_T_warehouse_item"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.cgc.bean.DataBeanCS_048"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    ArrayList<DataBeanCS_050> obj_AL;
    UserBean userbean;
%>
<%
            obj_AL = new ArrayList<DataBeanCS_050>();// ArrayList ที่เก็บข้อมูลของ หน้า CS_048
            obj_AL.clear();
            String[] strsprit = new String[]{};
            String doc_id = request.getParameter("doc_id");
            String doc_date = request.getParameter("doc_date");
            String process_id = "PR_034";
            String table_header = "d_carbon_withdraw_header_wh";
            String table_detail = "d_carbon_withdraw_detail_wh";
            userbean = (UserBean) session.getAttribute("user");
            int loop = 0;
            strsprit = request.getParameter("line_no").split(",");
            while (loop < strsprit.length) {
                DataBeanCS_050 objdb = new DataBeanCS_050();
                objdb.setLine_no(strsprit[loop]);
                objdb.setDoc_id(doc_id);
                objdb.setDoc_date(doc_date);
                objdb.setProcess_id(process_id);
                objdb.setProduct_id(request.getParameter("product_id_" + strsprit[loop]));//รหัสสินค้าที่คลัง
                objdb.setWh_in(request.getParameter("warehouse_id_" + strsprit[loop]));
                objdb.setWh_out(request.getParameter("warehouse_in_" + strsprit[loop]));
                objdb.setLocation_id(request.getParameter("location_id_" + strsprit[loop]));
                objdb.setWeight(request.getParameter("weight_" + strsprit[loop]));
                objdb.setJob_id(request.getParameter("job_id_"+strsprit[loop]));
                objdb.setWeight_withdraw(request.getParameter("weight_doc_id_"+strsprit[loop]));
                objdb.setTable_header(table_header);
                objdb.setTable_detail(table_detail);
                objdb.setBy(userbean.getUsername());
                objdb.setDate(new Timestamp(new java.util.Date().getTime()));
                objdb.setComplete_flag("N");
                obj_AL.add(objdb);
                loop++;
            }
            CS_050DAO obj_050 = new CS_050DAO();
            obj_050.Work_CS050(obj_AL);
            out.print(obj_050.Alert_Return());
            //out.print("ทำการอนุมัติรายการที่ต้องการสำเร็จ");
%>
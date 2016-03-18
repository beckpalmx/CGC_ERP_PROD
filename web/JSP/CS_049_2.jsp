<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.DB.CS_049DAO"%>
<%@page import="com.cgc.bean.DataBeanCS_049"%>
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
    Timestamp ts;
    ArrayList<DataBeanCS_049> obj_AL;
    UserBean userbean;
%>
<%
            obj_AL = new ArrayList<DataBeanCS_049>();// ArrayList ที่เก็บข้อมูลของ หน้า CS_048
            obj_AL.clear();
            String[] strsprit = new String[]{};
            String doc_id = request.getParameter("doc_id");
            String doc_date = request.getParameter("doc_date");
            String process_id = "PR_029";
            String table_header = "d_carbon_burn_out_header_wh";
            String table_detail = "d_carbon_burn_out_detail_wh";
            userbean = (UserBean) session.getAttribute("user");
            int loop = 0;
            strsprit = request.getParameter("line_no").split(",");
            while (loop < strsprit.length) {
                DataBeanCS_049 objdb = new DataBeanCS_049();
                objdb.setLine_no(strsprit[loop]);
                objdb.setDoc_id(doc_id);
                objdb.setDoc_date(doc_date);
                objdb.setProcess_id(process_id);
                objdb.setProduct_id(request.getParameter("product_id_" + strsprit[loop]));//รหัสสินค้าที่คลัง
                objdb.setProduct_doc_id(request.getParameter("product_doc_id_"+strsprit[loop]));
                objdb.setWh_in(request.getParameter("warehouse_in_" + strsprit[loop])==null ? "-":request.getParameter("warehouse_in_" + strsprit[loop]));
                objdb.setWh_out(request.getParameter("warehouse_id_" + strsprit[loop]));
                objdb.setLocation_id(request.getParameter("location_id_" + strsprit[loop]));
                objdb.setWeight(request.getParameter("weight_" + strsprit[loop]));
                objdb.setWeight_withdraw(request.getParameter("weight_doc_id_"+strsprit[loop]));
                objdb.setTable_header(table_header);
                objdb.setTable_detail(table_detail);
                objdb.setBy(userbean.getUsername());
                objdb.setDate(new Timestamp(new java.util.Date().getTime()));
                objdb.setComplete_flag("N");
                objdb.setG_sum(request.getParameter("g_sum_" + strsprit[loop]));
                
                System.out.println("product_id_ = " + request.getParameter("product_id_" + strsprit[loop]));
                System.out.println("warehouse_in_ 1 = " + request.getParameter("warehouse_in_" + strsprit[loop]));
                System.out.println("warehouse_id_ 2 = " + request.getParameter("warehouse_id_"+strsprit[loop]));                            
                System.out.println("g_sum_ = " + request.getParameter("g_sum_" + strsprit[loop]));
                System.out.println("weight_ 1 = " + request.getParameter("weight_" + strsprit[loop]));
                System.out.println("weight_doc_id_ 2 = " + request.getParameter("weight_doc_id_"+strsprit[loop]));
                
                Double weight_diff_final = Double.parseDouble(request.getParameter("weight_"+strsprit[loop])) 
                        + Double.parseDouble(request.getParameter("g_sum_"+strsprit[loop])) 
                        - Double.parseDouble(request.getParameter("weight_doc_id_"+strsprit[loop])) ;
                
                objdb.setWeight_diff_final(Double.toString(weight_diff_final));
                System.out.println("weight_diff_final = " + weight_diff_final);
                obj_AL.add(objdb);
                loop++;
            }
            CS_049DAO obj_049 = new CS_049DAO();
            obj_049.Work_CS049(obj_AL);
            out.print("ทำการอนุมัติรายการที่ต้องการสำเร็จ");
%>

<%@page import="com.cgc.DB.CS_114DAO"%>
<%@page import="com.cgc.Util.Chk_T_warehouse_item"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.cgc.bean.DataBeanCS_048"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cgc.bean.UserBean"%>
<%!    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    Timestamp ts;
    ArrayList<DataBeanCS_048> obj_AL;
    UserBean userbean;
%>
<%
            obj_AL = new ArrayList<DataBeanCS_048>();// ArrayList ที่เก็บข้อมูลของ หน้า CS_048
            obj_AL.clear();
            userbean = (UserBean) session.getAttribute("user");
            String[] strsprit = new String[]{};
            String doc_id = request.getParameter("doc_id");
            String doc_date = request.getParameter("doc_date");
            String process_id = "PR_114";
            String table_header = "d_carbon_return_header_wh";
            String table_detail = "d_carbon_return_detail_wh";
            int loop = 0;
            strsprit = request.getParameter("line_no").split(",");
            while (loop < strsprit.length) {
                DataBeanCS_048 objdb = new DataBeanCS_048();
                objdb.setLine_no(strsprit[loop]);
                objdb.setDoc_id(doc_id);
                objdb.setDoc_date(doc_date);
                objdb.setProcess_id(process_id);
                objdb.setProduct_id(request.getParameter("product_id_" + strsprit[loop]));//รหัสสินค้าที่คลัง
                objdb.setProduct_doc_id(request.getParameter("product_doc_id_" + strsprit[loop]));//รหสัสสินค้าหน้าเอกสาร
                objdb.setWh_in(request.getParameter("warehouse_id_" + strsprit[loop]));
                objdb.setWh_out(request.getParameter("warehouse_id_" + strsprit[loop]));
                objdb.setLocation_id(request.getParameter("location_id_" + strsprit[loop]));
                objdb.setWeight(request.getParameter("weight_" + strsprit[loop]));
                objdb.setWeight_withdraw(request.getParameter("weight_doc_id_"+strsprit[loop]));
                objdb.setJob_id(request.getParameter("job_id_" + strsprit[loop]));
                objdb.setTable_header(table_header);
                objdb.setTable_detail(table_detail);
                objdb.setComplate_falg("N");
                objdb.setBy(userbean.getUsername());
                objdb.setDate(new Timestamp(new java.util.Date().getTime()));
                obj_AL.add(objdb);
                loop++;
            }
            CS_114DAO obj_048 = new CS_114DAO();
            obj_048.Steadment_PR_114(obj_AL);
            out.print("ทำการอนุมัติการคืนถ่านสำเร็จ");
%>
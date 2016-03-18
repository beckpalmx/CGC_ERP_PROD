<%@page import="com.cgc.bean.UserBean"%>
<%@page import="com.cgc.DB.CS_052DAO"%>
<%@page import="com.cgc.bean.DataBeanCS_052"%>
<%@page import="com.cgc.Util.Chk_T_warehouse_item"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    ArrayList<DataBeanCS_052> obj_AL;
    UserBean userbean;
%>
<%
            obj_AL = new ArrayList<DataBeanCS_052>();// ArrayList ที่เก็บข้อมูลของ หน้า CS_048
            obj_AL.clear();
            String[] strsprit = new String[]{};
            String doc_id = request.getParameter("doc_id");
            String doc_date = request.getParameter("doc_date");
            String process_id = "PR_040";
            String table_header = "d_packing_product_header_wh";
            if (request.getParameter("table_s1") != null) {
                String table_detail = "d_packing_product_detail_wh";
                userbean = (UserBean) session.getAttribute("user");
                int loop = 0;
                strsprit = request.getParameter("line_no").split(",");
                while (loop < strsprit.length) {
                    DataBeanCS_052 objdb = new DataBeanCS_052();
                    objdb.setLine_no(strsprit[loop]);
                    objdb.setDoc_id(doc_id);
                    objdb.setDoc_date(doc_date);
                    objdb.setProcess_id(process_id);
                    objdb.setProduct_id(request.getParameter("product_withdraw_" + strsprit[loop]));//รหัสสินค้าที่คลัง
                    objdb.setWh_in(request.getParameter("warehouse_withdraw_" + strsprit[loop]));
                    objdb.setWh_out("W008");
                    objdb.setLocation_doc_id("-");
                    objdb.setLocation_id(request.getParameter("location_withdraw_" + strsprit[loop]));
                    objdb.setWeight(request.getParameter("weight_withdraw_" + strsprit[loop]));
                    objdb.setJob_id(request.getParameter("job_withdraw_" + strsprit[loop]));
                    objdb.setWeight_doc(request.getParameter("weight_doc_withdraw_" + strsprit[loop]));
                    objdb.setTable_header(table_header);
                    objdb.setTable_detail(table_detail);
                    objdb.setBy(userbean.getUsername());
                    objdb.setDate(new Timestamp(new java.util.Date().getTime()));
                    objdb.setComplete_flag("N");
                    obj_AL.add(objdb);
                    loop++;
                }
                CS_052DAO obj_052 = new CS_052DAO();
                obj_052.Work_CS052(obj_AL,table_detail);
                out.print(obj_052.Alert_Return());
                //out.print("ทำการอนุมัติรายการที่ต้องการสำเร็จ");

            } else {
                String table_detail_prod = "d_packing_product_detail_prod_wh";
                userbean = (UserBean) session.getAttribute("user");
                int loop = 0;
                strsprit = request.getParameter("line_no").split(",");
                while (loop < strsprit.length) {
                    DataBeanCS_052 objdb = new DataBeanCS_052();
                    objdb.setLine_no(strsprit[loop]);
                    objdb.setDoc_id(doc_id);
                    objdb.setDoc_date(doc_date);
                    objdb.setProcess_id(process_id);
                    objdb.setProduct_id(request.getParameter("product_secure_" + strsprit[loop]));//รหัสสินค้าที่คลัง
                    objdb.setWh_in("W008");
                    objdb.setLocation_doc_id("-");
                    objdb.setWh_out(request.getParameter("warehouse_secure_" + strsprit[loop]));
                    objdb.setLocation_id(request.getParameter("location_secure_" + strsprit[loop]));
                    objdb.setWeight(request.getParameter("weight_secure_" + strsprit[loop]));
                    objdb.setJob_id(request.getParameter("job_secure_" + strsprit[loop]));
                    objdb.setWeight_doc(request.getParameter("weight_doc_secure_" + strsprit[loop]));
                    objdb.setTable_header(table_header);
                    objdb.setTable_detail_prod(table_detail_prod);
                    objdb.setBy(userbean.getUsername());
                    objdb.setDate(new Timestamp(new java.util.Date().getTime()));
                    objdb.setComplete_flag("N");
                    obj_AL.add(objdb);
                    loop++;
                }
                CS_052DAO obj_052 = new CS_052DAO();
                obj_052.Work_CS052(obj_AL,table_detail_prod);
                out.print("ทำการอนุมัติรายการถ่านได้สำเร็จ");
            }



%>
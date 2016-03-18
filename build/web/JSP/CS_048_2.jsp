<%@page import="com.cgc.DB.CS_048DAO"%>
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
            String process_id = request.getParameter("process_id");
            String table_header = request.getParameter("table_h");
            String table_detail = request.getParameter("table_s1");
            String table_detail_prod = request.getParameter("table_s2");
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
                objdb.setWh_in((process_id.equals("PR_022"))
                        ? request.getParameter("warehouse_id_" + strsprit[loop])
                        : process_id.equals("PR_042")
                        ?request.getParameter("warehouse_id_" + strsprit[loop])
                        :request.getParameter("warehouse_id_" + strsprit[loop]));
                objdb.setWh_out((process_id.equals("PR_022"))
                        ? request.getParameter("warehouse_id_" + strsprit[loop])
                        : process_id.equals("PR_042")||process_id.equals("PR_023")||process_id.equals("PR_027")
                        ?request.getParameter("warehouse_in_" + strsprit[loop])
                        :request.getParameter("warehouse_in_" + strsprit[loop]));
                objdb.setLocation_doc_id(process_id.equals("PR_022")|| process_id.equals("PR_042")||process_id.equals("PR_023")||process_id.equals("PR_027")
                        ? "-"
                        : request.getParameter("location_doc_id_" + strsprit[loop]));
                
                System.out.println("location_doc_id_" + request.getParameter("location_doc_id_" + strsprit[loop]));
                System.out.println("location_id_" + request.getParameter("location_id_" + strsprit[loop]));
                
                objdb.setLocation_id(request.getParameter("location_id_" + strsprit[loop]));
                objdb.setWeight(request.getParameter("weight_" + strsprit[loop]));
                objdb.setWeight_withdraw(request.getParameter("weight_doc_id_"+strsprit[loop]));
                objdb.setJob_id(request.getParameter("job_id_" + strsprit[loop]));
                objdb.setTotal_price(request.getParameter("total_price_"+strsprit[loop]));
                objdb.setTable_header(table_header);
                objdb.setTable_detail(table_detail);
                objdb.setTable_detail_prod(table_detail_prod);
                objdb.setDoc_type(process_id.equals("PR_115")?request.getParameter("doc_type_"+strsprit[loop]):null);
                objdb.setComplate_falg("N");
                objdb.setBy(userbean.getUsername());
                objdb.setDate(new Timestamp(new java.util.Date().getTime()));
                obj_AL.add(objdb);
                loop++;
            }
            CS_048DAO obj_048 = new CS_048DAO();
            obj_048.workCS_048(obj_AL);
            out.print(obj_048.Alert_Return());
%>

<%@page import="com.cgc.DB.D_carbon_burn_out_detailDAO"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_burn_out_detail"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.DB.MPROCESSDAO"%>
<%@page import="com.cgc.bean.DataBeanMPROCESS"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    Timestamp ts;
    D_carbon_burn_out_detailDAO objex = new D_carbon_burn_out_detailDAO();
    ArrayList<DataBeanD_carbon_burn_out_detail> arraybean;


%>
<%
arraybean = new ArrayList<DataBeanD_carbon_burn_out_detail>();
 
            String[] strsprit = new String[]{};
            int loop = 0;
            int statusck = 2;
            String doc_id = "";
            
            ts = new Timestamp(new java.util.Date().getTime());
            doc_id = request.getParameter("doc_id");
            //wh_id = request.getParameter("wh_id");
            strsprit = request.getParameter("line_no").split(",");
            while (loop < strsprit.length) {
                DataBeanD_carbon_burn_out_detail objdb = new DataBeanD_carbon_burn_out_detail();
                objdb.setDoc_id(doc_id);
                objdb.setWh_id(request.getParameter("wh_id_"+strsprit[loop]));
                objdb.setDate(ts);
                objdb.setLine_no(strsprit[loop]);
                objdb.setLocation_id(request.getParameter("location_id_"+strsprit[loop]));
                objdb.setProduct_id(request.getParameter("product_id_"+strsprit[loop]));
                arraybean.add(objdb);
                loop++;
            }

            switch (statusck) {

                case 2:
                   
                    if (objex.UpdateDetail_031(arraybean) != -1){
                        out.print("บันทึกสำเร็จ");
                    }
                    break;
                default:
                    out.print("No Statment");
            }
%>
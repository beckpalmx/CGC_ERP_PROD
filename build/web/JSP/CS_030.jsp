
<%@page import="com.cgc.DB.D_carbon_burn_out_detailDAO"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_burn_out_detail"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.DB.MPROCESSDAO"%>
<%@page import="com.cgc.bean.DataBeanMPROCESS"%>
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="java.sql.Date"%>
<%@page import="com.cgc.Util.ThaiUtil"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<%!    UtiDatabase uti = new UtiDatabase();
    ThaiUtil en = new ThaiUtil();
    Timestamp ts;
    DataBeanD_carbon_burn_out_detail objdb = new DataBeanD_carbon_burn_out_detail();
    D_carbon_burn_out_detailDAO objex = new D_carbon_burn_out_detailDAO();


%>
<%

            String total = "";
            int statusck = 0;
            int statusnum = 0;
            if (request.getParameter("status_a") != null) {
                if (uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_burn_out_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag = 'N' and complete_flag = 'Y'") != 0) {
                    statusck = -1;
                } else {
                    statusck = 1;
                    statusnum = uti.numRowdatabase("Select Count(doc_id) As num from  d_carbon_burn_out_detail where doc_id = '" + en.EncodeTexttoTIS(request.getParameter("doc_id").trim()) + "' and delete_flag <> 'Y' and complete_flag <> 'Y'");
                    objdb.setLine_no(Integer.toString(statusnum + 1));
                }
            } else if (request.getParameter("status_u") != null) {
                statusck = 2;
                objdb.setLine_no(request.getParameter("line_no"));

            } else if (request.getParameter("status_d") != null) {
                statusck = Integer.parseInt(request.getParameter("status_d"));
            } else {
                statusck = -1;
            }
            if (request.getParameter("doc_id") != null) {
                objdb.setDoc_id(en.EncodeTexttoTIS(request.getParameter("doc_id").trim()));
            }
            if (request.getParameter("production_no") != null) {
                objdb.setProduction_no(en.EncodeTexttoTIS(request.getParameter("production_no")));
            }
            if (request.getParameter("size") != null) {
                objdb.setSize(en.EncodeTexttoTIS(request.getParameter("size")));
            }
            if (request.getParameter("g_code") != null) {
                objdb.setG_code(en.EncodeTexttoTIS(request.getParameter("g_code")));
            }
            if (request.getParameter("g_sum") != null) {
                objdb.setG_sum(en.EncodeTexttoTIS(request.getParameter("g_sum")));
            }
            if (request.getParameter("wh_in") != null) {
                objdb.setWh_in(en.EncodeTexttoTIS(request.getParameter("wh_in")));
            }
            if (request.getParameter("wh_out") != null) {
                objdb.setWh_out(en.EncodeTexttoTIS(request.getParameter("wh_out")));
            }
            if (request.getParameter("ctc_i2") != null) {
                objdb.setCtc_i2(request.getParameter("ctc_i2"));
            }
            if (request.getParameter("bag") != null) {
                objdb.setBag(request.getParameter("bag"));
            }
            if (request.getParameter("weight") != null) {
                objdb.setWeight(request.getParameter("weight"));
            }
            if (request.getParameter("lost") != null) {
                objdb.setLost(request.getParameter("lost"));
            }

            if (request.getParameter("doc_date") != null) {
                objdb.setDoc_date(request.getParameter("doc_date"));
            }
            if (request.getParameter("remark") != null) {
                objdb.setRemark(en.EncodeTexttoTIS(request.getParameter("remark")));
            }
            ts = new Timestamp(new java.util.Date().getTime());
            objdb.setDate(ts);
            objdb.setBy(en.EncodeTexttoTIS(request.getParameter("username")));
            switch (statusck) {
                case -1:
                    out.print("�������ö�ѹ�֡�����Ź�������ͧ�ҡ���Ţ����͡��÷������ó�����");
                    break;
                case 1:
                    if (objex.insert(objdb) != -1) {
                        out.print("�ѹ�֡�����");
                    }
                    break;
                case 2:
                    if (objex.update(objdb) != -1) {
                        out.print("��������");
                    }
                    break;
                case 3:

                    if (request.getParameter("chk_all") != null) {
                        //JOptionPane.showConfirmDialog(null,request.getParameter("chk_all"));
                        total = objex.Delete_line_no_All(objdb);
                        out.print(total);
                    } else {

                        total = objex.DeleteLine_no(request.getParameter("ckbox"), objdb);
                        out.print(total);
                        //JOptionPane.showConfirmDialog(null, total);
                    }
                    break;
                default:
                    out.print("No Statment");
            }
%>
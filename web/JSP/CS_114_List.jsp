<%@page import="java.text.DecimalFormat"%>
<%@page import="com.cgc.DB.D_carbon_return_detailDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.cgc.bean.DataBeanD_carbon_return_detail"%>
<%@page import="com.cgc.bean.DataBean"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
            String htmltext, id;
            int cnt;
            ArrayList<DataBeanD_carbon_return_detail> list = new ArrayList<DataBeanD_carbon_return_detail>();

%>
<%
            D_carbon_return_detailDAO carbonDao = new D_carbon_return_detailDAO();
            cnt = 0;
            htmltext = "<table width='200' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>";
            id = (String) request.getParameter("doc_id");
            list = carbonDao.selectDataSearch(id);
            DecimalFormat df = new DecimalFormat("#,###.00");
            String[] t = new String[2];
            double w = 0, b = 0;
            String total = "";


            for (DataBeanD_carbon_return_detail carbonBean : list) {
                htmltext += "<tr>"
                        + "<td width='3%' class='forborder'><input type='checkbox' name='item" + cnt + "' id='item" + cnt + "' value='" + carbonBean.getDoc_id() + "'/></td>"
                        + "<td width='3%' class='forborder'> <a href='javascript:;' onclick='viewDetail("+cnt+")'>" + (cnt + 1) + "</a></td>"
                        + "<td width='26%' class='forborder'><input type='text' class="inputs" size='25' name='product_"+cnt+"' id='product_"+cnt+"' value='"+carbonBean.getProduct_id()+"'></td>"
                        + "<td width='9%' class='forborder'>" + carbonBean.getBag_ret() + "</td>"
                        + "<td width='10%' class='forborder'>" + carbonBean.getSize() + "</td>"
                        + "<td width='10%' class='forborder'><input type='text' class="inputs" size='9' name='weigth_" + cnt + "' id='weigth_" + cnt + "' value='"+carbonBean.getWeight()+"'></td>"
                        + "<td width='15%' class='forborder'><input type='text' class="inputs" size='12' name='wh_" + cnt + "' id='wh_" + cnt + "' value=''></td>"
                        + "<td width='12%' class='forborder'><input type='text' class="inputs" size='10' name='location_" + cnt + "' id='location_" + cnt + "' value=''></td>"
                        + "<td width='12%' class='row5'>"+carbonBean.getConfirm()+"</td>"
                        + "<input type='hidden' name='location_out_" + cnt + "' id='location_out_" + cnt + "' value='" + carbonBean.getLocation_id() + "'/>"
                        + "</tr>";
                        
                cnt++;
            }
            htmltext += "</table>";
            out.print(htmltext);
%>
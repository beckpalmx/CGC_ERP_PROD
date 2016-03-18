<%@page import="com.cgc.bean.DataBeanD_carbon_withdraw_detail"%>
<%@page import="com.cgc.DB.D_carbon_withdraw_detailDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
            String ctc, prodcode, wh, location, wiegth, htmltext, id;
            int cnt;
            ArrayList<DataBeanD_carbon_withdraw_detail> list = new ArrayList<DataBeanD_carbon_withdraw_detail>();

%>
<%
            D_carbon_withdraw_detailDAO carbonDao = new D_carbon_withdraw_detailDAO();
            cnt = 0;
            htmltext = "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>";
            id = (String) request.getParameter("doc_id");
            list = carbonDao.selectDataSearch(id);
            DecimalFormat df = new DecimalFormat("#,###.00");
            String[] t = new String[2];
            double w = 0, b = 0;
            String total = "";


            for (DataBeanD_carbon_withdraw_detail carbonBean : list) {
                w = Double.parseDouble(carbonBean.getWeight());
                b = Double.parseDouble(carbonBean.getBag());
                total = df.format(w / b) + "";
                t[0] = total.substring(0, total.indexOf("."));
                t[1] = total.substring(total.indexOf(".") + 1, total.length());
                if (t[0].equals("") || t[0].equals("00")) {
                    t[0] = "0";
                }
                if (t[1].equals("") || t[1].equals("00")) {
                    t[1] = "0";
                }
                htmltext += "<tr>"
                        + "<td width='3%' class='forborder'><input type='checkbox' name='item" + cnt + "' id='item" + cnt + "' value='" + carbonBean.getDoc_id() + "'/></td>"
                        + "<td width='3%' class='forborder'>" + (cnt + 1) + "</td>"
                        + "<td width='10%' class='forborder'>" + carbonBean.getJob_id() + "</td>"
                        + "<td width='5%' class='forborder'>" + carbonBean.getSize_use() + "</td>"
                        + "<td width='5%' class='forborder'>" + carbonBean.getPcat_id() + "</td>"
                        + "<td width='5%' class='forborder'>" + carbonBean.getGrd_io_ctc() + "</td>"
                        + "<td width='5%' class='forborder'>" + carbonBean.getMachine() + "</td>"
                        + "<td width='14%' class='forborder'>" + carbonBean.getWeight() + "</td>"
                        + "<td width='15%' class='forborder'><input type='text' class="inputs" size='7' name='product_id_" + cnt + "' id='product_id_" + cnt + "' value='" + carbonBean.getProduct_id() + "'><a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('Vproduct&textinput=product_id_"+cnt+"', 31, 'Search_Detail.jsp')\"></a></td>"
                        + "<td width='10%' class='forborder'><input type='text' class="inputs" size='5' name='wh_" + cnt + "' id='wh_" + cnt + "' value=''><a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('mwarehouse&textinput=wh_"+cnt+"', 48, 'Search_Detail.jsp')\"></a></td>"
                        + "<td width='5%' class='forborder'><input type='text' class="inputs" size='2' name='location_" + cnt + "' id='location_" + cnt + "' value=''></td>"
                        + "<td width='10%' class='forborder'><input type='text' class="inputs" size='7' name='weigth_" + cnt + "' id='weigth_" + cnt + "' value='"+carbonBean.getWeight()+"'></td>"
                        + "<td width='10%' class='forborder' colspan='2'><table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>"
                        + "<input type='hidden' name='location_out_" + cnt + "' id='location_out_" + cnt + "' value='" + carbonBean.getLocation_id() + "'/>"
                        + "<tr>"
                        + "<td colspan='2'>"
                        + "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>"
                        + "<tr>"
                        + "<td class='row5' width='5%'>"+t[0]+"</td>"
                        + "<td class='row5' width='5%'>"+t[1]+"</td>"
                        + "</tr>"
                        + "</table>"
                        + "</td>"
                        + "</tr>"
                        + "</table></td>"
                        + "</tr>";
                cnt++;
            }

            htmltext += "</table>";
            out.print(htmltext);
%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="com.cgc.DB.CarbonBurnOutDAO"%>
<%@page import="com.cgc.bean.CarbonBurnOutBean"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%!    CarbonBurnOutDAO carbonDao = new CarbonBurnOutDAO();
    //CarbonBurnOutBean carbonBean = new CarbonBurnOutBean();
    String ctc, prodcode, wh, location, wiegth, htmltext,id;
    int cnt;
    ArrayList<CarbonBurnOutBean> list = new ArrayList<CarbonBurnOutBean>();

%>
<%
            cnt = 0;
            //htmltext = "<tr><td colspan='14' align='center' class='row5'><br>ไม่มีข้อมูล</td></tr>";
            htmltext = "<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>";
            id = (String)request.getParameter("doc_id");
            list = carbonDao.selectDataSearch(id);
            DecimalFormat df = new DecimalFormat("#,###.00");
            String[] t = new String[2];
            double w=0,b=0;
            String total = "";


            for (CarbonBurnOutBean carbonBean : list) {

                 w = Double.parseDouble(carbonBean.getWeight());
                 b = (carbonBean.getBag().equals("0"))?1:Double.parseDouble(carbonBean.getBag());
                 //b = Double.parseDouble(carbonBean.getBag());
                 total = df.format(w/b)+"";
                 t[0] = total.substring(0,total.indexOf("."));
                 t[1] = total.substring(total.indexOf(".")+1, total.length());
                 if(t[0].equals("") || t[0].equals("00"))
                     t[0] = "0";
                 if (t[1].equals("") || t[1].equals("00"))
                     t[1] = "0";
                htmltext += "<tr>"
                        + "<td width='3%' class='forborder'><input type='checkbox' name='item"+cnt+"' id='item"+cnt+"' value='"+carbonBean.getDoc_id()+"'/></td>"
                        + "<td width='3%' class='forborder'>"+(cnt+1)+"</td>"
                        + "<td width='14%' class='forborder'>"+carbonBean.getProduction_no()+"</td>"
                        + "<td width='5%' class='forborder'>"+carbonBean.getRaw_mat()+"</td>"
                        + "<td width='5%' class='forborder'>"+carbonBean.getSize()+"</td>"
                        + "<td width='5%' class='forborder'>"+carbonBean.getBag()+"</td>"
                        + "<td width='10%' class='forborder'>"+carbonBean.getWeight()+"</td>"
                        + "<td width='10%' class='forborder'><input type='text' class="inputs" size='9' name='ctc_"+cnt+"' id='ctc_"+cnt+"' value='"+carbonBean.getCtc_i2()+"'></td>"
                        + "<td width='10%' class='forborder'><input type='text' class="inputs" size='5' name='product_"+cnt+"' id='product_"+cnt+"' value='"+carbonBean.getProduct_id()+"'><a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('Vproduct&textinput=product_"+cnt+"', 31, 'Search_Detail.jsp')\"></a></td>"
                        + "<td width='10%' class='forborder'><input type='text' class="inputs" size='6' name='wh_"+cnt+"' id='wh_"+cnt+"' value='W005'><a href='#' ><img src='../IMAGES/BUTTON/MAIN/SEARCH20.png' alt='ค้นหา' name='IMAGE4' width='20' height='20' border='0' align='middle'  onclick=\"openBrWindow('mwarehouse&textinput=wh_"+cnt+"', 48, 'Search_Detail.jsp')\"></a></td>"
                        + "<td width='5%' class='forborder'><input type='text' class="inputs" size='3' name='location_"+cnt+"' id='location_"+cnt+"' value=''></td>"
                        + "<td width='10%' class='forborder'><input type='text' class="inputs" size='9' name='quantity_"+cnt+"' id='quantity_"+cnt+"' value='"+carbonBean.getWeight()+"'></td>"
                        + "<td width='10%' class='' colspan='2'><table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner3'>"
                        + "<input type='hidden' name='location_out_"+cnt+"' id='location_out_"+cnt+"' value='"+carbonBean.getLocation_id()+"'/>"
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

<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import ="com.cgc.Util.ThaiUtil" %>
<%@page import="com.cgc.DB.DBConnect"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="javax.swing.JOptionPane"%>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>

<%!
ThaiUtil objth = new ThaiUtil();
UtiDatabase objuti = new UtiDatabase();
String SQL1,SQL = "";
//int count;
%>
<%
out.println("<table width='100%' align='center' border='0' cellpadding='0' cellspacing='1' class='inner'>");


        SQL1 = "Select Count(doc_id) As num from  d_packing_req_detail where doc_id ='"+objth.EncodeTexttoTIS(request.getParameter("doc_id"))+"' and delete_flag <> 'Y' ";
        int a = objuti.numRowdatabase(SQL1);
	SQL = "Select doc_id,line_no,prod_name,place_prd,palate_no,qty_use,qty_balance,remark from vd_packing_req_detail where doc_id ='"+objth.EncodeTexttoTIS(request.getParameter("doc_id"))+"'and delete_flag <> 'Y' order by runno";
	DBConnect objcon = new DBConnect();
	Connection con =objcon.openNewConnection();
	ResultSet rs = null;
        rs =con.createStatement().executeQuery(SQL);
	while(rs.next())
	{

	out.println("<tr>");
        out.println("<td class='forborder' width='3px'><input type='checkbox' id='ckbox' name='ckbox' onclick=\"cancle_chkboxAll('chk_all',this.checked)\"></td>");
        out.println("<td class='forborder' width='7%'><a href=\"#\" onclick=\"OpenEdit(URLsend('line_no_"+rs.getString("line_no")+",doc_id,username','../SCREEN/CS_039.jsp'))\"><input type='hidden' id='line_no_"+rs.getString("line_no")+"' value=\""+rs.getString("line_no")+"\"><input type='hidden' id='doc_id' value=\""+rs.getString("doc_id")+"\">"+rs.getString("line_no")+"</a></td>");
        out.println("<td class='forborder' width='15%'>"+rs.getString("prod_name")+"&nbsp;</td>");
        out.println("<td class='forborder' width='20%'>"+rs.getString("place_prd")+"&nbsp;</td>");
        out.println("<td class='forborder' width='10%'>"+rs.getString("palate_no")+"&nbsp;</td>");
	out.println("<td class='forborder' width='15%'>"+rs.getString("qty_use")+"&nbsp;</td>");
        out.println("<td class='forborder' width='15%'>"+rs.getString("qty_balance")+"&nbsp;</td>");
	out.println("<td class='forborder' width='15%'>"+rs.getString("remark")+"&nbsp;</td>");
	out.println("</tr>");
	}
	rs.close();
        con.close();
        out.println("</table>");
%>

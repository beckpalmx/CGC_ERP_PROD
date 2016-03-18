
<%@page import="com.cgc.Util.UtiDatabase"%>
<%@page import="com.cgc.DB.DBConnect"%>
<%@page import="javax.swing.JOptionPane"%><script type="text/javascript" src="../JS/myAjaxFramework.js"></script>
<%@ page language="java" contentType="text/html; charset=TIS-620" pageEncoding="TIS-620"%>
<%@page import="java.sql.*"%>
<head>
<script type="text/javascript">
 
</script>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=TIS-620">
    <link href="../CSS/MENU.css" rel="stylesheet" type="text/css">
    <link href="../CSS/BT.css" rel="stylesheet" type="text/css">
<%
	String SQL,SQL2,Encode,strid;
	int start,screen;
	int row_page=15;
	int total=0;
	int count = 0;
	UtiDatabase objut = new UtiDatabase();
	DBConnect db = new DBConnect();
	Connection Conn = db.openNewConnection();
	if(request.getParameter("searchid") == null && request.getParameter("searchtxt") == null)
	{
		SQL = "Select Count(*) As num from  vsupplier where delete_flag <> 'Y' ";
		total = objut.numRowdatabase(SQL);
	}
	else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") != null)
	{
		strid = request.getParameter("searchid");
		Encode = new String(request.getParameter("searchtxt").getBytes("ISO8859-1"),"TIS-620");
		SQL = "Select Count(*) As num from  vsupplier where delete_flag <> 'Y' and supplier_id like '"+strid+"%' and name_t like '"+Encode+"%'";
		total = objut.numRowdatabase(SQL);
		out.print(total);
	}
	else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") == null)
	{
		strid = request.getParameter("searchid");
		SQL = "Select Count(*) As num from  vsupplier where delete_flag <> 'Y' and supplier_id like '"+strid+"%'";
		total = objut.numRowdatabase(SQL);
		out.print(total);
	}
	else
	{
		Encode = new String(request.getParameter("searchtxt").getBytes("ISO8859-1"),"TIS-620");
		SQL = "Select Count(*) As num from  vsupplier where delete_flag <> 'Y' and name_t like '"+Encode+"%'";
		total = objut.numRowdatabase(SQL);
		out.print(total);
	}
	int total_page=(int)Math.ceil((double)total/(double)row_page);
	if(request.getParameter("screen")==null)
	{
		screen=1;
	}
	else
	{
		screen=Integer.parseInt(request.getParameter("screen"));
	}
	if (screen>=1 && screen<=total )
	{
		start=(screen-1)*row_page;
		//row_page=row_page*screen;
		
		
%>
</head>
<body>
    <form name="serForm" method="get" action="SR_msupplier.jsp">
        <div style="width: 600px;">
            <table width="64%" cellpadding="0"  cellspacing="0">
                <tr >
                    <td width="20" class="ftopleft"></td>
                    <td  class="ftopcenter" colspan="2">รายงาน&nbsp;</td>
                    <td width="7" class="ftopright"></td>
                </tr>
                <tr >
                    <td class="fcenterleft"></td>
                    <td  colspan="2" class="fcentercenter">
                        <table cellpadding="0" cellspacing="0" >
                            <tr>
                                <td colspan="4"  class="blankspace"></td>
                            </tr>

                            <tr>
                              <td colspan="3" align="right">รหัส  : &nbsp;</td>
                              <td width="72%" align="left"><input type='text' class="inputs" name="searchid" value="" size="40"/></td>
                            </tr>
                            <tr>
                                <td colspan="3" align="right"">
                               	 ชื่อ :                                 </td>
                                <td align="left"><input type='text' class="inputs" name="searchtxt" value="" size="40"/>
                                <input type="submit" id="submit" value="ค้นหา"></td>
                            </tr>

                            <tr>
                                <td colspan="4" align="center">&nbsp;</td>
                            </tr>

                            <tr>
                                <td colspan="2" class="header2"><div align="left">รหัสsupplier</div></td><td colspan="2" class="header2"><div align="left">ชื่อsupplier</div></td>
                            </tr>
                            <%!ResultSet rs2; %>
<%
String sql2;
	if(request.getParameter("searchid") == null && request.getParameter("searchtxt") == null )
	{
		sql2="select * from vsupplier where delete_flag <> 'Y' order by 1 limit "+row_page+" offset "+start;
		rs2 = Conn.createStatement().executeQuery(sql2);
	}
	else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") != null )
	{
		sql2="select * from vsupplier where delete_flag <> 'Y' and supplier_id like '"+request.getParameter("searchid")+"%' and name_t like '"+new String(request.getParameter("searchtxt").getBytes("ISO8859-1"),"TIS-620")+"%' order by 1 limit "+row_page+" offset "+start;
		rs2 = Conn.createStatement().executeQuery(sql2);
	}
	else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") == null )
	{
		sql2="select * from vsupplier where delete_flag <> 'Y' and supplier_id like '"+request.getParameter("searchid")+"%' order by 1 limit "+row_page+" offset "+start;
		rs2 = Conn.createStatement().executeQuery(sql2);	
	}
	else
	{
		sql2="select * from vsupplier where delete_flag <> 'Y' and name_t like '"+new String(request.getParameter("searchtxt").getBytes("ISO8859-1"),"TIS-620")+"%' order by 1 limit "+row_page+" offset "+start;
		rs2 = Conn.createStatement().executeQuery(sql2);
	}
	while(rs2.next())
	{
		count++;
		String getshowdata;
		getshowdata = rs2.getString("supplier_id")+","+rs2.getString("name_t")+","+rs2.getString("address1_t")+","+rs2.getString("tambol_code")+","+rs2.getString("amp_code")+","+rs2.getString("prov_code")+","+rs2.getString("zipcode")+","+rs2.getString("tel")+","+rs2.getString("fax")+","+rs2.getString("contact_name")+","+rs2.getString("remark")+","+rs2.getString("t_name")+","+rs2.getString("amp_namt")+","+rs2.getString("prov_tname");
%>
                            <tr>
                                <td colspan="2" align="center"><div align="left"><a  href="#" onClick="gettoShow('<%=getshowdata%>','supplier_id,name_t,address1_t,tambol_code,amp_code,prov_code,zipcode,tel,fax,contact_name,remark,tambol_name,amp_name,prov_name')"><%=rs2.getString("supplier_id")%></a></div></td>
                                <td colspan="2" align="left"><%= rs2.getString("name_t") %></td>
                            </tr>
<%
}
%>
                        </table>
                        <div align="center">
                          <%
if(screen>1)
{
	if(request.getParameter("searchid") == null && request.getParameter("searchtxt") == null )
	{%>
	                      <a href="../JSP/SR_msupplier.jsp?screen=<%=screen-1%>">ย้อนกลับ</a>
	                      <%
	}
	else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") != null )
	{%>
	                      <a href="../JSP/SR_msupplier.jsp?screen=<%=screen-1%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=request.getParameter("searchtxt")%>">ย้อนกลับ</a>
	                      <%	
	}
	else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") == null )
	{%>
	                      <a href="../JSP/SR_msupplier.jsp?screen=<%=screen-1%>&searchid=<%=request.getParameter("searchid")%>">ย้อนกลับ</a>
	                      <%	
	}
	else
	{%>
	                      <a href="../JSP/SR_msupplier.jsp?screen=<%=screen-1%>&searchtxt=<%=request.getParameter("searchtxt")%>">ย้อนกลับ</a>
	                      <%	
	}
}
if((screen%10)!= 0 && screen <= 10)
{
for(int i=1;i<=10 && i <= total_page ;i++)
{
	
	if(i==screen) 
	{
	%>
		                  <%="["+i+"]"%>
	                      <%
	}
	else 
	{
		if(request.getParameter("searchid") == null && request.getParameter("searchtxt") == null )
		{%>
		| <a href="../JSP/SR_msupplier.jsp?screen=<%=i%>"><%=i%></a> |
		<%
		}
		else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") != null )
		{%>
		| <a href="../JSP/SR_msupplier.jsp?screen=<%=i%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=request.getParameter("searchtxt")%>"><%=i%></a> |
		<%	
		}
		else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") == null )
		{%>
		| <a href="../JSP/SR_msupplier.jsp?screen=<%=i%>&searchid=<%=request.getParameter("searchid")%>"><%=i%></a> |
		<%	
		}
		else
		{%>
		| <a href="../JSP/SR_msupplier.jsp?screen=<%=i%>&searchtxt=<%=request.getParameter("searchtxt")%>"><%=i%></a> |
		<%	
		}
	}
	
}
}
else
{
	for(int y=(screen-5);y<=(screen+5)&& y<= total_page ;y++)
	{
		if(y==screen) 
		{
		%>
			<%="["+y+"]"%>
		    <%
		}
		else 
		{
			if(request.getParameter("searchid") == null && request.getParameter("searchtxt") == null )
			{%>
			| <a href="../JSP/SR_msupplier.jsp?screen=<%=y%>"><%=y%></a> |
			<%
			}
			else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") != null )
			{%>
			| <a href="../JSP/SR_msupplier.jsp?screen=<%=y%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=request.getParameter("searchtxt")%>"><%=y%></a> |
			<%	
			}
			else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") == null )
			{%>
			| <a href="../JSP/SR_msupplier.jsp?screen=<%=y%>&searchid=<%=request.getParameter("searchid")%>"><%=y%></a> |
			<%	
			}
			else
			{%>
			| <a href="../JSP/SR_msupplier.jsp?screen=<%=y%>&searchtxt=<%=request.getParameter("searchtxt")%>"><%=y%></a> |
			<%	
			}
		}
	}
}
if(screen<total_page)
{
	if(request.getParameter("searchid") == null && request.getParameter("searchtxt") == null )
	{%>
	        <a href="../JSP/SR_msupplier.jsp?screen=<%=screen+1%>">ไปข้างหน้า</a>
	        <%
	}
	else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") != null )
	{%>
	        <a href="../JSP/SR_msupplier.jsp?screen=<%=screen+1%>&searchid=<%=request.getParameter("searchid")%>&searchtxt=<%=request.getParameter("searchtxt")%>">ไปข้างหน้า</a>
	        <%	
	}
	else if(request.getParameter("searchid") != null && request.getParameter("searchtxt") == null )
	{%>
	        <a href="../JSP/SR_msupplier.jsp?screen=<%=screen+1%>&searchid=<%=request.getParameter("searchid")%>">ไปข้างหน้า</a>
	        <%	
	}
	else
	{%>
	        <a href="../JSP/SR_msupplier.jsp?screen=<%=screen+1%>&searchtxt=<%=request.getParameter("searchtxt")%>">ไปข้างหน้า</a>
	        <%	
	}
}
else{;

}
rs2.close();
Conn.close();
}
%>
                        </div></td>
                    <td class="fcenterright"></td>
                </tr>
                <tr bordercolor="0069B3" style="height: 5px">
                    <td width="20" class="ffootleft"></td>
                    <td  class="ffootcenter" colspan="2" ></td>
                    <td width="7" class="ffootright"></td>
                </tr>
            </table>
        </div>
    </form>
</body>
